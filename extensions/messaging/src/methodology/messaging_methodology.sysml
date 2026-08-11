package memo_extension_messaging_methodology {
    private import ScalarValues::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;
    private import memo_core_enumerations::*;

    part messagingExtensionMethod : MethodologyDefinition {
        attribute :>> id = "EXT-MESSAGING-001";
        attribute :>> name = "MessagingExtension";
        attribute :>> version = "0.7.0";
        attribute :>> domain = "publish/subscribe messaging";
        attribute :>> description = "Adds message items, publisher/subscriber ports, topic interfaces, brokers, and delivery semantics.";
        ref :>> baseMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
        attribute :>> includedModule = "memo_extension_messaging";
    }
}
