package memo_extension_aadl_methodology {
    private import ScalarValues::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part aadlExtensionMethod : MethodologyDefinition {
        @MemoIdentity { :>> providedId = "EXT-AADL-001"; :>> label = "AadlCorrespondenceExtension"; }
        attribute :>> version = "0.13.2";
        attribute :>> domain = "AADL (SAE AS5506) software runtime";
        doc /* Adds the AADL correspondence profile and the process / thread / virtual-processor runtime families. */
        ref :>> baseMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
        // Every package the extension ships, so a project that includes the
        // extension selects all of them. The facade alone would leave the
        // packages that declare the definitions out of an explicit scope.
        attribute :>> includedModule = (
            "memo_extension_aadl",
            "memo_extension_aadl_runtime",
            "memo_extension_aadl_correspondence"
        );
    }
}
