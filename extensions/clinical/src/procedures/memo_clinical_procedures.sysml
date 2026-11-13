// Clinical data added to the base operational workflow, the analysis of a
// procedure: what it treats. Its scenarios hold the steps. Activities,
// tasks, techniques, variants, and resources continue to use the base ontology.
//
// Where a procedure acts is not an attribute here. A step's `targets` (memo_architecture_operational_activities)
// reference the anatomy, the parts of the anatomy extension that a project generates from FMA, so
// the site is a typed part with its FMA code and not a second, coded string. How long a procedure
// takes is not an attribute either: a number is set on a level-2 activity, per variant, and rolled
// up (memo_architecture_operational_rollups); a typical duration on the level-1 workflow is a
// number entered where the principle says none belongs.
package memo_extension_clinical_procedures {
    private import memo_core_stdlib_quantities::*;
    private import ScalarValues::*;

    private import memo_core_terminology::*;
    private import memo_architecture_operational_workflows::*;
    private import memo_viewpoints_rendering::*;
    private import memo_core_common::MemoIdentity;

    part def ClinicalProcedureWorkflow specializes ClinicalWorkflow {
        @MemoIdentity { :>> label = "Clinical procedure workflow"; }
        attribute procedureCode : TerminologyCode[0..1];
        attribute clinicalObjective : String;
        attribute anesthesiaRequirement : String;
    }

    // A package places its own kinds in the Model Explorer (the core ontology's classifications apply to the
    // core's). Without this the procedure workflow is listed in no domain, outside the level it is declared at.
    part explorerProceduresClassification : ExplorerClassification {
        @MemoIdentity { :>> providedId = "EXPL-031"; :>> label = "proceduresExplorerClassification"; }
        attribute :>> sourceNamespace = "procedures";
        attribute :>> explorerDomain = "architecture";
        attribute :>> explorerGroup = "operational";
    }
}
