// MEMO base hierarchy. Construct-specific foundations: one base per
// SysML v2 metaclass family (part, action, port, interface, item, requirement,
// connection), each carrying the shared MEMO semantics. Common inheritance
// across metaclasses is not portable, so non-part bases re-declare the small
// identification core and share classification through the metadata defs in
// memo_core_dimensions.
//
// ─── The identification core ────────────────────────────────────────────
// Every MEMO base below declares the SAME attributes, in the same order,
// with no exceptions:
//
//     id, uuid, name, shortDescription, description,
//     rationale, sourceReference, status
//
// They are re-declared per metaclass only because KerML will not let an
// action, port, item, requirement, or connection inherit from a part def.
// The duplication is a language constraint, not a design choice — so treat
// the block as one unit: anything added or removed here is added or removed
// in all of them. The drift this replaces was real (MemoPort carried no
// sourceReference and no status; MemoRequirement and MemoNeed each invented
// their own status attribute), and drift here shows up as an element whose
// properties panel is missing fields its neighbours have.
//
// `uuid` is the stable technical identity: never displayed, never used as a
// label, never reused. Authors normally leave it unset and let the compiler
// derive it (memo-tools assigns a v5 UUID over file+kind+id); set it
// explicitly on an element whose file or id must be free to change without
// breaking external references to it, and the authored value wins.
package memo_core_common {
    private import ScalarValues::*;

    private import memo_core_dimensions::*;
    private import memo_core_terminology::*;
    private import memo_core_enumerations::*;

    // ─── Single abstract part root ──────────────────────────────────
    // Every structural MEMO concept specializes MemoPart. Identity and
    // traceability are attributes of this one root — MEMO has no separate
    // IdentifiedElement/TraceableElement classes, because *everything* is
    // identifiable and traceable by definition; that is not a type a modeler
    // picks. MemoPart is abstract: never instantiated, only specialized.
    //
    // Axis ownership (horizontal architecture layer vs. vertical assurance
    // discipline) is NOT an attribute — it is the element's owning package
    // (memo_architecture_* xor memo_assurance_*), enforced by CR-ONT-045.
    // The remaining dimensions are orthogonal to the axis: realization stage,
    // cross-cutting concern, and editorial status.
    abstract part def MemoPart {
        // identity
        attribute id : String;
        attribute uuid : String;
        attribute name : String;
        // Two description registers on every MEMO element, because views have
        // two densities. `shortDescription` is the one-line form a table cell,
        // matrix header, chip, or diagram node can show whole; `description` is
        // the full prose a properties panel or a generated document section
        // renders. A view picks the register that fits — it never truncates
        // the long one, because a silently clipped sentence in a DHF table is
        // a defect, not a layout choice.
        attribute shortDescription : String;
        attribute description : String;
        // traceability
        attribute rationale : String;
        attribute sourceReference : String;
        // editorial status and lifecycle
        attribute status : ElementStatusKind;
        attribute lifecycleState : LifecycleStateKind;
        // orthogonal dimensions
        attribute realizationStage : RealizationStageKind[0..1];
        attribute crossCuttingConcerns : CrossCuttingConcernKind[0..*];
        attribute concerns : ConcernKind[0..*];
        attribute applicableStandards : ExternalReference[0..*];
        attribute codes : TerminologyCode[0..*];
    }

    // ─── Role bases retained from the original kernel, re-founded on
    //     MemoPart so all existing content inherits the dimensions. ───
    part def RequirementDriver specializes MemoPart;
    abstract part def VerifiableElement specializes MemoPart;
    abstract part def ArchitectureElement specializes MemoPart;
    part def InterfaceElement specializes MemoPart;
    part def MemoEvidence specializes MemoPart;
    abstract part def AnalysisArtifact specializes MemoPart;

    // Document-bound elements add only what a document needs beyond the two
    // description registers every MemoPart now carries: a title and its place
    // in a document. The former `shortDescription`/`longDescription` pair is
    // gone — short is inherited, and `description` IS the long form.
    part def DocumentedElement specializes MemoPart {
        attribute title : String;
        attribute documentUsage : String[*];
        attribute sectionIdentifier : String;
    }

    // ─── Construct-specific foundations (non-part metaclasses) ───────

    // Behavioral foundation: operational activities, tasks, system actions,
    // and interaction steps specialize MemoAction.
    action def MemoAction {
        attribute id : String;
        attribute uuid : String;
        attribute name : String;
        attribute shortDescription : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
        attribute status : ElementStatusKind;
    }

    // Boundary feature foundation for typed ports.
    port def MemoPort {
        attribute id : String;
        attribute uuid : String;
        attribute name : String;
        attribute shortDescription : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
        attribute status : ElementStatusKind;
    }

    // Interaction-contract foundation for interface definitions between ports.
    abstract interface def MemoInterface {
        end source;
        end target;
        attribute id : String;
        attribute uuid : String;
        attribute name : String;
        attribute shortDescription : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
    }

    // Exchange-content foundation: everything that flows — information,
    // command, material, energy — is an item, not a part.
    item def MemoExchangeItem {
        attribute id : String;
        attribute uuid : String;
        attribute name : String;
        attribute shortDescription : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
        attribute status : ElementStatusKind;
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
    // Shared base of the requirement family. It exists so a relation end can
    // say "a need or a requirement" with one type name — before it, every end
    // that had to accept both was left untyped.
    abstract requirement def MemoRequirementElement {
        attribute id : String;
        attribute uuid : String;
        attribute name : String;
        attribute shortDescription : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
        attribute status : ElementStatusKind;
        attribute statement : String;
    }

    requirement def MemoNeed :> MemoRequirementElement {
        attribute needSource : String;
        attribute priority : String;
    }

    requirement def MemoRequirement :> MemoRequirementElement {
        attribute acceptanceCriteria : String;
    }

    // Verification-case foundation. A SysML v2 verification case is a behaviour
    // (it checks requirements), and KerML forbids a behaviour from specializing
    // the part-based MemoPart — so, like MemoAction, it re-declares the small
    // identification core rather than inheriting it.
    verification def MemoVerificationCase {
        attribute id : String;
        attribute uuid : String;
        attribute name : String;
        attribute shortDescription : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
        attribute status : ElementStatusKind;
    }

    // State foundation. SysML v2 states (state machines and their mode states)
    // are behaviours, so — like MemoAction and MemoVerificationCase — they
    // re-declare the identification core instead of specializing MemoPart
    // Transitions stay part-based to keep their traceable safety
    // attributes (id, sourceReference, priority, sameStepCritical).
    abstract state def MemoState {
        attribute id : String;
        attribute uuid : String;
        attribute name : String;
        attribute shortDescription : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
        attribute status : ElementStatusKind;
    }

    part def Citation specializes MemoPart {
        attribute source : String;
        attribute section : String;
        attribute uri : String;
        attribute year : String;
    }
}
