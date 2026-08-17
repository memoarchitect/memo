package memo_examples_ui_screen_regions_viewpoints_functional_views_ui_functional_tree {
    private import ScalarValues::*;

    private import memo_core_relationships::*;
    private import memo_core_annotations::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_implementation_ui::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_human_factors::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;
    private import memo_artifacts_core::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;
    private import memo_viewpoints_ui_layout_views_screen_layout_view::*;
    private import memo_examples_ui_screen_regions_viewpoints_functional::*;
    private import memo_examples_ui_screen_regions_architecture_implementation_ui::*;
    private import memo_examples_ui_screen_regions_architecture_functional_functions::*;
    private import memo_examples_ui_screen_regions_assurance_requirements::*;
    private import memo_examples_ui_screen_regions_assurance_requirements_needs::*;
    private import memo_examples_ui_screen_regions_assurance_human_factors::*;
    private import memo_examples_ui_screen_regions_assurance_safety_risk::*;
    private import memo_examples_ui_screen_regions_assurance_verification_validation::*;
    private import memo_examples_ui_screen_regions_artifacts_assets::*;
    private import memo_examples_ui_screen_regions_artifacts_reviews_comments::*;
    private import memo_examples_ui_screen_regions_artifacts_reviews_rationales::*;
    private import memo_examples_ui_screen_regions_artifacts_reviews_notes::*;
    private import memo_examples_ui_screen_regions_traces::*;

    view uiFunctionalTree : MemoDiagramView {
        expose memo_examples_ui_screen_regions_architecture_implementation_ui::*;
        expose memo_examples_ui_screen_regions_architecture_functional_functions::*;
        expose memo_examples_ui_screen_regions_assurance_requirements::*;
        expose memo_examples_ui_screen_regions_assurance_requirements_needs::*;
        expose memo_examples_ui_screen_regions_assurance_human_factors::*;
        expose memo_examples_ui_screen_regions_assurance_safety_risk::*;
        expose memo_examples_ui_screen_regions_assurance_verification_validation::*;
        expose memo_examples_ui_screen_regions_artifacts_assets::*;
        expose memo_examples_ui_screen_regions_artifacts_reviews_comments::*;
        expose memo_examples_ui_screen_regions_artifacts_reviews_rationales::*;
        expose memo_examples_ui_screen_regions_artifacts_reviews_notes::*;
        expose memo_examples_ui_screen_regions_traces::*;
        attribute depth = 3;
        attribute :>> id = "FUN-101";
        attribute :>> shortDescription = "Display-management functions, invoked actions, and UI allocation.";
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
        attribute :>> autoPopulate = true;
        part :>> selectionQuery {
            attribute :>> id = "QRY-102";
            attribute :>> name = "UIFunctionalTreeQuery";
            attribute :>> includeElementKinds = ("SystemFunction", "UIAction", "UIElement", "UserInterface");
            attribute :>> includeRelationshipKinds = ("Composes", "ElementTriggersAction", "Performs", "AllocatedTo");
            attribute :>> includeLayers = ("functions", "implementation");
            attribute :>> rationaleText = "Show function decomposition from interaction to allocated user interface.";
        }
        ref :>> viewpointDefinition = functionalViewpoint;
    }
}
