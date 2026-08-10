package memo_assurance_safety_risk {
    private import ScalarValues::*;
    private import memo_core_relationships::*;   // MemoRelationship

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_assurance_requirements::*;
    part def Risk specializes RiskDriver {
        attribute probabilityEstimate : ProbabilityKind;
        attribute severityEstimate : SeverityKind;
        attribute riskLevel : CriticalityKind;
        attribute acceptability : RiskAcceptabilityKind;
        attribute estimationBasis : String;
        attribute analysisContext : String;
        attribute foreseeableMisuseIncluded : Boolean;
    }
    part def ResidualRisk specializes Risk {
        attribute benefitRiskRequired : Boolean;
    }
    part def RiskMatrix specializes MemoPart {
        attribute probabilityScaleDefinition : String;
        attribute severityScaleDefinition : String;
        attribute riskLevelMapping : String;
        attribute acceptabilityThresholds : String;
    }
    part def DesignControlRiskRow specializes Risk {
        attribute rowTitle : String;
        attribute hazardAnalysis : String;
        attribute hazardCategory : String;
        attribute hazardSubcategory : String;
        attribute causeSequenceOfEventsFailure : String;
        attribute harmText : String;
        attribute probabilityBeforeRaw : String;
        attribute severityBeforeRaw : String;
        attribute riskBeforeMeasureRaw : String;
        attribute probabilityAfterRaw : String;
        attribute severityAfterRaw : String;
        attribute riskAfterMitigationRaw : String;
        attribute cannotReduceFurther : Boolean;
        attribute linkSummary : String;
    }
    // A device characteristic whose implementation, failure, or misuse can
    // affect safety. This is the modelable output of ISO 14971 §5.3.
    part def SafetyRelatedCharacteristic specializes MemoPart {
        attribute characteristic : String;
        attribute safetyImpact : String;
        attribute normalUseRelevant : Boolean;
        attribute faultConditionRelevant : Boolean;
    }
    // ─── Risk-element base ──────────────────────────────────────────
    // The common supertype of the item-based elements an ISO 14971 / FMEA /
    // FTA chain relates: hazards, sequences of events, hazardous situations,
    // harms, causes, failure modes, fault-tree events, cut sets, HAZOP
    // deviations, vulnerabilities.
    //
    // It exists so the risk relations can TYPE their ends. Before it, every
    // one of them (Causes, TracesRisk, DetectedBy, InputToGate, ProducesEvent,
    // ContainsEvent, IdentifiesHazard, Mitigates, ImpactsSafety) fell back to
    // MemoPart — which every element in MEMO is — so the authoring picker
    // offered fault-tree edges when linking a screen to a requirement.
    //
    // It is deliberately an `item def` and deliberately does NOT cover Risk /
    // ResidualRisk / RiskMatrix, which are parts: a risk is an assessed
    // judgement about a chain, not a link in it, and it is reached by
    // AssessedAgainst instead. One base per metaclass is the right shape here
    // — forcing the two families under one supertype would put a hazard and a
    // risk matrix back in the same picker.
    abstract item def RiskItem specializes MemoPart;

    item def Hazard specializes RiskItem {
        attribute hazardType : HazardTypeKind;
        attribute severity : SeverityKind;
        attribute foreseeable : Boolean;
    }
    item def SequenceOfEvents specializes RiskItem {
        attribute initiatingEvent : String;
        attribute contributingFactors : String;
    }
    // A categorized root cause in a hazard causal tree (FDA GIIP
    // taxonomy pattern: cause -> hazard -> hazardous situation -> harm;
    // several HazardCause elements may converge on one Hazard).
    item def HazardCause specializes RiskItem {
        attribute causeSource : CauseSourceKind;
        attribute contributingFactors : String;
    }
    item def HazardousSituation specializes RiskItem {
        attribute exposedPersons : String;
        attribute operatingCondition : String;
    }
    item def Harm specializes RiskItem {
        attribute clinicalImpact : String;
        attribute reversibility : String;
        attribute severity : SeverityKind;
    }
    item def RiskControlMeasure specializes VerifiableElement {
        attribute controlKind : RiskControlKind;
        attribute implementationKind : RiskControlImplementationKind;
        attribute verificationStatus : String;
    }
    part def Benefit specializes MemoPart {
        attribute beneficialOutcome : String;
        attribute beneficiary : String;
        attribute clinicalSignificance : String;
        attribute supportingEvidence : String;
    }
    item def OverallResidualRiskEvaluation specializes MemoPart {
        attribute conclusion : String;
        attribute reviewer : String;
    }

    // ── Relations owned by this package ─────────────────────────────
    // Moved out of memo_core_relationships: their ends are typed against
    // types declared here, and core must not depend on a domain package.
    // ISO 14971 risk chain — distinct sequence-of-events relations over risk elements.
    connection def TracesRisk :> MemoRelationship {
        end sourceRiskElement : RiskItem :>> source;
        end targetRiskElement : RiskItem :>> target;
    }
    connection def AssessedAgainst :> MemoRelationship {
        end risk : Risk :>> source;
        end riskMatrix : RiskMatrix :>> target;
    }
    // Mitigates unifies the control/action → risk-element edges of the
    // ISO 14971 / FMEA / FTA / cyber chains — MitigatesHazard,
    // MitigatesVulnerability, MitigatedByControl, BrokenByControl,
    // AddressedByAction — keyed by mitigationKind. control is the mitigating
    // control/action; mitigatedElement is the hazard/vulnerability/failure/cut set.
    enum def MitigationKind {
        enum hazard;
        enum vulnerability;
        enum failureMode;
        enum cutSet;
        enum fmeaAction;
    }
    connection def Mitigates :> MemoRelationship {
        attribute mitigationKind : MitigationKind;
        // Untyped: controls/hazards may be item defs (RiskControlMeasure, Hazard, …).
        end control :>> source;
        end mitigatedElement : RiskItem :>> target;
    }
}
