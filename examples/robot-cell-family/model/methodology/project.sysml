// Robot Cell Family — model identity and method binding.
//
// A reference product family: one model, one compile, holding a system of
// systems (`sos/`), what its systems share (`shared/`) and each system
// (`systems/<system>/`). The names are fictional.
package robot_cell_family_project {
    private import memo::*;
    private import ScalarValues::*;


    private import robot_cell_family_shared::*;
    private import robot_cell_family_systems_navigation_navigation_system::*;
    private import robot_cell_family_systems_manipulation_manipulation_system::*;
    private import robot_cell_family_systems_perception_perception_system::*;
    private import robot_cell_family_sos_icds::*;
    private import robot_cell_family_sos::*;
    private import robot_cell_family_sos_chains::*;
    private import robot_cell_family_sos_use_cases::*;

    part projectBinding : ModelMethodBinding {
        @MemoIdentity { :>> providedId = "RCF-PMB-001"; :>> label = "Robot cell family method binding"; }
        attribute :>> modelName = "Robot Cell Family";
        ref :>> selectedMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
