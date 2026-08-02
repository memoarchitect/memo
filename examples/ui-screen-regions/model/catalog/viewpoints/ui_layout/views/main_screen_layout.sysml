package memo_examples_ui_screen_regions_viewpoints_ui_layout_views_main_screen_layout {
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
    private import memo_examples_ui_screen_regions_viewpoints_ui_layout::*;
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

    // The geometry view: the capture as backdrop, elements drawn at their
    // authored bounds. Images for a layout view live in
    // `model/assets/<viewName>/`, so this view's backdrop is under
    // `model/assets/mainScreenLayout/`.
    //
    // `viewKind` is bound by MemoScreenLayoutView and inherited here; SysIDE
    // rejects redeclaring a bound feature value. No `diagramType` is set —
    // geometry has no legacy intent to map from.
    view mainScreenLayout : MemoScreenLayoutView {
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
        attribute :>> id = "UIE-001";
        attribute :>> title = "Main Infusion Screen — Region Layout";
        part :>> viewpointDefinition = uiLayoutViewpoint;
    }
}
