package memo_methodology_profiles {
    private import ScalarValues::*;

    private import memo_methodology_core::*;
    private import memo_methodology_rules::*;
    private import memo_methodology_patterns::*;
    private import memo_methodology_workflow::*;
    private import memo_methodology_gates::*;
    private import memo_core_enumerations::*;
    private import memo_core_methodology_scope::*;

    part mdCoreLibrary : MethodologyLibrary {
        attribute :>> id = "METHLIB-001";
        attribute :>> name = "MedicalDeviceMethodologyLibrary";
        attribute :>> version = "0.1";
        attribute :>> domain = "medical device modeling";
        attribute :>> description = "Methodology layer for selecting, restricting, sequencing, tailoring, and lightly extending use of the medical-device ontology.";
    }

    // The default methodology deliberately selects everything the project's
    // resolved reusable packages provide. That is what `scopeMode` exists to
    // say: `allAvailable` is an authored decision, not an empty list that the
    // resolver silently reads as "allow everything". Under `allAvailable` the
    // inclusion lists must stay empty — authoring both would leave two
    // competing answers to the same question.
    //
    // Before the flip this methodology carried a narrower `includedLayer` /
    // `includedModule` pair that nothing consumed: effective scope came from
    // the separate `mdCoverageScope : MethodologyScope` part, whose lists said
    // "all five architecture layers, all five assurance disciplines". Folding
    // that into `allAvailable` preserves the effective result and removes the
    // second scope authority.
    part mdDefaultDefinition : MethodologyDefinition {
        attribute :>> id = "METH-MD-DEFAULT";
        attribute :>> name = "MedicalDeviceDefault";
        attribute :>> version = "0.6.5";
        attribute :>> domain = "medical device modeling";
        attribute :>> description = "MEMO default medical-device methodology. Selects every layer, discipline, standard, artifact kind, and viewpoint the resolved ontology and extension packages provide.";
        attribute :>> scopeMode = ScopeModeKind::allAvailable;
    }

    part useRiskAndResidualRule : ElementUsageRule {
        attribute :>> id = "RULE-001";
        attribute :>> name = "UseRiskAndResidualRisk";
        attribute :>> elementTypeName = "Risk,ResidualRisk,RiskMatrix";
        attribute :>> strength = RuleStrengthKind::recommended;
        attribute :>> rationaleText = "Even a light methodology should distinguish pre- and post-mitigation risk and assess against a matrix.";
    }

    part requireVerifiedByRule : RelationUsageRule {
        attribute :>> id = "RULE-002";
        attribute :>> name = "VerifiedBysRequired";
        attribute :>> relationTypeName = "verify";
        attribute :>> strength = RuleStrengthKind::required;
        attribute :>> rationaleText = "Safety-relevant requirements and controls shall trace to verification.";
    }

    part lightRiskPattern : ModelingPattern {
        attribute :>> id = "PAT-001";
        attribute :>> name = "LightRiskBeforeAfterPattern";
        attribute :>> intent = "Model hazard chain, before/after mitigation risk, controls, and residual evaluation in a lightweight way.";
        attribute :>> stage = WorkflowStageKind::risk;
        attribute :>> strength = RuleStrengthKind::recommended;
    }

    part lightTracePattern : ModelingPattern {
        attribute :>> id = "PAT-002";
        attribute :>> name = "CoreTracePattern";
        attribute :>> intent = "Need or risk to requirement, requirement to architecture, requirement/control to verification.";
        attribute :>> stage = WorkflowStageKind::requirements;
        attribute :>> strength = RuleStrengthKind::required;
    }

    action stepRequirements : MethodologyWorkflowStep {
        attribute :>> id = "STEP-001";
        attribute :>> name = "CaptureRequirements";
        attribute :>> stage = WorkflowStageKind::requirements;
        attribute :>> objectiveDescription = "Capture stakeholder needs and derive requirements.";
        attribute :>> entryCriteria = "Intended use and actors understood.";
        attribute :>> exitCriteria = "Initial requirement set exists.";
    }

    action stepArchitecture : MethodologyWorkflowStep {
        attribute :>> id = "STEP-002";
        attribute :>> name = "DefineArchitecture";
        attribute :>> stage = WorkflowStageKind::architecture;
        attribute :>> objectiveDescription = "Define key software and hardware architecture elements and interfaces.";
        attribute :>> entryCriteria = "Initial requirements exist.";
        attribute :>> exitCriteria = "Core architecture and interfaces exist.";
    }

    action stepRisk : MethodologyWorkflowStep {
        attribute :>> id = "STEP-003";
        attribute :>> name = "PerformRiskAnalysis";
        attribute :>> stage = WorkflowStageKind::risk;
        attribute :>> objectiveDescription = "Create core risk chain and controls.";
        attribute :>> entryCriteria = "Initial requirements and key behavior exist.";
        attribute :>> exitCriteria = "Risk and control model exists.";
    }

    action stepVerification : MethodologyWorkflowStep {
        attribute :>> id = "STEP-004";
        attribute :>> name = "PlanVerification";
        attribute :>> stage = WorkflowStageKind::verificationStage;
        attribute :>> objectiveDescription = "Define verification and evidence expectations.";
        attribute :>> entryCriteria = "Requirements and controls exist.";
        attribute :>> exitCriteria = "Verification cases and evidence targets exist.";
    }
    first stepRequirements then stepArchitecture;
    first stepArchitecture then stepRisk;
    first stepRisk then stepVerification;

    part gateLightComplete : QualityGate {
        attribute :>> id = "GATE-001";
        attribute :>> name = "LightMethodReady";
        attribute :>> gateStage = WorkflowStageKind::verificationStage;
        attribute :>> passCriteria = "Core traceability, risk, verification, and RMF view support are present.";
    }

    // The GPCA binding used to live here, in the reusable default methodology,
    // naming its methodology by string. A project binding is project content:
    // it now lives in the GPCA project's own `model/catalog/project.sysml` and
    // references its methodology with a typed SysML reference.

    part rmpDoc : DhfDocumentBinding {
        attribute :>> id = "DHF-001";
        attribute :>> name = "RiskManagementPlan";
        attribute :>> documentTitle = "Risk Management Plan";
        attribute :>> groupLabel = "Risk Management";
        attribute :>> templateId = "iso-14971/rmp";
        attribute :>> viewKind = "RMF";
        attribute :>> regulatoryReference = "ISO 14971";
        attribute :>> lifecycleStage = WorkflowStageKind::risk;
        attribute :>> required = true;
    }

    part harDoc : DhfDocumentBinding {
        attribute :>> id = "DHF-002";
        attribute :>> name = "HazardAnalysisReport";
        attribute :>> documentTitle = "Hazard Analysis Report";
        attribute :>> groupLabel = "Risk Management";
        attribute :>> templateId = "iso-14971/har";
        attribute :>> viewKind = "RMF";
        attribute :>> regulatoryReference = "ISO 14971";
        attribute :>> lifecycleStage = WorkflowStageKind::risk;
        attribute :>> required = true;
    }

    part sadDoc : DhfDocumentBinding {
        attribute :>> id = "DHF-003";
        attribute :>> name = "SoftwareArchitectureDescription";
        attribute :>> documentTitle = "Software Architecture Description";
        attribute :>> groupLabel = "Software";
        attribute :>> templateId = "iec-62304/sad";
        attribute :>> viewKind = "ArchitectureDescription";
        attribute :>> regulatoryReference = "IEC 62304";
        attribute :>> lifecycleStage = WorkflowStageKind::architecture;
        attribute :>> required = true;
    }

    part threatModelDoc : DhfDocumentBinding {
        attribute :>> id = "DHF-004";
        attribute :>> name = "CybersecurityThreatModel";
        attribute :>> documentTitle = "Threat Model";
        attribute :>> groupLabel = "Cybersecurity";
        attribute :>> templateId = "fda-cybersecurity/threat-model";
        attribute :>> viewKind = "ThreatModel";
        attribute :>> regulatoryReference = "FDA Cybersecurity Guidance";
        attribute :>> lifecycleStage = WorkflowStageKind::risk;
        attribute :>> required = true;
    }

    part vvPlanDoc : DhfDocumentBinding {
        attribute :>> id = "DHF-005";
        attribute :>> name = "VerificationValidationPlan";
        attribute :>> documentTitle = "V&V Plan";
        attribute :>> groupLabel = "Verification & Validation";
        attribute :>> templateId = "21cfr820/vv-plan";
        attribute :>> viewKind = "VV";
        attribute :>> regulatoryReference = "21 CFR 820.30";
        attribute :>> lifecycleStage = WorkflowStageKind::verificationStage;
        attribute :>> required = true;
    }
}
