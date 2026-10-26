package memo_methodology_profiles {
    private import ScalarValues::*;

    private import memo_methodology_core::*;
    private import memo_methodology_rules::*;
    private import memo_methodology_patterns::*;
    private import memo_methodology_workflow::*;
    private import memo_methodology_gates::*;
    private import memo_rules_closure::*;
    private import memo_viewpoints_catalog::*;
    private import memo_viewpoints_stakeholders_concerns::*;
    private import memo_core_enumerations::*;
    private import memo_core_methodology_scope::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part mdCoreLibrary : MethodologyLibrary {
        @MemoIdentity { :>> providedId = "METHLIB-001"; :>> label = "MedicalDeviceMethodologyLibrary"; }
        attribute :>> version = "0.16.2";
        attribute :>> domain = "medical device modeling";
        doc /* Methodology layer for selecting, restricting, sequencing, tailoring, and lightly extending use of the medical-device ontology. */
    }

    // The default methodology deliberately selects everything the project's
    // resolved reusable packages provide. That is what `scopeMode` exists to
    // say: `allAvailable` is an authored decision, not an empty list that the
    // resolver silently reads as "allow everything". Under `allAvailable` this
    // package imports nothing publicly — a methodology selects by its
    // package's public imports, and stating both would leave two competing
    // answers to the same question.
    //
    // Before the flip this methodology carried a narrower `includedLayer` /
    // `includedModule` pair that nothing consumed: effective scope came from
    // the separate `mdCoverageScope : MethodologyScope` part, whose lists said
    // "all five architecture layers, all five assurance disciplines". Folding
    // that into `allAvailable` preserves the effective result and removes the
    // second scope authority.
    part mdDefaultDefinition : MethodologyDefinition {
        @MemoIdentity { :>> providedId = "METH-MD-DEFAULT"; :>> label = "MedicalDeviceDefault"; }
        attribute :>> version = "0.16.2";
        attribute :>> domain = "medical device modeling";
        doc /* MEMO default medical-device methodology. Selects every layer, discipline, standard, artifact kind, and viewpoint the resolved ontology and extension packages provide. */
        attribute :>> scopeMode = ScopeModeKind::allAvailable;
    }

    part useRiskAndResidualRule : ElementUsageRule {
        @MemoIdentity { :>> providedId = "RULE-001"; :>> label = "UseRiskAndResidualRisk"; }
        attribute :>> elementTypeName = "Risk,ResidualRisk,RiskMatrix";
        attribute :>> strength = RuleStrengthKind::recommended;
        attribute :>> rationaleText = "Even a light methodology should distinguish pre- and post-mitigation risk and assess against a matrix.";
    }

    part requireVerifiedByRule : RelationUsageRule {
        @MemoIdentity { :>> providedId = "RULE-002"; :>> label = "VerifiedBysRequired"; }
        attribute :>> relationTypeName = "verifiedBy";
        attribute :>> strength = RuleStrengthKind::required;
        attribute :>> rationaleText = "Safety-relevant requirements and controls shall trace to verification.";
    }

    part lightRiskPattern : ModelingPattern {
        @MemoIdentity { :>> providedId = "PAT-001"; :>> label = "LightRiskBeforeAfterPattern"; }
        attribute :>> intent = "Model hazard chain, before/after mitigation risk, controls, and residual evaluation in a lightweight way.";
        attribute :>> stage = WorkflowStageKind::risk;
        attribute :>> strength = RuleStrengthKind::recommended;
    }

    part lightTracePattern : ModelingPattern {
        @MemoIdentity { :>> providedId = "PAT-002"; :>> label = "CoreTracePattern"; }
        attribute :>> intent = "Need or risk to requirement, requirement to architecture, requirement/control to verification.";
        attribute :>> stage = WorkflowStageKind::requirements;
        attribute :>> strength = RuleStrengthKind::required;
    }

    // The default method (plan O11): the steps a family works through, at the system of systems
    // and at each system. `outputKinds` and the rules a step is `#DoneWhen` say when it is done.

    action stepSosContext : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SOS-01"; :>> label = "SosContext"; }
        attribute :>> stage = WorkflowStageKind::context;
        attribute :>> level = MethodLevelKind::systemOfSystems;
        ref :>> role = projectLead;
        ref :>> guideViewpoint = vpSystemContext;
        attribute :>> outputKinds = ("SystemOfSystems", "System");
        attribute :>> objectiveDescription = "State the system of systems and the systems it is made of.";
        attribute :>> entryCriteria = "The family is chosen.";
        attribute :>> exitCriteria = "The system of systems and its constituent systems are declared.";
    }

    action stepSosOperational : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SOS-02"; :>> label = "SosOperationalAnalysis"; }
        attribute :>> stage = WorkflowStageKind::operational;
        attribute :>> level = MethodLevelKind::systemOfSystems;
        ref :>> role = systemArchitect;
        ref :>> guideViewpoint = vpUseCase;
        attribute :>> outputKinds = ("UseCase", "OperationalWorkflow");
        attribute :>> objectiveDescription = "Describe the clinical procedures the systems serve together, and the workflows that realize them.";
        attribute :>> entryCriteria = "The constituent systems are declared.";
        attribute :>> exitCriteria = "Each clinical procedure has a workflow.";
    }

    action stepSosFunctions : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SOS-03"; :>> label = "SosFunctionsAndChains"; }
        attribute :>> stage = WorkflowStageKind::functional;
        attribute :>> level = MethodLevelKind::systemOfSystems;
        ref :>> role = systemArchitect;
        ref :>> guideViewpoint = vpFunctionalFlow;
        attribute :>> outputKinds = ("FunctionalFlow");
        attribute :>> objectiveDescription = "Follow the functions across the systems in functional chains.";
        attribute :>> entryCriteria = "Clinical procedures and workflows exist.";
        attribute :>> exitCriteria = "Each cross-system chain is stated.";
    }

    action stepSosArchitecture : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SOS-04"; :>> label = "SosArchitecture"; }
        attribute :>> stage = WorkflowStageKind::architecture;
        attribute :>> level = MethodLevelKind::systemOfSystems;
        ref :>> role = systemArchitect;
        ref :>> guideViewpoint = vpSystemDecomposition;
        attribute :>> outputKinds = ("Interface");
        attribute :>> objectiveDescription = "Define the interfaces between the systems.";
        attribute :>> entryCriteria = "Functional chains exist.";
        attribute :>> exitCriteria = "Each pair of systems that exchange something has an interface.";
    }

    action stepSosHazards : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SOS-05"; :>> label = "SosHazards"; }
        attribute :>> stage = WorkflowStageKind::risk;
        attribute :>> level = MethodLevelKind::systemOfSystems;
        ref :>> role = safetyEngineer;
        ref :>> guideViewpoint = vpRiskChain;
        attribute :>> outputKinds = ("Hazard");
        attribute :>> objectiveDescription = "Identify the hazards that arise only from the systems working together.";
        attribute :>> entryCriteria = "The architecture and its interfaces exist.";
        attribute :>> exitCriteria = "Each hazard of the combination has a control.";
    }
    #DoneWhen dependency from stepSosHazards to memo_rules_closure::HazardMitigationRule;

    action stepSysOperational : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SYS-01"; :>> label = "SystemOperational"; }
        attribute :>> stage = WorkflowStageKind::operational;
        attribute :>> level = MethodLevelKind::system;
        ref :>> role = systemArchitect;
        ref :>> guideViewpoint = vpUseCase;
        attribute :>> outputKinds = ("UseCase");
        attribute :>> objectiveDescription = "State what the system is used for.";
        attribute :>> entryCriteria = "The system is declared.";
        attribute :>> exitCriteria = "Each use of the system is a use case.";
    }

    action stepSysFunctional : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SYS-02"; :>> label = "SystemFunctional"; }
        attribute :>> stage = WorkflowStageKind::functional;
        attribute :>> level = MethodLevelKind::system;
        ref :>> role = systemArchitect;
        ref :>> guideViewpoint = vpFunctionalArchitecture;
        attribute :>> outputKinds = ("SystemFunction");
        attribute :>> objectiveDescription = "State what the system does.";
        attribute :>> entryCriteria = "The system use cases exist.";
        attribute :>> exitCriteria = "Each function is stated.";
    }

    action stepSysLogical : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SYS-03"; :>> label = "SystemLogical"; }
        attribute :>> stage = WorkflowStageKind::logical;
        attribute :>> level = MethodLevelKind::system;
        ref :>> role = systemArchitect;
        ref :>> guideViewpoint = vpLogicalArchitecture;
        attribute :>> outputKinds = ("LogicalComponent");
        attribute :>> objectiveDescription = "Divide the system into logical components and allocate its functions.";
        attribute :>> entryCriteria = "The system functions exist.";
        attribute :>> exitCriteria = "Every function is allocated to a component.";
    }
    #DoneWhen dependency from stepSysLogical to memo_rules_closure::LogicalFunctionAllocationRule;

    action stepSysHardware : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SYS-04"; :>> label = "SystemHardware"; }
        attribute :>> stage = WorkflowStageKind::physical;
        attribute :>> level = MethodLevelKind::system;
        ref :>> role = hardwareEngineer;
        ref :>> guideViewpoint = vpHardwareArchitecture;
        attribute :>> outputKinds = ("PhysicalAssembly");
        attribute :>> objectiveDescription = "Realize the logical components in hardware.";
        attribute :>> entryCriteria = "The logical components exist.";
        attribute :>> exitCriteria = "The hardware assemblies are declared.";
    }

    action stepSysSoftware : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SYS-05"; :>> label = "SystemSoftware"; }
        attribute :>> stage = WorkflowStageKind::physical;
        attribute :>> level = MethodLevelKind::system;
        ref :>> role = softwareArchitect;
        ref :>> guideViewpoint = vpSoftwareComponents;
        attribute :>> outputKinds = ("SoftwareSystem");
        attribute :>> objectiveDescription = "Realize the logical components in software.";
        attribute :>> entryCriteria = "The logical components exist.";
        attribute :>> exitCriteria = "The software is declared.";
    }

    action stepSysHumanFactors : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SYS-06"; :>> label = "SystemHumanFactors"; }
        attribute :>> stage = WorkflowStageKind::humanFactors;
        attribute :>> level = MethodLevelKind::system;
        ref :>> role = usabilityEngineer;
        ref :>> guideViewpoint = vpHumanFactors;
        attribute :>> outputKinds = ("UserInterface");
        attribute :>> objectiveDescription = "Design how people use the system.";
        attribute :>> entryCriteria = "The system use cases exist.";
        attribute :>> exitCriteria = "The user interface is declared.";
    }

    action stepSysRisk : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SYS-07"; :>> label = "SystemRisk"; }
        attribute :>> stage = WorkflowStageKind::risk;
        attribute :>> level = MethodLevelKind::system;
        ref :>> role = safetyEngineer;
        ref :>> guideViewpoint = vpRiskChain;
        attribute :>> outputKinds = ("Hazard", "Risk");
        attribute :>> objectiveDescription = "Identify hazards, estimate risk and state the controls.";
        attribute :>> entryCriteria = "The system functions exist.";
        attribute :>> exitCriteria = "Each hazard has a control.";
    }
    #DoneWhen dependency from stepSysRisk to memo_rules_closure::HazardMitigationRule;

    action stepSysSecurity : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SYS-08"; :>> label = "SystemSecurity"; }
        attribute :>> stage = WorkflowStageKind::security;
        attribute :>> level = MethodLevelKind::system;
        ref :>> role = securityEngineer;
        ref :>> guideViewpoint = vpCybersecurity;
        attribute :>> outputKinds = ("Threat");
        attribute :>> objectiveDescription = "Identify threats and state the mitigations.";
        attribute :>> entryCriteria = "The system functions exist.";
        attribute :>> exitCriteria = "Each threat is mitigated.";
    }
    #DoneWhen dependency from stepSysSecurity to memo_rules_closure::ThreatMitigationRule;

    action stepSysVerification : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SYS-09"; :>> label = "SystemVerification"; }
        attribute :>> stage = WorkflowStageKind::verificationStage;
        attribute :>> level = MethodLevelKind::system;
        ref :>> role = verificationEngineer;
        ref :>> guideViewpoint = vpVerificationCoverage;
        attribute :>> outputKinds = ("VerificationCase");
        attribute :>> objectiveDescription = "Verify what the system must do and the controls it relies on.";
        attribute :>> entryCriteria = "Risks and their controls exist.";
        attribute :>> exitCriteria = "Each verification case has a target.";
    }
    #DoneWhen dependency from stepSysVerification to memo_rules_closure::VerificationCaseTargetRule;

    action stepSysRelease : MethodologyWorkflowStep {
        @MemoIdentity { :>> providedId = "STEP-SYS-10"; :>> label = "SystemRelease"; }
        attribute :>> stage = WorkflowStageKind::release;
        attribute :>> level = MethodLevelKind::system;
        ref :>> role = regulatoryEngineer;
        attribute :>> outputKinds = ("ReleaseRecord");
        attribute :>> objectiveDescription = "Release the system: its part number, revision and the commit it was built from.";
        attribute :>> entryCriteria = "The system is verified.";
        attribute :>> exitCriteria = "The release has a record.";
    }

    // Order, within a level.
    first stepSosContext then stepSosOperational;
    first stepSosOperational then stepSosFunctions;
    first stepSosFunctions then stepSosArchitecture;
    first stepSosArchitecture then stepSosHazards;

    first stepSysOperational then stepSysFunctional;
    first stepSysFunctional then stepSysLogical;
    first stepSysLogical then stepSysHardware;
    first stepSysLogical then stepSysSoftware;
    first stepSysOperational then stepSysHumanFactors;
    first stepSysFunctional then stepSysRisk;
    first stepSysFunctional then stepSysSecurity;
    first stepSysRisk then stepSysVerification;
    first stepSysVerification then stepSysRelease;

    part gateLightComplete : QualityGate {
        @MemoIdentity { :>> providedId = "GATE-001"; :>> label = "LightMethodReady"; }
        attribute :>> gateStage = WorkflowStageKind::verificationStage;
        attribute :>> passCriteria = "Core traceability, risk, verification, and RMF view support are present.";
    }

    // The GPCA binding used to live here, in the reusable default methodology,
    // naming its methodology by string. A project binding is project content:
    // it now lives in the GPCA project's own `model/methodology/project.sysml` and
    // references its methodology with a typed SysML reference.

    part rmpDoc : DhfDocumentBinding {
        @MemoIdentity { :>> providedId = "DHF-001"; :>> label = "RiskManagementPlan"; }
        attribute :>> documentTitle = "Risk Management Plan";
        attribute :>> groupLabel = "Risk Management";
        attribute :>> templateId = "iso-14971/rmp";
        attribute :>> viewKind = "RMF";
        attribute :>> regulatoryReference = "ISO 14971";
        attribute :>> lifecycleStage = WorkflowStageKind::risk;
        attribute :>> required = true;
    }

    part harDoc : DhfDocumentBinding {
        @MemoIdentity { :>> providedId = "DHF-002"; :>> label = "HazardAnalysisReport"; }
        attribute :>> documentTitle = "Hazard Analysis Report";
        attribute :>> groupLabel = "Risk Management";
        attribute :>> templateId = "iso-14971/har";
        attribute :>> viewKind = "RMF";
        attribute :>> regulatoryReference = "ISO 14971";
        attribute :>> lifecycleStage = WorkflowStageKind::risk;
        attribute :>> required = true;
    }

    part sadDoc : DhfDocumentBinding {
        @MemoIdentity { :>> providedId = "DHF-003"; :>> label = "SoftwareArchitectureDescription"; }
        attribute :>> documentTitle = "Software Architecture Description";
        attribute :>> groupLabel = "Software";
        attribute :>> templateId = "iec-62304/sad";
        attribute :>> viewKind = "ArchitectureDescription";
        attribute :>> regulatoryReference = "IEC 62304";
        attribute :>> lifecycleStage = WorkflowStageKind::architecture;
        attribute :>> required = true;
    }

    part threatModelDoc : DhfDocumentBinding {
        @MemoIdentity { :>> providedId = "DHF-004"; :>> label = "CybersecurityThreatModel"; }
        attribute :>> documentTitle = "Threat Model";
        attribute :>> groupLabel = "Cybersecurity";
        attribute :>> templateId = "fda-cybersecurity/threat-model";
        attribute :>> viewKind = "ThreatModel";
        attribute :>> regulatoryReference = "FDA Cybersecurity Guidance";
        attribute :>> lifecycleStage = WorkflowStageKind::risk;
        attribute :>> required = true;
    }

    part vvPlanDoc : DhfDocumentBinding {
        @MemoIdentity { :>> providedId = "DHF-005"; :>> label = "VerificationValidationPlan"; }
        attribute :>> documentTitle = "V&V Plan";
        attribute :>> groupLabel = "Verification & Validation";
        attribute :>> templateId = "21cfr820/vv-plan";
        attribute :>> viewKind = "VV";
        attribute :>> regulatoryReference = "21 CFR 820.30";
        attribute :>> lifecycleStage = WorkflowStageKind::verificationStage;
        attribute :>> required = true;
    }
}
