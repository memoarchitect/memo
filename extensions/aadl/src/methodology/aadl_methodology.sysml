package memo_extension_aadl_methodology {
    private import ScalarValues::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part aadlExtensionMethod : MethodologyDefinition {
        @MemoIdentity { :>> providedId = "EXT-AADL-001"; }
        attribute :>> name = "AadlCorrespondenceExtension";
        attribute :>> version = "0.7.0";
        attribute :>> domain = "AADL (SAE AS5506) software runtime";
        attribute :>> description = "Adds the AADL correspondence profile and the process / thread / virtual-processor runtime families.";
        ref :>> baseMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
        attribute :>> includedModule = "memo_extension_aadl";
    }
}
