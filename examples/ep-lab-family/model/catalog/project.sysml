// EP Lab Family — model identity and method binding.
//
// A reference product family: one model, one compile, holding a system of
// systems (`sos/`), what its systems share (`shared/`) and each system
// (`systems/<system>/`). The names are fictional.
package ep_lab_family_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    private import ep_lab_family_shared::*;
    private import ep_lab_family_mapping::*;
    private import ep_lab_family_ablation::*;
    private import ep_lab_family_recording::*;
    private import ep_lab_family_icds::*;
    private import ep_lab_family_sos::*;
    private import ep_lab_family_chains::*;
    private import ep_lab_family_clinical_use_cases::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "EPF-PMB-001"; :>> label = "EpLabFamilyMethodBinding"; }
        attribute :>> modelName = "EP Lab Family";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
