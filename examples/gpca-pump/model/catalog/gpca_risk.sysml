package memo_examples_gpca_pump_gpca_risk {
    private import ScalarValues::*;

    private import memo_assurance_safety_risk::*;
    private import memo_core_common::Citation;
    private import memo_core_enumerations::*;

    private import memo_core_common::MemoIdentity;
    // ── Source corpus citations (verified 2026-07-05, extended 2026-07-08) ──
    part citeCriSysSysReq : Citation {
        @MemoIdentity { :>> providedId = "CITE-001"; :>> label = "CriSysGpcaSystemRequirements"; }
        attribute :>> source = "System Requirements: Generic Patient Controlled Analgesic Infusion (GPCA) System, draft — Murugesan, Rayadurgam, Heimdahl, University of Minnesota";
        attribute :>> section = "Ch.2 system description; Ch.3 interfaces (I 1-I 11, data dictionary); Ch.4 behavioral requirements (mode tree, REQ 1-86, REQ 59 notification table); Ch.5 non-behavioral; App. A.4 constants";
        attribute :>> uri = "https://crisys.cs.umn.edu/downloads/gpca/SystemRequirements.pdf";
        attribute :>> year = "2013";
    }
    part citeCriSysAadl : Citation {
        @MemoIdentity { :>> providedId = "CITE-002"; :>> label = "CriSysGpcaAadlModel"; }
        attribute :>> source = "GPCA System Architectural Model v2.0 (AADL packages, AGREE contracts, ModelDocumentation.pdf) — University of Minnesota CriSys";
        attribute :>> section = "8 software subcomponents + port topology + AGREE contracts";
        attribute :>> uri = "https://crisys.cs.umn.edu/downloads/gpca/AADL.zip";
        attribute :>> year = "undated";
    }
    part citeCriSysVerification : Citation {
        @MemoIdentity { :>> providedId = "CITE-003"; :>> label = "CriSysGpcaVerification"; }
        attribute :>> source = "GPCA compositional verification package (AGREE properties, Simulink/Stateflow models) — University of Minnesota CriSys";
        attribute :>> section = "Full package";
        attribute :>> uri = "https://crisys.cs.umn.edu/downloads/gpca/Verification.zip";
        attribute :>> year = "undated";
    }
    part citeGipHazardAnalysis : Citation {
        @MemoIdentity { :>> providedId = "CITE-004"; :>> label = "GipHazardAnalysis"; }
        attribute :>> source = "Generic Infusion Pump Hazard Analysis and Safety Requirements Version 1.0 — Arney, Jetley, Jones, Lee, Ray, Sokolsky, Zhang; University of Pennsylvania / FDA OSEL (Tech Report MS-CIS-08-31)";
        attribute :>> section = "§2.1 hazard categories; §2.2 alarms and alerts; §2.3 pump checks; §2.4.1-2.4.8 hazard tables (HID rows: cause, action, mitigated-by, safety requirement); §3 safety requirements";
        attribute :>> uri = "https://repository.upenn.edu/cis_reports/893/";
        attribute :>> year = "2009";
    }
    part citeOpenPcaPump : Citation {
        @MemoIdentity { :>> providedId = "CITE-005"; :>> label = "OpenPcaPumpArtifacts"; }
        attribute :>> source = "Model-based Risk Analysis for an Open-Source PCA Pump using the AADL Error Modeling Annex — Thiagarajan, Larson, Hatcliff, Zhang; Kansas State University SAnToS Lab (Open PCA Pump project ISO 14971 risk analysis)";
        attribute :>> section = "§4 Table 1 (harm / hazardous situation / hazard / initiating cause for the two primary hazards: opioid over-infusion, air embolism); Fig. 3 ISO 14971 causality chain; §5 harm and cause instances";
        attribute :>> uri = "https://awas.sireum.org/_static/awas-ISO14971-risk-analysis.pdf";
        attribute :>> year = "undated";
    }
    part citeGiipTaxonomy : Citation {
        @MemoIdentity { :>> providedId = "CITE-006"; :>> label = "FdaGiipHazardTaxonomy"; }
        attribute :>> source = "A Hazard Analysis for a Generic Insulin Infusion Pump — Zhang, Jones et al., Journal of Diabetes Science and Technology (structure template only; insulin-pump content, not GPCA)";
        attribute :>> section = "Table 1 hazardous-situation taxonomy; Tables 2-9 cause-source tables (operational, software, hardware, physical, electrical, biological/chemical, use, environmental) forming cause -> hazardous situation -> harm causal trees";
        attribute :>> uri = "https://pmc.ncbi.nlm.nih.gov/articles/PMC2864162/";
        attribute :>> year = "2010";
    }
    part citeGpcaHazardDoc : Citation {
        @MemoIdentity { :>> providedId = "CITE-007"; :>> label = "FdaGpcaHazardAnalysisDoc"; }
        attribute :>> source = "The Generic Patient Controlled Analgesia Pump Hazard Analysis (GPCA Model ver. 0.9) — FDA OSEL GIP project working document (Jetley); GPCA specialization of the GIP v1.0 hazard tables, retrieved from the archived GIP project site";
        attribute :>> section = "System domain; pump components; hazard tables: Operational HID 1.1-1.27, Environmental 2.1-2.13, Electrical 3.1-3.11, Hardware 4.1-4.13, Software 5.1-5.12, Mechanical 6.1-6.6, Biological/Chemical 7.1-7.2, Use 8.1-8.14";
        attribute :>> uri = "https://web.archive.org/web/20111121142920/http://rtg.cis.upenn.edu/gip-docs/Hazard_Analysis_GPCA.doc";
        attribute :>> year = "2009";
    }
    part citeGpcaSafetyReqDoc : Citation {
        @MemoIdentity { :>> providedId = "CITE-008"; :>> label = "FdaGpcaSafetyRequirementsDoc"; }
        attribute :>> source = "Safety Requirements for the Generic Patient Controlled Analgesia Pump (GPCA Model ver. 0.9) — FDA OSEL GIP project working document (Jetley), retrieved from the archived GIP project site";
        attribute :>> section = "Infusion Control (flow rate + KVO, flow rate accuracy, VTBI, bolus dose, drug reservoir, pump suspend, reverse delivery, air-in-line alarm, occlusion alarm); User Interface (tamper resistance, confirmation); Error Handling; POST; Power; Dose Error Reduction (drug library hard/soft limits); System Environment";
        attribute :>> uri = "https://web.archive.org/web/20120124081510/http://rtg.cis.upenn.edu/gip-docs/Safety_Requirements_GPCA.doc";
        attribute :>> year = "2009";
    }

    part citeCriSysSoftwareBehavior : Citation {
        @MemoIdentity { :>> providedId = "CITE-009"; :>> label = "CriSysGpcaSoftwareBehaviorModel"; }
        attribute :>> source = "PCA Pump Software Model (Simulink/Stateflow) — University of Minnesota CriSys";
        attribute :>> section = "Infusion Pump Software Model Stateflow chart";
        attribute :>> uri = "https://crisys.cs.umn.edu/downloads/gpca/PCA_Pump_SoftwareModel.mdl";
        attribute :>> year = "undated";
    }

    // ── Shared risk matrix ───────────────────────────────────────────
    part riskMatrix : RiskMatrix {
        @MemoIdentity { :>> providedId = "RMX-001"; :>> label = "StandardRiskMatrix"; }
        attribute :>> probabilityScaleDefinition = "Remote, Occasional, Probable";
        attribute :>> severityScaleDefinition = "Minor, Serious, Catastrophic";
        attribute :>> riskLevelMapping = "matrix based";
        attribute :>> acceptabilityThresholds = "High unacceptable";
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }
    part programmedDoseCharacteristic : SafetyRelatedCharacteristic {
        @MemoIdentity { :>> providedId = "SRC-001"; :>> label = "ProgrammedDoseAndFlowLimits"; }
        attribute :>> characteristic = "Programmable basal rate, bolus volume, lockout interval, and maximum dose";
        attribute :>> safetyImpact = "Incorrect values or failed enforcement can expose the patient to over-infusion or under-infusion.";
        attribute :>> normalUseRelevant = true;
        attribute :>> faultConditionRelevant = true;
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), prescription and bolus parameters; CITE-004: GIP Hazard Analysis v1.0"; }
    }
    part analgesiaBenefit : Benefit {
        @MemoIdentity { :>> providedId = "BEN-001"; :>> label = "PatientTitratedAnalgesiaBenefit"; }
        attribute :>> beneficialOutcome = "Timely pain relief using patient-titrated opioid delivery within prescribed limits.";
        attribute :>> beneficiary = "patient";
        attribute :>> clinicalSignificance = "Improved pain management with lower total opioid consumption than fixed-schedule dosing.";
        attribute :>> supportingEvidence = "IU-001 intended-use clinical benefit and applicable clinical evidence.";
        @MemoIdentity { :>> sourceReference = "IU-001"; }
    }

    // ═══ HZ-001: Opioid over-infusion ═══════════════════════════════
    // Primary hazard 1 of the Open PCA ISO 14971 analysis; GIP
    // operational-hazard rows HID 1.1-1.3. Causal tree per GIIP
    // pattern: categorized causes converge on the hazard.
    item overdoseHazard : Hazard {
        @MemoIdentity { :>> providedId = "HZ-001"; :>> label = "OpioidOverInfusion"; }
        attribute :>> hazardType = HazardTypeKind::drugDeliveryError;
        attribute :>> severity = SeverityKind::catastrophic;
        attribute :>> foreseeable = true;
        doc /* Drug delivered at a rate above the prescription (overinfusion). */
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 Operational Hazards HID 1.1-1.3 (overinfusion); CITE-005: Open PCA ISO 14971 risk analysis, §4 (primary hazard: opioid over-infusion)"; }
    }
    item causeFlowRateTooHigh : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-001"; :>> label = "ProgrammedFlowRateTooHigh"; }
        attribute :>> causeSource = CauseSourceKind::operational;
        attribute :>> contributingFactors = "Programmed value not checked against drug-database hard limits";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.1 (programmed flow rate too high; mitigated by drug library)"; }
    }
    item causeFrequentBolus : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-002"; :>> label = "BolusRequestsTooFrequent"; }
        attribute :>> causeSource = CauseSourceKind::usageCause;
        attribute :>> contributingFactors = "Patient bolus button pressed too often, or pressed by someone other than the patient (bolus by proxy)";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.2 (dose limit exceeded due to too many bolus requests); CITE-005: Open PCA ISO 14971 risk analysis, §4 Table 1 (bolus button pressed too frequent) and §5 (TooSoonPress, ThirdPartyPress error types)"; }
    }
    item causeBolusVolumeTooHigh : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-003"; :>> label = "ProgrammedBolusVolumeTooHigh"; }
        attribute :>> causeSource = CauseSourceKind::operational;
        attribute :>> contributingFactors = "Bolus volume or drug concentration programmed above safe limits";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.3 ((programmed) bolus volume/concentration too high; mitigated by drug library)"; }
    }
    item causePumpCalibration : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-004"; :>> label = "IncorrectPumpCalibrationOrMotorRunaway"; }
        attribute :>> causeSource = CauseSourceKind::hardware;
        attribute :>> contributingFactors = "Uncalibrated pumping mechanism or motor-driver fault drives flow above the commanded rate";
        @MemoIdentity { :>> sourceReference = "CITE-005: Open PCA ISO 14971 risk analysis, §4 Table 1 (incorrect pump calibration) and §5 (calibration_over error source on drug_outlet); CITE-004: §2.4.1 HID 1.21 (increased pump speed)"; }
    }
    item seqFrequentBolus : SequenceOfEvents {
        @MemoIdentity { :>> providedId = "SEQ-001"; :>> label = "RepeatedBolusOverDeliverySequence"; }
        attribute :>> initiatingEvent = "Repeated patient bolus presses over time propagate through button-press detection and control logic to increased motor flow commands";
        attribute :>> contributingFactors = "Lockout or max-dose filtering fails or is misconfigured";
        @MemoIdentity { :>> sourceReference = "CITE-005: Open PCA ISO 14971 risk analysis, §4 (bottom-up causality walk of Fig. 3, right side); CITE-001: CriSys GPCA System Requirements (2013), §4.1.9 PATIENT BOLUS mode (REQ 25/26 lockout and max-dose filtering)"; }
    }
    item hsExcessInfusion : HazardousSituation {
        @MemoIdentity { :>> providedId = "HS-001"; :>> label = "PatientExposedToOpioidOverDelivery"; }
        attribute :>> exposedPersons = "patient";
        attribute :>> operatingCondition = "ACTIVE therapy; opioid infused while the patient's respiration is deteriorating";
        @MemoIdentity { :>> sourceReference = "CITE-005: Open PCA ISO 14971 risk analysis, §4 Table 1 (infusing opioid when patient's respiration is deteriorating) and §6 (OverInfusion hazardous-situation instance)"; }
    }
    item harmRespiratoryDepression : Harm {
        @MemoIdentity { :>> providedId = "HM-001"; :>> label = "RespiratoryDepression"; }
        attribute :>> clinicalImpact = "respiratory depression progressing to cardiac arrest";
        attribute :>> reversibility = "potentially irreversible";
        attribute :>> severity = SeverityKind::catastrophic;
        @MemoIdentity { :>> sourceReference = "CITE-005: Open PCA ISO 14971 risk analysis, §4 Table 1 (harm: cardiac arrest) and §5 (H1 respiratory depression, severity catastrophic)"; }
    }
    part riskBefore : Risk {
        @MemoIdentity { :>> providedId = "RISK-B-001"; :>> label = "OverInfusionInitialRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::occasional;
        attribute :>> severityEstimate = SeverityKind::catastrophic;
        attribute :>> riskLevel = CriticalityKind::high;
        attribute :>> acceptability = RiskAcceptabilityKind::unacceptable;
        attribute :>> estimationBasis = "mode and bolus hazard analysis";
        attribute :>> analysisContext = "patient bolus and active mode control";
        attribute :>> foreseeableMisuseIncluded = true;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }
    part lockoutControl : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-001"; :>> label = "LockoutAndMaxDoseEnforcement"; }
        attribute :>> controlKind = RiskControlKind::inherentSafeDesign;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
        attribute :>> verificationStatus = "planned";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.9 (REQ 25/26 — model REQ-CS-25/26: ignore bolus requests during lockout or past max doses per hour); CITE-002: CriSys AADL v2.0, GPCA_SW AGREE lockout guarantee (model GP-002)"; }
    }
    part riskAfter : ResidualRisk {
        @MemoIdentity { :>> providedId = "RISK-A-001"; :>> label = "OverInfusionResidualRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::remote;
        attribute :>> severityEstimate = SeverityKind::catastrophic;
        attribute :>> riskLevel = CriticalityKind::medium;
        attribute :>> acceptability = RiskAcceptabilityKind::acceptable;
        attribute :>> benefitRiskRequired = false;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }

    // ═══ HZ-002: Under-infusion / therapy interruption ══════════════
    item underdoseHazard : Hazard {
        @MemoIdentity { :>> providedId = "HZ-002"; :>> label = "UnderInfusion"; }
        attribute :>> hazardType = HazardTypeKind::drugDeliveryError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
        doc /* Delivered dose falls below prescription (underinfusion). */
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 Operational Hazards HID 1.5-1.10 (underinfusion); CITE-005: Open PCA ISO 14971 risk analysis, §5 (under-infusion captured as functional-safety hazard)"; }
    }
    item causeOcclusion : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-005"; :>> label = "LineOcclusion"; }
        attribute :>> causeSource = CauseSourceKind::operational;
        attribute :>> contributingFactors = "Supply-side or patient-side occlusion; kinked or clamped administration set";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.7 (occlusion, supply side and patient side; mitigated by flow sensor)"; }
    }
    item causeReservoirEmpty : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-006"; :>> label = "ReservoirEmptyOrLow"; }
        attribute :>> causeSource = CauseSourceKind::operational;
        attribute :>> contributingFactors = "Reservoir exhausted during therapy without timely replacement";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.8/1.9 (reservoir empty, reservoir low; mitigated by flow sensor and drug library)"; }
    }
    item causeAirInLine : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-007"; :>> label = "AirInLine"; }
        attribute :>> causeSource = CauseSourceKind::operational;
        attribute :>> contributingFactors = "Air enters the administration set and displaces drug delivery";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.6 (underinfusion: air in line) and HID 1.27 (air bubble introduced in blood stream; mitigated by flow sensor)"; }
    }
    item causePumpMechanismFails : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-008"; :>> label = "PumpMotorFailsToStroke"; }
        attribute :>> causeSource = CauseSourceKind::mechanical;
        attribute :>> contributingFactors = "Motor failure or mechanism unable to stroke stops infusion";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.6 Mechanical Hazards HID 6.6 (pump stops infusion: pump motor fails, pump unable to stroke; mitigated by flow sensor)"; }
    }
    item causeFlowRateTooLow : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-009"; :>> label = "ProgrammedFlowRateTooLow"; }
        attribute :>> causeSource = CauseSourceKind::operational;
        attribute :>> contributingFactors = "Programmed value below therapeutic range and not caught by drug-database limits";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.5 (programmed flow rate too low; mitigated by drug library)"; }
    }
    item seqOcclusion : SequenceOfEvents {
        @MemoIdentity { :>> providedId = "SEQ-002"; :>> label = "UndetectedOcclusionSequence"; }
        attribute :>> initiatingEvent = "Downstream line kinked or clamped during active therapy";
        attribute :>> contributingFactors = "Occlusion not detected or alarm not annunciated; post-occlusion bolus released when the occlusion clears";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.2 Alarms (occlusion); CITE-008: GPCA Safety Requirements (2009), Occlusion alarm (stop and alarm within max delay; bounded post-occlusion bolus volume)"; }
    }
    item hsInterruptedTherapy : HazardousSituation {
        @MemoIdentity { :>> providedId = "HS-002"; :>> label = "PatientReceivingLessThanPrescribedDose"; }
        attribute :>> exposedPersons = "patient";
        attribute :>> operatingCondition = "ACTIVE therapy with blocked, exhausted, or failed fluid path";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.5-1.10 (underinfusion)"; }
    }
    item harmUntreatedPain : Harm {
        @MemoIdentity { :>> providedId = "HM-002"; :>> label = "UntreatedPainAndClinicalDeterioration"; }
        attribute :>> clinicalImpact = "uncontrolled pain, delayed recovery, post-occlusion bolus injury";
        attribute :>> reversibility = "reversible with intervention";
        attribute :>> severity = SeverityKind::serious;
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 (underinfusion rows); CITE-008: GPCA Safety Requirements (2009), Flow rate accuracy (underinfusion alarm)"; }
    }
    part riskBeforeUnderdose : Risk {
        @MemoIdentity { :>> providedId = "RISK-B-002"; :>> label = "UnderInfusionInitialRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::probable;
        attribute :>> severityEstimate = SeverityKind::serious;
        attribute :>> riskLevel = CriticalityKind::high;
        attribute :>> acceptability = RiskAcceptabilityKind::unacceptable;
        attribute :>> estimationBasis = "occlusion and reservoir exhaustion frequency in ward use";
        attribute :>> analysisContext = "fluid path monitoring during active therapy";
        attribute :>> foreseeableMisuseIncluded = true;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }
    part occlusionAlarmControl : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-003"; :>> label = "OcclusionDetectionAndKvoPause"; }
        attribute :>> controlKind = RiskControlKind::alarm;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
        attribute :>> verificationStatus = "planned";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.2 Alarms (occlusion); CITE-008: GPCA Safety Requirements (2009), Occlusion alarm; CITE-002: CriSys AADL v2.0, AGREE occlusion => flow <= KVO (model GP-010; model extension REQ-X-04)"; }
    }
    part reservoirMonitorControl : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-004"; :>> label = "ReservoirEmptyDetectionAndAlarm"; }
        attribute :>> controlKind = RiskControlKind::monitoring;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
        attribute :>> verificationStatus = "planned";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 23 — model REQ-CS-23: empty-reservoir pause) and §4.3 REQ 59 (Empty Reservoir row); CITE-002: CriSys AADL v2.0, AGREE empty reservoir => no flow (model GP-007); CITE-004: §2.2 Alarms (empty reservoir) and Alerts (low reservoir)"; }
    }
    part riskAfterUnderdose : ResidualRisk {
        @MemoIdentity { :>> providedId = "RISK-A-002"; :>> label = "UnderInfusionResidualRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::remote;
        attribute :>> severityEstimate = SeverityKind::serious;
        attribute :>> riskLevel = CriticalityKind::medium;
        attribute :>> acceptability = RiskAcceptabilityKind::acceptable;
        attribute :>> benefitRiskRequired = false;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }

    // ═══ HZ-003: Air embolism ═══════════════════════════════════════
    // Primary hazard 2 of the Open PCA ISO 14971 analysis.
    item airEmbolismHazard : Hazard {
        @MemoIdentity { :>> providedId = "HZ-003"; :>> label = "AirEmbolism"; }
        attribute :>> hazardType = HazardTypeKind::drugDeliveryError;
        attribute :>> severity = SeverityKind::catastrophic;
        attribute :>> foreseeable = true;
        doc /* Air infused into the patient line above the clinically tolerable volume. */
        @MemoIdentity { :>> sourceReference = "CITE-005: Open PCA ISO 14971 risk analysis, §4 Table 1 (primary hazard: air embolism); CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.27 (air bubble introduced in blood stream); CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 21)"; }
    }
    item causeImproperPriming : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-010"; :>> label = "InappropriatePriming"; }
        attribute :>> causeSource = CauseSourceKind::usageCause;
        attribute :>> contributingFactors = "Infusion continued after set primed incompletely";
        @MemoIdentity { :>> sourceReference = "CITE-005: Open PCA ISO 14971 risk analysis, §4 Table 1 (continue infusion after inappropriate priming); CITE-004: §2.4.1 HID 1.24 (failure to prime: air in line)"; }
    }
    item causeTubingLeak : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-011"; :>> label = "TubingLeakageAdmitsAir"; }
        attribute :>> causeSource = CauseSourceKind::mechanical;
        attribute :>> contributingFactors = "Infusion continued under tubing leakage";
        @MemoIdentity { :>> sourceReference = "CITE-005: Open PCA ISO 14971 risk analysis, §4 Table 1 (continue infusion under tubing leakage)"; }
    }
    item causeAirSensorSilent : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-012"; :>> label = "AirSensorFailureSuppressesAlarm"; }
        attribute :>> causeSource = CauseSourceKind::hardware;
        attribute :>> contributingFactors = "Air sensor failed, disabled, or threshold miscalibrated so air passes undetected";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.4 Hardware Hazards HID 4.13 (failure to alarm: sensor failure)"; }
    }
    item seqAirInLine : SequenceOfEvents {
        @MemoIdentity { :>> providedId = "SEQ-003"; :>> label = "AirEntersLineSequence"; }
        attribute :>> initiatingEvent = "Infusion continues after inappropriate priming, with an empty reservoir, or under tubing leakage";
        attribute :>> contributingFactors = "Air-in-line detection failed or thresholds miscalibrated";
        @MemoIdentity { :>> sourceReference = "CITE-005: Open PCA ISO 14971 risk analysis, §4 Table 1 (initiating causes for air embolism); CITE-004: §2.2 Alarms (air-in-line)"; }
    }
    item hsAirTowardPatient : HazardousSituation {
        @MemoIdentity { :>> providedId = "HS-003"; :>> label = "AirInfusedIntoPatientBloodStream"; }
        attribute :>> exposedPersons = "patient";
        attribute :>> operatingCondition = "ACTIVE therapy with air in the administration set";
        @MemoIdentity { :>> sourceReference = "CITE-005: Open PCA ISO 14971 risk analysis, §4 Table 1 (infusing air bubbles into the patient's blood stream)"; }
    }
    item harmAirEmbolism : Harm {
        @MemoIdentity { :>> providedId = "HM-003"; :>> label = "TissueOrOrganDamage"; }
        attribute :>> clinicalImpact = "tissue or organ damage from vascular air embolism, potentially fatal";
        attribute :>> reversibility = "potentially irreversible";
        attribute :>> severity = SeverityKind::catastrophic;
        @MemoIdentity { :>> sourceReference = "CITE-005: Open PCA ISO 14971 risk analysis, §4 Table 1 (harm: tissue or organ damage)"; }
    }
    part riskBeforeAir : Risk {
        @MemoIdentity { :>> providedId = "RISK-B-003"; :>> label = "AirEmbolismInitialRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::occasional;
        attribute :>> severityEstimate = SeverityKind::catastrophic;
        attribute :>> riskLevel = CriticalityKind::high;
        attribute :>> acceptability = RiskAcceptabilityKind::unacceptable;
        attribute :>> estimationBasis = "reservoir exhaustion and priming error frequency";
        attribute :>> analysisContext = "fluid path integrity during active therapy";
        attribute :>> foreseeableMisuseIncluded = true;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }
    part airDetectionControl : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-002"; :>> label = "AirInLineDetectionAndKvoPause"; }
        attribute :>> controlKind = RiskControlKind::protectiveMeasure;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
        attribute :>> verificationStatus = "planned";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 21 — model REQ-CS-21: air-embolism pause on single or cumulative bubble volume); CITE-002: CriSys AADL v2.0, AGREE air-in-line => flow <= KVO (model GP-009); CITE-008: GPCA Safety Requirements (2009), Air-in-line alarm"; }
    }
    part riskAfterAir : ResidualRisk {
        @MemoIdentity { :>> providedId = "RISK-A-003"; :>> label = "AirEmbolismResidualRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::remote;
        attribute :>> severityEstimate = SeverityKind::catastrophic;
        attribute :>> riskLevel = CriticalityKind::medium;
        attribute :>> acceptability = RiskAcceptabilityKind::acceptable;
        attribute :>> benefitRiskRequired = false;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }

    // ═══ HZ-004: Incorrect therapy programmed (use error) ═══════════
    item wrongDoseHazard : Hazard {
        @MemoIdentity { :>> providedId = "HZ-004"; :>> label = "IncorrectDrugOrDoseProgrammed"; }
        attribute :>> hazardType = HazardTypeKind::useError;
        attribute :>> severity = SeverityKind::catastrophic;
        attribute :>> foreseeable = true;
        doc /* Prescription programmed or reservoir loaded so delivered therapy differs from the intended prescription. */
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.8 Use Hazards and §2.4.1 HID 1.25 (prescription/dosage values out of default range); CITE-007: GPCA Hazard Analysis doc (2009), Use Hazards HID 8.6/8.10/8.14"; }
    }
    item causeWrongPrescriptionEntered : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-013"; :>> label = "IncorrectPrescriptionEntered"; }
        attribute :>> causeSource = CauseSourceKind::usageCause;
        attribute :>> contributingFactors = "Attentional failure during prescription entry";
        @MemoIdentity { :>> sourceReference = "CITE-004/CITE-007: GIP/GPCA hazard analysis (2009), Use Hazards HID 8.10 (attentional failure: incorrect prescription entered)"; }
    }
    item causeWrongDoseUnits : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-014"; :>> label = "IncorrectDoseUnits"; }
        attribute :>> causeSource = CauseSourceKind::usageCause;
        attribute :>> contributingFactors = "Incorrect units used for dose parameters (e.g., ml/hr instead of mcg/hr)";
        @MemoIdentity { :>> sourceReference = "CITE-004/CITE-007: GIP/GPCA hazard analysis (2009), Use Hazards HID 8.14 (incorrect dose mode; mitigated by barcode scanner)"; }
    }
    item causeWrongDrugLoaded : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-015"; :>> label = "WrongPrescriptionOrDrugConcentration"; }
        attribute :>> causeSource = CauseSourceKind::usageCause;
        attribute :>> contributingFactors = "Incorrect prescription given to patient; incorrect drug concentration specified; look-alike packaging";
        @MemoIdentity { :>> sourceReference = "CITE-004/CITE-007: GIP/GPCA hazard analysis (2009), Use Hazards HID 8.6 (incorrect prescription; incorrect drug library) and §2.4.1 HID 1.4 (incorrect drug concentration specified; mitigated by barcode scanner)"; }
    }
    item causeSettingsChangedInadvertently : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-016"; :>> label = "SettingsChangedInadvertently"; }
        attribute :>> causeSource = CauseSourceKind::usageCause;
        attribute :>> contributingFactors = "User or patient changes infusion settings inadvertently during therapy";
        @MemoIdentity { :>> sourceReference = "CITE-004/CITE-007: GIP/GPCA hazard analysis (2009), Use Hazards HID 8.7/8.8 (user/patient change infusion settings inadvertently; mitigated by drug library)"; }
    }
    item causePumpRevertsToDefaults : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-017"; :>> label = "PumpRevertsToDefaultDoseValues"; }
        attribute :>> causeSource = CauseSourceKind::software;
        attribute :>> contributingFactors = "Programmed dose set incorrectly; inappropriate reset to default values";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.5 Software Hazards HID 5.11 (pump reverts to default dose values; mitigated by drug library)"; }
    }
    item seqMisprogram : SequenceOfEvents {
        @MemoIdentity { :>> providedId = "SEQ-004"; :>> label = "MisprogrammingSequence"; }
        attribute :>> initiatingEvent = "Prescription entered with wrong value, units, or drug and accepted for delivery";
        attribute :>> contributingFactors = "Safe-value check against the pharmacy database skipped or unavailable; confirmation bypassed";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.25 (prescription/dosage values fall out of default value range; mitigated by drug library and barcode scanner)"; }
    }
    item hsWrongTherapy : HazardousSituation {
        @MemoIdentity { :>> providedId = "HS-004"; :>> label = "PatientReceivingUnintendedTherapy"; }
        attribute :>> exposedPersons = "patient";
        attribute :>> operatingCondition = "therapy started from an unverified prescription";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.25 and §2.4.8 Use Hazards (incorrect therapy rows)"; }
    }
    part riskBeforeWrongDose : Risk {
        @MemoIdentity { :>> providedId = "RISK-B-004"; :>> label = "MisprogrammingInitialRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::probable;
        attribute :>> severityEstimate = SeverityKind::catastrophic;
        attribute :>> riskLevel = CriticalityKind::high;
        attribute :>> acceptability = RiskAcceptabilityKind::unacceptable;
        attribute :>> estimationBasis = "published PCA misprogramming incident rates";
        attribute :>> analysisContext = "prescription entry and reservoir loading tasks";
        attribute :>> foreseeableMisuseIncluded = true;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }
    part drugLibraryControl : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-005"; :>> label = "DrugDatabaseLimitsAndConfirmation"; }
        attribute :>> controlKind = RiskControlKind::plausibilityCheck;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
        attribute :>> verificationStatus = "planned";
        @MemoIdentity { :>> sourceReference = "CITE-008: GPCA Safety Requirements (2009), Dose Error Reduction (drug library hard/soft limits, re-entry and confirmation prompts) and User Interface (two-step setting changes, confirmation); CITE-001: CriSys GPCA System Requirements (2013), Ch.3 Pharmacy DB interface (safe-value lookup)"; }
    }
    part riskAfterWrongDose : ResidualRisk {
        @MemoIdentity { :>> providedId = "RISK-A-004"; :>> label = "MisprogrammingResidualRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::remote;
        attribute :>> severityEstimate = SeverityKind::catastrophic;
        attribute :>> riskLevel = CriticalityKind::medium;
        attribute :>> acceptability = RiskAcceptabilityKind::acceptable;
        attribute :>> benefitRiskRequired = true;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }

    // ═══ HZ-005: Free flow ══════════════════════════════════════════
    item freeFlowHazard : Hazard {
        @MemoIdentity { :>> providedId = "HZ-005"; :>> label = "GravityFreeFlow"; }
        attribute :>> hazardType = HazardTypeKind::mechanicalFailure;
        attribute :>> severity = SeverityKind::catastrophic;
        attribute :>> foreseeable = true;
        doc /* Unregulated gravity flow of drug when the set is disengaged from the pumping mechanism. */
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.13 (improper flow: free flow of drug; mitigated by flow sensor)"; }
    }
    item causeSetDisengaged : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-018"; :>> label = "AdministrationSetDisengaged"; }
        attribute :>> causeSource = CauseSourceKind::mechanical;
        attribute :>> contributingFactors = "Set removed or loaded improperly with reservoir above patient level";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.13 (free flow of drug) and §2.2 Alerts (infusion set not loaded properly)"; }
    }
    item causeDoorOpenedDuringInfusion : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-019"; :>> label = "DoorOpenedDuringInfusion"; }
        attribute :>> causeSource = CauseSourceKind::environmental;
        attribute :>> contributingFactors = "Panel/door opened during infusion, or infusion started when door open";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.2 Environmental Hazards HID 2.9 (panel/door opened during infusion; alert and log)"; }
    }
    item seqFreeFlow : SequenceOfEvents {
        @MemoIdentity { :>> providedId = "SEQ-005"; :>> label = "SetDisengagedSequence"; }
        attribute :>> initiatingEvent = "Door opened / set removed with reservoir above patient level";
        attribute :>> contributingFactors = "Anti-free-flow protection absent, defeated, or failed";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.13 and §2.4.2 HID 2.9"; }
    }
    item hsFreeFlow : HazardousSituation {
        @MemoIdentity { :>> providedId = "HS-005"; :>> label = "PatientConnectedToUnregulatedFluidPath"; }
        attribute :>> exposedPersons = "patient";
        attribute :>> operatingCondition = "set change or door open with line still connected";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.13 (free flow of drug)"; }
    }
    part riskBeforeFreeFlow : Risk {
        @MemoIdentity { :>> providedId = "RISK-B-005"; :>> label = "FreeFlowInitialRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::occasional;
        attribute :>> severityEstimate = SeverityKind::catastrophic;
        attribute :>> riskLevel = CriticalityKind::high;
        attribute :>> acceptability = RiskAcceptabilityKind::unacceptable;
        attribute :>> estimationBasis = "set-change frequency and historic free-flow incidents";
        attribute :>> analysisContext = "reservoir and set handling during therapy";
        attribute :>> foreseeableMisuseIncluded = true;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }
    part freeFlowValveControl : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-006"; :>> label = "AdministrationSetFreeFlowPrevention"; }
        attribute :>> controlKind = RiskControlKind::inherentSafeDesign;
        attribute :>> implementationKind = RiskControlImplementationKind::hardwareDesign;
        attribute :>> verificationStatus = "planned";
        @MemoIdentity { :>> sourceReference = "CITE-008: GPCA Safety Requirements (2009), User Interface (the administration set should be designed to prevent compromising patient safety or causing an unacceptable flow error); CITE-004: §2.4.1 HID 1.13 (free-flow detection via flow sensor, safety requirement 1.2.2)"; }
    }
    part doorInterlockControl : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-009"; :>> label = "DoorOpenDeliveryInhibit"; }
        attribute :>> controlKind = RiskControlKind::interlock;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
        attribute :>> verificationStatus = "planned";
        @MemoIdentity { :>> sourceReference = "CITE-002: CriSys AADL v2.0, AGREE door open => flow <= KVO (model GP-011); CITE-004: §2.4.2 HID 2.8/2.9 (panel/door opened during infusion: alert and stop); model extension REQ-X-05"; }
    }
    part riskAfterFreeFlow : ResidualRisk {
        @MemoIdentity { :>> providedId = "RISK-A-005"; :>> label = "FreeFlowResidualRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::improbable;
        attribute :>> severityEstimate = SeverityKind::catastrophic;
        attribute :>> riskLevel = CriticalityKind::medium;
        attribute :>> acceptability = RiskAcceptabilityKind::acceptable;
        attribute :>> benefitRiskRequired = false;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }

    // ═══ HZ-006: Reverse delivery ═══════════════════════════════════
    item reverseDeliveryHazard : Hazard {
        @MemoIdentity { :>> providedId = "HZ-006"; :>> label = "ReverseDelivery"; }
        attribute :>> hazardType = HazardTypeKind::drugDeliveryError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
        doc /* Drug or body fluid drawn backwards through the administration set (bleed back / reflux). */
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.14 (improper flow: bleed back, reflux within device); CITE-008: GPCA Safety Requirements (2009), Reverse delivery (continuous reverse delivery shall not be possible, from IEC 601-2-24); CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 22)"; }
    }
    item causeBleedBack : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-020"; :>> label = "BleedBackRefluxWithinDevice"; }
        attribute :>> causeSource = CauseSourceKind::operational;
        attribute :>> contributingFactors = "Pressure gradient or mechanism fault reverses flow through the set";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.14 (bleed back; reflux within device; mitigated by flow sensor, safety requirement 1.8)"; }
    }
    item seqReverseDelivery : SequenceOfEvents {
        @MemoIdentity { :>> providedId = "SEQ-006"; :>> label = "SustainedReverseFlowSequence"; }
        attribute :>> initiatingEvent = "Reflux within the device draws drug or blood back through the administration set";
        attribute :>> contributingFactors = "Reverse flow undetected; continuous episode or cumulative episodes exceed the permitted duration limits";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 22: continuous and cumulative reverse-delivery duration limits, App. A.4 Rev_Delivery constants); CITE-004: §2.4.1 HID 1.14"; }
    }
    item hsReverseFlow : HazardousSituation {
        @MemoIdentity { :>> providedId = "HS-006"; :>> label = "PatientLineFlowReversed"; }
        attribute :>> exposedPersons = "patient";
        attribute :>> operatingCondition = "THERAPY with reverse flow past the continuous or cumulative duration limits";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 22); CITE-008: GPCA Safety Requirements (2009), Reverse delivery"; }
    }
    part riskBeforeReverse : Risk {
        @MemoIdentity { :>> providedId = "RISK-B-006"; :>> label = "ReverseDeliveryInitialRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::occasional;
        attribute :>> severityEstimate = SeverityKind::serious;
        attribute :>> riskLevel = CriticalityKind::high;
        attribute :>> acceptability = RiskAcceptabilityKind::unacceptable;
        attribute :>> estimationBasis = "reflux behavior of pumping mechanisms under adverse pressure gradients";
        attribute :>> analysisContext = "fluid path integrity during active therapy";
        attribute :>> foreseeableMisuseIncluded = true;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }
    part reverseDeliveryPauseControl : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-010"; :>> label = "ReverseDeliveryDetectionAndPause"; }
        attribute :>> controlKind = RiskControlKind::alarm;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
        attribute :>> verificationStatus = "planned";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 22 — model REQ-CS-22: transition to PAUSED and REQ 59 'Reverse Delivery' actions, model NOTIF-04); CITE-004: §2.4.1 HID 1.14 (flow sensor)"; }
    }
    part antiRefluxDesignControl : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-011"; :>> label = "ContinuousReverseDeliveryPrevention"; }
        attribute :>> controlKind = RiskControlKind::inherentSafeDesign;
        attribute :>> implementationKind = RiskControlImplementationKind::hardwareDesign;
        attribute :>> verificationStatus = "planned";
        @MemoIdentity { :>> sourceReference = "CITE-008: GPCA Safety Requirements (2009), Reverse delivery (during normal use and/or single fault condition, continuous reverse delivery shall not be possible; from IEC 601-2-24)"; }
    }
    part riskAfterReverse : ResidualRisk {
        @MemoIdentity { :>> providedId = "RISK-A-006"; :>> label = "ReverseDeliveryResidualRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::remote;
        attribute :>> severityEstimate = SeverityKind::serious;
        attribute :>> riskLevel = CriticalityKind::medium;
        attribute :>> acceptability = RiskAcceptabilityKind::acceptable;
        attribute :>> benefitRiskRequired = false;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }

    // ═══ HZ-007: VTBI over-infusion ═════════════════════════════════
    item vtbiOverInfusionHazard : Hazard {
        @MemoIdentity { :>> providedId = "HZ-007"; :>> label = "VtbiOverInfusion"; }
        attribute :>> hazardType = HazardTypeKind::drugDeliveryError;
        attribute :>> severity = SeverityKind::catastrophic;
        attribute :>> foreseeable = true;
        doc /* Total volume infused exceeds the prescribed or drug-database maximum VTBI (volume to be infused). */
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 20: Over Infusion VTBI); CITE-008: GPCA Safety Requirements (2009), VTBI (range and increments) and Dose Error Reduction (hard/soft VTBI limits); CITE-004/CITE-007: Use Hazards HID 8.1 (overfill: incorrect fill volume specified)"; }
    }
    item causeVtbiTooHigh : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-021"; :>> label = "IncorrectVtbiOrFillVolumeSpecified"; }
        attribute :>> causeSource = CauseSourceKind::usageCause;
        attribute :>> contributingFactors = "Overfill: incorrect fill volume or VTBI specified at programming time";
        @MemoIdentity { :>> sourceReference = "CITE-004/CITE-007: GIP/GPCA hazard analysis (2009), Use Hazards HID 8.1 (overfill: incorrect fill volume specified; mitigated by barcode scanner)"; }
    }
    item causeStaleDrugLibrary : HazardCause {
        @MemoIdentity { :>> providedId = "CAUSE-022"; :>> label = "IncorrectOrOutdatedDrugLibraryLimits"; }
        attribute :>> causeSource = CauseSourceKind::software;
        attribute :>> contributingFactors = "Incorrect drug library or old version leaves VTBI limits wrong or missing";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.5 Software Hazards HID 5.6 (incorrect dose administered: incorrect drug library, old version of drug library)"; }
    }
    item seqVtbiExceeded : SequenceOfEvents {
        @MemoIdentity { :>> providedId = "SEQ-007"; :>> label = "VtbiCeilingExceededSequence"; }
        attribute :>> initiatingEvent = "Volume infused accumulates past the drug-database maximum VTBI during THERAPY";
        attribute :>> contributingFactors = "Infusion-complete transition missed; VTBI limit misprogrammed or outdated";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 20) and §4.1.6 (REQ 28: infusion complete at prescribed duration or maximum VTBI)"; }
    }
    item hsVtbiExceeded : HazardousSituation {
        @MemoIdentity { :>> providedId = "HS-007"; :>> label = "PatientReceivingVolumeBeyondPrescribedVtbi"; }
        attribute :>> exposedPersons = "patient";
        attribute :>> operatingCondition = "ACTIVE therapy continuing past the prescribed total volume";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 20: actual volume infused exceeds the drug-database maximum VTBI)"; }
    }
    part riskBeforeVtbi : Risk {
        @MemoIdentity { :>> providedId = "RISK-B-007"; :>> label = "VtbiOverInfusionInitialRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::occasional;
        attribute :>> severityEstimate = SeverityKind::catastrophic;
        attribute :>> riskLevel = CriticalityKind::high;
        attribute :>> acceptability = RiskAcceptabilityKind::unacceptable;
        attribute :>> estimationBasis = "programming error rates for volume-based dose settings";
        attribute :>> analysisContext = "prescription entry and long-running therapy volume accounting";
        attribute :>> foreseeableMisuseIncluded = true;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }
    part vtbiLimitPauseControl : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-012"; :>> label = "VtbiCeilingPauseAtKvo"; }
        attribute :>> controlKind = RiskControlKind::alarm;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
        attribute :>> verificationStatus = "planned";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.5.2 (REQ 20 — model REQ-CS-20: transition to PAUSED and REQ 59 'Over Infusion VTBI' actions, model NOTIF-06); CITE-002: CriSys AADL v2.0, AGREE over-VTBI => flow <= KVO (model GP-008)"; }
    }
    part infusionCompleteControl : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-013"; :>> label = "InfusionCompleteStopAtVtbi"; }
        attribute :>> controlKind = RiskControlKind::inherentSafeDesign;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
        attribute :>> verificationStatus = "planned";
        @MemoIdentity { :>> sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.6 (REQ 28 — model REQ-CS-28: transition to IDLE when total volume infused reaches the programmed prescription maximum VTBI)"; }
    }
    part riskAfterVtbi : ResidualRisk {
        @MemoIdentity { :>> providedId = "RISK-A-007"; :>> label = "VtbiOverInfusionResidualRisk"; }
        attribute :>> driverKind = "risk";
        attribute :>> probabilityEstimate = ProbabilityKind::remote;
        attribute :>> severityEstimate = SeverityKind::catastrophic;
        attribute :>> riskLevel = CriticalityKind::medium;
        attribute :>> acceptability = RiskAcceptabilityKind::acceptable;
        attribute :>> benefitRiskRequired = false;
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }

    // ── Cross-cutting platform controls ─────────────────────────────
    part watchdogControl : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-007"; :>> label = "HardwareWatchdogSafeState"; }
        attribute :>> controlKind = RiskControlKind::protectiveMeasure;
        attribute :>> implementationKind = RiskControlImplementationKind::hardwareDesign;
        attribute :>> verificationStatus = "planned";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.2 Alarms (watchdog alarm) and §2.3 Pump Checks (watchdog interrupt tests); CITE-008: GPCA Safety Requirements (2009), POST (watchdog test)"; }
    }
    part flowCrossCheckControl : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-008"; :>> label = "IndependentFlowCrossCheck"; }
        attribute :>> controlKind = RiskControlKind::monitoring;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
        attribute :>> verificationStatus = "planned";
        @MemoIdentity { :>> sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 HID 1.2/1.10/1.16 (flow sensor mitigation); CITE-008: GPCA Safety Requirements (2009), Flow rate accuracy (over-infusion and under-infusion alarms from flow sensor comparison)"; }
    }

    part residualEval : OverallResidualRiskEvaluation {
        @MemoIdentity { :>> providedId = "RREV-001"; :>> label = "OverallResidualRiskEvaluation"; }
        attribute :>> conclusion = "Residual risk across opioid over-infusion, under-infusion, air embolism, misprogramming, free flow, reverse delivery, and VTBI over-infusion is acceptable given lockout and max-dose enforcement, KVO-pause alarm semantics for air/occlusion/VTBI/reverse-delivery conditions, drug-database limit checking with confirmation, administration-set free-flow prevention, door interlock, watchdog safe state, and independent flow cross-check, each with planned verification.";
        attribute :>> reviewer = "Safety review";
        @MemoIdentity { :>> sourceReference = "illustrative — no source"; }
    }
}
