package memo {
    package examples {
        package gpca {
            package risk {
                private import memo::architecture::risk::*;
                private import memo::core::common::Citation;
                private import memo::core::enumerations::*;

                // ── Source corpus citations (verified 2026-07-05) ────────────────
                part citeCriSysSysReq : Citation {
                    attribute id = "CITE-001";
                    attribute name = "CriSysGpcaSystemRequirements";
                    attribute source = "System Requirements: Generic Patient Controlled Analgesic Infusion (GPCA) System, draft — Murugesan, Rayadurgam, Heimdahl, University of Minnesota";
                    attribute section = "Ch.2 system description; Ch.3 interfaces (I 1-I 11, data dictionary); Ch.4 behavioral requirements (mode tree, REQ 1-86, REQ 59 notification table); Ch.5 non-behavioral; App. A.4 constants";
                    attribute uri = "https://crisys.cs.umn.edu/downloads/gpca/SystemRequirements.pdf";
                    attribute year = "2013";
                }
                part citeCriSysAadl : Citation {
                    attribute id = "CITE-002";
                    attribute name = "CriSysGpcaAadlModel";
                    attribute source = "GPCA System Architectural Model v2.0 (AADL packages, AGREE contracts, ModelDocumentation.pdf) — University of Minnesota CriSys";
                    attribute section = "8 software subcomponents + port topology + AGREE contracts";
                    attribute uri = "https://crisys.cs.umn.edu/downloads/gpca/AADL.zip";
                    attribute year = "undated";
                }
                part citeCriSysVerification : Citation {
                    attribute id = "CITE-003";
                    attribute name = "CriSysGpcaVerification";
                    attribute source = "GPCA compositional verification package (AGREE properties, Simulink/Stateflow models) — University of Minnesota CriSys";
                    attribute section = "Full package";
                    attribute uri = "https://crisys.cs.umn.edu/downloads/gpca/Verification.zip";
                    attribute year = "undated";
                }
                part citeGipHazardAnalysis : Citation {
                    attribute id = "CITE-004";
                    attribute name = "GipHazardAnalysis";
                    attribute source = "Generic Infusion Pump Hazard Analysis and Safety Requirements Version 1.0 — Arney, Jetley, Jones, Lee, Ray, Sokolsky, Zhang; University of Pennsylvania / FDA OSEL";
                    attribute section = "§2.1 hazards; §2.2 alarms and alerts; §2.3 pump checks; §2.4.1-2.4.8 hazard tables; §3 safety requirements";
                    attribute uri = "https://repository.upenn.edu/cis_reports/893/";
                    attribute year = "2009";
                }
                part citeOpenPcaPump : Citation {
                    attribute id = "CITE-005";
                    attribute name = "OpenPcaPumpArtifacts";
                    attribute source = "Open PCA Pump project artifacts (requirements, 121-component AADL model, assurance case, ISO 14971 EMV2 risk analysis) — Kansas State University SAnToS Lab";
                    attribute section = "Project artifact repository";
                    attribute uri = "http://openpcapump.santoslab.org";
                    attribute year = "undated";
                }
                part citeGiipTaxonomy : Citation {
                    attribute id = "CITE-006";
                    attribute name = "FdaGiipHazardTaxonomy";
                    attribute source = "A Hazard Analysis for a Generic Insulin Infusion Pump — Zhang, Jones et al., Journal of Diabetes Science and Technology (structure template only; insulin-pump content, not GPCA)";
                    attribute section = "Hazard taxonomy and cause-source tables";
                    attribute uri = "https://pmc.ncbi.nlm.nih.gov/articles/PMC2864162/";
                    attribute year = "2010";
                }

                // ── Shared risk matrix ───────────────────────────────────────────
                part riskMatrix : RiskMatrix {
                    attribute id = "RMX-001";
                    attribute name = "StandardRiskMatrix";
                    attribute probabilityScaleDefinition = "Remote, Occasional, Probable";
                    attribute severityScaleDefinition = "Minor, Serious, Catastrophic";
                    attribute riskLevelMapping = "matrix based";
                    attribute acceptabilityThresholds = "High unacceptable";
                }

                // ═══ HZ-001: Overdose via bolus misuse ══════════════════════════
                part overdoseHazard : Hazard {
                    attribute id = "HZ-001";
                    attribute name = "Overdose";
                    attribute hazardType = HazardTypeKind::drugDeliveryError;
                    attribute severity = SeverityKind::catastrophic;
                    attribute foreseeable = true;
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 Operational Hazards (overinfusion)";
                }
                part seqFrequentBolus : SequenceOfEvents {
                    attribute id = "SEQ-001";
                    attribute name = "FrequentPatientBolusSequence";
                    attribute initiatingEvent = "Patient bolus request during lockout";
                    attribute contributingFactors = "Lockout violation or max bolus exceeded";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.1.9 PATIENT BOLUS mode (lockout and max-dose requirements)";
                }
                part hsExcessInfusion : HazardousSituation {
                    attribute id = "HS-001";
                    attribute name = "PatientExposedToExcessInfusion";
                    attribute exposedPersons = "patient";
                    attribute operatingCondition = "ACTIVE therapy";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 Operational Hazards (overinfusion)";
                }
                part harmRespiratoryDepression : Harm {
                    attribute id = "HM-001";
                    attribute name = "RespiratoryDepression";
                    attribute clinicalImpact = "serious injury or death";
                    attribute reversibility = "potentially irreversible";
                    attribute severity = SeverityKind::catastrophic;
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 Operational Hazards (overinfusion)";
                }
                part riskBefore : RiskBeforeMitigation {
                    attribute id = "RISK-B-001";
                    attribute name = "OverdoseRiskBeforeMitigation";
                    attribute driverKind = "risk";
                    attribute probabilityEstimate = ProbabilityKind::occasional;
                    attribute severityEstimate = SeverityKind::catastrophic;
                    attribute riskLevel = CriticalityKind::high;
                    attribute acceptability = RiskAcceptabilityKind::unacceptable;
                    attribute estimationBasis = "mode and bolus hazard analysis";
                    attribute analysisContext = "patient bolus and active mode control";
                    attribute foreseeableMisuseIncluded = true;
                    attribute sourceReference = "illustrative — no source";
                }
                part lockoutControl : RiskControl {
                    attribute id = "RC-001";
                    attribute name = "LockoutAndMaxBolusEnforcement";
                    attribute controlKind = RiskControlKind::inherentSafeDesign;
                    attribute implementationKind = RiskControlImplementationKind::softwareDesign;
                    attribute verificationStatus = "planned";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §2.2.2 Overdose Protection and §4.1.9 PATIENT BOLUS mode";
                }
                part riskAfter : RiskAfterMitigation {
                    attribute id = "RISK-A-001";
                    attribute name = "OverdoseRiskAfterMitigation";
                    attribute driverKind = "risk";
                    attribute probabilityEstimate = ProbabilityKind::remote;
                    attribute severityEstimate = SeverityKind::catastrophic;
                    attribute riskLevel = CriticalityKind::medium;
                    attribute acceptability = RiskAcceptabilityKind::alarp;
                    attribute residualProbability = ProbabilityKind::remote;
                    attribute residualSeverity = SeverityKind::catastrophic;
                    attribute residualAcceptability = RiskAcceptabilityKind::acceptable;
                    attribute benefitRiskRequired = false;
                }

                // ═══ HZ-002: Under-infusion / therapy interruption ══════════════
                part underdoseHazard : Hazard {
                    attribute id = "HZ-002";
                    attribute name = "UnderInfusion";
                    attribute hazardType = HazardTypeKind::drugDeliveryError;
                    attribute severity = SeverityKind::serious;
                    attribute foreseeable = true;
                    attribute description = "Delivered dose falls below prescription due to occlusion, empty reservoir, or pump degradation.";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 Operational Hazards (underinfusion)";
                }
                part seqOcclusion : SequenceOfEvents {
                    attribute id = "SEQ-002";
                    attribute name = "UndetectedOcclusionSequence";
                    attribute initiatingEvent = "Downstream line kinked or clamped during active therapy";
                    attribute contributingFactors = "Occlusion not detected or alarm not annunciated; post-occlusion bolus on release";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.2 Alarms and Alerts (occlusion)";
                }
                part hsInterruptedTherapy : HazardousSituation {
                    attribute id = "HS-002";
                    attribute name = "PatientReceivingLessThanPrescribedDose";
                    attribute exposedPersons = "patient";
                    attribute operatingCondition = "ACTIVE therapy with blocked or exhausted fluid path";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 Operational Hazards (underinfusion)";
                }
                part harmUntreatedPain : Harm {
                    attribute id = "HM-002";
                    attribute name = "UntreatedPainAndClinicalDeterioration";
                    attribute clinicalImpact = "uncontrolled pain, delayed recovery, post-occlusion bolus injury";
                    attribute reversibility = "reversible with intervention";
                    attribute severity = SeverityKind::serious;
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 Operational Hazards (underinfusion)";
                }
                part riskBeforeUnderdose : RiskBeforeMitigation {
                    attribute id = "RISK-B-002";
                    attribute name = "UnderInfusionRiskBeforeMitigation";
                    attribute driverKind = "risk";
                    attribute probabilityEstimate = ProbabilityKind::probable;
                    attribute severityEstimate = SeverityKind::serious;
                    attribute riskLevel = CriticalityKind::high;
                    attribute acceptability = RiskAcceptabilityKind::unacceptable;
                    attribute estimationBasis = "occlusion and reservoir exhaustion frequency in ward use";
                    attribute analysisContext = "fluid path monitoring during active therapy";
                    attribute foreseeableMisuseIncluded = true;
                    attribute sourceReference = "illustrative — no source";
                }
                part occlusionAlarmControl : RiskControl {
                    attribute id = "RC-003";
                    attribute name = "OcclusionDetectionAndAlarm";
                    attribute controlKind = RiskControlKind::alarm;
                    attribute implementationKind = RiskControlImplementationKind::softwareDesign;
                    attribute verificationStatus = "planned";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.2 Alarms and Alerts (occlusion)";
                }
                part reservoirMonitorControl : RiskControl {
                    attribute id = "RC-004";
                    attribute name = "ReservoirEmptyDetectionAndAlarm";
                    attribute controlKind = RiskControlKind::monitoring;
                    attribute implementationKind = RiskControlImplementationKind::softwareDesign;
                    attribute verificationStatus = "planned";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.3 Notification Requirements (REQ 59: Empty Reservoir)";
                }
                part riskAfterUnderdose : RiskAfterMitigation {
                    attribute id = "RISK-A-002";
                    attribute name = "UnderInfusionRiskAfterMitigation";
                    attribute driverKind = "risk";
                    attribute probabilityEstimate = ProbabilityKind::remote;
                    attribute severityEstimate = SeverityKind::serious;
                    attribute riskLevel = CriticalityKind::medium;
                    attribute acceptability = RiskAcceptabilityKind::alarp;
                    attribute residualProbability = ProbabilityKind::remote;
                    attribute residualSeverity = SeverityKind::serious;
                    attribute residualAcceptability = RiskAcceptabilityKind::acceptable;
                    attribute benefitRiskRequired = false;
                }

                // ═══ HZ-003: Air embolism ═══════════════════════════════════════
                part airEmbolismHazard : Hazard {
                    attribute id = "HZ-003";
                    attribute name = "AirEmbolism";
                    attribute hazardType = HazardTypeKind::drugDeliveryError;
                    attribute severity = SeverityKind::catastrophic;
                    attribute foreseeable = true;
                    attribute description = "Air infused into the patient line above the clinically tolerable volume.";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.3 Notification Requirements (REQ 59: Air embolism)";
                }
                part seqAirInLine : SequenceOfEvents {
                    attribute id = "SEQ-003";
                    attribute name = "AirEntersLineSequence";
                    attribute initiatingEvent = "Reservoir runs dry or set primed incompletely";
                    attribute contributingFactors = "Air sensor failed, disabled, or threshold miscalibrated";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.2 Alarms and Alerts (air-in-line)";
                }
                part hsAirTowardPatient : HazardousSituation {
                    attribute id = "HS-003";
                    attribute name = "AirColumnAdvancingTowardPatient";
                    attribute exposedPersons = "patient";
                    attribute operatingCondition = "ACTIVE therapy with air in the administration set";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.3 Notification Requirements (REQ 59: Air embolism)";
                }
                part harmAirEmbolism : Harm {
                    attribute id = "HM-003";
                    attribute name = "VascularAirEmbolismInjury";
                    attribute clinicalImpact = "cardiovascular or neurological injury, potentially fatal";
                    attribute reversibility = "potentially irreversible";
                    attribute severity = SeverityKind::catastrophic;
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.3 Notification Requirements (REQ 59: Air embolism)";
                }
                part riskBeforeAir : RiskBeforeMitigation {
                    attribute id = "RISK-B-003";
                    attribute name = "AirEmbolismRiskBeforeMitigation";
                    attribute driverKind = "risk";
                    attribute probabilityEstimate = ProbabilityKind::occasional;
                    attribute severityEstimate = SeverityKind::catastrophic;
                    attribute riskLevel = CriticalityKind::high;
                    attribute acceptability = RiskAcceptabilityKind::unacceptable;
                    attribute estimationBasis = "reservoir exhaustion and priming error frequency";
                    attribute analysisContext = "fluid path integrity during active therapy";
                    attribute foreseeableMisuseIncluded = true;
                    attribute sourceReference = "illustrative — no source";
                }
                part airDetectionControl : RiskControl {
                    attribute id = "RC-002";
                    attribute name = "AirInLineDetectionSameStepStop";
                    attribute controlKind = RiskControlKind::protectiveMeasure;
                    attribute implementationKind = RiskControlImplementationKind::softwareDesign;
                    attribute verificationStatus = "planned";
                    attribute sourceReference = "CITE-001: CriSys GPCA System Requirements (2013), §4.3 Notification Requirements (REQ 59: Air embolism, inhibit infusion)";
                }
                part riskAfterAir : RiskAfterMitigation {
                    attribute id = "RISK-A-003";
                    attribute name = "AirEmbolismRiskAfterMitigation";
                    attribute driverKind = "risk";
                    attribute probabilityEstimate = ProbabilityKind::remote;
                    attribute severityEstimate = SeverityKind::catastrophic;
                    attribute riskLevel = CriticalityKind::medium;
                    attribute acceptability = RiskAcceptabilityKind::alarp;
                    attribute residualProbability = ProbabilityKind::remote;
                    attribute residualSeverity = SeverityKind::catastrophic;
                    attribute residualAcceptability = RiskAcceptabilityKind::acceptable;
                    attribute benefitRiskRequired = false;
                }

                // ═══ HZ-004: Incorrect drug or dose programmed (use error) ══════
                part wrongDoseHazard : Hazard {
                    attribute id = "HZ-004";
                    attribute name = "IncorrectDrugOrDoseProgrammed";
                    attribute hazardType = HazardTypeKind::useError;
                    attribute severity = SeverityKind::catastrophic;
                    attribute foreseeable = true;
                    attribute description = "Prescription programmed or reservoir loaded so delivered therapy differs from the intended prescription.";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.8 Use Hazards (incorrect dose settings)";
                }
                part seqMisprogram : SequenceOfEvents {
                    attribute id = "SEQ-004";
                    attribute name = "MisprogrammingSequence";
                    attribute initiatingEvent = "Clinician enters rate or bolus volume an order of magnitude off (UE-001) or wrong drug loaded (UE-003)";
                    attribute contributingFactors = "No drug library check, confirmation skipped, look-alike packaging";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.8 Use Hazards (incorrect dose settings)";
                }
                part hsWrongTherapy : HazardousSituation {
                    attribute id = "HS-004";
                    attribute name = "PatientReceivingUnintendedTherapy";
                    attribute exposedPersons = "patient";
                    attribute operatingCondition = "therapy started from an unverified prescription";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.8 Use Hazards (incorrect dose settings)";
                }
                part riskBeforeWrongDose : RiskBeforeMitigation {
                    attribute id = "RISK-B-004";
                    attribute name = "MisprogrammingRiskBeforeMitigation";
                    attribute driverKind = "risk";
                    attribute probabilityEstimate = ProbabilityKind::probable;
                    attribute severityEstimate = SeverityKind::catastrophic;
                    attribute riskLevel = CriticalityKind::high;
                    attribute acceptability = RiskAcceptabilityKind::unacceptable;
                    attribute estimationBasis = "published PCA misprogramming incident rates";
                    attribute analysisContext = "prescription entry and reservoir loading tasks";
                    attribute foreseeableMisuseIncluded = true;
                    attribute sourceReference = "illustrative — no source";
                }
                part drugLibraryControl : RiskControl {
                    attribute id = "RC-005";
                    attribute name = "DrugLibraryLimitsAndConfirmation";
                    attribute controlKind = RiskControlKind::plausibilityCheck;
                    attribute implementationKind = RiskControlImplementationKind::softwareDesign;
                    attribute verificationStatus = "planned";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 hazard mitigations (drug library)";
                }
                part riskAfterWrongDose : RiskAfterMitigation {
                    attribute id = "RISK-A-004";
                    attribute name = "MisprogrammingRiskAfterMitigation";
                    attribute driverKind = "risk";
                    attribute probabilityEstimate = ProbabilityKind::remote;
                    attribute severityEstimate = SeverityKind::catastrophic;
                    attribute riskLevel = CriticalityKind::medium;
                    attribute acceptability = RiskAcceptabilityKind::alarp;
                    attribute residualProbability = ProbabilityKind::remote;
                    attribute residualSeverity = SeverityKind::catastrophic;
                    attribute residualAcceptability = RiskAcceptabilityKind::acceptable;
                    attribute benefitRiskRequired = true;
                }

                // ═══ HZ-005: Free flow ══════════════════════════════════════════
                part freeFlowHazard : Hazard {
                    attribute id = "HZ-005";
                    attribute name = "GravityFreeFlow";
                    attribute hazardType = HazardTypeKind::mechanicalFailure;
                    attribute severity = SeverityKind::catastrophic;
                    attribute foreseeable = true;
                    attribute description = "Unregulated gravity flow of drug when the set is disengaged from the pumping mechanism.";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 Operational Hazards (free flow of drug)";
                }
                part seqFreeFlow : SequenceOfEvents {
                    attribute id = "SEQ-005";
                    attribute name = "SetDisengagedSequence";
                    attribute initiatingEvent = "Door opened / set removed with reservoir above patient level";
                    attribute contributingFactors = "Anti-free-flow valve absent, defeated, or failed";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 Operational Hazards (free flow of drug)";
                }
                part hsFreeFlow : HazardousSituation {
                    attribute id = "HS-005";
                    attribute name = "PatientConnectedToUnregulatedFluidPath";
                    attribute exposedPersons = "patient";
                    attribute operatingCondition = "set change or door open with line still connected";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 Operational Hazards (free flow of drug)";
                }
                part riskBeforeFreeFlow : RiskBeforeMitigation {
                    attribute id = "RISK-B-005";
                    attribute name = "FreeFlowRiskBeforeMitigation";
                    attribute driverKind = "risk";
                    attribute probabilityEstimate = ProbabilityKind::occasional;
                    attribute severityEstimate = SeverityKind::catastrophic;
                    attribute riskLevel = CriticalityKind::high;
                    attribute acceptability = RiskAcceptabilityKind::unacceptable;
                    attribute estimationBasis = "set-change frequency and historic free-flow incidents";
                    attribute analysisContext = "reservoir and set handling during therapy";
                    attribute foreseeableMisuseIncluded = true;
                    attribute sourceReference = "illustrative — no source";
                }
                part freeFlowValveControl : RiskControl {
                    attribute id = "RC-006";
                    attribute name = "AntiFreeFlowValveInterlock";
                    attribute controlKind = RiskControlKind::inherentSafeDesign;
                    attribute implementationKind = RiskControlImplementationKind::hardwareDesign;
                    attribute verificationStatus = "planned";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §3 Safety Requirements (free flow)";
                }
                part riskAfterFreeFlow : RiskAfterMitigation {
                    attribute id = "RISK-A-005";
                    attribute name = "FreeFlowRiskAfterMitigation";
                    attribute driverKind = "risk";
                    attribute probabilityEstimate = ProbabilityKind::improbable;
                    attribute severityEstimate = SeverityKind::catastrophic;
                    attribute riskLevel = CriticalityKind::medium;
                    attribute acceptability = RiskAcceptabilityKind::acceptable;
                    attribute residualProbability = ProbabilityKind::improbable;
                    attribute residualSeverity = SeverityKind::catastrophic;
                    attribute residualAcceptability = RiskAcceptabilityKind::acceptable;
                    attribute benefitRiskRequired = false;
                }

                // ── Additional software-platform controls ───────────────────────
                part watchdogControl : RiskControl {
                    attribute id = "RC-007";
                    attribute name = "HardwareWatchdogSafeState";
                    attribute controlKind = RiskControlKind::protectiveMeasure;
                    attribute implementationKind = RiskControlImplementationKind::hardwareDesign;
                    attribute verificationStatus = "planned";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.2 Alarms and Alerts (watchdog alarm)";
                }
                part flowCrossCheckControl : RiskControl {
                    attribute id = "RC-008";
                    attribute name = "IndependentFlowCrossCheck";
                    attribute controlKind = RiskControlKind::monitoring;
                    attribute implementationKind = RiskControlImplementationKind::softwareDesign;
                    attribute verificationStatus = "planned";
                    attribute sourceReference = "CITE-004: GIP Hazard Analysis v1.0 (2009), §2.4.1 hazard mitigations (flow sensor)";
                }

                part residualEval : OverallResidualRiskEvaluation {
                    attribute id = "RREV-001";
                    attribute name = "OverallResidualRiskEvaluation";
                    attribute conclusion = "Residual risk across overdose, under-infusion, air embolism, misprogramming, and free flow is acceptable given lockout and dose limiting, same-step alarm stops, drug-library checking with confirmation, mechanical free-flow prevention, watchdog safe state, and independent flow cross-check, each with planned verification.";
                    attribute reviewer = "Safety review";
                }
            }
        }
    }
}
