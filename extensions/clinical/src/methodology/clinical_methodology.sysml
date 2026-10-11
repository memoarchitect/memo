package memo_extension_clinical_methodology {
    private import ScalarValues::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part clinicalExtensionMethod : MethodologyDefinition {
        @MemoIdentity { :>> providedId = "EXT-CLINICAL-001"; :>> label = "ClinicalProcedureExtension"; }
        attribute :>> version = "0.13.2";
        attribute :>> domain = "clinical procedures";
        doc /* Adds optional clinical-procedure vocabulary to a MEMO project. */
        // The base is a typed SysML reference, not a name to keep in sync with
        // another file. `baseMethodName` was the pre-flip spelling and no
        // longer resolves.
        ref :>> baseMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
        // Every package the extension ships, so a project that includes the
        // extension selects all of them: the facade, and the package that
        // declares ClinicalProcedureWorkflow.
        attribute :>> includedModule = (
            "memo_extension_clinical",
            "memo_extension_clinical_procedures"
        );
    }
}
