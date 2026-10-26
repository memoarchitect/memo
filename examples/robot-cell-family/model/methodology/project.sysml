// Robot Cell Family — model identity and method binding.
//
// A reference product family: one model, one compile, holding a system of
// systems (`sos/`), what its systems share (`shared/`) and each system
// (`systems/<system>/`). The names are fictional.
package robot_cell_family_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    private import robot_cell_family_shared::*;
    private import robot_cell_family_systems_navigation_navigation_system::*;
    private import robot_cell_family_systems_manipulation_manipulation_system::*;
    private import robot_cell_family_systems_perception_perception_system::*;
    private import robot_cell_family_sos_icds::*;
    private import robot_cell_family_sos::*;
    private import robot_cell_family_sos_chains::*;
    private import robot_cell_family_sos_use_cases::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "RCF-PMB-001"; :>> label = "RobotCellFamilyMethodBinding"; }
        attribute :>> modelName = "Robot Cell Family";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
