package memo_assurance_cybersecurity {
    private import ScalarValues::*;

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

    item def Vulnerability specializes MemoPart {
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
    part def ThreatScenario specializes MemoScenario {
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
}
