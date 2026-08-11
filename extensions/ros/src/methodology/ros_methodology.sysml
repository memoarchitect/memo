package memo_extension_ros_methodology {
    private import ScalarValues::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;
    private import memo_core_enumerations::*;

    // An extension that builds on other extensions names them all here.
    // `baseMethodology` is [0..1] — single inheritance, deliberate — but
    // `includedModule` is [0..*], so this is how a dependency between
    // extensions is expressed. There is no chaining and no second base.
    part rosExtensionMethod : MethodologyDefinition {
        attribute :>> id = "EXT-ROS-001";
        attribute :>> name = "Ros2Extension";
        attribute :>> version = "0.7.0";
        attribute :>> domain = "ROS 2 robotics middleware";
        attribute :>> description = "Adds ROS 2 nodes, messages, directional ports, topic/service/action interfaces, QoS, and containerized deployment.";
        ref :>> baseMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
        attribute :>> includedModule = (
            "memo_extension_messaging",
            "memo_extension_container",
            "memo_extension_ros"
        );
    }
}
