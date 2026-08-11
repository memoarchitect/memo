package memo_extension_cloud_methodology {
    private import ScalarValues::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;
    private import memo_core_enumerations::*;

    part cloudExtensionMethod : MethodologyDefinition {
        attribute :>> id = "EXT-CLOUD-001";
        attribute :>> name = "CloudRuntimeExtension";
        attribute :>> version = "0.7.0";
        attribute :>> domain = "networked services and managed data stores";
        attribute :>> description = "Adds service and data-store runtime families with their contracts, discovery, and retention.";
        ref :>> baseMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
        attribute :>> includedModule = "memo_extension_cloud";
    }
}
