package memo_examples_ui_screen_regions_viewpoints_requirements_views_ui_requirements_trace {
    private import memo::*;
    private import ScalarValues::*;


    private import memo_examples_ui_screen_regions_viewpoints_requirements::*;
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

    view uiRequirementsTrace : MemoDiagramView {
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
        @MemoIdentity { :>> providedId = "REQ-101"; :>> shortDescription = "Clinical need through UI requirements to satisfying regions and functions."; }
        attribute :>> viewKind = DiagramViewKind::grid;
        attribute :>> diagramType = "req";
        attribute :>> autoPopulate = true;
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-101"; :>> label = "UIRequirementsTraceQuery"; }
            attribute :>> includeElementKinds = ("Need", "Requirement", "UIElement", "SystemFunction", "VerificationCase");
            attribute :>> includeRelationshipKinds = ("DerivesFrom", "SatisfiedBy", "VerifiedBy");
            attribute :>> includeLayers = ("requirements", "implementation", "functions", "assurance");
            attribute :>> rationaleText = "Show the example's requirement derivation and satisfaction chain.";
        }
        ref :>> viewpointDefinition = requirementsViewpoint;
    }
}
