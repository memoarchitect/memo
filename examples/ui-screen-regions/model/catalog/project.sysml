// UI screen regions — project identity and method binding.
//
// The native entrypoint for this project. Everything that decides what the
// model means is here or reachable from here: the imports name the reusable
// packages, and the binding names the methodology with a typed SysML
// reference. No YAML file participates. Removing every application setting
// from this directory leaves the model unchanged.
package memo_examples_ui_screen_regions_project {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    // The project's own content. Importing it here makes the catalog a single
    // reachable closure from one entrypoint.
    private import memo_examples_ui_screen_regions_architecture_implementation_ui::*;
    private import memo_examples_ui_screen_regions_architecture_functional_functions::*;
    private import memo_examples_ui_screen_regions_assurance_requirements::*;
    private import memo_examples_ui_screen_regions_assurance_requirements_needs::*;
    private import memo_examples_ui_screen_regions_assurance_human_factors::*;
    private import memo_examples_ui_screen_regions_assurance_safety_risk::*;
    private import memo_examples_ui_screen_regions_assurance_verification_validation::*;
    private import memo_examples_ui_screen_regions_artifacts_assets::*;
    private import memo_examples_ui_screen_regions_artifacts_reviews_comments::*;
    private import memo_examples_ui_screen_regions_artifacts_reviews_notes::*;
    private import memo_examples_ui_screen_regions_artifacts_reviews_rationales::*;
    private import memo_examples_ui_screen_regions_traces::*;
    private import memo_examples_ui_screen_regions_viewpoints_ui_layout::*;
    private import memo_examples_ui_screen_regions_viewpoints_requirements::*;
    private import memo_examples_ui_screen_regions_viewpoints_functional::*;
    private import memo_examples_ui_screen_regions_viewpoints_risk::*;

    part uiScreenRegionsBinding : ProjectMethodBinding {
        attribute :>> id = "PMB-UIR-001";
        attribute :>> name = "UIScreenRegionsProjectMethodBinding";
        attribute :>> projectName = "UI Screen Regions";
        // The default methodology selects everything the resolved ontology
        // provides, which is what makes the UI layout rules CR-MED-110…113
        // evaluable against this model.
        ref :>> selectedMethodology = mdDefaultDefinition;
        // The project adds no modules of its own.
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
