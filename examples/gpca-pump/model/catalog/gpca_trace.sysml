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
    private import memo_assurance_human_factors::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_safety_risk_analysis::*;
    private import memo_viewpoints_definitions::*;

    // ── System context interactions (context view) ──────────────
    connection : InteractsWith connect contextParticipant ::> actorPatient to target ::> entityGpcaPump;
    connection : InteractsWith connect contextParticipant ::> actorNurse to target ::> entityGpcaPump;
    connection : InteractsWith connect contextParticipant ::> actorPrescriber to target ::> entityGpcaPump;
    connection : InteractsWith connect contextParticipant ::> actorPharmacist to target ::> entityGpcaPump;
    connection : InteractsWith connect contextParticipant ::> actorTechnician to target ::> entityGpcaPump;
    connection : InteractsWith connect contextParticipant ::> actorPharmacist to target ::> entityPharmacy;

    // ── Fig 2.1 context flows (CriSys §2.1) ─────────────────────
    // Data flows
    flow from entityPrescription to actorNurse;
    flow from actorNurse to entityGpcaPump;
    flow from entityGpcaPump to actorNurse;
    flow from actorPatient to entityGpcaPump;
    flow from entityPharmacyDb to entityGpcaPump;
    // Physical connections (drug path)
    connection : ConnectsPhysically connect source ::> entityDrugReservoir to target ::> entityGpcaPump;
    connection : ConnectsPhysically connect source ::> entityGpcaPump to target ::> entityNeedle;
    connection : ConnectsPhysically connect source ::> entityNeedle to target ::> actorPatient;
    connection : ConnectsPhysically connect source ::> entityPowerInfrastructure to target ::> entityGpcaPump;
    // Intended use and use context anchoring (no floating context nodes)
    connection : Governs { attribute :>> governKind = GovernKind::'use'; connect governor ::> gpcaIntendedUse to governedElement ::> entityGpcaPump; }
    connection : AppliesInContext connect useContext ::> hospitalWardContext to subjectElement ::> entityGpcaPump;
    connection : AppliesInContext connect useContext ::> hospitalWardContext to subjectElement ::> entityHospital;

    // Actor participation (use case view): native `actor`, nested in
    // ucDeliverPcaTherapy's own body in gpca_operational.sysml (R10-S6).

    // ── Operational thread (therapy lifecycle) ──────────────────
    connection : Precedes connect predecessor ::> oaPrescribe to successor ::> oaLoadReservoir;
    connection : Precedes connect predecessor ::> oaLoadReservoir to successor ::> oaProgram;
    connection : Precedes connect predecessor ::> oaProgram to successor ::> oaStartTherapy;
    connection : Precedes connect predecessor ::> oaStartTherapy to successor ::> oaRequestBolus;
    connection : Supports { attribute :>> supportKind = SupportKind::capability; connect supporter ::> oaStartTherapy to supported ::> ocTitratedAnalgesia; }
    connection : Supports { attribute :>> supportKind = SupportKind::capability; connect supporter ::> oaRequestBolus to supported ::> ocTitratedAnalgesia; }
    connection : Supports { attribute :>> supportKind = SupportKind::capability; connect supporter ::> oaRespondAlarm to supported ::> ocFailSafeTherapy; }
    connection : DerivesFrom connect sourceDriver ::> oaProgram to targetRequirement ::> reqDrugLibraryLimits;
    connection : DerivesFrom connect sourceDriver ::> oaRequestBolus to targetRequirement ::> reqCs25;
    connection : DerivesFrom connect sourceDriver ::> oaRespondAlarm to targetRequirement ::> reqCs59;

    // ── Functional chains ───────────────────────────────────────
    connection : InvolvesFunction connect functionalChain ::> fcPatientBolus to function ::> fnAcquireSensors;
    connection : InvolvesFunction connect functionalChain ::> fcPatientBolus to function ::> fnEnforceLimits;
    connection : InvolvesFunction connect functionalChain ::> fcPatientBolus to function ::> fnManageInfusion;
    connection : InvolvesFunction connect functionalChain ::> fcPatientBolus to function ::> fnCommandPump;
    connection : InvolvesFunction connect functionalChain ::> fcPatientBolus to function ::> fnLogEvents;
    connection : InvolvesFunction connect functionalChain ::> fcAlarmStop to function ::> fnAcquireSensors;
    connection : InvolvesFunction connect functionalChain ::> fcAlarmStop to function ::> fnMonitorAlarm;
    connection : InvolvesFunction connect functionalChain ::> fcAlarmStop to function ::> fnManageInfusion;
    connection : InvolvesFunction connect functionalChain ::> fcAlarmStop to function ::> fnAnnunciate;
    connection : InvolvesFunction connect functionalChain ::> fcStartup to function ::> fnSelfTest;
    connection : InvolvesFunction connect functionalChain ::> fcStartup to function ::> fnPresentStatus;
    #refinement dependency fcPatientBolus to ssBolusDuringBasal;
    #refinement dependency fcAlarmStop to ssAlarmPause;

    // A user task may be realized by several system-side steps: the mapping is
    // refinement, not specialization, because the steps retain distinct
    // functions and exchanged items while tracing the same operative intent.
    #refinement dependency fcsBolusSense to wsRequestBolus;
    #refinement dependency fcsBolusValidate to wsRequestBolus;
    #refinement dependency fcsBolusCommand to wsRequestBolus;
    #refinement dependency fcsBolusActuate to wsRequestBolus;
    #refinement dependency fcsBolusLog to wsRequestBolus;
    #refinement dependency fcsAlarmSense to wsRespondAlarm;
    #refinement dependency fcsAlarmEvaluate to wsRespondAlarm;
    #refinement dependency fcsAlarmStopInfusion to wsRespondAlarm;
    #refinement dependency fcsAlarmAnnunciate to wsRespondAlarm;

    // ── Requirement derivation ──────────────────────────────────
    // MEMO extension requirements (REQ-X) derive from needs and risks.
    connection : DerivesFrom connect sourceDriver ::> needSafeTherapy to targetRequirement ::> reqPost;
    connection : DerivesFrom connect sourceDriver ::> needEffectiveAnalgesia to targetRequirement ::> reqPumpAccuracy;
    connection : DerivesFrom connect sourceDriver ::> needEffectiveAnalgesia to targetRequirement ::> reqBatteryBackup;
    connection : DerivesFrom connect sourceDriver ::> needTimelyAlarms to targetRequirement ::> reqAlarmLoudness;
    connection : DerivesFrom connect sourceDriver ::> needAuditableRecord to targetRequirement ::> reqEventLogging;
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
    allocate fnAcquireSensors to gpcaDeviceSensors;
    allocate fnAcquireSensors to systemStatus;
    allocate fnPresentStatus to outputBus;
    allocate fnValidatePrescription to config;
    allocate fnMonitorAlarm to alarm;
    allocate fnAnnunciate to audibleAlarm;
    allocate fnManageInfusion to infusionMgr;
    allocate fnEnforceLimits to infusionMgr;
    allocate fnCommandPump to pumpMotorAssembly;
    allocate fnLogEvents to logging;
    allocate fnManagePower to systemMonitor;
    allocate fnPresentStatus to operatorDisplay;
    allocate fnSelfTest to systemMonitor;
    // ── Deployment, hosting, and interface realization ──────────
    allocation gpcaSoftwareDeployment : DeploysTo allocate gpcaSoftware to controllerBoard;
    connection : HostedBy connect processingNode ::> mainController to hostAssembly ::> controllerBoard;
    #refinement dependency sensorInputInterface to hwSoftwareBus;
    #refinement dependency actuatorCommandInterface to pumpMotorDrive;
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
    flow from tlm to outputBus;
    flow from infusionMgr to systemStatus;
    flow from tlm to systemStatus;
    flow from config to systemStatus;
    flow from systemStatus to outputBus;
    flow from infusionMgr to alarm;
    flow from tlm to alarm;
    flow from systemMonitor to alarm;
    flow from systemStatus to alarm;
    flow from config to alarm;
    flow from alarm to outputBus;
    flow from tlm to config;
    flow from systemStatus to config;
    flow from config to outputBus;
    flow from tlm to infusionMgr;
    flow from config to infusionMgr;
    flow from alarm to infusionMgr;
    flow from systemStatus to infusionMgr;
    flow from infusionMgr to outputBus;
    flow from tlm to systemMonitor;
    flow from systemMonitor to outputBus;
    flow from tlm to logging;
    flow from config to logging;
    flow from alarm to logging;
    flow from systemStatus to logging;
    flow from infusionMgr to logging;
    flow from logging to outputBus;

    // ── GPCA_SW boundary features (AADL GPCA_SW.aadl; CITE-002) ──
    // The seven top-level ports are features of GPCA_Software, so
    // interconnection views pin them on the software boundary.
    connection : Composes connect parent ::> gpcaSoftware to child ::> portOpCmdIn;
    connection : Composes connect parent ::> gpcaSoftware to child ::> portPresIn;
    connection : Composes connect parent ::> gpcaSoftware to child ::> portPatientIn;
    connection : Composes connect parent ::> gpcaSoftware to child ::> portSensorIn;
    connection : Composes connect parent ::> gpcaSoftware to child ::> portConstIn;
    connection : Composes connect parent ::> gpcaSoftware to child ::> portDbIn;
    connection : Composes connect parent ::> gpcaSoftware to child ::> portGpcaSwOut;

    // Each software module owns the AADL features it declares — same shape as
    // the gpcaSoftware -> top-level-port composition above.
    connection : Composes connect parent ::> alarm to child ::> portAlarmAlarmOut;
    connection : Composes connect parent ::> alarm to child ::> portAlarmConfigIn;
    connection : Composes connect parent ::> alarm to child ::> portAlarmConstIn;
    connection : Composes connect parent ::> alarm to child ::> portAlarmDbIn;
    connection : Composes connect parent ::> alarm to child ::> portAlarmImIn;
    connection : Composes connect parent ::> alarm to child ::> portAlarmOpCmdIn;
    connection : Composes connect parent ::> alarm to child ::> portAlarmSensorIn;
    connection : Composes connect parent ::> alarm to child ::> portAlarmSysMonIn;
    connection : Composes connect parent ::> alarm to child ::> portAlarmSysStatIn;
    connection : Composes connect parent ::> alarm to child ::> portAlarmTlmModeIn;
    connection : Composes connect parent ::> config to child ::> portConfigConfigOut;
    connection : Composes connect parent ::> config to child ::> portConfigConstIn;
    connection : Composes connect parent ::> config to child ::> portConfigDbIn;
    connection : Composes connect parent ::> config to child ::> portConfigOpCmdIn;
    connection : Composes connect parent ::> config to child ::> portConfigPresIn;
    connection : Composes connect parent ::> config to child ::> portConfigSysStatIn;
    connection : Composes connect parent ::> config to child ::> portConfigTlmModeIn;
    connection : Composes connect parent ::> infusionMgr to child ::> portImAlarmIn;
    connection : Composes connect parent ::> infusionMgr to child ::> portImConfigIn;
    connection : Composes connect parent ::> infusionMgr to child ::> portImImOut;
    connection : Composes connect parent ::> infusionMgr to child ::> portImOpCmdIn;
    connection : Composes connect parent ::> infusionMgr to child ::> portImPatientIn;
    connection : Composes connect parent ::> infusionMgr to child ::> portImSysStatIn;
    connection : Composes connect parent ::> infusionMgr to child ::> portImTlmModeIn;
    connection : Composes connect parent ::> logging to child ::> portLogAlarmIn;
    connection : Composes connect parent ::> logging to child ::> portLogConfigIn;
    connection : Composes connect parent ::> logging to child ::> portLogImIn;
    connection : Composes connect parent ::> logging to child ::> portLogLogOut;
    connection : Composes connect parent ::> logging to child ::> portLogSysStatIn;
    connection : Composes connect parent ::> logging to child ::> portLogTlmModeIn;
    connection : Composes connect parent ::> systemMonitor to child ::> portSysMonSysMonOut;
    connection : Composes connect parent ::> systemMonitor to child ::> portSysMonTlmModeIn;
    connection : Composes connect parent ::> outputBus to child ::> portOutputAlarmIn;
    connection : Composes connect parent ::> outputBus to child ::> portOutputConfigIn;
    connection : Composes connect parent ::> outputBus to child ::> portOutputGpcaSwOut;
    connection : Composes connect parent ::> outputBus to child ::> portOutputImIn;
    connection : Composes connect parent ::> outputBus to child ::> portOutputLogIn;
    connection : Composes connect parent ::> outputBus to child ::> portOutputSysMonIn;
    connection : Composes connect parent ::> outputBus to child ::> portOutputSysStatIn;
    connection : Composes connect parent ::> outputBus to child ::> portOutputTlmModeIn;
    connection : Composes connect parent ::> systemStatus to child ::> portSysStatConfigIn;
    connection : Composes connect parent ::> systemStatus to child ::> portSysStatConstIn;
    connection : Composes connect parent ::> systemStatus to child ::> portSysStatImIn;
    connection : Composes connect parent ::> systemStatus to child ::> portSysStatSensorIn;
    connection : Composes connect parent ::> systemStatus to child ::> portSysStatSysStatOut;
    connection : Composes connect parent ::> systemStatus to child ::> portSysStatTlmModeIn;
    connection : Composes connect parent ::> tlm to child ::> portTlmConstIn;
    connection : Composes connect parent ::> tlm to child ::> portTlmOpCmdIn;
    connection : Composes connect parent ::> tlm to child ::> portTlmTlmModeOut;

    // ── Device/subsystem feature ownership (published AADL, 1:1) ──
    connection : Composes connect parent ::> gpcaDevice to child ::> devOpCmdIn;
    connection : Composes connect parent ::> gpcaDevice to child ::> devDbIn;
    connection : Composes connect parent ::> gpcaDevice to child ::> devPresIn;
    connection : Composes connect parent ::> gpcaDevice to child ::> devPatientIn;
    connection : Composes connect parent ::> gpcaDevice to child ::> devGpcaOut;
    connection : Composes connect parent ::> gpcaDeviceSensors to child ::> snsOpCmdIn;
    connection : Composes connect parent ::> gpcaDeviceSensors to child ::> snsDbIn;
    connection : Composes connect parent ::> gpcaDeviceSensors to child ::> snsPresIn;
    connection : Composes connect parent ::> gpcaDeviceSensors to child ::> snsPatientIn;
    connection : Composes connect parent ::> gpcaDeviceSensors to child ::> snsOpCmdOut;
    connection : Composes connect parent ::> gpcaDeviceSensors to child ::> snsPresOut;
    connection : Composes connect parent ::> gpcaDeviceSensors to child ::> snsPatientOut;
    connection : Composes connect parent ::> gpcaDeviceSensors to child ::> snsSensorOut;
    connection : Composes connect parent ::> gpcaDeviceSensors to child ::> snsConstOut;
    connection : Composes connect parent ::> gpcaDeviceSensors to child ::> snsDbOut;
    connection : Composes connect parent ::> gpcaActuators to child ::> actGpcaSwIn;
    connection : Composes connect parent ::> gpcaActuators to child ::> actGpcaOut;

    // ── GPCA_Device.Impl connections (GPCA_Device.aadl, 1:1) ──
    bind devOpCmdIn = snsOpCmdIn;
    bind devDbIn = snsDbIn;
    bind devPresIn = snsPresIn;
    bind devPatientIn = snsPatientIn;
    flow from snsOpCmdOut to portOpCmdIn;
    flow from snsPresOut to portPresIn;
    flow from snsPatientOut to portPatientIn;
    flow from snsSensorOut to portSensorIn;
    flow from snsConstOut to portConstIn;
    flow from snsDbOut to portDbIn;
    flow from portGpcaSwOut to actGpcaSwIn;
    bind actGpcaOut = devGpcaOut;

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
    connection : TracesRisk connect sourceRiskElement ::> harmRespiratoryDepression to targetRiskElement ::> riskBefore;
    connection : AssessedAgainst connect risk ::> riskBefore to riskMatrix ::> riskMatrix;
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> lockoutControl to mitigatedElement ::> overdoseHazard; }
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> drugLibraryControl to mitigatedElement ::> overdoseHazard; }
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> watchdogControl to mitigatedElement ::> overdoseHazard; }
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> flowCrossCheckControl to mitigatedElement ::> overdoseHazard; }
    connection : TracesRisk connect sourceRiskElement ::> lockoutControl to targetRiskElement ::> riskAfter;
    connection : AssessedAgainst connect risk ::> riskAfter to riskMatrix ::> riskMatrix;
    connection : TracesRisk connect sourceRiskElement ::> residualEval to targetRiskElement ::> riskAfter;
    // HZ-002 under-infusion
    connection : TracesRisk connect sourceRiskElement ::> causeOcclusion to targetRiskElement ::> underdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeReservoirEmpty to targetRiskElement ::> underdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeAirInLine to targetRiskElement ::> underdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causePumpMechanismFails to targetRiskElement ::> underdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeFlowRateTooLow to targetRiskElement ::> underdoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> underdoseHazard to targetRiskElement ::> seqOcclusion;
    connection : TracesRisk connect sourceRiskElement ::> seqOcclusion to targetRiskElement ::> hsInterruptedTherapy;
    connection : TracesRisk connect sourceRiskElement ::> hsInterruptedTherapy to targetRiskElement ::> harmUntreatedPain;
    connection : TracesRisk connect sourceRiskElement ::> harmUntreatedPain to targetRiskElement ::> riskBeforeUnderdose;
    connection : AssessedAgainst connect risk ::> riskBeforeUnderdose to riskMatrix ::> riskMatrix;
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> occlusionAlarmControl to mitigatedElement ::> underdoseHazard; }
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> reservoirMonitorControl to mitigatedElement ::> underdoseHazard; }
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> flowCrossCheckControl to mitigatedElement ::> underdoseHazard; }
    connection : TracesRisk connect sourceRiskElement ::> occlusionAlarmControl to targetRiskElement ::> riskAfterUnderdose;
    connection : AssessedAgainst connect risk ::> riskAfterUnderdose to riskMatrix ::> riskMatrix;
    connection : TracesRisk connect sourceRiskElement ::> residualEval to targetRiskElement ::> riskAfterUnderdose;
    // HZ-003 air embolism (shares the air-in-line and empty-reservoir causes)
    connection : TracesRisk connect sourceRiskElement ::> causeAirInLine to targetRiskElement ::> airEmbolismHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeReservoirEmpty to targetRiskElement ::> airEmbolismHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeImproperPriming to targetRiskElement ::> airEmbolismHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeTubingLeak to targetRiskElement ::> airEmbolismHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeAirSensorSilent to targetRiskElement ::> airEmbolismHazard;
    connection : TracesRisk connect sourceRiskElement ::> airEmbolismHazard to targetRiskElement ::> seqAirInLine;
    connection : TracesRisk connect sourceRiskElement ::> seqAirInLine to targetRiskElement ::> hsAirTowardPatient;
    connection : TracesRisk connect sourceRiskElement ::> hsAirTowardPatient to targetRiskElement ::> harmAirEmbolism;
    connection : TracesRisk connect sourceRiskElement ::> harmAirEmbolism to targetRiskElement ::> riskBeforeAir;
    connection : AssessedAgainst connect risk ::> riskBeforeAir to riskMatrix ::> riskMatrix;
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> airDetectionControl to mitigatedElement ::> airEmbolismHazard; }
    connection : TracesRisk connect sourceRiskElement ::> airDetectionControl to targetRiskElement ::> riskAfterAir;
    connection : AssessedAgainst connect risk ::> riskAfterAir to riskMatrix ::> riskMatrix;
    connection : TracesRisk connect sourceRiskElement ::> residualEval to targetRiskElement ::> riskAfterAir;
    // HZ-004 misprogramming / wrong drug
    connection : TracesRisk connect sourceRiskElement ::> causeWrongPrescriptionEntered to targetRiskElement ::> wrongDoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeWrongDoseUnits to targetRiskElement ::> wrongDoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeWrongDrugLoaded to targetRiskElement ::> wrongDoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeSettingsChangedInadvertently to targetRiskElement ::> wrongDoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> causePumpRevertsToDefaults to targetRiskElement ::> wrongDoseHazard;
    connection : TracesRisk connect sourceRiskElement ::> wrongDoseHazard to targetRiskElement ::> seqMisprogram;
    connection : TracesRisk connect sourceRiskElement ::> seqMisprogram to targetRiskElement ::> hsWrongTherapy;
    connection : TracesRisk connect sourceRiskElement ::> hsWrongTherapy to targetRiskElement ::> harmRespiratoryDepression;
    connection : TracesRisk connect sourceRiskElement ::> hsWrongTherapy to targetRiskElement ::> riskBeforeWrongDose;
    connection : AssessedAgainst connect risk ::> riskBeforeWrongDose to riskMatrix ::> riskMatrix;
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> drugLibraryControl to mitigatedElement ::> wrongDoseHazard; }
    connection : TracesRisk connect sourceRiskElement ::> drugLibraryControl to targetRiskElement ::> riskAfterWrongDose;
    connection : AssessedAgainst connect risk ::> riskAfterWrongDose to riskMatrix ::> riskMatrix;
    connection : TracesRisk connect sourceRiskElement ::> residualEval to targetRiskElement ::> riskAfterWrongDose;
    // HZ-005 free flow
    connection : TracesRisk connect sourceRiskElement ::> causeSetDisengaged to targetRiskElement ::> freeFlowHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeDoorOpenedDuringInfusion to targetRiskElement ::> freeFlowHazard;
    connection : TracesRisk connect sourceRiskElement ::> freeFlowHazard to targetRiskElement ::> seqFreeFlow;
    connection : TracesRisk connect sourceRiskElement ::> seqFreeFlow to targetRiskElement ::> hsFreeFlow;
    connection : TracesRisk connect sourceRiskElement ::> hsFreeFlow to targetRiskElement ::> harmRespiratoryDepression;
    connection : TracesRisk connect sourceRiskElement ::> hsFreeFlow to targetRiskElement ::> riskBeforeFreeFlow;
    connection : AssessedAgainst connect risk ::> riskBeforeFreeFlow to riskMatrix ::> riskMatrix;
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> freeFlowValveControl to mitigatedElement ::> freeFlowHazard; }
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> doorInterlockControl to mitigatedElement ::> freeFlowHazard; }
    connection : TracesRisk connect sourceRiskElement ::> freeFlowValveControl to targetRiskElement ::> riskAfterFreeFlow;
    connection : AssessedAgainst connect risk ::> riskAfterFreeFlow to riskMatrix ::> riskMatrix;
    connection : TracesRisk connect sourceRiskElement ::> residualEval to targetRiskElement ::> riskAfterFreeFlow;
    // HZ-006 reverse delivery (CriSys REQ 22; GIP HID 1.14)
    connection : TracesRisk connect sourceRiskElement ::> causeBleedBack to targetRiskElement ::> reverseDeliveryHazard;
    connection : TracesRisk connect sourceRiskElement ::> reverseDeliveryHazard to targetRiskElement ::> seqReverseDelivery;
    connection : TracesRisk connect sourceRiskElement ::> seqReverseDelivery to targetRiskElement ::> hsReverseFlow;
    connection : TracesRisk connect sourceRiskElement ::> hsReverseFlow to targetRiskElement ::> harmUntreatedPain;
    connection : TracesRisk connect sourceRiskElement ::> harmUntreatedPain to targetRiskElement ::> riskBeforeReverse;
    connection : AssessedAgainst connect risk ::> riskBeforeReverse to riskMatrix ::> riskMatrix;
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> reverseDeliveryPauseControl to mitigatedElement ::> reverseDeliveryHazard; }
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> antiRefluxDesignControl to mitigatedElement ::> reverseDeliveryHazard; }
    connection : TracesRisk connect sourceRiskElement ::> reverseDeliveryPauseControl to targetRiskElement ::> riskAfterReverse;
    connection : AssessedAgainst connect risk ::> riskAfterReverse to riskMatrix ::> riskMatrix;
    connection : TracesRisk connect sourceRiskElement ::> residualEval to targetRiskElement ::> riskAfterReverse;
    // HZ-007 VTBI over-infusion (CriSys REQ 20/28; GIP use hazard 8.1)
    connection : TracesRisk connect sourceRiskElement ::> causeVtbiTooHigh to targetRiskElement ::> vtbiOverInfusionHazard;
    connection : TracesRisk connect sourceRiskElement ::> causeStaleDrugLibrary to targetRiskElement ::> vtbiOverInfusionHazard;
    connection : TracesRisk connect sourceRiskElement ::> vtbiOverInfusionHazard to targetRiskElement ::> seqVtbiExceeded;
    connection : TracesRisk connect sourceRiskElement ::> seqVtbiExceeded to targetRiskElement ::> hsVtbiExceeded;
    connection : TracesRisk connect sourceRiskElement ::> hsVtbiExceeded to targetRiskElement ::> harmRespiratoryDepression;
    connection : TracesRisk connect sourceRiskElement ::> harmRespiratoryDepression to targetRiskElement ::> riskBeforeVtbi;
    connection : AssessedAgainst connect risk ::> riskBeforeVtbi to riskMatrix ::> riskMatrix;
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> vtbiLimitPauseControl to mitigatedElement ::> vtbiOverInfusionHazard; }
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> infusionCompleteControl to mitigatedElement ::> vtbiOverInfusionHazard; }
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::hazard; connect control ::> drugLibraryControl to mitigatedElement ::> vtbiOverInfusionHazard; }
    connection : TracesRisk connect sourceRiskElement ::> vtbiLimitPauseControl to targetRiskElement ::> riskAfterVtbi;
    connection : AssessedAgainst connect risk ::> riskAfterVtbi to riskMatrix ::> riskMatrix;
    connection : TracesRisk connect sourceRiskElement ::> residualEval to targetRiskElement ::> riskAfterVtbi;
    // Use errors feeding the risk chains (IEC 62366-1 §5.3)
    connection : TracesRisk connect sourceRiskElement ::> ueMisprogrammedRate to targetRiskElement ::> seqMisprogram;
    connection : TracesRisk connect sourceRiskElement ::> ueWrongDrugLoaded to targetRiskElement ::> seqMisprogram;
    connection : TracesRisk connect sourceRiskElement ::> ueBolusByProxy to targetRiskElement ::> causeFrequentBolus;
    connection : TracesRisk connect sourceRiskElement ::> ueAlarmDisregard to targetRiskElement ::> seqOcclusion;

    // ── FMEA and fault tree integration ─────────────────────────
    connection : AnalyzedBy connect element ::> pumpMotorAssembly to analysisArtifact ::> fmeaDelivery;
    connection : HasFailureMode connect element ::> pumpMotorAssembly to failureMode ::> fmMotorRunaway;
    connection : HasFailureMode connect element ::> airInLineSensor to failureMode ::> fmAirSensorSilent;
    connection : HasFailureMode connect element ::> occlusionSensor to failureMode ::> fmOcclusionDrift;
    connection : HasFailureMode connect element ::> bolusButton to failureMode ::> fmStuckBolusButton;
    connection : HasFailureMode connect element ::> batteryPack to failureMode ::> fmBatteryEarlyDepletion;
    connection : Causes { attribute :>> causeKind = CauseKind::failureCausesEffect; connect cause ::> fmMotorRunaway to effect ::> feOverdose; }
    connection : Causes { attribute :>> causeKind = CauseKind::failureCausesEffect; connect cause ::> fmStuckBolusButton to effect ::> feOverdose; }
    connection : Causes { attribute :>> causeKind = CauseKind::failureCausesEffect; connect cause ::> fmAirSensorSilent to effect ::> feAirDelivered; }
    connection : Causes { attribute :>> causeKind = CauseKind::failureCausesEffect; connect cause ::> fmOcclusionDrift to effect ::> feTherapyInterrupted; }
    connection : Causes { attribute :>> causeKind = CauseKind::failureCausedBy; connect cause ::> fcMotorDriverFault to effect ::> fmMotorRunaway; }
    connection : Causes { attribute :>> causeKind = CauseKind::failureCausedBy; connect cause ::> fcTransducerAging to effect ::> fmAirSensorSilent; }
    connection : Causes { attribute :>> causeKind = CauseKind::failureCausedBy; connect cause ::> fcPendantAbuse to effect ::> fmStuckBolusButton; }
    connection : DetectedBy connect failureMode ::> fmMotorRunaway to detectionMethod ::> dmFlowCrossCheck;
    connection : DetectedBy connect failureMode ::> fmAirSensorSilent to detectionMethod ::> dmPostSensorCheck;
    connection : DetectedBy connect failureMode ::> fmStuckBolusButton to detectionMethod ::> dmStuckInputMonitor;
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::fmeaAction; connect control ::> fmeaActionAirSensor to mitigatedElement ::> fmAirSensorSilent; }
    connection : Causes { attribute :>> causeKind = CauseKind::contributesToHazard; connect cause ::> fmMotorRunaway to effect ::> overdoseHazard; }
    connection : Causes { attribute :>> causeKind = CauseKind::contributesToHazard; connect cause ::> fmStuckBolusButton to effect ::> overdoseHazard; }
    connection : Causes { attribute :>> causeKind = CauseKind::contributesToHazard; connect cause ::> fmAirSensorSilent to effect ::> airEmbolismHazard; }
    connection : Causes { attribute :>> causeKind = CauseKind::contributesToHazard; connect cause ::> fmOcclusionDrift to effect ::> underdoseHazard; }
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::failureMode; connect control ::> flowCrossCheckControl to mitigatedElement ::> fmMotorRunaway; }
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::failureMode; connect control ::> lockoutControl to mitigatedElement ::> fmStuckBolusButton; }
    connection : InputToGate connect input ::> fteMotorRunaway to gate ::> ftgMotorAnd;
    connection : InputToGate connect input ::> fteCrossCheckFails to gate ::> ftgMotorAnd;
    connection : InputToGate connect input ::> fteLockoutFault to gate ::> ftgBolusAnd;
    connection : InputToGate connect input ::> fteStuckButtonUndetected to gate ::> ftgBolusAnd;
    connection : InputToGate connect input ::> ftgMotorAnd to gate ::> ftgOverdoseOr;
    connection : InputToGate connect input ::> ftgBolusAnd to gate ::> ftgOverdoseOr;
    connection : ProducesEvent connect gate ::> ftgOverdoseOr to eventElement ::> fteOverdoseTop;
    connection : Causes { attribute :>> causeKind = CauseKind::leadsToHazard; connect cause ::> fteOverdoseTop to effect ::> overdoseHazard; }
    connection : Causes { attribute :>> causeKind = CauseKind::originatesFrom; connect cause ::> pumpMotorAssembly to effect ::> fteMotorRunaway; }
    connection : Causes { attribute :>> causeKind = CauseKind::originatesFrom; connect cause ::> bolusButton to effect ::> fteStuckButtonUndetected; }
    connection : ContainsEvent connect cutSet ::> mcsMotorPath to eventElement ::> fteMotorRunaway;
    connection : ContainsEvent connect cutSet ::> mcsMotorPath to eventElement ::> fteCrossCheckFails;
    connection : ContainsEvent connect cutSet ::> mcsBolusPath to eventElement ::> fteLockoutFault;
    connection : ContainsEvent connect cutSet ::> mcsBolusPath to eventElement ::> fteStuckButtonUndetected;
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::cutSet; connect control ::> flowCrossCheckControl to mitigatedElement ::> mcsMotorPath; }
    connection : Mitigates { attribute :>> mitigationKind = MitigationKind::cutSet; connect control ::> lockoutControl to mitigatedElement ::> mcsBolusPath; }

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
