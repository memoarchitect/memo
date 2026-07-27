package memo_extension_clinical_methodology {
    private import ScalarValues::*;
    private import memo_methodology_core::*;

    part clinicalExtensionMethod : MethodologyDefinition {
        attribute :>> id = "EXT-CLINICAL-001";
        attribute :>> name = "ClinicalProcedureExtension";
        attribute :>> version = "0.6.1";
        attribute :>> domain = "clinical procedures";
        attribute :>> description = "Adds optional clinical-procedure vocabulary to a MEMO project.";
        attribute :>> baseMethodName = "MedicalDeviceLightDefault";
        attribute :>> includedModule = "memo_extension_clinical";
    }
}
