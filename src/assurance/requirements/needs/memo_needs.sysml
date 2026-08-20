// Needs (§4). A Need is a problem-space expectation stated in stakeholder
// language; requirements (memo_assurance_requirements) are the solution-space
// obligations derived from needs. Need specializes the part-based
// RequirementDriver so it can serve as a typed end of trace relations
// (DerivesFrom, Motivates).
package memo_assurance_requirements_needs {
    private import ScalarValues::*;

    private import Metaobjects::SemanticMetadata;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    // A need is held by someone and arises in a context, and both are modelled
    // elements. Assurance may depend on architecture; the reverse may not.
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_context_use_context::*;

    // The kind of need. Was a subclass branch (StakeholderNeed / UserNeed /
    // ClinicalUserNeed / PatientUserNeed / BusinessNeed / ServiceNeed /
    // RegulatoryNeed / OperationalNeed / DesignControlNeed); now one attribute.
    // The exact terms survive as enum values, so design-input classification
    // (ISO 13485 §7.3.3, IEC 62366-1 user needs) is unchanged — it is simply
    // an attribute of the one Need type rather than a class the modeler picks.
    enum def NeedKind {
        enum 'stakeholder';
        enum user;
        enum clinicalUser;
        enum patientUser;
        enum business;
        enum service;
        enum regulatory;
        enum operational;
        enum designControl;
    }

    requirement def Need specializes MemoNeed {
        attribute needKind : NeedKind;
        // A user need (IEC 62366-1) says WHOSE need it is with HeldBy, and the
        // user's characteristics live on the User: `userPopulation`,
        // `impairmentConsiderations`, `intendedTraining`, `intendedQualification`.
        // A `userPopulationReference` string stood here and held prose — "ward
        // nurses, including those wearing corrective lenses" — which is two
        // typed attributes of a user profile written as one sentence nothing
        // could read, on the wrong element.
        // regulatory need
        attribute jurisdiction : String;
        attribute regulationReference : String;
        // The context an operational need arises in. Typed, because UseContext
        // carries the care setting, environment and jurisdiction that an
        // `operationalContextReference` string could only describe.
        ref useContext : UseContext[0..1];
        // design-control need (ISO 13485 design input)
        attribute sourceFolder : String;
    }

    // Whose need this is. The holder is a modelled participant — a User, with
    // the profile IEC 62366-1 asks for, or another operational participant —
    // so "which users does this need serve" is a question the model answers
    // rather than a sentence a reader interprets.
    connection def HeldBy :> MemoRelationship {
        end need : MemoNeed :>> source;
        end holder : OperationalParticipant :>> target;
    }
    abstract connection heldByLinks : HeldBy[*];
    metadata def <heldBy> HeldByMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = heldByLinks meta SysML::Usage;
    }
}
