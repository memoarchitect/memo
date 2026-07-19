// Clinical procedures, techniques, and variants (§7). A ClinicalProcedure is
// the medically defined intervention (SNOMED-codeable via TerminologyCode);
// an OperationalWorkflow (memo_workflows) describes how the work of carrying
// it out is organized.
package memo_clinical_procedures {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;

    part def ClinicalProcedure specializes MemoPart {
        attribute bodySite : String;
        attribute clinicalObjective : String;
        attribute anesthesiaRequirement : String;
        attribute typicalDuration : String;
    }

    // A recognized way of performing a procedure or task (e.g. interrupted
    // vs. continuous suturing).
    part def ClinicalTechnique specializes MemoPart {
        attribute skillPrerequisites : String;
        attribute advantages : String;
        attribute limitations : String;
    }

    // A defined variant of a procedure (patient population, approach,
    // technology) that shares the parent's clinical objective.
    part def ProcedureVariant specializes ClinicalProcedure {
        attribute variationRationale : String;
        ref baseProcedure : ClinicalProcedure[1];
    }

    // A curated set of instruments/materials assembled for a procedure
    // (tray/set). Members are referenced medical products, not copies.
    part def InstrumentSet specializes MemoPart {
        attribute setPurpose : String;
        attribute sterileAssembly : Boolean;
    }

    connection def UsesTechnique :> MemoRelationship {
        end procedure : ClinicalProcedure;
        end technique : ClinicalTechnique;
    }
    connection def AssembledFor :> MemoRelationship {
        end instrumentSet : InstrumentSet;
        end procedure : ClinicalProcedure;
    }
    connection def SetIncludesProduct :> MemoRelationship {
        attribute quantity : Integer;
        end instrumentSet : InstrumentSet;
        end product : MemoPart;
    }
}
