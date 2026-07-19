// MEMO base hierarchy. Construct-specific foundations: one base per
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
    // MemoPart. Axis ownership (horizontal architecture layer vs. vertical
    // assurance discipline) is NOT an attribute here — it is the element's
    // owning package (memo_architecture_* xor memo_assurance_*), enforced by
    // CR-ONT-045. The dimensions that remain are orthogonal to the axis:
    // realization stage, cross-cutting concern, and editorial status.
    part def MemoPart specializes TraceableElement {
        attribute status : ElementStatusKind;
        attribute lifecycleState : LifecycleStateKind;
        attribute realizationStage : RealizationStageKind[0..1];
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

    // Verification-case foundation. A SysML v2 verification case is a behaviour
    // (it checks requirements), and KerML forbids a behaviour from specializing
    // the part-based MemoPart — so, like MemoAction, it re-declares the small
    // identification core rather than inheriting it.
    verification def MemoVerificationCase {
        attribute id : String;
        attribute name : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
    }

    // State foundation. SysML v2 states (state machines and their mode states)
    // are behaviours, so — like MemoAction and MemoVerificationCase — they
    // re-declare the identification core instead of specializing MemoPart
    // Transitions stay part-based to keep their traceable safety
    // attributes (id, sourceReference, priority, sameStepCritical).
    state def MemoState {
        attribute id : String;
        attribute name : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
    }

    part def Citation specializes IdentifiedElement {
        attribute source : String;
        attribute section : String;
        attribute uri : String;
        attribute year : String;
    }
}
