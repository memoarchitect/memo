package memo_examples_ui_screen_regions_relationships {
    private import memo_artifacts_configuration_management::*;
    private import memo_assurance_safety_risk::*;
    private import memo_examples_ui_screen_regions_architecture_implementation_ui::*;
    private import memo_examples_ui_screen_regions_assurance_requirements::*;
    connection rel_tracesRisk_uiElement12_reqDrugIdentityDisplay : TracesRisk connect sourceRiskElement ::> elMainScreen::uiElement12 to targetRiskElement ::> reqDrugIdentityDisplay;
    connection rel_changes_uiElement12_reqDrugIdentityDisplay : Changes connect changeRequest ::> elMainScreen::uiElement12 to changedElement ::> reqDrugIdentityDisplay;
}
