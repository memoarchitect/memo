package memo_examples_gpca_pump_gpca_trace {
    private import memo::*;
    private import ScalarValues::*;
    private import ModelingMetadata::*;

    private import memo_examples_gpca_pump_gpca_context::*;
    private import memo_examples_gpca_pump_gpca_operational::*;
    private import memo_examples_gpca_pump_gpca_system::*;
    private import memo_examples_gpca_pump_gpca_requirements::*;
    private import memo_examples_gpca_pump_gpca_architecture::*;
    private import memo_examples_gpca_pump_gpca_physical::*;
    private import memo_examples_gpca_pump_gpca_behavior_subsystems::*;
    private import memo_examples_gpca_pump_gpca_behavior_modes::*;
    private import memo_examples_gpca_pump_gpca_interfaces::*;
    private import memo_examples_gpca_pump_gpca_risk::*;
    private import memo_examples_gpca_pump_gpca_analysis::*;
    private import memo_examples_gpca_pump_gpca_verification::*;
    private import memo_examples_gpca_pump_viewpoints_shared_views_document_architecture_description_view::*;
    private import memo_examples_gpca_pump_viewpoints_cybersecurity_views_document_cyber_assessment_view::*;
    private import memo_examples_gpca_pump_viewpoints_shared_views_document_dhf_index_view::*;
    private import memo_examples_gpca_pump_viewpoints_risk_views_document_hazard_analysis_view::*;
    private import memo_examples_gpca_pump_viewpoints_risk_views_document_rmf_view::*;
    private import memo_examples_gpca_pump_viewpoints_software_views_document_sdd_view::*;
    private import memo_examples_gpca_pump_viewpoints_cybersecurity_views_document_threat_model_view::*;
    private import memo_examples_gpca_pump_viewpoints_usability_views_document_usability_view::*;
    private import memo_examples_gpca_pump_viewpoints_verification_views_document_vv_view::*;
    private import memo_examples_gpca_pump_gpca_formal_behavior::*;

    // ── System context interactions (context view) ──────────────
    connection connect actorPatient to entityGpcaPump;
    connection connect actorNurse to entityGpcaPump;
    connection connect actorPrescriber to entityGpcaPump;
    connection connect actorPharmacist to entityGpcaPump;
    connection connect actorTechnician to entityGpcaPump;
    connection connect actorPharmacist to entityPharmacy;

    // ── Fig 2.1 context flows (CriSys §2.1) ─────────────────────
    // Data exchanges: who exchanges data with whom (the figure names no item),
    // so each is a connection from the source to the receiver.
    connection entityPrescriptionToActorNurse connect entityPrescription to actorNurse;
    connection actorNurseToEntityGpcaPump connect actorNurse to entityGpcaPump;
    connection entityGpcaPumpToActorNurse connect entityGpcaPump to actorNurse;
    connection actorPatientToEntityGpcaPump connect actorPatient to entityGpcaPump;
    connection entityPharmacyDbToEntityGpcaPump connect entityPharmacyDb to entityGpcaPump;
    // Physical connections (drug path)
    connection connect entityDrugReservoir to entityGpcaPump;
    connection connect entityGpcaPump to entityNeedle;
    connection connect entityNeedle to actorPatient;
    connection connect entityPowerInfrastructure to entityGpcaPump;
    // Intended use and use context anchoring (no floating context nodes)
    connection : Governs connect gpcaIntendedUse to entityGpcaPump { attribute :>> governKind = GovernKind::'use'; }
    connection : AppliesInContext connect hospitalWardContext to entityGpcaPump;
    connection : AppliesInContext connect hospitalWardContext to entityHospital;

    // Actor participation (use case view): native `actor`, nested in
    // ucDeliverPcaTherapy's own body in gpca_operational.sysml (R10-S6).

    // ── Operational thread (therapy lifecycle) ──────────────────
    first oaPrescribe then oaLoadReservoir;
    first oaLoadReservoir then oaProgram;
    first oaProgram then oaStartTherapy;
    first oaStartTherapy then oaRequestBolus;
    connection : DerivesFrom connect oaProgram to reqDrugLibraryLimits;
    connection : DerivesFrom connect oaRequestBolus to reqCs25;
    connection : DerivesFrom connect oaRespondAlarm to reqCs59;

    // ── Functional chains ───────────────────────────────────────
    // fcPatientBolus/fcAlarmStop already name every one of these functions:
    // each step subsets the function it performs (`action fcsBolusSense :>
    // fnAcquireSensors`) in gpca_system.sysml — InvolvesFunction was a
    // flattened restatement of that, not new information.
    // fcStartup declares no steps, so its two functions are native `perform`
    // statements directly on fcStartup in gpca_system.sysml instead.
    #refinement dependency fcPatientBolus to ssBolusDuringBasal;
    #refinement dependency fcAlarmStop to ssAlarmPause;

    // A user task may be realized by several system-side steps: the mapping is
    // refinement, not specialization, because the steps retain distinct
    // functions and exchanged items while tracing the same operative intent.
    // The nine refinement statements themselves live in gpca_operational.sysml,
    // inside wsRequestBolus's/wsRespondAlarm's own owning scope — the
    // `#refinement dependency ... to ...` shorthand's target end does not
    // accept a qualified path, and the operative actions are nested.

    // ── Requirement derivation ──────────────────────────────────
    // MEMO extension requirements (REQ-X) derive from needs and risks.
    // --8<-- [start:derives]
    connection : DerivesFrom connect needSafeTherapy to reqPost;
    connection : DerivesFrom connect needEffectiveAnalgesia to reqPumpAccuracy;
    connection : DerivesFrom connect needEffectiveAnalgesia to reqBatteryBackup;
    connection : DerivesFrom connect needTimelyAlarms to reqAlarmLoudness;
    connection : DerivesFrom connect needAuditableRecord to reqEventLogging;
    // --8<-- [end:derives]
    connection : DerivesFrom connect overdoseHazard to reqCs25;
    connection : DerivesFrom connect underdoseHazard to reqOcclusion;
    connection : DerivesFrom connect airEmbolismHazard to reqCs21;
    connection : DerivesFrom connect wrongDoseHazard to reqDrugLibraryLimits;
    connection : DerivesFrom connect freeFlowHazard to reqFreeFlowPrevention;
    connection : DerivesFrom connect reverseDeliveryHazard to reqCs22;
    connection : DerivesFrom connect vtbiOverInfusionHazard to reqCs20;
    connection : DerivesFrom connect vtbiOverInfusionHazard to reqCs28;
    connection : DerivesFrom connect riskBeforeReverse to reqCs22;
    connection : DerivesFrom connect riskBeforeVtbi to reqCs20;
    connection : DerivesFrom connect riskBefore to reqCs25;
    connection : DerivesFrom connect riskBefore to reqCs19;
    connection : DerivesFrom connect riskBefore to reqMaxHourlyDose;
    connection : DerivesFrom connect riskBefore to reqStuckButton;
    connection : DerivesFrom connect riskBefore to reqWatchdogSafeState;
    connection : DerivesFrom connect riskBefore to reqFlowCrossCheck;
    connection : DerivesFrom connect riskBeforeAir to reqCs21;
    connection : DerivesFrom connect riskBeforeUnderdose to reqOcclusion;
    connection : DerivesFrom connect riskBeforeUnderdose to reqCs23;
    connection : DerivesFrom connect riskBeforeUnderdose to reqPowerLossRetention;
    connection : DerivesFrom connect riskBeforeWrongDose to reqDrugLibraryLimits;
    connection : DerivesFrom connect riskBeforeWrongDose to reqCs09;
    connection : DerivesFrom connect riskBeforeFreeFlow to reqFreeFlowPrevention;
    connection : DerivesFrom connect riskBeforeFreeFlow to reqDoorOpen;
    // CriSys source requirements (REQ-CS) trace to the stakeholder
    // needs they serve. §4.1 GPCA system + OFF/ON/IDLE modes.
    connection : DerivesFrom connect needSafeTherapy to reqCs01;
    connection : DerivesFrom connect needSafeTherapy to reqCs02;
    connection : DerivesFrom connect needSafeTherapy to reqCs03;
    connection : DerivesFrom connect needSafeTherapy to reqCs04;
    connection : DerivesFrom connect needSafeTherapy to reqCs05;
    connection : DerivesFrom connect needSafeTherapy to reqCs06;
    connection : DerivesFrom connect needSafeTherapy to reqCs07;
    connection : DerivesFrom connect needSafeTherapy to reqCs08;
    connection : DerivesFrom connect needSafeTherapy to reqCs10;
    connection : DerivesFrom connect needAuditableRecord to reqCs11;
    connection : DerivesFrom connect needSafeTherapy to reqCs12;
    connection : DerivesFrom connect needSafeTherapy to reqCs13;
    connection : DerivesFrom connect needSafeTherapy to reqCs14;
    connection : DerivesFrom connect needTimelyAlarms to reqCs15;
    // §4.1 THERAPY/ACTIVE/BASAL/bolus/PAUSED modes.
    connection : DerivesFrom connect needEffectiveAnalgesia to reqCs16;
    connection : DerivesFrom connect needSafeTherapy to reqCs17;
    connection : DerivesFrom connect needSafeTherapy to reqCs18;
    connection : DerivesFrom connect needSafeTherapy to reqCs20;
    connection : DerivesFrom connect needSafeTherapy to reqCs22;
    connection : DerivesFrom connect needEffectiveAnalgesia to reqCs24;
    connection : DerivesFrom connect needSafeTherapy to reqCs26;
    connection : DerivesFrom connect needSafeTherapy to reqCs27;
    connection : DerivesFrom connect needSafeTherapy to reqCs28;
    connection : DerivesFrom connect needSafeTherapy to reqCs29;
    connection : DerivesFrom connect needSafeTherapy to reqCs30;
    connection : DerivesFrom connect needSafeTherapy to reqCs31;
    connection : DerivesFrom connect needSafeTherapy to reqCs32;
    connection : DerivesFrom connect needSafeTherapy to reqCs33;
    connection : DerivesFrom connect needSafeTherapy to reqCs34;
    connection : DerivesFrom connect needSafeTherapy to reqCs35;
    connection : DerivesFrom connect needSafeTherapy to reqCs36;
    connection : DerivesFrom connect needSafeTherapy to reqCs37;
    connection : DerivesFrom connect needSafeTherapy to reqCs38;
    connection : DerivesFrom connect needSafeTherapy to reqCs39;
    connection : DerivesFrom connect needEffectiveAnalgesia to reqCs40;
    connection : DerivesFrom connect needEffectiveAnalgesia to reqCs41;
    connection : DerivesFrom connect needEffectiveAnalgesia to reqCs42;
    connection : DerivesFrom connect needEffectiveAnalgesia to reqCs43;
    connection : DerivesFrom connect needTimelyAlarms to reqCs44;
    connection : DerivesFrom connect needSafeTherapy to reqCs45;
    connection : DerivesFrom connect needSafeTherapy to reqCs46;
    connection : DerivesFrom connect needSafeTherapy to reqCs47;
    // §4.2 data configuration.
    connection : DerivesFrom connect needSafeTherapy to reqCs48;
    connection : DerivesFrom connect needSafeTherapy to reqCs49;
    connection : DerivesFrom connect needSafeTherapy to reqCs50;
    connection : DerivesFrom connect needSafeTherapy to reqCs51;
    connection : DerivesFrom connect needSafeTherapy to reqCs52;
    connection : DerivesFrom connect needSafeTherapy to reqCs53;
    connection : DerivesFrom connect needSafeTherapy to reqCs54;
    connection : DerivesFrom connect needSafeTherapy to reqCs55;
    connection : DerivesFrom connect needSafeTherapy to reqCs56;
    connection : DerivesFrom connect needSafeTherapy to reqCs57;
    connection : DerivesFrom connect needSafeTherapy to reqCs58;
    // §4.3 notification, §4.4 logs, §4.5 security, Ch.5 non-behavioral.
    connection : DerivesFrom connect needTimelyAlarms to reqCs59;
    connection : DerivesFrom connect needTimelyAlarms to reqCs60;
    connection : DerivesFrom connect needTimelyAlarms to reqCs61;
    connection : DerivesFrom connect needTimelyAlarms to reqCs62;
    connection : DerivesFrom connect needTimelyAlarms to reqCs63;
    connection : DerivesFrom connect needTimelyAlarms to reqCs64;
    connection : DerivesFrom connect needTimelyAlarms to reqCs65;
    connection : DerivesFrom connect needTimelyAlarms to reqCs66;
    connection : DerivesFrom connect needTimelyAlarms to reqCs67;
    connection : DerivesFrom connect needTimelyAlarms to reqCs68;
    connection : DerivesFrom connect needTimelyAlarms to reqCs69;
    connection : DerivesFrom connect needTimelyAlarms to reqCs70;
    connection : DerivesFrom connect needTimelyAlarms to reqCs71;
    connection : DerivesFrom connect needTimelyAlarms to reqCs72;
    connection : DerivesFrom connect needTimelyAlarms to reqCs73;
    connection : DerivesFrom connect needTimelyAlarms to reqCs74;
    connection : DerivesFrom connect needTimelyAlarms to reqCs75;
    connection : DerivesFrom connect needTimelyAlarms to reqCs76;
    connection : DerivesFrom connect needAuditableRecord to reqCs77;
    connection : DerivesFrom connect needAuditableRecord to reqCs78;
    connection : DerivesFrom connect needAuditableRecord to reqCs79;
    connection : DerivesFrom connect needAuditableRecord to reqCs80;
    connection : DerivesFrom connect needAuditableRecord to reqCs81;
    connection : DerivesFrom connect needSafeTherapy to reqCs82;
    connection : DerivesFrom connect needSafeTherapy to reqCs83;
    connection : DerivesFrom connect needSafeTherapy to reqCs84;
    connection : DerivesFrom connect needAuditableRecord to reqCs85;
    connection : DerivesFrom connect needAuditableRecord to reqCs86;

    // ── Requirement satisfaction ────────────────────────────────































    // CriSys REQ-CS allocation to the UMN software subsystems
    // (coarse; refined against the AADL architecture in GR.04).
    // Mode control -> TLM; flow production -> Infusion_Manager;
    // notifications -> Alarm; data configuration -> Config;
    // logs -> Logging; enclosure non-behavioral -> DeviceEnclosure.














































































    // ── Function allocation ─────────────────────────────────────
    allocate fnAcquireSensors to gpcaDevice.gpcaDeviceSensors;
    allocate fnAcquireSensors to gpcaSoftware.systemStatus;
    allocate fnPresentStatus to gpcaSoftware.outputBus;
    allocate fnValidatePrescription to gpcaSoftware.config;
    allocate fnMonitorAlarm to gpcaSoftware.alarm;
    allocate fnAnnunciate to audibleAlarm;
    allocate fnManageInfusion to gpcaSoftware.infusionMgr;
    allocate fnEnforceLimits to gpcaSoftware.infusionMgr;
    allocate fnCommandPump to pumpMotorAssembly;
    allocate fnLogEvents to gpcaSoftware.logging;
    allocate fnManagePower to gpcaSoftware.systemMonitor;
    allocate fnPresentStatus to operatorDisplay;
    allocate fnSelfTest to gpcaSoftware.systemMonitor;
    // ── Deployment, hosting, and interface realization ──────────
    // Software reaches the hardware as a built image on the processor that
    // runs it: modules build into the image, the image deploys to the MCU.
    // --8<-- [start:deployment]
    part gpcaFirmwareImage : SoftwareDeploymentUnit {
        @MemoIdentity { :>> providedId = "DU-001"; :>> label = "GPCAFirmwareImage"; }
        attribute :>> unitKind = "firmware image";
        attribute :>> version = "2.0.0";
    }
    allocation : BuildsInto allocate gpcaSoftware.tlm to gpcaFirmwareImage;
    allocation : BuildsInto allocate gpcaSoftware.config to gpcaFirmwareImage;
    allocation : BuildsInto allocate gpcaSoftware.alarm to gpcaFirmwareImage;
    allocation : BuildsInto allocate gpcaSoftware.logging to gpcaFirmwareImage;
    allocation : BuildsInto allocate gpcaSoftware.infusionMgr to gpcaFirmwareImage;
    allocation : BuildsInto allocate gpcaSoftware.systemMonitor to gpcaFirmwareImage;
    allocation gpcaSoftwareDeployment : DeploysTo allocate gpcaFirmwareImage to mainController {
        attribute :>> deploymentKind = DeploymentKind::embedded;
    }
    allocation : HostedBy allocate mainController to controllerBoard;
    #refinement dependency sensorInputInterface to hwSoftwareBus;
    #refinement dependency actuatorCommandInterface to pumpMotorDrive;
    // --8<-- [end:deployment]
    connection : BindsToInterface connect portPatientPendant to bolusButtonLine;
    connection : BindsToInterface connect portMotorDrive to pumpMotorDrive;
    connection : BindsToInterface connect portSensorHarness to occlusionAnalogLine;
    allocate lfSensorAcquisition to exSensorVector;
    allocate lfFlowCommand to exFlowCommand;
    allocate lfAlarmSignal to exAlarmAnnunciation;
    allocate lfPrescriptionEntry to exPrescriptionEntry;
    // ── Fig 4.1 mode hierarchy (CriSys §4.1) ────────────────────

    // ── GPCA_SW.Impl connection topology (AADL; CE-101..142) ─────
    // The COMPONENT-granularity half of the 42 GPCA_SW.Impl port
    // connections; immediate semantics per connection are carried on
    // the CE-1xx elements.
    //
    // Only the 27 subcomponent-to-subcomponent edges live here. AADL's
    // other 15 are DELEGATIONS between GPCA_SW's own boundary port and
    // a subcomponent, and a delegation has no component-granularity
    // spelling: writing it `portOpCmdIn -> tlm` mixes a port end with a
    // component end, and SysML v2 rejects it because a boundary port
    // reads as a sink from outside its part. All 15 are already
    // recorded exactly, at port granularity, as `bind` statements in
    // gpca_interfaces.sysml — so nothing is lost by not restating them
    // here in a granularity that cannot express them.
    flow tlmToOutputBus from gpcaSoftware.tlm to gpcaSoftware.outputBus;
    flow infusionMgrToSystemStatus from gpcaSoftware.infusionMgr to gpcaSoftware.systemStatus;
    flow tlmToSystemStatus from gpcaSoftware.tlm to gpcaSoftware.systemStatus;
    flow configToSystemStatus from gpcaSoftware.config to gpcaSoftware.systemStatus;
    flow systemStatusToOutputBus from gpcaSoftware.systemStatus to gpcaSoftware.outputBus;
    flow infusionMgrToAlarm from gpcaSoftware.infusionMgr to gpcaSoftware.alarm;
    flow tlmToAlarm from gpcaSoftware.tlm to gpcaSoftware.alarm;
    flow systemMonitorToAlarm from gpcaSoftware.systemMonitor to gpcaSoftware.alarm;
    flow systemStatusToAlarm from gpcaSoftware.systemStatus to gpcaSoftware.alarm;
    flow configToAlarm from gpcaSoftware.config to gpcaSoftware.alarm;
    flow alarmToOutputBus from gpcaSoftware.alarm to gpcaSoftware.outputBus;
    flow tlmToConfig from gpcaSoftware.tlm to gpcaSoftware.config;
    flow systemStatusToConfig from gpcaSoftware.systemStatus to gpcaSoftware.config;
    flow configToOutputBus from gpcaSoftware.config to gpcaSoftware.outputBus;
    flow tlmToInfusionMgr from gpcaSoftware.tlm to gpcaSoftware.infusionMgr;
    flow configToInfusionMgr from gpcaSoftware.config to gpcaSoftware.infusionMgr;
    flow alarmToInfusionMgr from gpcaSoftware.alarm to gpcaSoftware.infusionMgr;
    flow systemStatusToInfusionMgr from gpcaSoftware.systemStatus to gpcaSoftware.infusionMgr;
    flow infusionMgrToOutputBus from gpcaSoftware.infusionMgr to gpcaSoftware.outputBus;
    flow tlmToSystemMonitor from gpcaSoftware.tlm to gpcaSoftware.systemMonitor;
    flow systemMonitorToOutputBus from gpcaSoftware.systemMonitor to gpcaSoftware.outputBus;
    flow tlmToLogging from gpcaSoftware.tlm to gpcaSoftware.logging;
    flow configToLogging from gpcaSoftware.config to gpcaSoftware.logging;
    flow alarmToLogging from gpcaSoftware.alarm to gpcaSoftware.logging;
    flow systemStatusToLogging from gpcaSoftware.systemStatus to gpcaSoftware.logging;
    flow infusionMgrToLogging from gpcaSoftware.infusionMgr to gpcaSoftware.logging;
    flow loggingToOutputBus from gpcaSoftware.logging to gpcaSoftware.outputBus;

    // ── GPCA_SW boundary features (AADL GPCA_SW.aadl; CITE-002) ──
    // The seven top-level ports are features of GPCA_Software, so
    // interconnection views pin them on the software boundary. Each software
    // module owns the AADL features it declares, natively: the ports are
    // nested in the module's own body in gpca_architecture.sysml, not wired
    // here with a separate relationship.

    // ── GPCA_Device.Impl connections (GPCA_Device.aadl, 1:1) ──
    bind gpcaDevice.devOpCmdIn = gpcaDevice.gpcaDeviceSensors.snsOpCmdIn;
    bind gpcaDevice.devDbIn = gpcaDevice.gpcaDeviceSensors.snsDbIn;
    bind gpcaDevice.devPresIn = gpcaDevice.gpcaDeviceSensors.snsPresIn;
    bind gpcaDevice.devPatientIn = gpcaDevice.gpcaDeviceSensors.snsPatientIn;
    flow snsOpCmdOutToPortOpCmdIn from gpcaDevice.gpcaDeviceSensors.snsOpCmdOut to gpcaSoftware.portOpCmdIn;
    flow snsPresOutToPortPresIn from gpcaDevice.gpcaDeviceSensors.snsPresOut to gpcaSoftware.portPresIn;
    flow snsPatientOutToPortPatientIn from gpcaDevice.gpcaDeviceSensors.snsPatientOut to gpcaSoftware.portPatientIn;
    flow snsSensorOutToPortSensorIn from gpcaDevice.gpcaDeviceSensors.snsSensorOut to gpcaSoftware.portSensorIn;
    flow snsConstOutToPortConstIn from gpcaDevice.gpcaDeviceSensors.snsConstOut to gpcaSoftware.portConstIn;
    flow snsDbOutToPortDbIn from gpcaDevice.gpcaDeviceSensors.snsDbOut to gpcaSoftware.portDbIn;
    flow portGpcaSwOutToActGpcaSwIn from gpcaSoftware.portGpcaSwOut to gpcaDevice.gpcaActuators.actGpcaSwIn;
    bind gpcaDevice.gpcaActuators.actGpcaOut = gpcaDevice.devGpcaOut;

    // ── Risk chains (ISO 14971, GIIP causal-tree structure) ─────
    // Categorized causes converge on each hazard (GIIP Tables 2-9
    // pattern); hazard -> sequence -> hazardous situation -> harm.
    // HZ-001 opioid over-infusion
    // ISO 14971 5.2, 5.3 and 7.4: a foreseeable misuse leads to a hazardous situation, a safety-related
    // characteristic bears on a hazard, and the benefit is weighed against the residual risk that needs it.
    connection : Causes connect bolusByProxyMisuse to hsExcessInfusion {
        attribute :>> causeKind = CauseKind::useErrorLeadsToHazard;
    }
    connection : ImpactsSafety connect programmedDoseCharacteristic to overdoseHazard;
    connection : WeighedAgainst connect analgesiaBenefit to riskAfterWrongDose;
    connection : TracesRisk connect causeFlowRateTooHigh to overdoseHazard;
    connection : TracesRisk connect causeFrequentBolus to overdoseHazard;
    connection : TracesRisk connect causeBolusVolumeTooHigh to overdoseHazard;
    connection : TracesRisk connect causePumpCalibration to overdoseHazard;
    connection : TracesRisk connect overdoseHazard to seqFrequentBolus;
    connection : TracesRisk connect seqFrequentBolus to hsExcessInfusion;
    connection : TracesRisk connect hsExcessInfusion to harmRespiratoryDepression;
    connection : EstimatedFor connect riskBefore to harmRespiratoryDepression;
    connection : AssessedAgainst connect riskBefore to riskMatrix;
    connection : Mitigates connect lockoutControl to overdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect drugLibraryControl to overdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect watchdogControl to overdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect flowCrossCheckControl to overdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect riskAfter to lockoutControl;
    connection : AssessedAgainst connect riskAfter to riskMatrix;
    connection : EvaluatedIn connect riskAfter to residualEval;
    // HZ-002 under-infusion
    connection : TracesRisk connect causeOcclusion to underdoseHazard;
    connection : TracesRisk connect causeReservoirEmpty to underdoseHazard;
    connection : TracesRisk connect causeAirInLine to underdoseHazard;
    connection : TracesRisk connect causePumpMechanismFails to underdoseHazard;
    connection : TracesRisk connect causeFlowRateTooLow to underdoseHazard;
    connection : TracesRisk connect underdoseHazard to seqOcclusion;
    connection : TracesRisk connect seqOcclusion to hsInterruptedTherapy;
    connection : TracesRisk connect hsInterruptedTherapy to harmUntreatedPain;
    connection : EstimatedFor connect riskBeforeUnderdose to harmUntreatedPain;
    connection : AssessedAgainst connect riskBeforeUnderdose to riskMatrix;
    connection : Mitigates connect occlusionAlarmControl to underdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect reservoirMonitorControl to underdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect flowCrossCheckControl to underdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect riskAfterUnderdose to occlusionAlarmControl;
    connection : AssessedAgainst connect riskAfterUnderdose to riskMatrix;
    connection : EvaluatedIn connect riskAfterUnderdose to residualEval;
    // HZ-003 air embolism (shares the air-in-line and empty-reservoir causes)
    connection : TracesRisk connect causeAirInLine to airEmbolismHazard;
    connection : TracesRisk connect causeReservoirEmpty to airEmbolismHazard;
    connection : TracesRisk connect causeImproperPriming to airEmbolismHazard;
    connection : TracesRisk connect causeTubingLeak to airEmbolismHazard;
    connection : TracesRisk connect causeAirSensorSilent to airEmbolismHazard;
    connection : TracesRisk connect airEmbolismHazard to seqAirInLine;
    connection : TracesRisk connect seqAirInLine to hsAirTowardPatient;
    connection : TracesRisk connect hsAirTowardPatient to harmAirEmbolism;
    connection : EstimatedFor connect riskBeforeAir to harmAirEmbolism;
    connection : AssessedAgainst connect riskBeforeAir to riskMatrix;
    connection : Mitigates connect airDetectionControl to airEmbolismHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect riskAfterAir to airDetectionControl;
    connection : AssessedAgainst connect riskAfterAir to riskMatrix;
    connection : EvaluatedIn connect riskAfterAir to residualEval;
    // HZ-004 misprogramming / wrong drug
    connection : TracesRisk connect causeWrongPrescriptionEntered to wrongDoseHazard;
    connection : TracesRisk connect causeWrongDoseUnits to wrongDoseHazard;
    connection : TracesRisk connect causeWrongDrugLoaded to wrongDoseHazard;
    connection : TracesRisk connect causeSettingsChangedInadvertently to wrongDoseHazard;
    connection : TracesRisk connect causePumpRevertsToDefaults to wrongDoseHazard;
    connection : TracesRisk connect wrongDoseHazard to seqMisprogram;
    connection : TracesRisk connect seqMisprogram to hsWrongTherapy;
    connection : TracesRisk connect hsWrongTherapy to harmRespiratoryDepression;
    connection : EstimatedFor connect riskBeforeWrongDose to hsWrongTherapy;
    connection : AssessedAgainst connect riskBeforeWrongDose to riskMatrix;
    connection : Mitigates connect drugLibraryControl to wrongDoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect riskAfterWrongDose to drugLibraryControl;
    connection : AssessedAgainst connect riskAfterWrongDose to riskMatrix;
    connection : EvaluatedIn connect riskAfterWrongDose to residualEval;
    // HZ-005 free flow
    connection : TracesRisk connect causeSetDisengaged to freeFlowHazard;
    connection : TracesRisk connect causeDoorOpenedDuringInfusion to freeFlowHazard;
    connection : TracesRisk connect freeFlowHazard to seqFreeFlow;
    connection : TracesRisk connect seqFreeFlow to hsFreeFlow;
    connection : TracesRisk connect hsFreeFlow to harmRespiratoryDepression;
    connection : EstimatedFor connect riskBeforeFreeFlow to hsFreeFlow;
    connection : AssessedAgainst connect riskBeforeFreeFlow to riskMatrix;
    connection : Mitigates connect freeFlowValveControl to freeFlowHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect doorInterlockControl to freeFlowHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect riskAfterFreeFlow to freeFlowValveControl;
    connection : AssessedAgainst connect riskAfterFreeFlow to riskMatrix;
    connection : EvaluatedIn connect riskAfterFreeFlow to residualEval;
    // HZ-006 reverse delivery (CriSys REQ 22; GIP HID 1.14)
    connection : TracesRisk connect causeBleedBack to reverseDeliveryHazard;
    connection : TracesRisk connect reverseDeliveryHazard to seqReverseDelivery;
    connection : TracesRisk connect seqReverseDelivery to hsReverseFlow;
    connection : TracesRisk connect hsReverseFlow to harmUntreatedPain;
    connection : EstimatedFor connect riskBeforeReverse to harmUntreatedPain;
    connection : AssessedAgainst connect riskBeforeReverse to riskMatrix;
    connection : Mitigates connect reverseDeliveryPauseControl to reverseDeliveryHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect antiRefluxDesignControl to reverseDeliveryHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect riskAfterReverse to reverseDeliveryPauseControl;
    connection : AssessedAgainst connect riskAfterReverse to riskMatrix;
    connection : EvaluatedIn connect riskAfterReverse to residualEval;
    // HZ-007 VTBI over-infusion (CriSys REQ 20/28; GIP use hazard 8.1)
    connection : TracesRisk connect causeVtbiTooHigh to vtbiOverInfusionHazard;
    connection : TracesRisk connect causeStaleDrugLibrary to vtbiOverInfusionHazard;
    connection : TracesRisk connect vtbiOverInfusionHazard to seqVtbiExceeded;
    connection : TracesRisk connect seqVtbiExceeded to hsVtbiExceeded;
    connection : TracesRisk connect hsVtbiExceeded to harmRespiratoryDepression;
    connection : EstimatedFor connect riskBeforeVtbi to harmRespiratoryDepression;
    connection : AssessedAgainst connect riskBeforeVtbi to riskMatrix;
    connection : Mitigates connect vtbiLimitPauseControl to vtbiOverInfusionHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect infusionCompleteControl to vtbiOverInfusionHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect drugLibraryControl to vtbiOverInfusionHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect riskAfterVtbi to vtbiLimitPauseControl;
    connection : AssessedAgainst connect riskAfterVtbi to riskMatrix;
    connection : EvaluatedIn connect riskAfterVtbi to residualEval;
    // Use errors feeding the risk chains (IEC 62366-1 §5.3)
    connection : Causes connect ueMisprogrammedRate to seqMisprogram { attribute :>> causeKind = CauseKind::useErrorLeadsToHazard; }
    connection : Causes connect ueWrongDrugLoaded to seqMisprogram { attribute :>> causeKind = CauseKind::useErrorLeadsToHazard; }
    connection : Causes connect ueBolusByProxy to causeFrequentBolus { attribute :>> causeKind = CauseKind::useErrorLeadsToHazard; }
    connection : Causes connect ueAlarmDisregard to seqOcclusion { attribute :>> causeKind = CauseKind::useErrorLeadsToHazard; }

    // ── FMEA and fault tree integration ─────────────────────────
    dependency from pumpMotorAssembly to fmeaDelivery;
    connection : HasFailureMode connect pumpMotorAssembly to fmMotorRunaway;
    connection : HasFailureMode connect airInLineSensor to fmAirSensorSilent;
    connection : HasFailureMode connect occlusionSensor to fmOcclusionDrift;
    connection : HasFailureMode connect bolusButton to fmStuckBolusButton;
    connection : HasFailureMode connect batteryPack to fmBatteryEarlyDepletion;
    connection : Causes connect fmMotorRunaway to feOverdose { attribute :>> causeKind = CauseKind::failureCausesEffect; }
    connection : Causes connect fmStuckBolusButton to feOverdose { attribute :>> causeKind = CauseKind::failureCausesEffect; }
    connection : Causes connect fmAirSensorSilent to feAirDelivered { attribute :>> causeKind = CauseKind::failureCausesEffect; }
    connection : Causes connect fmOcclusionDrift to feTherapyInterrupted { attribute :>> causeKind = CauseKind::failureCausesEffect; }
    connection : Causes connect fcMotorDriverFault to fmMotorRunaway { attribute :>> causeKind = CauseKind::failureCausedBy; }
    connection : Causes connect fcTransducerAging to fmAirSensorSilent { attribute :>> causeKind = CauseKind::failureCausedBy; }
    connection : Causes connect fcPendantAbuse to fmStuckBolusButton { attribute :>> causeKind = CauseKind::failureCausedBy; }
    connection : DetectedBy connect fmMotorRunaway to dmFlowCrossCheck;
    connection : DetectedBy connect fmAirSensorSilent to dmPostSensorCheck;
    connection : DetectedBy connect fmStuckBolusButton to dmStuckInputMonitor;
    connection : Mitigates connect fmeaActionAirSensor to fmAirSensorSilent { attribute :>> mitigationKind = MitigationKind::fmeaAction; }
    connection : Causes connect fmMotorRunaway to overdoseHazard { attribute :>> causeKind = CauseKind::contributesToHazard; }
    connection : Causes connect fmStuckBolusButton to overdoseHazard { attribute :>> causeKind = CauseKind::contributesToHazard; }
    connection : Causes connect fmAirSensorSilent to airEmbolismHazard { attribute :>> causeKind = CauseKind::contributesToHazard; }
    connection : Causes connect fmOcclusionDrift to underdoseHazard { attribute :>> causeKind = CauseKind::contributesToHazard; }
    connection : Mitigates connect flowCrossCheckControl to fmMotorRunaway { attribute :>> mitigationKind = MitigationKind::failureMode; }
    connection : Mitigates connect lockoutControl to fmStuckBolusButton { attribute :>> mitigationKind = MitigationKind::failureMode; }
    connection : InputToGate connect fteMotorRunaway to ftgMotorAnd;
    connection : InputToGate connect fteCrossCheckFails to ftgMotorAnd;
    connection : InputToGate connect fteLockoutFault to ftgBolusAnd;
    connection : InputToGate connect fteStuckButtonUndetected to ftgBolusAnd;
    connection : InputToGate connect ftgMotorAnd to ftgOverdoseOr;
    connection : InputToGate connect ftgBolusAnd to ftgOverdoseOr;
    connection : ProducesEvent connect ftgOverdoseOr to fteOverdoseTop;
    connection : Causes connect fteOverdoseTop to overdoseHazard { attribute :>> causeKind = CauseKind::leadsToHazard; }
    connection : Causes connect pumpMotorAssembly to fteMotorRunaway { attribute :>> causeKind = CauseKind::originatesFrom; }
    connection : Causes connect bolusButton to fteStuckButtonUndetected { attribute :>> causeKind = CauseKind::originatesFrom; }
    connection : ContainsEvent connect mcsMotorPath to fteMotorRunaway;
    connection : ContainsEvent connect mcsMotorPath to fteCrossCheckFails;
    connection : ContainsEvent connect mcsBolusPath to fteLockoutFault;
    connection : ContainsEvent connect mcsBolusPath to fteStuckButtonUndetected;
    connection : Mitigates connect flowCrossCheckControl to mcsMotorPath { attribute :>> mitigationKind = MitigationKind::cutSet; }
    connection : Mitigates connect lockoutControl to mcsBolusPath { attribute :>> mitigationKind = MitigationKind::cutSet; }

    // ── Verification coverage (IEC 62304 §5.7) ──────────────────























    // risk controls













    // behavior properties, contracts, and timing









    // class-C software items








    // ── Validation and usability testing ────────────────────────
    connection : Validates connect reqCs59 to valSimulatedWard;
    connection : Validates connect reqCs09 to valSummativeUsability;
    connection : Validates connect reqCs73 to valSummativeUsability;
    connection : TestedByUsability connect ueMisprogrammedRate to valSummativeUsability;
    connection : TestedByUsability connect ueBolusByProxy to valSummativeUsability;
    connection : TestedByUsability connect ueWrongDrugLoaded to valSummativeUsability;
    connection : TestedByUsability connect ueAlarmDisregard to valSummativeUsability;
    connection : TestedByUsability connect oaProgram to valSummativeUsability;
    // VAL-002's acceptance criteria name UE-001..UE-004, and each of those is
    // committed during one task (CommitsUseError, gpca_context). Only the
    // programming task was linked; the other three are the same evaluation.
    connection : TestedByUsability connect oaRequestBolus to valSummativeUsability;
    connection : TestedByUsability connect oaLoadReservoir to valSummativeUsability;
    connection : TestedByUsability connect oaRespondAlarm to valSummativeUsability;

    // ── Evidence production and document inclusion ──────────────
    connection : ProducesEvidence connect vcLockout to evidenceLockout;
    connection : ProducesEvidence connect vcModeRange to evidenceModeRange;
    connection : ProducesEvidence connect vcSameStepAlarm to evidenceSameStepAlarm;
    connection : ProducesEvidence connect vcTemporalModeSafety to evidenceTemporalModeSafety;
    connection : ProducesEvidence connect vcAirInLine to evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect vcOcclusion to evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect vcEmptyReservoir to evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect vcWatchdog to evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect vcPost to evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect vcPowerLoss to evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect vcStuckButton to evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect vcFlowCrossCheck to evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect vcReverseDeliveryPause to evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect vcVtbiCeiling to evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect vcInfusionComplete to evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect vcDoorInterlock to evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect vcAntiRefluxMechanism to evidenceHardwareBench;
    connection : ProducesEvidence connect vcAlarmLoudness to evidenceHardwareBench;
    connection : ProducesEvidence connect vcFreeFlow to evidenceHardwareBench;
    connection : ProducesEvidence connect vcHourlyMax to evidenceDoseProgramming;
    connection : ProducesEvidence connect vcDrugLibrary to evidenceDoseProgramming;
    connection : ProducesEvidence connect vcPrescriptionConfirm to evidenceDoseProgramming;
    connection : ProducesEvidence connect vcEventLog to evidenceDoseProgramming;
    connection : ProducesEvidence connect vcPumpAccuracy to evidenceDeliveryAccuracy;
    connection : ProducesEvidence connect valSummativeUsability to evidenceUsability;
}
