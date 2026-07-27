// Clinical data added to the base operational workflow. Activities, tasks,
// techniques, variants, and resources continue to use the base ontology.
package memo_extension_clinical_procedures {
    private import ScalarValues::*;

    private import memo_core_terminology::*;
    private import memo_architecture_operational_workflows::*;

    action def ClinicalProcedureWorkflow specializes OperationalWorkflow {
        attribute procedureCode : TerminologyCode[0..1];
        attribute bodySiteCode : TerminologyCode[0..1];
        attribute clinicalObjective : String;
        attribute anesthesiaRequirement : String;
        attribute typicalDuration : String;
    }
}
