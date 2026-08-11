// Focused example: a ROS 2 mobile logistics robot, modelled with the ROS
// extension. The point of the example is the MECHANISM, not the robot — it
// demonstrates how an extension is used, and it is deliberately the only place
// ROS vocabulary appears outside `extensions/ros`.
//
// Three things it shows:
//   1. Extension types are used exactly like base types. `RosNode` is a
//      `SoftwareComponent`, so period, WCET, safety class and the rest are
//      inherited and every base rule still applies to it.
//   2. ROS communication uses native item definitions/usages, directional
//      ports, interfaces, and flows — no publish/subscribe relation is added.
//   3. Deployment reuses the BASE relations unchanged — `BuildsInto`,
//      `DeploysTo`, `ProvidesEnvironment` — with no ROS-specific relation
//      anywhere in the chain.
package memo_examples_ros_mobile_robot {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_implementation_software_structure::*;
    private import memo_architecture_implementation_software_runtime::*;
    private import memo_architecture_functional_behavior::*;
    private import memo_architecture_realization_deployment::*;
    private import memo_architecture_realization_physical::*;
    private import memo_extension_messaging::*;
    private import memo_extension_container::*;
    private import memo_extension_ros::*;

    // ── Message definitions and named topic instances ──────────────────
    // The definition is the ROS message contract. A named usage is the topic
    // deployed in this system; publisher/subscriber ports reference that same
    // usage and native flows carry its message type.
    item def LaserScan specializes RosMessage {
        attribute :>> rosTypeName = "sensor_msgs/msg/LaserScan";
        attribute :>> messageSchema = "ranges[], intensities[], angle_min, angle_max, scan_time";
    }
    item def VelocityCommand specializes RosMessage {
        attribute :>> rosTypeName = "geometry_msgs/msg/Twist";
        attribute :>> messageSchema = "linear.x, angular.z";
    }
    item def EmergencyStop specializes RosMessage {
        attribute :>> rosTypeName = "std_msgs/msg/Bool";
        attribute :>> messageSchema = "data (true = stop asserted)";
    }

    item topicScan : LaserScan {
        attribute :>> id = "RMR-TP-001"; attribute :>> name = "ScanTopic";
    }
    item topicCmdVel : VelocityCommand {
        attribute :>> id = "RMR-TP-002"; attribute :>> name = "CmdVelTopic";
    }
    item topicEstop : EmergencyStop {
        attribute :>> id = "RMR-TP-003"; attribute :>> name = "EmergencyStopTopic";
    }

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
        out port scanPublisher : RosPublisher {
            ref :>> topic = topicScan;
            attribute :>> deliverySemantics = MessagingDeliveryKind::atMostOnce;
            attribute :>> publishRateHz = 20.0;
            attribute :>> offeredQos {
                attribute :>> reliability = RosReliabilityKind::bestEffort;
                attribute :>> durability = RosDurabilityKind::volatile;
                attribute :>> deadlineMs = 60.0;
                attribute :>> livelinessLeaseMs = 200.0;
                attribute :>> historyDepth = 5;
            }
        }
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
        in port scanSubscriber : RosSubscriber {
            ref :>> topic = topicScan;
            attribute :>> deliverySemantics = MessagingDeliveryKind::atMostOnce;
            attribute :>> lossBehaviour = "hold the last costmap for 200 ms, then command zero velocity";
            attribute :>> requestedQos {
                attribute :>> reliability = RosReliabilityKind::bestEffort;
                attribute :>> durability = RosDurabilityKind::volatile;
                attribute :>> deadlineMs = 60.0;
                attribute :>> livelinessLeaseMs = 200.0;
                attribute :>> historyDepth = 5;
            }
        }
        out port cmdVelPublisher : RosPublisher {
            ref :>> topic = topicCmdVel;
            attribute :>> deliverySemantics = MessagingDeliveryKind::atLeastOnce;
            attribute :>> publishRateHz = 10.0;
            attribute :>> offeredQos {
                attribute :>> reliability = RosReliabilityKind::reliable;
                attribute :>> durability = RosDurabilityKind::volatile;
                attribute :>> deadlineMs = 150.0;
                attribute :>> livelinessLeaseMs = 300.0;
                attribute :>> historyDepth = 1;
            }
        }
        in port estopSubscriber : RosSubscriber {
            ref :>> topic = topicEstop;
            attribute :>> deliverySemantics = MessagingDeliveryKind::atLeastOnce;
            attribute :>> lossBehaviour = "no publisher within the liveliness lease is treated as stop asserted";
            attribute :>> requestedQos {
                attribute :>> reliability = RosReliabilityKind::reliable;
                attribute :>> durability = RosDurabilityKind::transientLocal;
                attribute :>> deadlineMs = 100.0;
                attribute :>> livelinessLeaseMs = 200.0;
                attribute :>> historyDepth = 1;
            }
        }
        inout port setModeClient : RosServiceClient {
            attribute :>> serviceName = "/robot/safety/set_mode";
            attribute :>> timeoutMs = 500.0;
        }
        inout port navigateActionServer : RosActionServer {
            attribute :>> actionName = "/robot/navigation/navigate_to_pose";
        }
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
        in port scanSubscriber : RosSubscriber {
            ref :>> topic = topicScan;
            attribute :>> deliverySemantics = MessagingDeliveryKind::atMostOnce;
            attribute :>> lossBehaviour = "two consecutive misses assert the stop";
        }
        in port cmdVelSubscriber : RosSubscriber {
            ref :>> topic = topicCmdVel;
            attribute :>> deliverySemantics = MessagingDeliveryKind::atLeastOnce;
            attribute :>> lossBehaviour = "missing velocity commands assert the stop";
        }
        out port estopPublisher : RosPublisher {
            ref :>> topic = topicEstop;
            attribute :>> deliverySemantics = MessagingDeliveryKind::atLeastOnce;
            attribute :>> publishRateHz = 50.0;
            attribute :>> offeredQos {
                attribute :>> reliability = RosReliabilityKind::reliable;
                attribute :>> durability = RosDurabilityKind::transientLocal;
                attribute :>> deadlineMs = 100.0;
                attribute :>> livelinessLeaseMs = 200.0;
                attribute :>> historyDepth = 1;
            }
        }
        inout port setModeServer : RosServiceServer {
            attribute :>> serviceName = "/robot/safety/set_mode";
        }
        inout port navigateActionClient : RosActionClient {
            attribute :>> actionName = "/robot/navigation/navigate_to_pose";
        }
    }

    // Cross-view mappings: SEI module-view implementation units are distinct
    // from component-and-connector runtime elements. A runtime node realizes
    // the module whose code it executes; it is not the same model element.
    connection : Realizes connect realizing ::> nodeLidar to realized ::> swPerception;
    connection : Realizes connect realizing ::> nodeNavigation to realized ::> swNavigation;
    connection : Realizes connect realizing ::> nodeSafetyMonitor to realized ::> swSafety;

    // ── Native topic, service, and action interfaces ───────────────────
    interface scanToNavigation : RosTopicInterface
        connect nodeLidar.scanPublisher to nodeNavigation.scanSubscriber {
            attribute :>> direction = DirectionKind::output;
        }
    interface scanToSafety : RosTopicInterface
        connect nodeLidar.scanPublisher to nodeSafetyMonitor.scanSubscriber {
            attribute :>> direction = DirectionKind::output;
        }
    interface cmdVelToSafety : RosTopicInterface
        connect nodeNavigation.cmdVelPublisher to nodeSafetyMonitor.cmdVelSubscriber {
            attribute :>> direction = DirectionKind::output;
        }
    interface estopToNavigation : RosTopicInterface
        connect nodeSafetyMonitor.estopPublisher to nodeNavigation.estopSubscriber {
            attribute :>> direction = DirectionKind::output;
        }

    flow of LaserScan from nodeLidar.scanPublisher.message to nodeNavigation.scanSubscriber.message;
    flow of LaserScan from nodeLidar.scanPublisher.message to nodeSafetyMonitor.scanSubscriber.message;
    flow of VelocityCommand from nodeNavigation.cmdVelPublisher.message to nodeSafetyMonitor.cmdVelSubscriber.message;
    flow of EmergencyStop from nodeSafetyMonitor.estopPublisher.message to nodeNavigation.estopSubscriber.message;

    interface setModeService : RosServiceInterface
        connect nodeNavigation.setModeClient to nodeSafetyMonitor.setModeServer {
            attribute :>> direction = DirectionKind::inputOutput;
        }
    interface navigateAction : RosActionInterface
        connect nodeSafetyMonitor.navigateActionClient to nodeNavigation.navigateActionServer {
            attribute :>> direction = DirectionKind::inputOutput;
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
