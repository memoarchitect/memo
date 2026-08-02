// Stakeholder needs.
package memo_examples_ui_screen_regions_assurance_requirements_needs {
    private import ScalarValues::*;

    private import memo_core_relationships::*;
    private import memo_core_annotations::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_implementation_ui::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_human_factors::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;
    private import memo_artifacts_core::*;

    private import memo_core_enumerations::*;
    private import memo_assurance_requirements_needs::*;

    requirement needReadableProgramming : Need {
        attribute :>> id = "UIR-NEED-001"; attribute :>> name = "ReadableAndConfirmableProgramming";
        attribute :>> needKind = NeedKind::'stakeholder';
        attribute :>> statement = "Clinicians need infusion programming to be readable and explicitly confirmed before therapy changes.";
        attribute :>> priority = "high";
    }

}
