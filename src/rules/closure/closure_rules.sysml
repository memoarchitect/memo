// Closure consistency rules. Portable SysML bodies remain literal `true` where
// cross-model navigation is not resolvable by a general SysML compiler; MEMO
// compiles the ontology-owned `predicateExpression` against the semantic model.
package memo_rules_closure {
    private import ScalarValues::*;

    private import memo_core_consistency_rules::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    // ─── Risk Layer Rules ────────────────────────────────────────────────

    constraint def HazardMitigationRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-001"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "Hazard";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "ISO 14971 requires each identified hazard to have risk control measures.";
        attribute predicateExpression = "mitigates->size() >= 1";
        constraint { true }
    }

    constraint def HazardSeverityRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-002"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "Hazard";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Hazard severity is required for risk estimation per ISO 14971.";
        attribute predicateExpression = "attributes.severity != ''";
        constraint { true }
    }

    constraint def RiskControlVerificationRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-003"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "RiskControlMeasure";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Risk controls shall be verified per ISO 14971 clause 7.4.";
        attribute predicateExpression = "verifiedBy->size() >= 1";
        constraint { true }
    }

    constraint def InitialRiskMatrixRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-004"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "Risk";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Pre-mitigation risk must be assessed against a risk acceptability matrix.";
        attribute predicateExpression = "assessedAgainst->size() >= 1";
        constraint { true }
    }

    // ─── Requirements Layer Rules ────────────────────────────────────────

    constraint def SysReqTraceRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-010"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "Requirement[requirementKind=system]";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Requirements shall be traceable to stakeholder needs per ISO 13485.";
        attribute predicateExpression = "derivesFrom->size() >= 1";
        constraint { true }
    }

    constraint def SwReqTraceRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-011"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "Requirement[requirementKind=software]";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Software requirements derive from system requirements per IEC 62304.";
        attribute predicateExpression = "derivesFrom->size() >= 1";
        constraint { true }
    }

    // CR-MED-012 (RequirementIdMustBeUnique) is intentionally omitted from the native
    // constraint set: cross-element uniqueness is not a single-subject predicate and
    // cannot be expressed as a `constraint { … }` body over one Requirement.
    // It remains an engine-level check.
    // Do not reintroduce the `predicate="uniqueAttribute"` part.

    // ─── Architecture Layer Rules ────────────────────────────────────────

    constraint def SwComponentSafetyClassRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-020"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "SoftwareModule";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "IEC 62304 requires safety classification for all software items.";
        attribute predicateExpression = "attributes.safetyClass != ''";
        constraint { true }
    }

    constraint def SwComponentReqRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-021"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "SoftwareModule";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Software items shall be linked to their requirements per IEC 62304.";
        attribute predicateExpression = "satisfiedBy->size() >= 1";
        constraint { true }
    }

    constraint def LogicalFunctionAllocationRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-022"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "SystemFunction";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Functions should be allocated to implementation elements.";
        attribute predicateExpression = "allocatedTo->size() >= 1";
        constraint { true }
    }

    // A function that no edge reaches is not in the chain. This was a
    // TypeScript rule (BV-002) applying to every action usage in the model,
    // which reported a scenario and a flow step as defects for not being
    // wired like a function. It is declared here instead: scoped by the
    // ontology to the family it is about, tailorable by a methodology, and
    // readable next to the rule that requires the allocation.
    constraint def FunctionInChainRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-023"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "MemoFunction";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "A function participates in the functional chain through a flow or a succession. One that participates in neither is unreachable behaviour: nothing triggers it and nothing consumes what it produces.";
        attribute predicateExpression = "flow->size() >= 1 or succession->size() >= 1";
        constraint { true }
    }

    // ─── Verification Layer Rules ────────────────────────────────────────

    constraint def VerificationCaseMethodRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-030"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "VerificationCase";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Verification method (test, analysis, inspection, demonstration) required per IEC 62304.";
        attribute predicateExpression = "attributes.methodKind != ''";
        constraint { true }
    }

    constraint def VerificationCaseTargetRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-031"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "VerificationCase";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Verification cases must be linked to verifiable items.";
        attribute predicateExpression = "verifiedBy->size() >= 1";
        constraint { true }
    }

    constraint def EvidenceProductionRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-032"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "VerificationCase";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Verification results should be documented as evidence records.";
        attribute predicateExpression = "producesEvidence->size() >= 1";
        constraint { true }
    }

    // ─── Cybersecurity Layer Rules ───────────────────────────────────────

    constraint def ThreatMitigationRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-040"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "Threat";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "FDA cybersecurity guidance requires threat mitigation.";
        attribute predicateExpression = "derivesCyberRequirement->size() >= 1";
        constraint { true }
    }

    constraint def AssetThreatLinkRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-041"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "CybersecurityAsset";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Assets should have threat analysis per FDA cybersecurity guidance.";
        attribute predicateExpression = "threatenedBy->size() >= 1";
        constraint { true }
    }

    // ─── Interface Rules ─────────────────────────────────────────────────

    constraint def LogicalInterfaceDirectionRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-050"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "Interface";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Interface direction required for integration analysis.";
        attribute predicateExpression = "attributes.direction != '' or attributes.directionality != ''";
        constraint { true }
    }

    // ─── Conditional Rules ───────────────────────────────────────────────

    constraint def SafetyClassCVerificationRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-101"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "SoftwareModule";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "IEC 62304 requires rigorous verification for Class C software.";
        attribute predicateExpression = "not(attributes.safetyClass == 'C') or verifiedBy->size() >= 1";
        constraint { true }
    }

    // ─── UI Layout Rules ─────────────────────────────────────────────────
    //
    // Traceability only: every part of a screen must have a design record
    // behind it, and captured evidence must say where it came from.
    //
    // Scope is traceability, not geometry. Layout correctness (child within
    // parent, inline siblings disjoint) is checked where the geometry is drawn,
    // in the renderer: a pairwise sibling comparison has no KerML constraint
    // form, since the evaluator has no Real literal and binds one implicit
    // subject per quantifier.

    // The load-bearing traceability rule. A UI element that is not chrome must
    // reach a design record — a requirement it satisfies, or an action it
    // triggers. Chrome must be DECLARED `decoration`; an element left
    // unclassified fails rather than passing as scenery.
    constraint def UiElementDesignRecordRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-110"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "UIElement";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Every functional UI element must have a design record — a requirement it satisfies or an action it triggers. Elements with formKind `decoration` are chrome and are exempt.";
        attribute predicateExpression = "attributes.formKind == 'decoration' or satisfiedBy->size() >= 1 or elementTriggersAction->size() >= 1";
        constraint { true }
    }

    // Interactive UI is where use error happens (IEC 62366-1), so a control
    // that reaches no system function is either dead UI or unmodelled UI.
    // The interactive-form restriction lives in the predicate because it spans
    // several enum values.
    constraint def ControlInvokesFunctionRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-111"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "UIElement";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "An interactive UI element (button, selector, slider, field) should trigger a UIAction that invokes a system function; otherwise the control's purpose is not in the model. Physical controls are OperatorInterfaceElement and are covered separately.";
        attribute predicateExpression = "not(formKind == 'button' or formKind == 'selector' or formKind == 'slider' or formKind == 'field') or elementTriggersAction->size() >= 1";
        constraint { true }
    }

    // Automatic boundary detection proposes; a reviewer disposes. An
    // unconfirmed machine guess must never reach a design review looking like
    // an engineering decision.
    constraint def BoundsDetectionConfirmedRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-112"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "UIElement";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Automatically detected bounds are a proposal until a reviewer confirms them; released UI documentation should contain no unconfirmed automatic bounds.";
        attribute predicateExpression = "not(attributes.detectionMethod == 'automatic') or attributes.confirmedBy != ''";
        constraint { true }
    }

    // A screenshot with no build behind it is undated design intent, not
    // evidence of what the device does.
    constraint def ScreenCaptureProvenanceRule :> MemoConsistencyRule {
        @MemoIdentity { :>> providedId = "CR-MED-113"; }
        attribute tailoring = RuleTailoringKind::assurance;
        attribute appliesTo = "ScreenCapture";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A screen capture used as design or usability evidence must identify the build it was taken from and hash the image bytes, or it cannot be relied on in the DHF.";
        attribute predicateExpression = "attributes.capturedBuild != '' and attributes.imageHash != ''";
        constraint { true }
    }
}
