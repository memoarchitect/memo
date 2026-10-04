package memo_examples_gpca_pump_gpca_trace {
    private import ScalarValues::*;
    private import ModelingMetadata::*;

    private import memo_core_relationships::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_context_use_context::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_structure::*;
    private import memo_architecture_functional_functions::*;
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
    private import memo_examples_gpca_pump_viewpoints_logical_views_document_architecture_description_view::*;
    private import memo_examples_gpca_pump_viewpoints_cybersecurity_views_document_cyber_assessment_view::*;
    private import memo_examples_gpca_pump_viewpoints_requirements_views_document_dhf_index_view::*;
    private import memo_examples_gpca_pump_viewpoints_risk_views_document_hazard_analysis_view::*;
    private import memo_examples_gpca_pump_viewpoints_risk_views_document_rmf_view::*;
    private import memo_examples_gpca_pump_viewpoints_software_views_document_sdd_view::*;
    private import memo_examples_gpca_pump_viewpoints_cybersecurity_views_document_threat_model_view::*;
    private import memo_examples_gpca_pump_viewpoints_usability_views_document_usability_view::*;
    private import memo_examples_gpca_pump_viewpoints_verification_views_document_vv_view::*;
    private import memo_examples_gpca_pump_gpca_formal_behavior::*;
    private import memo_architecture_operational_context_stakeholders::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_architecture_operational_workflows::*;
    private import memo_architecture_realization_deployment::*;
    private import memo_core_enumerations::DeploymentKind;
    private import memo_core_common::MemoIdentity;
    private import memo_assurance_human_factors::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_safety_risk_analysis::*;
    private import memo_viewpoints_definitions::*;

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
    connection connect source ::> entityDrugReservoir to target ::> entityGpcaPump;
    connection connect source ::> entityGpcaPump to target ::> entityNeedle;
    connection connect source ::> entityNeedle to target ::> actorPatient;
    connection connect source ::> entityPowerInfrastructure to target ::> entityGpcaPump;
    // Intended use and use context anchoring (no floating context nodes)
    connection : Governs connect governor ::> gpcaIntendedUse to governedElement ::> entityGpcaPump { attribute :>> governKind = GovernKind::'use'; }
    connection : AppliesInContext connect useContext ::> hospitalWardContext to subjectElement ::> entityGpcaPump;
    connection : AppliesInContext connect useContext ::> hospitalWardContext to subjectElement ::> entityHospital;

    // Actor participation (use case view): native `actor`, nested in
    // ucDeliverPcaTherapy's own body in gpca_operational.sysml (R10-S6).

    // ── Operational thread (therapy lifecycle) ──────────────────
    first oaPrescribe then oaLoadReservoir;
    first oaLoadReservoir then oaProgram;
    first oaProgram then oaStartTherapy;
    first oaStartTherapy then oaRequestBolus;
    connection : DerivesFrom connect sourceDriver ::> oaProgram to targetRequirement ::> reqDrugLibraryLimits;
    connection : DerivesFrom connect sourceDriver ::> oaRequestBolus to targetRequirement ::> reqCs25;
    connection : DerivesFrom connect sourceDriver ::> oaRespondAlarm to targetRequirement ::> reqCs59;

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
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqPost;
    connection : DerivesFrom connect sourceDriver ::> needEffectiveAnalgesia to targetRequirement ::> reqPumpAccuracy;
    connection : DerivesFrom connect sourceDriver ::> needEffectiveAnalgesia to targetRequirement ::> reqBatteryBackup;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqAlarmLoudness;
    connection : DerivesFrom connect sourceDriver ::> needAuditableRecord to targetRequirement ::> reqEventLogging;
    // --8<-- [end:derives]
    connection : DerivesFrom connect sourceDriver ::> overdoseHazard to targetRequirement ::> reqCs25;
    connection : DerivesFrom connect sourceDriver ::> underdoseHazard to targetRequirement ::> reqOcclusion;
    connection : DerivesFrom connect sourceDriver ::> airEmbolismHazard to targetRequirement ::> reqCs21;
    connection : DerivesFrom connect sourceDriver ::> wrongDoseHazard to targetRequirement ::> reqDrugLibraryLimits;
    connection : DerivesFrom connect sourceDriver ::> freeFlowHazard to targetRequirement ::> reqFreeFlowPrevention;
    connection : DerivesFrom connect sourceDriver ::> reverseDeliveryHazard to targetRequirement ::> reqCs22;
    connection : DerivesFrom connect sourceDriver ::> vtbiOverInfusionHazard to targetRequirement ::> reqCs20;
    connection : DerivesFrom connect sourceDriver ::> vtbiOverInfusionHazard to targetRequirement ::> reqCs28;
    connection : DerivesFrom connect sourceDriver ::> riskBeforeReverse to targetRequirement ::> reqCs22;
    connection : DerivesFrom connect sourceDriver ::> riskBeforeVtbi to targetRequirement ::> reqCs20;
    connection : DerivesFrom connect sourceDriver ::> riskBefore to targetRequirement ::> reqCs25;
    connection : DerivesFrom connect sourceDriver ::> riskBefore to targetRequirement ::> reqCs19;
    connection : DerivesFrom connect sourceDriver ::> riskBefore to targetRequirement ::> reqMaxHourlyDose;
    connection : DerivesFrom connect sourceDriver ::> riskBefore to targetRequirement ::> reqStuckButton;
    connection : DerivesFrom connect sourceDriver ::> riskBefore to targetRequirement ::> reqWatchdogSafeState;
    connection : DerivesFrom connect sourceDriver ::> riskBefore to targetRequirement ::> reqFlowCrossCheck;
    connection : DerivesFrom connect sourceDriver ::> riskBeforeAir to targetRequirement ::> reqCs21;
    connection : DerivesFrom connect sourceDriver ::> riskBeforeUnderdose to targetRequirement ::> reqOcclusion;
    connection : DerivesFrom connect sourceDriver ::> riskBeforeUnderdose to targetRequirement ::> reqCs23;
    connection : DerivesFrom connect sourceDriver ::> riskBeforeUnderdose to targetRequirement ::> reqPowerLossRetention;
    connection : DerivesFrom connect sourceDriver ::> riskBeforeWrongDose to targetRequirement ::> reqDrugLibraryLimits;
    connection : DerivesFrom connect sourceDriver ::> riskBeforeWrongDose to targetRequirement ::> reqCs09;
    connection : DerivesFrom connect sourceDriver ::> riskBeforeFreeFlow to targetRequirement ::> reqFreeFlowPrevention;
    connection : DerivesFrom connect sourceDriver ::> riskBeforeFreeFlow to targetRequirement ::> reqDoorOpen;
    // CriSys source requirements (REQ-CS) trace to the stakeholder
    // needs they serve. §4.1 GPCA system + OFF/ON/IDLE modes.
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs01;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs02;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs03;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs04;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs05;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs06;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs07;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs08;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs10;
    connection : DerivesFrom connect sourceDriver ::> needAuditableRecord to targetRequirement ::> reqCs11;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs12;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs13;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs14;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs15;
    // §4.1 THERAPY/ACTIVE/BASAL/bolus/PAUSED modes.
    connection : DerivesFrom connect sourceDriver ::> needEffectiveAnalgesia to targetRequirement ::> reqCs16;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs17;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs18;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs20;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs22;
    connection : DerivesFrom connect sourceDriver ::> needEffectiveAnalgesia to targetRequirement ::> reqCs24;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs26;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs27;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs28;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs29;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs30;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs31;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs32;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs33;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs34;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs35;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs36;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs37;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs38;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs39;
    connection : DerivesFrom connect sourceDriver ::> needEffectiveAnalgesia to targetRequirement ::> reqCs40;
    connection : DerivesFrom connect sourceDriver ::> needEffectiveAnalgesia to targetRequirement ::> reqCs41;
    connection : DerivesFrom connect sourceDriver ::> needEffectiveAnalgesia to targetRequirement ::> reqCs42;
    connection : DerivesFrom connect sourceDriver ::> needEffectiveAnalgesia to targetRequirement ::> reqCs43;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs44;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs45;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs46;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs47;
    // §4.2 data configuration.
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs48;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs49;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs50;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs51;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs52;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs53;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs54;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs55;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs56;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs57;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs58;
    // §4.3 notification, §4.4 logs, §4.5 security, Ch.5 non-behavioral.
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs59;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs60;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs61;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs62;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs63;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs64;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs65;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs66;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs67;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs68;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs69;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs70;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs71;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs72;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs73;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs74;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs75;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqCs76;
    connection : DerivesFrom connect sourceDriver ::> needAuditableRecord to targetRequirement ::> reqCs77;
    connection : DerivesFrom connect sourceDriver ::> needAuditableRecord to targetRequirement ::> reqCs78;
    connection : DerivesFrom connect sourceDriver ::> needAuditableRecord to targetRequirement ::> reqCs79;
    connection : DerivesFrom connect sourceDriver ::> needAuditableRecord to targetRequirement ::> reqCs80;
    connection : DerivesFrom connect sourceDriver ::> needAuditableRecord to targetRequirement ::> reqCs81;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs82;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs83;
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqCs84;
    connection : DerivesFrom connect sourceDriver ::> needAuditableRecord to targetRequirement ::> reqCs85;
    connection : DerivesFrom connect sourceDriver ::> needAuditableRecord to targetRequirement ::> reqCs86;

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
    // This edge used to deploy the software system onto the circuit board,
    // which DeploysTo's ends reject — a system is not a deployment unit and a
    // board is not a processing node (mainController, hosted by the board).
    // --8<-- [start:deployment]
    part gpcaFirmwareImage : SoftwareDeploymentUnit {
        @MemoIdentity { :>> providedId = "DU-001"; :>> label = "GPCAFirmwareImage"; }
        attribute :>> unitKind = "firmware image";
        attribute :>> version = "2.0";
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
    connection : BindsToInterface connect portElement ::> portPatientPendant to boundInterface ::> bolusButtonLine;
    connection : BindsToInterface connect portElement ::> portMotorDrive to boundInterface ::> pumpMotorDrive;
    connection : BindsToInterface connect portElement ::> portSensorHarness to boundInterface ::> occlusionAnalogLine;
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
    connection : TracesRisk connect sourceRiskElement ::> causeFlowRateTooHigh to targetRiskElement ::> overdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeFrequentBolus to targetRiskElement ::> overdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeBolusVolumeTooHigh to targetRiskElement ::> overdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causePumpCalibration to targetRiskElement ::> overdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> overdoseHazard to targetRiskElement ::> seqFrequentBolus;
    connection : TracesRisk connect sourceRiskElement ::> seqFrequentBolus to targetRiskElement ::> hsExcessInfusion;
    connection : TracesRisk connect sourceRiskElement ::> hsExcessInfusion to targetRiskElement ::> harmRespiratoryDepression;
    connection : EstimatedFor connect risk ::> riskBefore to riskElement ::> harmRespiratoryDepression;
    connection : AssessedAgainst connect risk ::> riskBefore to riskMatrix ::> riskMatrix;
    connection : Mitigates connect control ::> lockoutControl to mitigatedElement ::> overdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect control ::> drugLibraryControl to mitigatedElement ::> overdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect control ::> watchdogControl to mitigatedElement ::> overdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect control ::> flowCrossCheckControl to mitigatedElement ::> overdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect residualRisk ::> riskAfter to control ::> lockoutControl;
    connection : AssessedAgainst connect risk ::> riskAfter to riskMatrix ::> riskMatrix;
    connection : EvaluatedIn connect residualRisk ::> riskAfter to evaluation ::> residualEval;
    // HZ-002 under-infusion
    connection : TracesRisk connect sourceRiskElement ::> causeOcclusion to targetRiskElement ::> underdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeReservoirEmpty to targetRiskElement ::> underdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeAirInLine to targetRiskElement ::> underdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causePumpMechanismFails to targetRiskElement ::> underdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeFlowRateTooLow to targetRiskElement ::> underdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> underdoseHazard to targetRiskElement ::> seqOcclusion;
    connection : TracesRisk connect sourceRiskElement ::> seqOcclusion to targetRiskElement ::> hsInterruptedTherapy;
    connection : TracesRisk connect sourceRiskElement ::> hsInterruptedTherapy to targetRiskElement ::> harmUntreatedPain;
    connection : EstimatedFor connect risk ::> riskBeforeUnderdose to riskElement ::> harmUntreatedPain;
    connection : AssessedAgainst connect risk ::> riskBeforeUnderdose to riskMatrix ::> riskMatrix;
    connection : Mitigates connect control ::> occlusionAlarmControl to mitigatedElement ::> underdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect control ::> reservoirMonitorControl to mitigatedElement ::> underdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect control ::> flowCrossCheckControl to mitigatedElement ::> underdoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect residualRisk ::> riskAfterUnderdose to control ::> occlusionAlarmControl;
    connection : AssessedAgainst connect risk ::> riskAfterUnderdose to riskMatrix ::> riskMatrix;
    connection : EvaluatedIn connect residualRisk ::> riskAfterUnderdose to evaluation ::> residualEval;
    // HZ-003 air embolism (shares the air-in-line and empty-reservoir causes)
    connection : TracesRisk connect sourceRiskElement ::> causeAirInLine to targetRiskElement ::> airEmbolismHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeReservoirEmpty to targetRiskElement ::> airEmbolismHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeImproperPriming to targetRiskElement ::> airEmbolismHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeTubingLeak to targetRiskElement ::> airEmbolismHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeAirSensorSilent to targetRiskElement ::> airEmbolismHazard;
    connection : TracesRisk connect sourceRiskElement ::> airEmbolismHazard to targetRiskElement ::> seqAirInLine;
    connection : TracesRisk connect sourceRiskElement ::> seqAirInLine to targetRiskElement ::> hsAirTowardPatient;
    connection : TracesRisk connect sourceRiskElement ::> hsAirTowardPatient to targetRiskElement ::> harmAirEmbolism;
    connection : EstimatedFor connect risk ::> riskBeforeAir to riskElement ::> harmAirEmbolism;
    connection : AssessedAgainst connect risk ::> riskBeforeAir to riskMatrix ::> riskMatrix;
    connection : Mitigates connect control ::> airDetectionControl to mitigatedElement ::> airEmbolismHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect residualRisk ::> riskAfterAir to control ::> airDetectionControl;
    connection : AssessedAgainst connect risk ::> riskAfterAir to riskMatrix ::> riskMatrix;
    connection : EvaluatedIn connect residualRisk ::> riskAfterAir to evaluation ::> residualEval;
    // HZ-004 misprogramming / wrong drug
    connection : TracesRisk connect sourceRiskElement ::> causeWrongPrescriptionEntered to targetRiskElement ::> wrongDoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeWrongDoseUnits to targetRiskElement ::> wrongDoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeWrongDrugLoaded to targetRiskElement ::> wrongDoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeSettingsChangedInadvertently to targetRiskElement ::> wrongDoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causePumpRevertsToDefaults to targetRiskElement ::> wrongDoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> wrongDoseHazard to targetRiskElement ::> seqMisprogram;
    connection : TracesRisk connect sourceRiskElement ::> seqMisprogram to targetRiskElement ::> hsWrongTherapy;
    connection : TracesRisk connect sourceRiskElement ::> hsWrongTherapy to targetRiskElement ::> harmRespiratoryDepression;
    connection : EstimatedFor connect risk ::> riskBeforeWrongDose to riskElement ::> hsWrongTherapy;
    connection : AssessedAgainst connect risk ::> riskBeforeWrongDose to riskMatrix ::> riskMatrix;
    connection : Mitigates connect control ::> drugLibraryControl to mitigatedElement ::> wrongDoseHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect residualRisk ::> riskAfterWrongDose to control ::> drugLibraryControl;
    connection : AssessedAgainst connect risk ::> riskAfterWrongDose to riskMatrix ::> riskMatrix;
    connection : EvaluatedIn connect residualRisk ::> riskAfterWrongDose to evaluation ::> residualEval;
    // HZ-005 free flow
    connection : TracesRisk connect sourceRiskElement ::> causeSetDisengaged to targetRiskElement ::> freeFlowHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeDoorOpenedDuringInfusion to targetRiskElement ::> freeFlowHazard;
    connection : TracesRisk connect sourceRiskElement ::> freeFlowHazard to targetRiskElement ::> seqFreeFlow;
    connection : TracesRisk connect sourceRiskElement ::> seqFreeFlow to targetRiskElement ::> hsFreeFlow;
    connection : TracesRisk connect sourceRiskElement ::> hsFreeFlow to targetRiskElement ::> harmRespiratoryDepression;
    connection : EstimatedFor connect risk ::> riskBeforeFreeFlow to riskElement ::> hsFreeFlow;
    connection : AssessedAgainst connect risk ::> riskBeforeFreeFlow to riskMatrix ::> riskMatrix;
    connection : Mitigates connect control ::> freeFlowValveControl to mitigatedElement ::> freeFlowHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect control ::> doorInterlockControl to mitigatedElement ::> freeFlowHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect residualRisk ::> riskAfterFreeFlow to control ::> freeFlowValveControl;
    connection : AssessedAgainst connect risk ::> riskAfterFreeFlow to riskMatrix ::> riskMatrix;
    connection : EvaluatedIn connect residualRisk ::> riskAfterFreeFlow to evaluation ::> residualEval;
    // HZ-006 reverse delivery (CriSys REQ 22; GIP HID 1.14)
    connection : TracesRisk connect sourceRiskElement ::> causeBleedBack to targetRiskElement ::> reverseDeliveryHazard;
    connection : TracesRisk connect sourceRiskElement ::> reverseDeliveryHazard to targetRiskElement ::> seqReverseDelivery;
    connection : TracesRisk connect sourceRiskElement ::> seqReverseDelivery to targetRiskElement ::> hsReverseFlow;
    connection : TracesRisk connect sourceRiskElement ::> hsReverseFlow to targetRiskElement ::> harmUntreatedPain;
    connection : EstimatedFor connect risk ::> riskBeforeReverse to riskElement ::> harmUntreatedPain;
    connection : AssessedAgainst connect risk ::> riskBeforeReverse to riskMatrix ::> riskMatrix;
    connection : Mitigates connect control ::> reverseDeliveryPauseControl to mitigatedElement ::> reverseDeliveryHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect control ::> antiRefluxDesignControl to mitigatedElement ::> reverseDeliveryHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect residualRisk ::> riskAfterReverse to control ::> reverseDeliveryPauseControl;
    connection : AssessedAgainst connect risk ::> riskAfterReverse to riskMatrix ::> riskMatrix;
    connection : EvaluatedIn connect residualRisk ::> riskAfterReverse to evaluation ::> residualEval;
    // HZ-007 VTBI over-infusion (CriSys REQ 20/28; GIP use hazard 8.1)
    connection : TracesRisk connect sourceRiskElement ::> causeVtbiTooHigh to targetRiskElement ::> vtbiOverInfusionHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeStaleDrugLibrary to targetRiskElement ::> vtbiOverInfusionHazard;
    connection : TracesRisk connect sourceRiskElement ::> vtbiOverInfusionHazard to targetRiskElement ::> seqVtbiExceeded;
    connection : TracesRisk connect sourceRiskElement ::> seqVtbiExceeded to targetRiskElement ::> hsVtbiExceeded;
    connection : TracesRisk connect sourceRiskElement ::> hsVtbiExceeded to targetRiskElement ::> harmRespiratoryDepression;
    connection : EstimatedFor connect risk ::> riskBeforeVtbi to riskElement ::> harmRespiratoryDepression;
    connection : AssessedAgainst connect risk ::> riskBeforeVtbi to riskMatrix ::> riskMatrix;
    connection : Mitigates connect control ::> vtbiLimitPauseControl to mitigatedElement ::> vtbiOverInfusionHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect control ::> infusionCompleteControl to mitigatedElement ::> vtbiOverInfusionHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : Mitigates connect control ::> drugLibraryControl to mitigatedElement ::> vtbiOverInfusionHazard { attribute :>> mitigationKind = MitigationKind::hazard; }
    connection : ReducedBy connect residualRisk ::> riskAfterVtbi to control ::> vtbiLimitPauseControl;
    connection : AssessedAgainst connect risk ::> riskAfterVtbi to riskMatrix ::> riskMatrix;
    connection : EvaluatedIn connect residualRisk ::> riskAfterVtbi to evaluation ::> residualEval;
    // Use errors feeding the risk chains (IEC 62366-1 §5.3)
    connection : Causes connect cause ::> ueMisprogrammedRate to effect ::> seqMisprogram { attribute :>> causeKind = CauseKind::useErrorLeadsToHazard; }
    connection : Causes connect cause ::> ueWrongDrugLoaded to effect ::> seqMisprogram { attribute :>> causeKind = CauseKind::useErrorLeadsToHazard; }
    connection : Causes connect cause ::> ueBolusByProxy to effect ::> causeFrequentBolus { attribute :>> causeKind = CauseKind::useErrorLeadsToHazard; }
    connection : Causes connect cause ::> ueAlarmDisregard to effect ::> seqOcclusion { attribute :>> causeKind = CauseKind::useErrorLeadsToHazard; }

    // ── FMEA and fault tree integration ─────────────────────────
    // Was `AnalyzedBy`: a zero-attribute edge from an element to the
    // artifact analysing it, which is what a bare dependency states.
    dependency from pumpMotorAssembly to fmeaDelivery;
    connection : HasFailureMode connect element ::> pumpMotorAssembly to failureMode ::> fmMotorRunaway;
    connection : HasFailureMode connect element ::> airInLineSensor to failureMode ::> fmAirSensorSilent;
    connection : HasFailureMode connect element ::> occlusionSensor to failureMode ::> fmOcclusionDrift;
    connection : HasFailureMode connect element ::> bolusButton to failureMode ::> fmStuckBolusButton;
    connection : HasFailureMode connect element ::> batteryPack to failureMode ::> fmBatteryEarlyDepletion;
    connection : Causes connect cause ::> fmMotorRunaway to effect ::> feOverdose { attribute :>> causeKind = CauseKind::failureCausesEffect; }
    connection : Causes connect cause ::> fmStuckBolusButton to effect ::> feOverdose { attribute :>> causeKind = CauseKind::failureCausesEffect; }
    connection : Causes connect cause ::> fmAirSensorSilent to effect ::> feAirDelivered { attribute :>> causeKind = CauseKind::failureCausesEffect; }
    connection : Causes connect cause ::> fmOcclusionDrift to effect ::> feTherapyInterrupted { attribute :>> causeKind = CauseKind::failureCausesEffect; }
    connection : Causes connect cause ::> fcMotorDriverFault to effect ::> fmMotorRunaway { attribute :>> causeKind = CauseKind::failureCausedBy; }
    connection : Causes connect cause ::> fcTransducerAging to effect ::> fmAirSensorSilent { attribute :>> causeKind = CauseKind::failureCausedBy; }
    connection : Causes connect cause ::> fcPendantAbuse to effect ::> fmStuckBolusButton { attribute :>> causeKind = CauseKind::failureCausedBy; }
    connection : DetectedBy connect failureMode ::> fmMotorRunaway to detectionMethod ::> dmFlowCrossCheck;
    connection : DetectedBy connect failureMode ::> fmAirSensorSilent to detectionMethod ::> dmPostSensorCheck;
    connection : DetectedBy connect failureMode ::> fmStuckBolusButton to detectionMethod ::> dmStuckInputMonitor;
    connection : Mitigates connect control ::> fmeaActionAirSensor to mitigatedElement ::> fmAirSensorSilent { attribute :>> mitigationKind = MitigationKind::fmeaAction; }
    connection : Causes connect cause ::> fmMotorRunaway to effect ::> overdoseHazard { attribute :>> causeKind = CauseKind::contributesToHazard; }
    connection : Causes connect cause ::> fmStuckBolusButton to effect ::> overdoseHazard { attribute :>> causeKind = CauseKind::contributesToHazard; }
    connection : Causes connect cause ::> fmAirSensorSilent to effect ::> airEmbolismHazard { attribute :>> causeKind = CauseKind::contributesToHazard; }
    connection : Causes connect cause ::> fmOcclusionDrift to effect ::> underdoseHazard { attribute :>> causeKind = CauseKind::contributesToHazard; }
    connection : Mitigates connect control ::> flowCrossCheckControl to mitigatedElement ::> fmMotorRunaway { attribute :>> mitigationKind = MitigationKind::failureMode; }
    connection : Mitigates connect control ::> lockoutControl to mitigatedElement ::> fmStuckBolusButton { attribute :>> mitigationKind = MitigationKind::failureMode; }
    connection : InputToGate connect input ::> fteMotorRunaway to gate ::> ftgMotorAnd;
    connection : InputToGate connect input ::> fteCrossCheckFails to gate ::> ftgMotorAnd;
    connection : InputToGate connect input ::> fteLockoutFault to gate ::> ftgBolusAnd;
    connection : InputToGate connect input ::> fteStuckButtonUndetected to gate ::> ftgBolusAnd;
    connection : InputToGate connect input ::> ftgMotorAnd to gate ::> ftgOverdoseOr;
    connection : InputToGate connect input ::> ftgBolusAnd to gate ::> ftgOverdoseOr;
    connection : ProducesEvent connect gate ::> ftgOverdoseOr to eventElement ::> fteOverdoseTop;
    connection : Causes connect cause ::> fteOverdoseTop to effect ::> overdoseHazard { attribute :>> causeKind = CauseKind::leadsToHazard; }
    connection : Causes connect cause ::> pumpMotorAssembly to effect ::> fteMotorRunaway { attribute :>> causeKind = CauseKind::originatesFrom; }
    connection : Causes connect cause ::> bolusButton to effect ::> fteStuckButtonUndetected { attribute :>> causeKind = CauseKind::originatesFrom; }
    connection : ContainsEvent connect cutSet ::> mcsMotorPath to eventElement ::> fteMotorRunaway;
    connection : ContainsEvent connect cutSet ::> mcsMotorPath to eventElement ::> fteCrossCheckFails;
    connection : ContainsEvent connect cutSet ::> mcsBolusPath to eventElement ::> fteLockoutFault;
    connection : ContainsEvent connect cutSet ::> mcsBolusPath to eventElement ::> fteStuckButtonUndetected;
    connection : Mitigates connect control ::> flowCrossCheckControl to mitigatedElement ::> mcsMotorPath { attribute :>> mitigationKind = MitigationKind::cutSet; }
    connection : Mitigates connect control ::> lockoutControl to mitigatedElement ::> mcsBolusPath { attribute :>> mitigationKind = MitigationKind::cutSet; }

    // ── Verification coverage (IEC 62304 §5.7) ──────────────────























    // risk controls













    // behavior properties, contracts, and timing









    // class-C software items








    // ── Validation and usability testing ────────────────────────
    connection : Validates connect validationTarget ::> reqCs59 to validationCase ::> valSimulatedWard;
    connection : Validates connect validationTarget ::> reqCs09 to validationCase ::> valSummativeUsability;
    connection : Validates connect validationTarget ::> reqCs73 to validationCase ::> valSummativeUsability;
    connection : TestedByUsability connect uiElementOrTask ::> ueMisprogrammedRate to usabilityTest ::> valSummativeUsability;
    connection : TestedByUsability connect uiElementOrTask ::> ueBolusByProxy to usabilityTest ::> valSummativeUsability;
    connection : TestedByUsability connect uiElementOrTask ::> ueWrongDrugLoaded to usabilityTest ::> valSummativeUsability;
    connection : TestedByUsability connect uiElementOrTask ::> ueAlarmDisregard to usabilityTest ::> valSummativeUsability;
    connection : TestedByUsability connect uiElementOrTask ::> oaProgram to usabilityTest ::> valSummativeUsability;
    // VAL-002's acceptance criteria name UE-001..UE-004, and each of those is
    // committed during one task (CommitsUseError, gpca_context). Only the
    // programming task was linked; the other three are the same evaluation.
    connection : TestedByUsability connect uiElementOrTask ::> oaRequestBolus to usabilityTest ::> valSummativeUsability;
    connection : TestedByUsability connect uiElementOrTask ::> oaLoadReservoir to usabilityTest ::> valSummativeUsability;
    connection : TestedByUsability connect uiElementOrTask ::> oaRespondAlarm to usabilityTest ::> valSummativeUsability;

    // ── Evidence production and document inclusion ──────────────
    connection : ProducesEvidence connect producer ::> vcLockout to producedEvidence ::> evidenceLockout;
    connection : ProducesEvidence connect producer ::> vcModeRange to producedEvidence ::> evidenceModeRange;
    connection : ProducesEvidence connect producer ::> vcSameStepAlarm to producedEvidence ::> evidenceSameStepAlarm;
    connection : ProducesEvidence connect producer ::> vcTemporalModeSafety to producedEvidence ::> evidenceTemporalModeSafety;
    connection : ProducesEvidence connect producer ::> vcAirInLine to producedEvidence ::> evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect producer ::> vcOcclusion to producedEvidence ::> evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect producer ::> vcEmptyReservoir to producedEvidence ::> evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect producer ::> vcWatchdog to producedEvidence ::> evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect producer ::> vcPost to producedEvidence ::> evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect producer ::> vcPowerLoss to producedEvidence ::> evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect producer ::> vcStuckButton to producedEvidence ::> evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect producer ::> vcFlowCrossCheck to producedEvidence ::> evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect producer ::> vcReverseDeliveryPause to producedEvidence ::> evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect producer ::> vcVtbiCeiling to producedEvidence ::> evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect producer ::> vcInfusionComplete to producedEvidence ::> evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect producer ::> vcDoorInterlock to producedEvidence ::> evidenceSafetyAlarmSuite;
    connection : ProducesEvidence connect producer ::> vcAntiRefluxMechanism to producedEvidence ::> evidenceHardwareBench;
    connection : ProducesEvidence connect producer ::> vcAlarmLoudness to producedEvidence ::> evidenceHardwareBench;
    connection : ProducesEvidence connect producer ::> vcFreeFlow to producedEvidence ::> evidenceHardwareBench;
    connection : ProducesEvidence connect producer ::> vcHourlyMax to producedEvidence ::> evidenceDoseProgramming;
    connection : ProducesEvidence connect producer ::> vcDrugLibrary to producedEvidence ::> evidenceDoseProgramming;
    connection : ProducesEvidence connect producer ::> vcPrescriptionConfirm to producedEvidence ::> evidenceDoseProgramming;
    connection : ProducesEvidence connect producer ::> vcEventLog to producedEvidence ::> evidenceDoseProgramming;
    connection : ProducesEvidence connect producer ::> vcPumpAccuracy to producedEvidence ::> evidenceDeliveryAccuracy;
    connection : ProducesEvidence connect producer ::> valSummativeUsability to producedEvidence ::> evidenceUsability;
}
