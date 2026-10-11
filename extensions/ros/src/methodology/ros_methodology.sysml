package memo_extension_ros_methodology {
    private import ScalarValues::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_extension_messaging_methodology::messagingExtensionMethod;
    private import memo_extension_container_methodology::containerExtensionMethod;
    // An extension that builds on other extensions names them here, by their
    // methodologies: `includedExtension` is a typed reference, so the
    // dependency is checked by the compiler, and the import it needs is the
    // one the KPAR build reads to record the dependency. `baseMethodology`
    // stays [0..1] — single inheritance, deliberate — and the modules listed
    // are this extension's own packages only.
    part rosExtensionMethod : MethodologyDefinition {
        @MemoIdentity { :>> providedId = "EXT-ROS-001"; :>> label = "Ros2Extension"; }
        attribute :>> version = "0.13.2";
        attribute :>> domain = "ROS 2 robotics middleware";
        doc /* Adds ROS 2 nodes, messages, directional ports, topic/service/action interfaces, QoS, and containerized deployment. */
        ref :>> baseMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
        ref :>> includedExtension = (messagingExtensionMethod, containerExtensionMethod);
        attribute :>> includedModule = "memo_extension_ros";
    }
}
