package model_catalog_relationships {
    connection rel_tracesRisk_uiElement12_reqDrugIdentityDisplay : TracesRisk connect sourceRiskElement ::> uiElement12 to targetRiskElement ::> reqDrugIdentityDisplay;
    connection rel_changes_uiElement12_reqDrugIdentityDisplay : Changes connect changeRequest ::> uiElement12 to changedElement ::> reqDrugIdentityDisplay;
}
