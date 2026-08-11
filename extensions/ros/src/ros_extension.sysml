// ROS 2 (Robot Operating System 2).
//
// The acceptance test for MEMO's extension point (plan §10.3): a whole
// technology stack — nodes, topics, quality of service, publish/subscribe, and
// containerized deployment — landing without a single change to a base
// relation. `BuildsInto`, `DeploysTo`, and `ProvidesEnvironment` are reused
// exactly as the base declares them.
//
// Composition is by MODULE LIST, not by chaining. `baseMethodology` is [0..1],
// but `includedModule` is [0..*], so this extension's methodology names
// `memo_extension_messaging` and `memo_extension_container` alongside its own
// module. A ROS topic IS a messaging topic and a ROS container image IS an OCI
// image; specializing them is what keeps a ROS model comparable with a
// non-ROS one, and restating them would have made two vocabularies for one
// thing.
package memo_extension_ros {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_relationships::*;
    private import memo_architecture_implementation_software_runtime::*;
    private import memo_extension_messaging::*;
    private import memo_extension_container::*;

    // ── Quality of service ──────────────────────────────────────────────
    //
    // QoS is the first real customer for "where do per-technology properties
    // live" (plan C3, open question §14.6). The answer is a typed
    // `attribute def` on the extension's own types — NOT the base's
    // `PropertySet` stub, which was one String field and could not say what a
    // reliability setting is. A typed profile can be validated, compared
    // between a publisher and a subscriber, and read by a tool; a property bag
    // cannot. `PropertySet` is deleted in this session for that reason.

    // ROS 2 RELIABLE resends until delivery; BEST_EFFORT does not. This is
    // the delivery guarantee, so it maps onto MessagingDeliveryKind:
    // bestEffort is atMostOnce, reliable is atLeastOnce.
    enum def RosReliabilityKind {
        enum bestEffort;
        enum reliable;
    }
    // TRANSIENT_LOCAL replays the last samples to a late-joining subscriber;
    // VOLATILE does not. The difference decides whether a node that restarts
    // sees the current state or waits for the next publication — which is a
    // safety-relevant fact when the topic carries a latched mode or setpoint.
    enum def RosDurabilityKind {
        enum volatile;
        enum transientLocal;
    }

    attribute def RosQosProfile {
        attribute reliability : RosReliabilityKind;
        attribute durability : RosDurabilityKind;
        // The QoS contract: a sample is expected at least this often.
        attribute deadlineMs : Real;
        // How long a publisher may be silent before subscribers treat it as
        // lost — ROS 2 liveliness lease duration.
        attribute livelinessLeaseMs : Real;
        // Depth of the history buffer, KEEP_LAST(n) / KEEP_ALL.
        attribute historyDepth : Integer;
    }

    // ── Nodes and topics ────────────────────────────────────────────────

    // A ROS node. `runtimeKind` is deliberately NOT bound: a node may run as
    // its own process or be composed with others into a single container
    // process, and which one it is is a design decision the model should
    // record rather than a fact the type can assert.
    part def RosNode specializes SoftwareComponent {
        attribute nodeNamespace : String;
        // Whether the node implements the managed-node lifecycle
        // (unconfigured / inactive / active / finalized). A lifecycle-managed
        // node can be brought up in a defined order and held inactive until
        // its preconditions hold, which is how a robot reaches a safe state.
        attribute lifecycleManaged : Boolean;
        attribute executorModel : String;
    }

    item def RosTopic specializes MessagingTopic {
        // Fully-qualified ROS message type, e.g. "sensor_msgs/msg/LaserScan".
        attribute messageType : String;
        // The offered profile. A subscriber whose requested profile is not
        // compatible with it never receives anything — a failure mode that is
        // invisible in code review and obvious in a model.
        attribute offeredQos : RosQosProfile;
    }

    // ── Publish and subscribe ───────────────────────────────────────────
    //
    // Both specialize the technology-neutral messaging relations, which root
    // on `MemoLink` because `ComponentConnects` types both ends
    // `SoftwareComponent` and a topic is an item. See the note in
    // memo_extension_messaging and §22 of the plan.
    connection def RosPublishesTo :> MessagingPublishesTo {
        attribute qos : RosQosProfile;
        end publishingNode : RosNode :>> publisher;
        end rosTopic : RosTopic :>> publishedTopic;
    }
    abstract connection rosPublishesToLinks : RosPublishesTo[*];
    metadata def <rosPublishesTo> RosPublishesToMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = rosPublishesToLinks meta SysML::Usage;
    }

    connection def RosSubscribesTo :> MessagingSubscribesTo {
        // The REQUESTED profile, which is a different statement from the
        // offered one on the topic. QoS incompatibility is exactly the
        // mismatch between these two.
        attribute qos : RosQosProfile;
        end subscribingNode : RosNode :>> subscriber;
        end rosTopic : RosTopic :>> subscribedTopic;
    }
    abstract connection rosSubscribesToLinks : RosSubscribesTo[*];
    metadata def <rosSubscribesTo> RosSubscribesToMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = rosSubscribesToLinks meta SysML::Usage;
    }

    // ── Deployment ──────────────────────────────────────────────────────
    //
    // Nothing below declares a relation. The base's three deployment
    // relations already say everything a ROS deployment needs:
    //   BuildsInto          SoftwareModule -> RosContainerImage
    //   DeploysTo           RosContainerImage -> ProcessingNode
    //   ProvidesEnvironment ProcessingNode -> RosContainerRuntime
    // That is the proof the base is factored correctly.
    part def RosContainerImage specializes ContainerImage {
        // humble, iron, jazzy, rolling.
        attribute rosDistribution : String;
        // The workspace overlay the image was built from.
        attribute workspaceOverlay : String;
    }

    part def RosContainerRuntime specializes ContainerRuntime {
        attribute rosDistribution : String;
        // The RMW implementation below ROS 2 — rmw_fastrtps_cpp,
        // rmw_cyclonedds_cpp. QoS is enforced here, so it is part of any
        // argument that a QoS profile is actually honoured.
        attribute rmwImplementation : String;
        // ROS_DOMAIN_ID. Two robots sharing a domain see each other's topics,
        // which is a hazard on a shared network and not visible in any node.
        attribute rosDomainId : Integer;
    }
}
