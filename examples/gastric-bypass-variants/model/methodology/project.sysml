// Gastric Bypass Variants — model identity and method binding.
package memo_examples_gastric_bypass_variants_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    private import memo_examples_gastric_bypass_variants::*;
    private import memo_examples_gastric_bypass_variants_viewpoints_operational_views_bypass_flow_baseline::*;
    private import memo_examples_gastric_bypass_variants_viewpoints_operational_views_bypass_flow_functional::*;
    private import memo_examples_gastric_bypass_variants_viewpoints_operational_views_bypass_flow_laparoscopic::*;
    private import memo_examples_gastric_bypass_variants_viewpoints_operational_views_bypass_flow_our_robot::*;
    private import memo_examples_gastric_bypass_variants_viewpoints_operational_views_bypass_flow_competitor_robot::*;

    // The clinical extension brings the anatomy extension with it. The anatomy the model uses is
    // generated from FMA into a library of its own (`memo anatomy generate`), from the selector below.
    public import memo_extension_clinical::*;
    public import gastric_bypass_variants_anatomy_fma::*;
    part upperGi :> upperGastrointestinal;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-GASTRIC-BYPASS-001"; :>> label = "GastricBypassVariantsModelMethodBinding"; }
        attribute :>> modelName = "Gastric Bypass Variants";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
