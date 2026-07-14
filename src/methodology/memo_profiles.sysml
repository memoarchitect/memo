package memo_methodology_profiles {
    private import ScalarValues::*;

    private import memo_methodology_core::*;
    private import memo_methodology_viewpoints::*;
    private import memo_methodology_rules::*;
    private import memo_methodology_patterns::*;
    private import memo_methodology_workflow::*;
    private import memo_methodology_gates::*;
    private import memo_core_enumerations::*;
    private import memo_core_methodology_scope::*;

    part mdCoreLibrary : MethodologyLibrary {
        attribute id = "METHLIB-001";
        attribute name = "MedicalDeviceMethodologyLibrary";
        attribute version = "0.1";
        attribute domain = "medical device modeling";
        attribute description = "Methodology layer for selecting, restricting, sequencing, tailoring, and lightly extending use of the medical-device ontology.";
    }

    part mdLightDefaultDefinition : MethodologyDefinition {
        attribute id = "METH-001";
        attribute name = "MedicalDeviceLightDefault";
        attribute version = "0.1";
        attribute domain = "medical device modeling";
        attribute description = "Light default methodology around the ontology for smaller or early project use.";
        attribute baseMethodName = "";
    }

    part mdLightDefaultResolved : ResolvedMethodology {
        attribute id = "RMETH-001";
        attribute name = "MedicalDeviceLightDefaultResolved";
        attribute version = "0.1";
        attribute safetyClassification = SafetyClassKind::A;
        attribute lifecycleStage = LifecycleStateKind::development;
        attribute resolutionSummary = "Class A development-stage scope: core requirements, architecture, risk, verification, and RMF support required; cybersecurity and SOUP out of scope.";
    }

    part riskView : Viewpoint {
        attribute id = "VP-001";
        attribute name = "RiskManagementView";
        attribute purpose = "Focus on risk chain, controls, verification, and residual risk.";
        attribute audience = AudienceKind::safetyEngineer;
        attribute stage = WorkflowStageKind::risk;
        attribute abstractionLevel = "safety management";
    }

    part swArchView : Viewpoint {
        attribute id = "VP-002";
        attribute name = "SoftwareArchitectureView";
        attribute purpose = "Focus on software decomposition, interfaces, timing, and contracts.";
        attribute audience = AudienceKind::softwareArchitect;
        attribute stage = WorkflowStageKind::architecture;
        attribute abstractionLevel = "software design";
    }

    part useRiskBeforeRule : ElementUsageRule {
        attribute id = "RULE-001";
        attribute name = "UseRiskBeforeAfter";
        attribute elementTypeName = "RiskBeforeMitigation,RiskAfterMitigation,RiskMatrix";
        attribute strength = RuleStrengthKind::recommended;
        attribute rationaleText = "Even a light methodology should distinguish pre- and post-mitigation risk and assess against a matrix.";
    }

    part requireVerifiedByRule : RelationUsageRule {
        attribute id = "RULE-002";
        attribute name = "VerifiedBysRequired";
        attribute relationTypeName = "VerifiedBy";
        attribute strength = RuleStrengthKind::required;
        attribute rationaleText = "Safety-relevant requirements and controls shall trace to verification.";
    }

    part lightRiskPattern : ModelingPattern {
        attribute id = "PAT-001";
        attribute name = "LightRiskBeforeAfterPattern";
        attribute intent = "Model hazard chain, before/after mitigation risk, controls, and residual evaluation in a lightweight way.";
        attribute stage = WorkflowStageKind::risk;
        attribute strength = RuleStrengthKind::recommended;
    }

    part lightTracePattern : ModelingPattern {
        attribute id = "PAT-002";
        attribute name = "CoreTracePattern";
        attribute intent = "Need or risk to requirement, requirement to architecture, requirement/control to verification.";
        attribute stage = WorkflowStageKind::requirements;
        attribute strength = RuleStrengthKind::required;
    }

    part stepRequirements : WorkflowStep {
        attribute id = "STEP-001";
        attribute name = "CaptureRequirements";
        attribute stepOrder = 1;
        attribute stage = WorkflowStageKind::requirements;
        attribute objectiveDescription = "Capture stakeholder needs and derive requirements.";
        attribute entryCriteria = "Intended use and actors understood.";
        attribute exitCriteria = "Initial requirement set exists.";
    }

    part stepArchitecture : WorkflowStep {
        attribute id = "STEP-002";
        attribute name = "DefineArchitecture";
        attribute stepOrder = 2;
        attribute stage = WorkflowStageKind::architecture;
        attribute objectiveDescription = "Define key software and hardware architecture elements and interfaces.";
        attribute entryCriteria = "Initial requirements exist.";
        attribute exitCriteria = "Core architecture and interfaces exist.";
    }

    part stepRisk : WorkflowStep {
        attribute id = "STEP-003";
        attribute name = "PerformRiskAnalysis";
        attribute stepOrder = 3;
        attribute stage = WorkflowStageKind::risk;
        attribute objectiveDescription = "Create core risk chain and controls.";
        attribute entryCriteria = "Initial requirements and key behavior exist.";
        attribute exitCriteria = "Risk and control model exists.";
    }

    part stepVerification : WorkflowStep {
        attribute id = "STEP-004";
        attribute name = "PlanVerification";
        attribute stepOrder = 4;
        attribute stage = WorkflowStageKind::verificationStage;
        attribute objectiveDescription = "Define verification and evidence expectations.";
        attribute entryCriteria = "Requirements and controls exist.";
        attribute exitCriteria = "Verification cases and evidence targets exist.";
    }

    part gateLightComplete : QualityGate {
        attribute id = "GATE-001";
        attribute name = "LightMethodReady";
        attribute gateStage = WorkflowStageKind::verificationStage;
        attribute passCriteria = "Core traceability, risk, verification, and RMF view support are present.";
    }

    part mdCoverageScope : MethodologyScope {
        attribute id = "SCOPE-COV-001";
        attribute name = "MedicalDeviceCoverageScope";
        attribute scopeName = "coverage";

        attribute includedArchLayer = "context";
        attribute includedArchLayer = "requirements";
        attribute includedArchLayer = "functions";
        attribute includedArchLayer = "logical_structure";
        attribute includedArchLayer = "interfaces";
        attribute includedArchLayer = "software_structure";
        attribute includedArchLayer = "hardware_structure";
        attribute includedArchLayer = "behavior";
        attribute includedArchLayer = "risk";
        attribute includedArchLayer = "arch_risk";
        attribute includedArchLayer = "assurance";
        attribute includedArchLayer = "cybersecurity";
        attribute includedArchLayer = "constraints";

        attribute includedStandard = "ISO 14971";
        attribute includedStandard = "IEC 62304";
        attribute includedStandard = "21 CFR 820";
        attribute includedStandard = "ISO 13485";
        attribute includedStandard = "ISO 14155";
        attribute includedStandard = "IEC 62366";
        attribute includedStandard = "IEC 60601-1";
        attribute includedStandard = "IEC 82304-1";
        attribute includedStandard = "FDA Cybersecurity Guidance";

        attribute includedArtifactKind = "RiskManagementPlan";
        attribute includedArtifactKind = "RequirementsSpecification";
        attribute includedArtifactKind = "SystemArchitectureDescription";
        attribute includedArtifactKind = "SoftwareDesignDescription";
        attribute includedArtifactKind = "HazardAnalysisReport";
        attribute includedArtifactKind = "RequirementsTraceabilityMatrix";
        attribute includedArtifactKind = "CybersecurityAssessmentReport";
        attribute includedArtifactKind = "ThreatModelReport";
        attribute includedArtifactKind = "UsabilityEngineeringReport";
        attribute includedArtifactKind = "ClinicalSafetyReport";
        attribute includedArtifactKind = "FailureModeEffectsAnalysisReport";
        attribute includedArtifactKind = "SoupList";
        attribute includedArtifactKind = "DesignInputPlan";
        attribute includedArtifactKind = "DesignOutputPlan";
        attribute includedArtifactKind = "SoftwareDevelopmentPlan";
        attribute includedArtifactKind = "LabelingSpecification";
        attribute includedArtifactKind = "DesignHistoryFileIndex";
        attribute includedArtifactKind = "DesignChangeLog";

        attribute includedViewpointType = "VP-CTX";
        attribute includedViewpointType = "VP-OPS";
        attribute includedViewpointType = "VP-REQ";
        attribute includedViewpointType = "VP-FUNC";
        attribute includedViewpointType = "VP-LOG";
        attribute includedViewpointType = "VP-SW";
        attribute includedViewpointType = "VP-PHY";
        attribute includedViewpointType = "VP-RISK";
        attribute includedViewpointType = "VP-VER";
        attribute includedViewpointType = "VP-CYB";
        attribute includedViewpointType = "VP-USE";
        attribute includedViewpointType = "VP-CLIN";

        attribute excludedKind = "";
        attribute description = "Comprehensive default methodology — includes all architecture layers, supported standards, artifact kinds, and viewpoint types. No GPCA-specific subtraction.";
    }

    part gpcaProjectBinding : ProjectMethodBinding {
        attribute id = "PMB-001";
        attribute name = "GPCAProjectMethodBinding";
        attribute projectName = "GPCA";
    }

    part rmpDoc : DhfDocumentBinding {
        attribute id = "DHF-001";
        attribute name = "RiskManagementPlan";
        attribute documentTitle = "Risk Management Plan";
        attribute groupLabel = "Risk Management";
        attribute templateId = "iso-14971/rmp";
        attribute viewKind = "RMF";
        attribute regulatoryReference = "ISO 14971";
        attribute lifecycleStage = WorkflowStageKind::risk;
        attribute required = true;
    }

    part harDoc : DhfDocumentBinding {
        attribute id = "DHF-002";
        attribute name = "HazardAnalysisReport";
        attribute documentTitle = "Hazard Analysis Report";
        attribute groupLabel = "Risk Management";
        attribute templateId = "iso-14971/har";
        attribute viewKind = "RMF";
        attribute regulatoryReference = "ISO 14971";
        attribute lifecycleStage = WorkflowStageKind::risk;
        attribute required = true;
    }

    part sadDoc : DhfDocumentBinding {
        attribute id = "DHF-003";
        attribute name = "SoftwareArchitectureDescription";
        attribute documentTitle = "Software Architecture Description";
        attribute groupLabel = "Software";
        attribute templateId = "iec-62304/sad";
        attribute viewKind = "ArchitectureDescription";
        attribute regulatoryReference = "IEC 62304";
        attribute lifecycleStage = WorkflowStageKind::architecture;
        attribute required = true;
    }

    part threatModelDoc : DhfDocumentBinding {
        attribute id = "DHF-004";
        attribute name = "CybersecurityThreatModel";
        attribute documentTitle = "Threat Model";
        attribute groupLabel = "Cybersecurity";
        attribute templateId = "fda-cybersecurity/threat-model";
        attribute viewKind = "ThreatModel";
        attribute regulatoryReference = "FDA Cybersecurity Guidance";
        attribute lifecycleStage = WorkflowStageKind::risk;
        attribute required = true;
    }

    part vvPlanDoc : DhfDocumentBinding {
        attribute id = "DHF-005";
        attribute name = "VerificationValidationPlan";
        attribute documentTitle = "V&V Plan";
        attribute groupLabel = "Verification & Validation";
        attribute templateId = "21cfr820/vv-plan";
        attribute viewKind = "VV";
        attribute regulatoryReference = "21 CFR 820.30";
        attribute lifecycleStage = WorkflowStageKind::verificationStage;
        attribute required = true;
    }
}
