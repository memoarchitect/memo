package memo_assurance_cybersecurity {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;
    private import memo_core_relationships::*;   // MemoRelationship

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;
    private import memo_architecture_operational_scenarios::*;

    part def CybersecurityAsset specializes ArchitectureElement {
        attribute assetKind : AssetKind;
        attribute confidentialityNeed : String;
        attribute integrityNeed : String;
        attribute availabilityNeed : String;
        attribute privacyRelevant : Boolean;
        attribute safetyRelevant : Boolean;
        attribute owningLayer : String;
        attribute assetOwner : String;
        attribute classification : String;
    }

    part def AttackSurface specializes MemoPart {
        attribute entryPointKind : InterfaceKind;
        attribute exposureLevel : String;
        attribute reachableFrom : String;
        attribute authenticationExpected : Boolean;
    }

    item def Threat specializes RiskDriver {
        attribute threatCategory : ThreatCategoryKind;
        attribute attackVector : String;
        attribute threatSource : String;
        attribute precondition : String;
        attribute affectedConcern : ConcernKind;
        attribute defaultTechnique : String;
        attribute strideCategory : ThreatCategoryKind;
    }

    item def Vulnerability specializes RiskItem {
        attribute weakness : String;
        attribute exploitability : String;
        attribute discoveryMethod : String;
        attribute affectedLayer : String;
        attribute cweReference : String;
        attribute remediable : Boolean;
    }

    // A scenario specialization: an attack path through the
    // system, classified by the shared scenario dimensions with purpose
    // `cybersecurity`.
    action def ThreatScenario specializes MemoScenario {
        attribute actorDescription : String;
        attribute assumptionSummary : String;
        attribute guaranteeSummary : String;
        attribute securityObjective : String;
        attribute abuseCaseReference : String;
        attribute defaultCategory : ThreatCategoryKind;
    }

    item def CyberHazard specializes Hazard {
        attribute securityImpact : String;
        attribute safetyImpact : String;
        attribute privacyImpact : String;
        attribute operationalImpact : String;
        attribute linkedSafetyHazardId : String;
    }

    item def CyberRisk specializes Risk {
        attribute exploitabilityEstimate : String;
        attribute attackComplexity : String;
        attribute detectability : DetectionKind;
        attribute essentialPerformanceImpact : String;
        attribute patientSafetyContribution : String;
    }

    part def CyberMitigation specializes RiskControlMeasure {
        attribute cyberControlKind : CyberControlKind;
        attribute securityMechanism : String;
        attribute verificationExpectation : String;
        attribute hardeningScope : String;
    }

    requirement def SecurityRequirement :> Requirement {
        attribute securityObjective : String;
        attribute derivedFromThreat : String;
        attribute derivedFromRisk : String;
        attribute defaultConcern : ConcernKind;
    }

    item def TrustBoundary specializes InterfaceElement {
        attribute boundaryType : String;
        attribute crossingConstraint : String;
        attribute trustAssumption : String;
    }

    part def SecurityClaim specializes MemoEvidence {
        attribute claimText : String;
        attribute claimScope : String;
        attribute supportedByEvidence : String;
    }

    // ── Relations owned by this package ─────────────────────────────
    // Moved out of memo_core_relationships: their ends are typed against
    // types declared here, and core must not depend on a domain package.
    connection def Exploits :> MemoRelationship {
        end realizedThreat : RequirementDriver :>> source;
        end enablingVulnerability : Vulnerability :>> target;
    }
    abstract connection exploitsLinks : Exploits[*];
    metadata def <exploits> ExploitsMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = exploitsLinks meta SysML::Usage;
    }
    connection def RealizedByScenario :> MemoRelationship {
        end realizedThreat : RequirementDriver :>> source;
        end scenario : MemoScenario :>> target;
    }
    abstract connection realizedByScenarioLinks : RealizedByScenario[*];
    metadata def <realizedByScenario> RealizedByScenarioMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = realizedByScenarioLinks meta SysML::Usage;
    }
    connection def ImpactsSafety :> MemoRelationship {
        attribute tracePurpose : String;
        end cyberElement : MemoPart :>> source;
        end safetyElement : RiskItem :>> target;
    }
    abstract connection impactsSafetyLinks : ImpactsSafety[*];
    metadata def <impactsSafety> ImpactsSafetyMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = impactsSafetyLinks meta SysML::Usage;
    }
}
