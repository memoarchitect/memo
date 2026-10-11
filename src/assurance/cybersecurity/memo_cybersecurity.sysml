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
    private import memo_assurance_requirements::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;
    private import memo_architecture_operational_scenarios::*;
    private import memo_architecture_implementation_software_structure::SBOMEntry;

    part def CybersecurityAsset specializes MemoPart {
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
        attribute entryPointKind : InterfaceKind;
        attribute exposureLevel : String;
        attribute reachableFrom : String;
        attribute authenticationExpected : Boolean;
    }

    part def Threat specializes RiskDriver {
        attribute threatCategory : ThreatCategoryKind;
        attribute attackVector : String;
        attribute threatSource : String;
        attribute precondition : String;
        attribute affectedConcern : ConcernKind;
    }

    item def Vulnerability specializes RiskItem {
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
        attribute securityImpact : String;
        attribute safetyImpact : String;
        attribute privacyImpact : String;
        attribute operationalImpact : String;
    }

    part def CyberRisk specializes Risk {
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
    }

    part def TrustBoundary specializes InterfaceElement {
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
    enum def PenTestFindingStatusKind {
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

    part def ThreatActor specializes MemoPart {
        attribute actorKind : ThreatActorKind;
        attribute motivation : String;
        attribute capability : ThreatCapabilityKind;
        attribute accessMode : ThreatAccessKind;
        attribute organization : String;
    }

    part def AttackTechnique specializes MemoPart {
        attribute framework : AttackTechniqueFrameworkKind;
        attribute externalId : String;
        attribute tactic : String;
        attribute platform : String;
        attribute techniqueVersion : String;
    }

    part def SecurityProperty specializes MemoPart {
        attribute objectiveKind : SecurityObjectiveKind;
        attribute impactLevel : CriticalityKind;
        attribute propertyRationale : String;
    }

    part def CybersecurityAssumption specializes MemoPart {
        attribute statement : String;
        attribute owner : String;
        attribute reviewDate : String;
        attribute expirationDate : String;
        attribute validity : CyberAssumptionValidityKind;
    }

    // The path's narrative is the inherited `pathSummary`.
    action def AttackPath specializes OperativeScenario {
        attribute entryPoint : String;
        attribute attackGoal : String;
    }

    // Security assessment: a case is the planned activity (penetration test,
    // static or dynamic analysis, composition analysis), a report is what it
    // produced, and a finding is one result. Findings stay separate objects so
    // each can be traced to a vulnerability, a risk and a mitigation.
    enum def SecurityAssessmentMethodKind {
        enum penetrationTest;
        enum sast;
        enum dast;
        enum sca;
    }
    part def SecurityAssessmentCase specializes MemoPart {
        attribute assessmentMethod : SecurityAssessmentMethodKind;
        attribute assessmentScope : String;
        attribute toolName : String;
        attribute toolVersion : String;
    }
    part def SecurityAssessmentReport specializes MemoEvidence {
        attribute reportDate : String;
        attribute assessor : String;
    }
    part def SecurityFinding specializes MemoEvidence {
        attribute findingIdentifier : String;
        attribute severity : CriticalityKind;
        attribute cvssBaseScore : Real;
        attribute cvssVector : String;
        attribute findingStatus : PenTestFindingStatusKind;
        attribute retestDate : String;
    }
    part def PenTestFinding specializes SecurityFinding;
    part def SASTFinding specializes SecurityFinding {
        attribute weaknessReference : String;
        attribute sourceLocation : String;
    }
    part def DASTFinding specializes SecurityFinding {
        attribute testedEndpoint : String;
    }
    part def SCAFinding specializes SecurityFinding {
        attribute affectedPackage : String;
    }

    action def PostmarketProcess specializes MemoAction {
        attribute processKind : PostmarketProcessKind;
        attribute owner : String;
        attribute cadence : String;
        attribute serviceLevelTarget : String;
    }

    // A CyberRisk remains the stable risk identity. Assessments record its
    // pre-control (inherent) and post-control (residual) states without
    // duplicating the risk itself.
    part def CyberRiskAssessment specializes MemoPart {
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
        end postmarketProcess : PostmarketProcess :>> source;
        end monitoredComponent : SBOMEntry :>> target;
    }
    abstract connection monitorsSBOMEntryLinks : MonitorsSBOMEntry[*];
    metadata def <monitorsSBOMEntry> MonitorsSBOMEntryMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = monitorsSBOMEntryLinks meta SysML::Usage;
    }

    connection def ProducesReport :> MemoRelationship {
        end assessmentCase : SecurityAssessmentCase :>> source;
        end producedReport : SecurityAssessmentReport :>> target;
    }
    abstract connection producesReportLinks : ProducesReport[*];
    metadata def <producesReport> ProducesReportMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = producesReportLinks meta SysML::Usage;
    }

    connection def ReportsFinding :> MemoRelationship {
        end report : SecurityAssessmentReport :>> source;
        end reportedFinding : SecurityFinding :>> target;
    }
    abstract connection reportsFindingLinks : ReportsFinding[*];
    metadata def <reportsFinding> ReportsFindingMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = reportsFindingLinks meta SysML::Usage;
    }

    connection def IdentifiesAffectedEntry :> MemoRelationship {
        end scaFinding : SCAFinding :>> source;
        end affectedEntry : SBOMEntry :>> target;
    }
    abstract connection identifiesAffectedEntryLinks : IdentifiesAffectedEntry[*];
    metadata def <identifiesAffectedEntry> IdentifiesAffectedEntryMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = identifiesAffectedEntryLinks meta SysML::Usage;
    }
}
