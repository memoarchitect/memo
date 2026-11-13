// Cybersecurity (FDA premarket cybersecurity guidance 2023, AAMI TIR57).
// What an element is linked to is a relation, not a string naming it: a
// security requirement's source threat is `DerivesCyberRequirement`, not a
// `derivedFromThreat` id, and an asset's threats are `ThreatenedBy`. Which
// layer an element belongs to is its package; an asset or a vulnerability
// that lives in the architecture points at that element with a typed ref.
// `ThreatenedBy` lives here rather than in memo_core_relationships because
// its ends are typed against CybersecurityAsset and Threat.
package memo_assurance_cybersecurity {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;
    private import memo_core_relationships::*;   // MemoRelationship

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;
    private import memo_architecture_operational_scenarios::*;
    private import memo_architecture_implementation_software_structure::SBOMEntry;

    part def CybersecurityAsset specializes MemoPart {
        @MemoIdentity { :>> label = "Cybersecurity asset"; }
        attribute assetKind : AssetKind;
        attribute confidentialityNeed : SecurityNeedKind;
        attribute integrityNeed : SecurityNeedKind;
        attribute availabilityNeed : SecurityNeedKind;
        attribute privacyRelevant : Boolean;
        attribute safetyRelevant : Boolean;
        attribute assetOwner : String;
        attribute classification : String;
        // The architecture elements that store, process or are this asset.
        ref holder : MemoPart[0..*];
    }

    part def AttackSurface specializes MemoPart {
        @MemoIdentity { :>> label = "Attack surface"; }
        attribute entryPointKind : InterfaceKind;
        attribute exposureLevel : String;
        attribute reachableFrom : String;
        attribute authenticationExpected : Boolean;
    }

    part def Threat specializes RiskDriver {
        @MemoIdentity { :>> label = "Threat"; }
        attribute threatCategory : ThreatCategoryKind;
        attribute attackVector : String;
        attribute threatSource : String;
        attribute precondition : String;
        attribute affectedConcern : ConcernKind;
    }

    item def Vulnerability specializes RiskItem {
        @MemoIdentity { :>> label = "Vulnerability"; }
        attribute weakness : String;
        attribute exploitability : String;
        attribute discoveryMethod : String;
        attribute cweReference : String;
        attribute cveReference : String;
        attribute remediable : Boolean;
        attribute vulnerabilityDisposition : VulnerabilityDispositionKind;
        // CVSS v3.1 quantitative rating — the core output of a vulnerability
        // analysis (e.g. RSK-00058). `cvssBaseScore` is the 0.0-10.0 numeric
        // score; `cvssVector` the source vector string (AV:.../AC:.../...).
        attribute cvssBaseScore : Real;
        attribute cvssVector : String;
        // The architecture elements the weakness is in.
        ref affectedElement : MemoPart[0..*];
    }

    item def CyberHazard specializes Hazard {
        @MemoIdentity { :>> label = "Cyber hazard"; }
        attribute securityImpact : String;
        attribute safetyImpact : String;
        attribute privacyImpact : String;
        attribute operationalImpact : String;
    }

    part def CyberRisk specializes Risk {
        @MemoIdentity { :>> label = "Cyber risk"; }
        attribute exploitabilityEstimate : String;
        attribute attackComplexity : String;
        attribute detectability : DetectionKind;
        attribute essentialPerformanceImpact : String;
        attribute patientSafetyContribution : String;
    }

    part def CyberMitigation specializes RiskControlMeasure {
        @MemoIdentity { :>> label = "Cyber mitigation"; }
        attribute cyberControlKind : CyberControlKind;
        attribute securityMechanism : String;
        attribute verificationExpectation : String;
        attribute hardeningScope : String;
    }

    requirement def SecurityRequirement :> Requirement {
        @MemoIdentity { :>> label = "Security requirement"; }
        attribute securityObjective : String;
    }

    part def TrustBoundary specializes InterfaceElement {
        @MemoIdentity { :>> label = "Trust boundary"; }
        attribute boundaryType : String;
        attribute crossingConstraint : String;
        attribute trustAssumption : String;
    }

    // ── Product-security and threat-intelligence extensions ─────────
    enum def ThreatActorKind {
        enum insider;
        enum serviceTechnician;
        enum opportunistic;
        enum cybercriminal;
        enum nationState;
        enum supplyChain;
    }
    enum def ThreatCapabilityKind {
        enum low;
        enum moderate;
        enum high;
        enum advanced;
    }
    enum def ThreatAccessKind {
        enum physical;
        enum local;
        enum network;
        enum remote;
        enum supplyChain;
    }
    enum def AttackTechniqueFrameworkKind {
        enum mitreAttackIcs;
        enum mitreEmb3d;
        enum capec;
        enum other;
    }
    enum def SecurityObjectiveKind {
        enum confidentiality;
        enum integrity;
        enum availability;
        enum authenticity;
        enum accountability;
        enum privacy;
        enum safety;
    }
    enum def CyberAssumptionValidityKind {
        enum valid;
        enum reviewDue;
        enum invalid;
        enum retired;
    }
    enum def VulnerabilityDispositionKind {
        enum open;
        enum mitigated;
        enum accepted;
        enum closed;
    }
    enum def SecurityFindingStatusKind {
        enum open;
        enum inRemediation;
        enum accepted;
        enum closed;
    }
    enum def PostmarketProcessKind {
        enum monitoring;
        enum vulnerabilityDisclosure;
        enum patching;
        enum incidentResponse;
    }
    enum def CyberRiskAssessmentStageKind {
        enum inherent;
        enum residual;
    }

    // A threat is an actor of its own: it takes part from outside the system, as
    // MemoActor says. What kind of threat it is goes in threatActorKind; the
    // inherited actorKind names a user role and is not set on a threat.
    part def ThreatActor specializes MemoActor {
        @MemoIdentity { :>> label = "Threat actor"; }
        attribute threatActorKind : ThreatActorKind;
        attribute motivation : String;
        attribute capability : ThreatCapabilityKind;
        attribute accessMode : ThreatAccessKind;
        attribute organization : String;
    }

    part def AttackTechnique specializes MemoPart {
        @MemoIdentity { :>> label = "Attack technique"; }
        attribute framework : AttackTechniqueFrameworkKind;
        attribute externalId : String;
        attribute tactic : String;
        attribute platform : String;
        attribute techniqueVersion : String;
    }

    part def SecurityProperty specializes MemoPart {
        @MemoIdentity { :>> label = "Security property"; }
        attribute objectiveKind : SecurityObjectiveKind;
        attribute impactLevel : CriticalityKind;
        attribute propertyRationale : String;
    }

    part def CybersecurityAssumption specializes MemoPart {
        @MemoIdentity { :>> label = "Cybersecurity assumption"; }
        attribute statement : String;
        attribute owner : String;
        attribute reviewDate : String;
        attribute expirationDate : String;
        attribute validity : CyberAssumptionValidityKind;
    }

    // The path's narrative is the inherited `pathSummary`.
    action def AttackPath specializes OperativeScenario {
        @MemoIdentity { :>> label = "Attack path"; }
        attribute entryPoint : String;
        attribute attackGoal : String;
    }

    // Security assessment: a case is the planned activity (penetration test,
    // static or dynamic analysis, composition analysis), a report is the
    // evidence it produced, and a finding is one result in the report.
    // The case is a verification case: it checks the security requirements,
    // and `ProducesEvidence` already links a verification case to what it
    // produced. The method is stated once, on the case; a finding is one
    // type whose method-specific descriptors are optional, as Interface's
    // are. A finding is traced to its vulnerability by
    // `IdentifiesVulnerability`, and from there to the SBOM entry by
    // `AffectsSBOMEntry`.
    enum def SecurityAssessmentMethodKind {
        enum penetrationTest;
        enum sast;
        enum dast;
        enum sca;
    }
    verification def SecurityAssessmentCase :> VerificationCase {
        @MemoIdentity { :>> label = "Security assessment case"; }
        attribute assessmentMethod : SecurityAssessmentMethodKind;
        attribute assessmentScope : String;
        attribute toolName : String;
        attribute toolVersion : String;
    }
    part def SecurityFinding specializes MemoEvidence {
        @MemoIdentity { :>> label = "Security finding"; }
        attribute findingIdentifier : String;
        attribute severity : CriticalityKind;
        attribute cvssBaseScore : Real;
        attribute cvssVector : String;
        attribute findingStatus : SecurityFindingStatusKind;
        attribute retestDate : String;
        // method-specific (optional)
        attribute weaknessReference : String[0..1];   // CWE identifier (SAST)
        attribute sourceLocation : String[0..1];      // file and line (SAST)
        attribute testedEndpoint : String[0..1];      // URL or interface (DAST)
    }
    part def SecurityAssessmentReport specializes MemoEvidence {
        @MemoIdentity { :>> label = "Security assessment report"; }
        attribute reportDate : String;
        attribute assessor : String;
        part finding : SecurityFinding[0..*];
    }

    action def PostmarketProcess specializes MemoAction {
        @MemoIdentity { :>> label = "Postmarket process"; }
        attribute processKind : PostmarketProcessKind;
        attribute owner : String;
        attribute cadence : String;
        attribute serviceLevelTarget : String;
    }

    // A CyberRisk remains the stable risk identity. Assessments record its
    // pre-control (inherent) and post-control (residual) states without
    // duplicating the risk itself.
    part def CyberRiskAssessment specializes MemoPart {
        @MemoIdentity { :>> label = "Cyber risk assessment"; }
        attribute assessmentStage : CyberRiskAssessmentStageKind;
        attribute probabilityEstimate : ProbabilityKind;
        attribute severityEstimate : SeverityKind;
        attribute riskLevel : CriticalityKind;
        attribute acceptability : RiskAcceptabilityKind;
        attribute controlsAppliedSummary : String;
        attribute assessmentDate : String;
        attribute assessor : String;
        attribute approver : String;
    }

    // ── Relations owned by this package ─────────────────────────────
    connection def ThreatenedBy :> MemoRelationship {
        @MemoIdentity { :>> label = "Threatened by"; }
        attribute threatRole : String;
        end protectedAsset : CybersecurityAsset :>> source;
        end threat : Threat :>> target;
    }
    abstract connection threatenedByLinks : ThreatenedBy[*];
    metadata def <threatenedBy> ThreatenedByMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = threatenedByLinks meta SysML::Usage;
    }
    connection def Exploits :> MemoRelationship {
        @MemoIdentity { :>> label = "Exploits"; }
        end threat : Threat :>> source;
        end enablingVulnerability : Vulnerability :>> target;
    }
    abstract connection exploitsLinks : Exploits[*];
    metadata def <exploits> ExploitsMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = exploitsLinks meta SysML::Usage;
    }
    connection def RealizedByScenario :> MemoRelationship {
        @MemoIdentity { :>> label = "Realized by scenario"; }
        end realizedThreat : RequirementDriver :>> source;
        end scenario : OperativeScenario :>> target;
    }
    abstract connection realizedByScenarioLinks : RealizedByScenario[*];
    metadata def <realizedByScenario> RealizedByScenarioMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = realizedByScenarioLinks meta SysML::Usage;
    }
    connection def ImpactsSafety :> MemoRelationship {
        @MemoIdentity { :>> label = "Impacts safety"; }
        attribute :>> isTrace = true;
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

    // ── Product-security and threat-intelligence relations ──────────

    connection def HasSecurityProperty :> MemoRelationship {
        @MemoIdentity { :>> label = "Has security property"; }
        end characterizedAsset : CybersecurityAsset :>> source;
        end securityProperty : SecurityProperty :>> target;
    }
    abstract connection hasSecurityPropertyLinks : HasSecurityProperty[*];
    metadata def <hasSecurityProperty> HasSecurityPropertyMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = hasSecurityPropertyLinks meta SysML::Usage;
    }

    connection def ExposesAsset :> MemoRelationship {
        @MemoIdentity { :>> label = "Exposes asset"; }
        end attackSurface : AttackSurface :>> source;
        end exposedAsset : CybersecurityAsset :>> target;
    }
    abstract connection exposesAssetLinks : ExposesAsset[*];
    metadata def <exposesAsset> ExposesAssetMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = exposesAssetLinks meta SysML::Usage;
    }

    connection def AttributedToThreatActor :> MemoRelationship {
        @MemoIdentity { :>> label = "Attributed to threat actor"; }
        end attributedThreat : Threat :>> source;
        end threatActor : ThreatActor :>> target;
    }
    abstract connection attributedToThreatActorLinks : AttributedToThreatActor[*];
    metadata def <attributedToThreatActor> AttributedToThreatActorMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = attributedToThreatActorLinks meta SysML::Usage;
    }

    connection def UsesAttackTechnique :> MemoRelationship {
        @MemoIdentity { :>> label = "Uses attack technique"; }
        end realizedThreat : Threat :>> source;
        end attackTechnique : AttackTechnique :>> target;
    }
    abstract connection usesAttackTechniqueLinks : UsesAttackTechnique[*];
    metadata def <usesAttackTechnique> UsesAttackTechniqueMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = usesAttackTechniqueLinks meta SysML::Usage;
    }

    connection def IncludesAttackTechnique :> MemoRelationship {
        @MemoIdentity { :>> label = "Includes attack technique"; }
        end attackPath : AttackPath :>> source;
        end attackTechnique : AttackTechnique :>> target;
    }
    abstract connection includesAttackTechniqueLinks : IncludesAttackTechnique[*];
    metadata def <includesAttackTechnique> IncludesAttackTechniqueMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = includesAttackTechniqueLinks meta SysML::Usage;
    }

    connection def RealizesCyberHazard :> MemoRelationship {
        @MemoIdentity { :>> label = "Realizes cyber hazard"; }
        end realizedThreat : Threat :>> source;
        end resultingCyberHazard : CyberHazard :>> target;
    }
    abstract connection realizesCyberHazardLinks : RealizesCyberHazard[*];
    metadata def <realizesCyberHazard> RealizesCyberHazardMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = realizesCyberHazardLinks meta SysML::Usage;
    }

    connection def AssessesCyberRisk :> MemoRelationship {
        @MemoIdentity { :>> label = "Assesses cyber risk"; }
        end assessment : CyberRiskAssessment :>> source;
        end assessedRisk : CyberRisk :>> target;
    }
    abstract connection assessesCyberRiskLinks : AssessesCyberRisk[*];
    metadata def <assessesCyberRisk> AssessesCyberRiskMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = assessesCyberRiskLinks meta SysML::Usage;
    }

    connection def IdentifiesVulnerability :> MemoRelationship {
        @MemoIdentity { :>> label = "Identifies vulnerability"; }
        end finding : SecurityFinding :>> source;
        end identifiedVulnerability : Vulnerability :>> target;
    }
    abstract connection identifiesVulnerabilityLinks : IdentifiesVulnerability[*];
    metadata def <identifiesVulnerability> IdentifiesVulnerabilityMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = identifiesVulnerabilityLinks meta SysML::Usage;
    }

    connection def AffectsSBOMEntry :> MemoRelationship {
        @MemoIdentity { :>> label = "Affects SBOM entry"; }
        end vulnerability : Vulnerability :>> source;
        end affectedComponent : SBOMEntry :>> target;
    }
    abstract connection affectsSBOMEntryLinks : AffectsSBOMEntry[*];
    metadata def <affectsSBOMEntry> AffectsSBOMEntryMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = affectsSBOMEntryLinks meta SysML::Usage;
    }

    connection def DemonstratesAttackPath :> MemoRelationship {
        @MemoIdentity { :>> label = "Demonstrates attack path"; }
        end finding : SecurityFinding :>> source;
        end demonstratedPath : AttackPath :>> target;
    }
    abstract connection demonstratesAttackPathLinks : DemonstratesAttackPath[*];
    metadata def <demonstratesAttackPath> DemonstratesAttackPathMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = demonstratesAttackPathLinks meta SysML::Usage;
    }

    connection def SupportsMitigationEffectiveness :> MemoRelationship {
        @MemoIdentity { :>> label = "Supports mitigation effectiveness"; }
        end supportingEvidence : MemoEvidence :>> source;
        end supportedMitigation : CyberMitigation :>> target;
    }
    abstract connection supportsMitigationEffectivenessLinks : SupportsMitigationEffectiveness[*];
    metadata def <supportsMitigationEffectiveness> SupportsMitigationEffectivenessMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = supportsMitigationEffectivenessLinks meta SysML::Usage;
    }

    connection def ConditionsCyberElement :> MemoRelationship {
        @MemoIdentity { :>> label = "Conditions cyber element"; }
        end governingAssumption : CybersecurityAssumption :>> source;
        end conditionedElement :>> target;
    }
    abstract connection conditionsCyberElementLinks : ConditionsCyberElement[*];
    metadata def <conditionsCyberElement> ConditionsCyberElementMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = conditionsCyberElementLinks meta SysML::Usage;
    }

    connection def MonitorsSBOMEntry :> MemoRelationship {
        @MemoIdentity { :>> label = "Monitors SBOM entry"; }
        end postmarketProcess : PostmarketProcess :>> source;
        end monitoredComponent : SBOMEntry :>> target;
    }
    abstract connection monitorsSBOMEntryLinks : MonitorsSBOMEntry[*];
    metadata def <monitorsSBOMEntry> MonitorsSBOMEntryMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = monitorsSBOMEntryLinks meta SysML::Usage;
    }
}
