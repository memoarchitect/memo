// Focused example: a ROS 2 mobile logistics robot, modelled with the ROS
// extension. The point of the example is the MECHANISM, not the robot — it
// demonstrates how an extension is used, and it is deliberately the only place
// ROS vocabulary appears outside `extensions/ros`.
//
// Three things it shows:
//   1. Extension types are used exactly like base types. `RosNode` is a
//      `SoftwareComponent`, so period, WCET, safety class and the rest are
//      inherited and every base rule still applies to it.
//   2. Publish and subscribe are RELATIONS. This is why an extension may
//      declare connection defs.
//   3. Deployment reuses the BASE relations unchanged — `BuildsInto`,
//      `DeploysTo`, `ProvidesEnvironment` — with no ROS-specific relation
//      anywhere in the chain.
package memo_examples_ros_mobile_robot {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_implementation_software_structure::*;
    private import memo_architecture_implementation_software_runtime::*;
    private import memo_architecture_realization_deployment::*;
    private import memo_architecture_realization_physical::*;
    private import memo_extension_messaging::*;
    private import memo_extension_container::*;
    private import memo_extension_ros::*;

    // ── Code ────────────────────────────────────────────────────────────
    part swPerception : SoftwareModule {
        attribute :>> moduleKind = ModuleKind::unit;
        attribute :>> id = "RMR-SW-001"; attribute :>> name = "PerceptionStack";
        attribute :>> responsibility = "Lidar driver and obstacle segmentation.";
        attribute :>> safetyClass = SafetyClassKind::B;
    }
    part swNavigation : SoftwareModule {
        attribute :>> moduleKind = ModuleKind::unit;
        attribute :>> id = "RMR-SW-002"; attribute :>> name = "NavigationStack";
        attribute :>> responsibility = "Global and local planning; velocity command generation.";
        attribute :>> safetyClass = SafetyClassKind::B;
    }
    part swSafety : SoftwareModule {
        attribute :>> moduleKind = ModuleKind::unit;
        attribute :>> id = "RMR-SW-003"; attribute :>> name = "SafetyMonitor";
        attribute :>> responsibility = "Independent watchdog: stops the base on obstacle proximity or missing heartbeat.";
        attribute :>> safetyClass = SafetyClassKind::C;
    }

    // ── Nodes ───────────────────────────────────────────────────────────
    //
    // `runtimeKind` is set per node rather than by the type: the first two are
    // composed into one container process, the safety monitor runs as its own
    // process so a fault in navigation cannot take it down. That distinction
    // is exactly what an extension type must NOT decide for the modeller.
    part nodeLidar : RosNode {
        attribute :>> runtimeKind = RuntimeKind::thread;
        attribute :>> id = "RMR-ND-001"; attribute :>> name = "LidarDriverNode";
        attribute :>> nodeNamespace = "/robot/perception";
        attribute :>> lifecycleManaged = true;
        attribute :>> executorModel = "single-threaded executor, composed";
        attribute :>> periodMs = 50.0;
        attribute :>> wcetMs = 8.0;
        attribute :>> safetyClass = SafetyClassKind::B;
    }
    part nodeNavigation : RosNode {
        attribute :>> runtimeKind = RuntimeKind::thread;
        attribute :>> id = "RMR-ND-002"; attribute :>> name = "NavigationNode";
        attribute :>> nodeNamespace = "/robot/navigation";
        attribute :>> lifecycleManaged = true;
        attribute :>> executorModel = "multi-threaded executor, composed";
        attribute :>> periodMs = 100.0;
        attribute :>> wcetMs = 35.0;
        attribute :>> safetyClass = SafetyClassKind::B;
    }
    part nodeSafetyMonitor : RosNode {
        attribute :>> runtimeKind = RuntimeKind::process;
        attribute :>> id = "RMR-ND-003"; attribute :>> name = "SafetyMonitorNode";
        attribute :>> nodeNamespace = "/robot/safety";
        attribute :>> lifecycleManaged = false;
        attribute :>> executorModel = "own process, real-time priority";
        attribute :>> periodMs = 20.0;
        attribute :>> deadlineMs = 20.0;
        attribute :>> wcetMs = 3.0;
        attribute :>> priority = 90;
        attribute :>> safetyClass = SafetyClassKind::C;
        attribute :>> faultContainment = "separate process; watchdog-fed; stops the base on its own timeout";
    }

    // ── Topics ──────────────────────────────────────────────────────────
    //
    // Each carries the QoS profile it is OFFERED with. A subscriber requests
    // its own, and the two have to be compatible — the mismatch that silently
    // delivers nothing at runtime is visible here as two profiles side by side.
    item topicScan : RosTopic {
        attribute :>> id = "RMR-TP-001"; attribute :>> name = "ScanTopic";
        attribute :>> messageType = "sensor_msgs/msg/LaserScan";
        attribute :>> topicStructure = "/{namespace}/{sensor}/scan";
        attribute :>> messageSchema = "ranges[], intensities[], angle_min, angle_max, scan_time";
        attribute :>> offeredQos {
            attribute :>> reliability = RosReliabilityKind::bestEffort;
            attribute :>> durability = RosDurabilityKind::volatile;
            attribute :>> deadlineMs = 60.0;
            attribute :>> livelinessLeaseMs = 200.0;
            attribute :>> historyDepth = 5;
        }
    }
    item topicCmdVel : RosTopic {
        attribute :>> id = "RMR-TP-002"; attribute :>> name = "CmdVelTopic";
        attribute :>> messageType = "geometry_msgs/msg/Twist";
        attribute :>> topicStructure = "/{namespace}/cmd_vel";
        attribute :>> messageSchema = "linear.x, angular.z";
        attribute :>> offeredQos {
            attribute :>> reliability = RosReliabilityKind::reliable;
            attribute :>> durability = RosDurabilityKind::volatile;
            attribute :>> deadlineMs = 150.0;
            attribute :>> livelinessLeaseMs = 300.0;
            attribute :>> historyDepth = 1;
        }
    }
    item topicEstop : RosTopic {
        attribute :>> id = "RMR-TP-003"; attribute :>> name = "EmergencyStopTopic";
        attribute :>> messageType = "std_msgs/msg/Bool";
        attribute :>> topicStructure = "/{namespace}/safety/estop";
        attribute :>> messageSchema = "data (true = stop asserted)";
        // Latched: a node that starts or restarts must immediately learn that
        // a stop is asserted rather than wait for the next publication.
        attribute :>> offeredQos {
            attribute :>> reliability = RosReliabilityKind::reliable;
            attribute :>> durability = RosDurabilityKind::transientLocal;
            attribute :>> deadlineMs = 100.0;
            attribute :>> livelinessLeaseMs = 200.0;
            attribute :>> historyDepth = 1;
        }
    }

    // ── Publish and subscribe ───────────────────────────────────────────
    connection lidarPublishesScan : RosPublishesTo
        connect publishingNode ::> nodeLidar to rosTopic ::> topicScan {
        attribute :>> deliverySemantics = MessagingDeliveryKind::atMostOnce;
        attribute :>> publishRateHz = 20.0;
    }
    connection navigationSubscribesScan : RosSubscribesTo
        connect subscribingNode ::> nodeNavigation to rosTopic ::> topicScan {
        attribute :>> deliverySemantics = MessagingDeliveryKind::atMostOnce;
        attribute :>> lossBehaviour = "planner holds last costmap for 200 ms, then commands zero velocity";
    }
    connection safetySubscribesScan : RosSubscribesTo
        connect subscribingNode ::> nodeSafetyMonitor to rosTopic ::> topicScan {
        attribute :>> deliverySemantics = MessagingDeliveryKind::atMostOnce;
        attribute :>> lossBehaviour = "two consecutive misses assert the stop";
    }
    connection navigationPublishesCmdVel : RosPublishesTo
        connect publishingNode ::> nodeNavigation to rosTopic ::> topicCmdVel {
        attribute :>> deliverySemantics = MessagingDeliveryKind::atLeastOnce;
        attribute :>> publishRateHz = 10.0;
    }
    connection safetyPublishesEstop : RosPublishesTo
        connect publishingNode ::> nodeSafetyMonitor to rosTopic ::> topicEstop {
        attribute :>> deliverySemantics = MessagingDeliveryKind::atLeastOnce;
        attribute :>> publishRateHz = 50.0;
    }
    connection navigationSubscribesEstop : RosSubscribesTo
        connect subscribingNode ::> nodeNavigation to rosTopic ::> topicEstop {
        attribute :>> deliverySemantics = MessagingDeliveryKind::atLeastOnce;
        attribute :>> lossBehaviour = "no publisher within the liveliness lease is treated as stop asserted";
    }

    // ── Deployment: base relations, unchanged ───────────────────────────
    part imageRuntime : RosContainerImage {
        attribute :>> id = "RMR-DU-001"; attribute :>> name = "RobotRuntimeImage";
        attribute :>> unitKind = "OCI container image";
        attribute :>> imageReference = "registry.example.com/robot-runtime:2.3.0";
        attribute :>> registry = "registry.example.com";
        attribute :>> digest = "sha256:9f2c1ad4e0b7";
        attribute :>> baseImage = "ros:jazzy-ros-base";
        attribute :>> rosDistribution = "jazzy";
        attribute :>> workspaceOverlay = "/opt/robot_ws";
        attribute :>> integrityProtection = "image signature + SBOM attestation";
    }
    part imageSafety : RosContainerImage {
        attribute :>> id = "RMR-DU-002"; attribute :>> name = "SafetyMonitorImage";
        attribute :>> unitKind = "OCI container image";
        attribute :>> imageReference = "registry.example.com/safety-monitor:2.3.0";
        attribute :>> registry = "registry.example.com";
        attribute :>> digest = "sha256:41bb7c0e5d92";
        attribute :>> baseImage = "ros:jazzy-ros-core";
        attribute :>> rosDistribution = "jazzy";
        attribute :>> workspaceOverlay = "/opt/safety_ws";
        attribute :>> integrityProtection = "image signature + SBOM attestation";
    }
    connection : BuildsInto connect module ::> swPerception to deploymentUnit ::> imageRuntime;
    connection : BuildsInto connect module ::> swNavigation to deploymentUnit ::> imageRuntime;
    connection : BuildsInto connect module ::> swSafety to deploymentUnit ::> imageSafety;

    part nodeComputeUnit : ProcessingNode {
        attribute :>> id = "RMR-HW-001"; attribute :>> name = "OnboardComputeUnit";
        attribute :>> nodeKind = ProcessingNodeKind::SoC;
        attribute :>> processorArchitecture = "arm64, 8 core";
        attribute :>> memoryMB = "16384";
        attribute :>> operatingSystem = "Linux with PREEMPT_RT";
        attribute :>> supportsContainerization = true;
        attribute :>> realTimeCapable = true;
    }
    allocation runtimeImageDeployment : DeploysTo allocate imageRuntime to nodeComputeUnit {
        attribute :>> deploymentKind = DeploymentKind::containerized;
    }
    allocation safetyImageDeployment : DeploysTo allocate imageSafety to nodeComputeUnit {
        attribute :>> deploymentKind = DeploymentKind::containerized;
    }

    part rosRuntime : RosContainerRuntime {
        attribute :>> id = "RMR-RT-001"; attribute :>> name = "OnboardRosRuntime";
        attribute :>> environmentKind = "container runtime";
        attribute :>> osOrRtos = "Linux with PREEMPT_RT";
        attribute :>> orchestrationPlatform = "systemd-managed compose, no cluster orchestrator";
        attribute :>> runtimeEngine = "containerd";
        attribute :>> rosDistribution = "jazzy";
        attribute :>> rmwImplementation = "rmw_cyclonedds_cpp";
        // Fixed per robot. Two robots sharing a domain would see each other's
        // topics, which is a hazard on a shared network and is visible in no
        // single node.
        attribute :>> rosDomainId = 42;
    }
    connection : ProvidesEnvironment connect node ::> nodeComputeUnit to environment ::> rosRuntime;
}
