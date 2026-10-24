// ROS 2 (Robot Operating System 2).
//
// The acceptance test for MEMO's extension point (plan §10.3): a whole
// technology stack — nodes, messages, topics, quality of service, services,
// actions, and
// containerized deployment — landing without a single change to a base
// relation. `BuildsInto`, `DeploysTo`, and `ProvidesEnvironment` are reused
// exactly as the base declares them.
//
// Composition is by import. ROS builds on the messaging and container
// extensions and imports them PUBLICLY, so a project that imports
// `memo_extension_ros` has all three: their definitions are visible and their
// packages are selected. The dependency is stated once, here, and the KPAR
// build reads the same lines to record it. ROS communication specializes
// native MEMO item, port, and interface families; it does not invent
// publish/subscribe relations.
package memo_extension_ros {
    private import memo_core_stdlib_quantities::*;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_architecture_functional_behavior::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_implementation_software_structure::*;
    private import memo_architecture_implementation_software_runtime::*;
    public import memo_extension_messaging::*;
    public import memo_extension_container::*;

    // ── Quality of service ──────────────────────────────────────────────
    //
    // QoS is the first real customer for "where do per-technology properties
    // live" (plan C3, open question §14.6). The answer is a typed
    // `attribute def` on the extension's own types — NOT the base's
    // `PropertySet` stub, which was one String field and could not say what a
    // reliability setting is. A typed profile can be validated, compared
    // between a publisher and a subscriber, and read by a tool; a property bag
    // cannot. `PropertySet` is deleted in this session for that reason.

    // TRANSIENT_LOCAL replays the last samples to a late-joining subscriber;
    // VOLATILE does not. The difference decides whether a node that restarts
    // sees the current state or waits for the next publication — which is a
    // safety-relevant fact when the topic carries a latched mode or setpoint.
    enum def RosDurabilityKind {
        enum volatile;
        enum transientLocal;
    }

    // RELIABILITY is not in the profile. ROS 2 RELIABLE resends until delivery
    // and BEST_EFFORT does not, which is the delivery guarantee the port
    // already states as `deliverySemantics`: bestEffort is atMostOnce and
    // reliable is atLeastOnce. Stating it a second time here let one port
    // say both and disagree.
    attribute def RosQosProfile {
        attribute durability : RosDurabilityKind;
        // The QoS contract: a sample is expected at least this often.
        attribute deadlineMs : DurationValue;
        // How long a publisher may be silent before subscribers treat it as
        // lost — ROS 2 liveliness lease duration.
        attribute livelinessLeaseMs : DurationValue;
        // Depth of the history buffer, KEEP_LAST(n) / KEEP_ALL.
        attribute historyDepth : Integer;
    }

    // ── Nodes, messages, topics, and endpoint roles ────────────────────

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

    // A definition is the ROS message contract (`LaserScan`, `Twist`, ...).
    // A named item usage of that definition is a deployed topic (`/scan`).
    // Individual deliveries are native flows/messages between ports that
    // reference the same topic usage.
    abstract item def RosMessage specializes MessagingMessage {
        attribute rosTypeName : String;
    }

    port def RosPublisher specializes MessagingPublisher {
        attribute offeredQos : RosQosProfile;
    }

    port def RosSubscriber specializes MessagingSubscriber {
        attribute requestedQos : RosQosProfile;
    }

    interface def RosTopicInterface specializes MessagingTopicInterface {
        end rosPublisher : RosPublisher :>> publisher;
        end rosSubscriber : RosSubscriber :>> subscriber;
        // A topic goes publisher to subscriber, always.
        attribute :>> direction default DirectionKind::output;
    }

    // ── Services: one correlated request/reply contract ────────────────
    abstract item def RosServiceRequest specializes RosMessage;
    abstract item def RosServiceResponse specializes RosMessage;

    port def RosServiceClient specializes SoftwarePort {
        out item request : RosServiceRequest;
        in item response : RosServiceResponse;
        attribute serviceName : String;
    }

    port def RosServiceServer specializes SoftwarePort {
        in item request : RosServiceRequest;
        out item response : RosServiceResponse;
        attribute serviceName : String;
    }

    interface def RosServiceInterface specializes SoftwareInterface {
        end client : RosServiceClient :>> source;
        end server : RosServiceServer :>> target;
        flow rosServiceRequestFlow of RosServiceRequest from client.request to server.request;
        flow rosServiceResponseFlow of RosServiceResponse from server.response to client.response;
    }

    // ── Actions: long-running goal protocol ─────────────────────────────
    // ROS 2 realizes an action through goal/result/cancel services plus
    // feedback/status topics. The port exposes those distinct native message
    // features, so an action cannot be mistaken for a two-message service.
    abstract item def RosActionGoal specializes RosMessage;
    abstract item def RosActionAcceptance specializes RosMessage;
    abstract item def RosActionFeedback specializes RosMessage;
    abstract item def RosActionResult specializes RosMessage;
    abstract item def RosActionCancel specializes RosMessage;
    abstract item def RosActionStatus specializes RosMessage;

    port def RosActionClient specializes SoftwarePort {
        out item goal : RosActionGoal;
        in item acceptance : RosActionAcceptance;
        in item feedback : RosActionFeedback;
        in item result : RosActionResult;
        out item cancel : RosActionCancel;
        in item actionStatus : RosActionStatus;
        attribute actionName : String;
    }

    port def RosActionServer specializes SoftwarePort {
        in item goal : RosActionGoal;
        out item acceptance : RosActionAcceptance;
        out item feedback : RosActionFeedback;
        out item result : RosActionResult;
        in item cancel : RosActionCancel;
        out item actionStatus : RosActionStatus;
        attribute actionName : String;
    }

    interface def RosActionInterface specializes SoftwareInterface {
        end client : RosActionClient :>> source;
        end server : RosActionServer :>> target;
        flow rosActionGoalFlow of RosActionGoal from client.goal to server.goal;
        flow rosActionAcceptanceFlow of RosActionAcceptance from server.acceptance to client.acceptance;
        flow rosActionFeedbackFlow of RosActionFeedback from server.feedback to client.feedback;
        flow rosActionCancelFlow of RosActionCancel from client.cancel to server.cancel;
        flow rosActionResultFlow of RosActionResult from server.result to client.result;
        flow rosActionStatusFlow of RosActionStatus from server.actionStatus to client.actionStatus;
    }

    abstract state def RosActionExecution specializes MemoState;
    state def RosActionAccepted specializes RosActionExecution;
    state def RosActionExecuting specializes RosActionExecution;
    state def RosActionCanceling specializes RosActionExecution;
    state def RosActionSucceeded specializes RosActionExecution;
    state def RosActionCanceled specializes RosActionExecution;
    state def RosActionAborted specializes RosActionExecution;

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
