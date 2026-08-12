package memo_examples_ui_screen_regions_relationships {
    private import memo_artifacts_configuration_management::*;
    private import memo_assurance_safety_risk::*;
    connection rel_tracesRisk_uiElement12_reqDrugIdentityDisplay : TracesRisk connect sourceRiskElement ::> uiElement12 to targetRiskElement ::> reqDrugIdentityDisplay;
    connection rel_changes_uiElement12_reqDrugIdentityDisplay : Changes connect changeRequest ::> uiElement12 to changedElement ::> reqDrugIdentityDisplay;
}
