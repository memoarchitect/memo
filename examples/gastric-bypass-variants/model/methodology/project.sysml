// Gastric Bypass Variants — model identity and method binding.
package memo_examples_gastric_bypass_variants_project {
    private import memo::*;
    private import ScalarValues::*;


    private import memo_examples_gastric_bypass_variants::*;
    private import memo_examples_gastric_bypass_variants_viewpoints_operational_views::*;
    private import memo_examples_gastric_bypass_variants_viewpoints_functional_views::*;

    // The clinical extension brings the anatomy extension with it. The anatomy the model uses is
    // generated from FMA into a library of its own (`memo anatomy generate`), from the selector below.
    public import memo_extension_clinical::*;
    public import gastric_bypass_variants_anatomy_fma::*;
    part upperGi :> upperGastrointestinal;

    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-GASTRIC-BYPASS-001"; :>> label = "Gastric bypass variants model method binding"; }
        attribute :>> modelName = "Gastric Bypass Variants";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
