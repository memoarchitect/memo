// MEMO base hierarchy (ADR-0002). Construct-specific foundations: one base per
// SysML v2 metaclass family (part, action, port, interface, item, requirement,
// connection), each carrying the shared MEMO semantics. Common inheritance
// across metaclasses is not portable, so non-part bases re-declare the small
// identification core and share classification through the metadata defs in
// memo_core_dimensions.
package memo_core_common {
    private import ScalarValues::*;

    private import memo_core_dimensions::*;
    private import memo_core_terminology::*;
    private import memo_core_enumerations::*;

    // ─── Identification core (part lineage) ─────────────────────────
    part def IdentifiedElement {
        attribute id : String;
        attribute name : String;
        attribute description : String;
    }

    part def TraceableElement specializes IdentifiedElement {
        attribute rationale : String;
        attribute sourceReference : String;
    }

    // The part-based foundation. Every structural MEMO concept specializes
    // MemoPart and thereby participates in the orthogonal dimensions
    // (perspective, realization stage, discipline, cross-cutting concern)
    // without duplication (ADR-0001).
    part def MemoPart specializes TraceableElement {
        attribute status : ElementStatusKind;
        attribute lifecycleState : LifecycleStateKind;
        attribute perspective : ArchitecturePerspectiveKind[0..*];
        attribute realizationStage : RealizationStageKind[0..1];
        attribute disciplines : EngineeringDisciplineKind[0..*];
        attribute crossCuttingConcerns : CrossCuttingConcernKind[0..*];
        attribute concerns : ConcernKind[0..*];
        attribute applicableStandards : ExternalReference[0..*];
        attribute codes : TerminologyCode[0..*];
    }

    // ─── Role bases retained from the original kernel, re-founded on
    //     MemoPart so all existing content inherits the dimensions. ───
    part def RequirementDriver specializes MemoPart;
    part def VerifiableElement specializes MemoPart;
    part def ArchitectureElement specializes MemoPart;
    part def InterfaceElement specializes MemoPart;
    part def MemoEvidence specializes MemoPart;

    part def DocumentedElement specializes MemoPart {
        attribute title : String;
        attribute shortDescription : String;
        attribute longDescription : String;
        attribute documentUsage : String[*];
        attribute sectionIdentifier : String;
    }

    // ─── Construct-specific foundations (non-part metaclasses) ───────

    // Behavioral foundation: operational activities, tasks, system actions,
    // and interaction steps specialize MemoAction.
    action def MemoAction {
        attribute id : String;
        attribute name : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
        attribute status : ElementStatusKind;
    }

    // Boundary feature foundation for typed ports.
    port def MemoPort {
        attribute id : String;
        attribute name : String;
        attribute description : String;
        attribute direction : DirectionKind;
    }

    // Interaction-contract foundation for interface definitions between ports.
    interface def MemoInterface {
        attribute id : String;
        attribute name : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
    }

    // Exchange-content foundation: everything that flows — information,
    // command, material, energy — is an item, not a part.
    item def MemoExchangeItem {
        attribute id : String;
        attribute name : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
        attribute semantics : String;
        attribute unit : String;
        attribute minValue : String;
        attribute maxValue : String;
        attribute encoding : String;
        attribute timestampRequired : Boolean;
        attribute codes : TerminologyCode[0..*];
    }

    // Requirement-family foundations. MemoNeed captures a problem-space
    // expectation in stakeholder language; MemoRequirement a testable
    // solution-space obligation.
    requirement def MemoNeed {
        attribute needId : String;
        attribute statement : String;
        attribute needRationale : String;
        attribute needSource : String;
        attribute priority : String;
        attribute needStatus : ElementStatusKind;
    }

    requirement def MemoRequirement {
        attribute requirementId : String;
        attribute statement : String;
        attribute acceptanceCriteria : String;
        attribute requirementStatus : ElementStatusKind;
    }

    part def Citation specializes IdentifiedElement {
        attribute source : String;
        attribute section : String;
        attribute uri : String;
        attribute year : String;
    }
}
