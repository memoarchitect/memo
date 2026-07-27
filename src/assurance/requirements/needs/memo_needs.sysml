// Needs (§4). A Need is a problem-space expectation stated in stakeholder
// language; requirements (memo_assurance_requirements) are the solution-space
// obligations derived from needs. Need specializes the part-based
// RequirementDriver so it can serve as a typed end of trace relations
// (DerivesFrom, Motivates).
package memo_assurance_requirements_needs {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    // The kind of need. Was a subclass branch (StakeholderNeed / UserNeed /
    // ClinicalUserNeed / PatientUserNeed / BusinessNeed / ServiceNeed /
    // RegulatoryNeed / OperationalNeed / DesignControlNeed); now one attribute.
    // The exact terms survive as enum values, so design-input classification
    // (ISO 13485 §7.3.3, IEC 62366-1 user needs) is unchanged — it is simply
    // an attribute of the one Need type rather than a class the modeler picks.
    enum def NeedKind {
        enum stakeholder;
        enum user;
        enum clinicalUser;
        enum patientUser;
        enum business;
        enum service;
        enum regulatory;
        enum operational;
        enum designControl;
    }

    requirement def Need specializes MemoNeed, RequirementDriver {
        attribute needKind : NeedKind;
        // user need (IEC 62366-1)
        attribute userPopulationReference : String;
        // regulatory need
        attribute jurisdiction : String;
        attribute regulationReference : String;
        // operational need
        attribute operationalContextReference : String;
        // design-control need (ISO 13485 design input)
        attribute sourceFolder : String;
        attribute linkedDesignControls : String;
    }
}
