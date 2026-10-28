// Gastric Bypass Variants — model identity and method binding.
package memo_examples_gastric_bypass_variants_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    private import memo_examples_gastric_bypass_variants::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-GASTRIC-BYPASS-001"; :>> label = "GastricBypassVariantsModelMethodBinding"; }
        attribute :>> modelName = "Gastric Bypass Variants";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
