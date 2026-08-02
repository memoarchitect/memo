package memo_extension_clinical_methodology {
    private import ScalarValues::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;
    private import memo_core_enumerations::*;

    part clinicalExtensionMethod : MethodologyDefinition {
        attribute :>> id = "EXT-CLINICAL-001";
        attribute :>> name = "ClinicalProcedureExtension";
        attribute :>> version = "0.6.5";
        attribute :>> domain = "clinical procedures";
        attribute :>> description = "Adds optional clinical-procedure vocabulary to a MEMO project.";
        // The base is a typed SysML reference, not a name to keep in sync with
        // another file. `baseMethodName` was the pre-flip spelling and no
        // longer resolves.
        ref :>> baseMethodology = mdDefaultDefinition;
        // An extension adds its own module to whatever its base selected;
        // saying so explicitly is required now that an empty list means empty.
        attribute :>> scopeMode = ScopeModeKind::explicit;
        attribute :>> includedModule = "memo_extension_clinical";
    }
}
