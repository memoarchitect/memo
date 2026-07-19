// Needs hierarchy (§4). A Need is a problem-space expectation stated in
// stakeholder language; requirements (memo_assurance_requirements) are the
// solution-space obligations derived from needs. Needs also specialize the
// part-based RequirementDriver so they can serve as typed ends of trace
// relations (DerivesFrom, Motivates).
package memo_assurance_needs {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    requirement def Need specializes MemoNeed, RequirementDriver;

    requirement def StakeholderNeed specializes Need;

    // A need of a human who interacts with the device (design input per
    // ISO 13485 7.3.3; IEC 62366-1 user needs).
    requirement def UserNeed specializes StakeholderNeed {
        attribute userPopulationReference : String;
    }
    requirement def ClinicalUserNeed specializes UserNeed;
    requirement def PatientUserNeed specializes UserNeed;

    requirement def BusinessNeed specializes StakeholderNeed;
    requirement def ServiceNeed specializes StakeholderNeed;

    requirement def RegulatoryNeed specializes Need {
        attribute jurisdiction : String;
        attribute regulationReference : String;
    }
    requirement def OperationalNeed specializes Need {
        attribute operationalContextReference : String;
    }
}
