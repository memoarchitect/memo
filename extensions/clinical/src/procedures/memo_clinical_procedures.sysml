// Clinical data added to the base operational workflow, the analysis of a
// procedure: what it treats and where. Its scenarios hold the steps. Activities,
// tasks, techniques, variants, and resources continue to use the base ontology.
package memo_extension_clinical_procedures {
    private import memo_core_stdlib_quantities::*;
    private import ScalarValues::*;

    private import memo_core_terminology::*;
    private import memo_architecture_operational_workflows::*;

    part def ClinicalProcedureWorkflow specializes OperationalWorkflow {
        attribute procedureCode : TerminologyCode[0..1];
        attribute bodySiteCode : TerminologyCode[0..1];
        attribute clinicalObjective : String;
        attribute anesthesiaRequirement : String;
        attribute typicalDuration : DurationValue;
    }
}
