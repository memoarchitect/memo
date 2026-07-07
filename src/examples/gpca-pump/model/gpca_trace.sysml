package memo {
    package examples {
        package gpca {
            package trace {
                private import memo::core::relationships::*;
                private import memo::architecture::context::*;
                private import memo::architecture::operational::*;
                private import memo::architecture::system::*;
                private import memo::examples::gpca::context::*;
                private import memo::examples::gpca::operational::*;
                private import memo::examples::gpca::system::*;
                private import memo::examples::gpca::requirements::*;
                private import memo::examples::gpca::architecture::*;
                private import memo::examples::gpca::physical::*;
                private import memo::examples::gpca::behavior_subsystems::*;
                private import memo::examples::gpca::behavior_modes::*;
                private import memo::examples::gpca::interfaces::*;
                private import memo::examples::gpca::risk::*;
                private import memo::examples::gpca::analysis::*;
                private import memo::examples::gpca::verification::*;
                private import memo::examples::gpca::document_views::*;
                private import memo::examples::gpca::formal_behavior::*;

                // ── System context interactions (context view) ──────────────
                connection : InteractsWith connect participant ::> actorPatient to target ::> entityGpcaPump;
                connection : InteractsWith connect participant ::> actorNurse to target ::> entityGpcaPump;
                connection : InteractsWith connect participant ::> actorPrescriber to target ::> entityGpcaPump;
                connection : InteractsWith connect participant ::> actorPharmacist to target ::> entityGpcaPump;
                connection : InteractsWith connect participant ::> actorTechnician to target ::> entityGpcaPump;
                connection : InteractsWith connect participant ::> actorPharmacist to target ::> entityPharmacy;

                // ── Fig 2.1 context flows (CriSys §2.1) ─────────────────────
                // Data flows
                connection : ExchangesWith connect source ::> entityPrescription to target ::> actorNurse;
                connection : ExchangesWith connect source ::> actorNurse to target ::> entityGpcaPump;
                connection : ExchangesWith connect source ::> entityGpcaPump to target ::> actorNurse;
                connection : ExchangesWith connect source ::> actorPatient to target ::> entityGpcaPump;
                connection : ExchangesWith connect source ::> entityPharmacyDb to target ::> entityGpcaPump;
                // Physical connections (drug path)
                connection : ConnectsPhysically connect source ::> entityDrugReservoir to target ::> entityGpcaPump;
                connection : ConnectsPhysically connect source ::> entityGpcaPump to target ::> entityNeedle;
                connection : ConnectsPhysically connect source ::> entityNeedle to target ::> actorPatient;
                connection : ConnectsPhysically connect source ::> entityPowerInfrastructure to target ::> entityGpcaPump;
                // Intended use and use context anchoring (no floating context nodes)
                connection : GovernsUse connect intendedUse ::> gpcaIntendedUse to governedElement ::> entityGpcaPump;
                connection : AppliesInContext connect useContext ::> hospitalWardContext to subject ::> entityGpcaPump;
                connection : AppliesInContext connect useContext ::> hospitalWardContext to subject ::> entityHospital;

                // ── Actor participation (use case view) ─────────────────────
                connection : InteractsWith connect participant ::> actorPrescriber to target ::> oaPrescribe;
                connection : InteractsWith connect participant ::> actorPharmacist to target ::> oaLoadReservoir;
                connection : InteractsWith connect participant ::> actorNurse to target ::> oaProgram;
                connection : InteractsWith connect participant ::> actorNurse to target ::> oaStartTherapy;
                connection : InteractsWith connect participant ::> actorNurse to target ::> oaRespondAlarm;
                connection : InteractsWith connect participant ::> actorNurse to target ::> oaReviewLog;
                connection : InteractsWith connect participant ::> actorPatient to target ::> oaRequestBolus;
                connection : InteractsWith connect participant ::> actorTechnician to target ::> oaMaintain;

                // ── Operational thread (therapy lifecycle) ──────────────────
                connection : SequencesStep connect activity ::> oaPrescribe to nextActivity ::> oaLoadReservoir;
                connection : SequencesStep connect activity ::> oaLoadReservoir to nextActivity ::> oaProgram;
                connection : SequencesStep connect activity ::> oaProgram to nextActivity ::> oaStartTherapy;
                connection : SequencesStep connect activity ::> oaStartTherapy to nextActivity ::> oaRequestBolus;
                connection : ContributesToCapability connect activity ::> oaStartTherapy to capability ::> ocTitratedAnalgesia;
                connection : ContributesToCapability connect activity ::> oaRequestBolus to capability ::> ocTitratedAnalgesia;
                connection : ContributesToCapability connect activity ::> oaRespondAlarm to capability ::> ocFailSafeTherapy;
                connection : DerivesSystemNeed connect activity ::> oaProgram to systemNeed ::> reqDrugLibraryLimits;
                connection : DerivesSystemNeed connect activity ::> oaRequestBolus to systemNeed ::> reqCs25;
                connection : DerivesSystemNeed connect activity ::> oaRespondAlarm to systemNeed ::> reqCs59;

                // ── System capabilities and functional chains ───────────────
                connection : RealizesCapability connect functionalChain ::> fcPatientBolus to capability ::> scPatientBolus;
                connection : RealizesCapability connect functionalChain ::> fcAlarmStop to capability ::> scAlarmAnnunciation;
                connection : RealizesCapability connect functionalChain ::> fcStartup to capability ::> scBasalDelivery;
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
                connection : RealizesScenario connect functionalChain ::> fcPatientBolus to scenario ::> ssBolusDuringBasal;
                connection : RealizesScenario connect functionalChain ::> fcAlarmStop to scenario ::> ssAlarmPause;

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
                connection : SatisfiedBy connect requirement ::> reqCs01 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs25 to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqCs19 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqDrugLibraryLimits to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs09 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqPowerLossRetention to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqPost to satisfyingElement ::> systemMonitor;
                connection : SatisfiedBy connect requirement ::> reqWatchdogSafeState to satisfyingElement ::> systemMonitor;
                connection : SatisfiedBy connect requirement ::> reqWatchdogSafeState to satisfyingElement ::> controllerBoard;
                connection : SatisfiedBy connect requirement ::> reqCs59 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs72 to satisfyingElement ::> audibleAlarm;
                connection : SatisfiedBy connect requirement ::> reqCs73 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs75 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs21 to satisfyingElement ::> airInLineSensor;
                connection : SatisfiedBy connect requirement ::> reqCs21 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqOcclusion to satisfyingElement ::> occlusionSensor;
                connection : SatisfiedBy connect requirement ::> reqOcclusion to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs23 to satisfyingElement ::> reservoirSensor;
                connection : SatisfiedBy connect requirement ::> reqCs23 to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqDoorOpen to satisfyingElement ::> doorSensor;
                connection : SatisfiedBy connect requirement ::> reqDoorOpen to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqMaxHourlyDose to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqStuckButton to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqFlowCrossCheck to satisfyingElement ::> flowSensor;
                connection : SatisfiedBy connect requirement ::> reqFlowCrossCheck to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs77 to satisfyingElement ::> logging;
                connection : SatisfiedBy connect requirement ::> reqCs78 to satisfyingElement ::> logging;
                connection : SatisfiedBy connect requirement ::> reqEventLogging to satisfyingElement ::> logging;
                // CriSys REQ-CS allocation to the UMN software subsystems
                // (coarse; refined against the AADL architecture in GR.04).
                // Mode control -> TLM; flow production -> Infusion_Manager;
                // notifications -> Alarm; data configuration -> Config;
                // logs -> Logging; enclosure non-behavioral -> DeviceEnclosure.
                connection : SatisfiedBy connect requirement ::> reqCs02 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs03 to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqCs04 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs05 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs06 to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqCs07 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs08 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs10 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs11 to satisfyingElement ::> logging;
                connection : SatisfiedBy connect requirement ::> reqCs12 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs13 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs14 to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqCs15 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs16 to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqCs17 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs18 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs20 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs22 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs24 to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqCs26 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs27 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs28 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs29 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs30 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs31 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs32 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs33 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs34 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs35 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs36 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs37 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs38 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs39 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs40 to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqCs41 to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqCs42 to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqCs43 to satisfyingElement ::> infusionMgr;
                connection : SatisfiedBy connect requirement ::> reqCs44 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs45 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs46 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs47 to satisfyingElement ::> tlm;
                connection : SatisfiedBy connect requirement ::> reqCs48 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs49 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs50 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs51 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs52 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs53 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs54 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs55 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs56 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs57 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs58 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs60 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs61 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs62 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs63 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs64 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs65 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs66 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs67 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs68 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs69 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs70 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs71 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs74 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs76 to satisfyingElement ::> alarm;
                connection : SatisfiedBy connect requirement ::> reqCs79 to satisfyingElement ::> logging;
                connection : SatisfiedBy connect requirement ::> reqCs80 to satisfyingElement ::> logging;
                connection : SatisfiedBy connect requirement ::> reqCs81 to satisfyingElement ::> logging;
                connection : SatisfiedBy connect requirement ::> reqCs82 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqCs83 to satisfyingElement ::> enclosure;
                connection : SatisfiedBy connect requirement ::> reqCs84 to satisfyingElement ::> enclosure;
                connection : SatisfiedBy connect requirement ::> reqCs85 to satisfyingElement ::> logging;
                connection : SatisfiedBy connect requirement ::> reqCs86 to satisfyingElement ::> config;
                connection : SatisfiedBy connect requirement ::> reqPumpAccuracy to satisfyingElement ::> pumpMotorAssembly;
                connection : SatisfiedBy connect requirement ::> reqAlarmLoudness to satisfyingElement ::> audibleAlarm;
                connection : SatisfiedBy connect requirement ::> reqBatteryBackup to satisfyingElement ::> batteryPack;
                connection : SatisfiedBy connect requirement ::> reqFreeFlowPrevention to satisfyingElement ::> antiFreeFlowValve;

                // ── Function allocation ─────────────────────────────────────
                connection : AllocatedTo connect function ::> fnAcquireSensors to allocatedElement ::> gpcaDeviceSensors;
                connection : AllocatedTo connect function ::> fnValidatePrescription to allocatedElement ::> config;
                connection : AllocatedTo connect function ::> fnMonitorAlarm to allocatedElement ::> alarm;
                connection : AllocatedTo connect function ::> fnAnnunciate to allocatedElement ::> audibleAlarm;
                connection : AllocatedTo connect function ::> fnManageInfusion to allocatedElement ::> infusionMgr;
                connection : AllocatedTo connect function ::> fnEnforceLimits to allocatedElement ::> infusionMgr;
                connection : AllocatedTo connect function ::> fnCommandPump to allocatedElement ::> pumpMotorAssembly;
                connection : AllocatedTo connect function ::> fnLogEvents to allocatedElement ::> logging;
                connection : AllocatedTo connect function ::> fnManagePower to allocatedElement ::> systemMonitor;
                connection : AllocatedTo connect function ::> fnPresentStatus to allocatedElement ::> operatorDisplay;
                connection : AllocatedTo connect function ::> fnSelfTest to allocatedElement ::> systemMonitor;

                // ── Deployment, hosting, and interface realization ──────────
                connection : DeploysOnto connect softwareComponent ::> gpcaSoftware to hostAssembly ::> controllerBoard;
                connection : HostedBy connect processingNode ::> mainController to hostAssembly ::> controllerBoard;
                connection : RealizesInterface connect logicalInterface ::> sensorInputInterface to physicalInterface ::> hwSoftwareBus;
                connection : RealizesInterface connect logicalInterface ::> actuatorCommandInterface to physicalInterface ::> pumpMotorDrive;
                connection : BindsToInterface connect port ::> portPatientPendant to boundInterface ::> bolusButtonLine;
                connection : BindsToInterface connect port ::> portMotorDrive to boundInterface ::> pumpMotorDrive;
                connection : BindsToInterface connect port ::> portSensorHarness to boundInterface ::> occlusionAnalogLine;
                connection : AllocatesExchange connect functionalFlow ::> lfSensorAcquisition to componentExchange ::> exSensorVector;
                connection : AllocatesExchange connect functionalFlow ::> lfFlowCommand to componentExchange ::> exFlowCommand;
                connection : AllocatesExchange connect functionalFlow ::> lfAlarmSignal to componentExchange ::> exAlarmAnnunciation;
                connection : AllocatesExchange connect functionalFlow ::> lfPrescriptionEntry to componentExchange ::> exPrescriptionEntry;
                connection : Precedes connect predecessor ::> tlm to successor ::> alarm;
                connection : Precedes connect predecessor ::> alarm to successor ::> infusionMgr;

                // ── Risk chains (ISO 14971) ─────────────────────────────────
                // HZ-001 overdose
                connection : TracesRisk connect sourceRiskElement ::> overdoseHazard to targetRiskElement ::> seqFrequentBolus;
                connection : TracesRisk connect sourceRiskElement ::> seqFrequentBolus to targetRiskElement ::> hsExcessInfusion;
                connection : TracesRisk connect sourceRiskElement ::> hsExcessInfusion to targetRiskElement ::> harmRespiratoryDepression;
                connection : TracesRisk connect sourceRiskElement ::> harmRespiratoryDepression to targetRiskElement ::> riskBefore;
                connection : AssessedAgainst connect risk ::> riskBefore to riskMatrix ::> riskMatrix;
                connection : MitigatesHazard connect riskControl ::> lockoutControl to mitigatedHazard ::> overdoseHazard;
                connection : MitigatesHazard connect riskControl ::> watchdogControl to mitigatedHazard ::> overdoseHazard;
                connection : MitigatesHazard connect riskControl ::> flowCrossCheckControl to mitigatedHazard ::> overdoseHazard;
                connection : TracesRisk connect sourceRiskElement ::> lockoutControl to targetRiskElement ::> riskAfter;
                connection : AssessedAgainst connect risk ::> riskAfter to riskMatrix ::> riskMatrix;
                connection : TracesRisk connect sourceRiskElement ::> residualEval to targetRiskElement ::> riskAfter;
                // HZ-002 under-infusion
                connection : TracesRisk connect sourceRiskElement ::> underdoseHazard to targetRiskElement ::> seqOcclusion;
                connection : TracesRisk connect sourceRiskElement ::> seqOcclusion to targetRiskElement ::> hsInterruptedTherapy;
                connection : TracesRisk connect sourceRiskElement ::> hsInterruptedTherapy to targetRiskElement ::> harmUntreatedPain;
                connection : TracesRisk connect sourceRiskElement ::> harmUntreatedPain to targetRiskElement ::> riskBeforeUnderdose;
                connection : AssessedAgainst connect risk ::> riskBeforeUnderdose to riskMatrix ::> riskMatrix;
                connection : MitigatesHazard connect riskControl ::> occlusionAlarmControl to mitigatedHazard ::> underdoseHazard;
                connection : MitigatesHazard connect riskControl ::> reservoirMonitorControl to mitigatedHazard ::> underdoseHazard;
                connection : TracesRisk connect sourceRiskElement ::> occlusionAlarmControl to targetRiskElement ::> riskAfterUnderdose;
                connection : AssessedAgainst connect risk ::> riskAfterUnderdose to riskMatrix ::> riskMatrix;
                connection : TracesRisk connect sourceRiskElement ::> residualEval to targetRiskElement ::> riskAfterUnderdose;
                // HZ-003 air embolism
                connection : TracesRisk connect sourceRiskElement ::> airEmbolismHazard to targetRiskElement ::> seqAirInLine;
                connection : TracesRisk connect sourceRiskElement ::> seqAirInLine to targetRiskElement ::> hsAirTowardPatient;
                connection : TracesRisk connect sourceRiskElement ::> hsAirTowardPatient to targetRiskElement ::> harmAirEmbolism;
                connection : TracesRisk connect sourceRiskElement ::> harmAirEmbolism to targetRiskElement ::> riskBeforeAir;
                connection : AssessedAgainst connect risk ::> riskBeforeAir to riskMatrix ::> riskMatrix;
                connection : MitigatesHazard connect riskControl ::> airDetectionControl to mitigatedHazard ::> airEmbolismHazard;
                connection : TracesRisk connect sourceRiskElement ::> airDetectionControl to targetRiskElement ::> riskAfterAir;
                connection : AssessedAgainst connect risk ::> riskAfterAir to riskMatrix ::> riskMatrix;
                connection : TracesRisk connect sourceRiskElement ::> residualEval to targetRiskElement ::> riskAfterAir;
                // HZ-004 misprogramming / wrong drug
                connection : TracesRisk connect sourceRiskElement ::> wrongDoseHazard to targetRiskElement ::> seqMisprogram;
                connection : TracesRisk connect sourceRiskElement ::> seqMisprogram to targetRiskElement ::> hsWrongTherapy;
                connection : TracesRisk connect sourceRiskElement ::> hsWrongTherapy to targetRiskElement ::> harmRespiratoryDepression;
                connection : TracesRisk connect sourceRiskElement ::> hsWrongTherapy to targetRiskElement ::> riskBeforeWrongDose;
                connection : AssessedAgainst connect risk ::> riskBeforeWrongDose to riskMatrix ::> riskMatrix;
                connection : MitigatesHazard connect riskControl ::> drugLibraryControl to mitigatedHazard ::> wrongDoseHazard;
                connection : TracesRisk connect sourceRiskElement ::> drugLibraryControl to targetRiskElement ::> riskAfterWrongDose;
                connection : AssessedAgainst connect risk ::> riskAfterWrongDose to riskMatrix ::> riskMatrix;
                connection : TracesRisk connect sourceRiskElement ::> residualEval to targetRiskElement ::> riskAfterWrongDose;
                // HZ-005 free flow
                connection : TracesRisk connect sourceRiskElement ::> freeFlowHazard to targetRiskElement ::> seqFreeFlow;
                connection : TracesRisk connect sourceRiskElement ::> seqFreeFlow to targetRiskElement ::> hsFreeFlow;
                connection : TracesRisk connect sourceRiskElement ::> hsFreeFlow to targetRiskElement ::> harmRespiratoryDepression;
                connection : TracesRisk connect sourceRiskElement ::> hsFreeFlow to targetRiskElement ::> riskBeforeFreeFlow;
                connection : AssessedAgainst connect risk ::> riskBeforeFreeFlow to riskMatrix ::> riskMatrix;
                connection : MitigatesHazard connect riskControl ::> freeFlowValveControl to mitigatedHazard ::> freeFlowHazard;
                connection : TracesRisk connect sourceRiskElement ::> freeFlowValveControl to targetRiskElement ::> riskAfterFreeFlow;
                connection : AssessedAgainst connect risk ::> riskAfterFreeFlow to riskMatrix ::> riskMatrix;
                connection : TracesRisk connect sourceRiskElement ::> residualEval to targetRiskElement ::> riskAfterFreeFlow;
                // Use errors feeding the risk chains (IEC 62366-1 §5.3)
                connection : TracesRisk connect sourceRiskElement ::> ueMisprogrammedRate to targetRiskElement ::> seqMisprogram;
                connection : TracesRisk connect sourceRiskElement ::> ueWrongDrugLoaded to targetRiskElement ::> seqMisprogram;
                connection : TracesRisk connect sourceRiskElement ::> ueBolusByProxy to targetRiskElement ::> seqFrequentBolus;
                connection : TracesRisk connect sourceRiskElement ::> ueAlarmDisregard to targetRiskElement ::> seqOcclusion;

                // ── FMEA and fault tree integration ─────────────────────────
                connection : AnalyzedBy connect element ::> pumpMotorAssembly to analysisArtifact ::> fmeaDelivery;
                connection : HasFailureMode connect element ::> pumpMotorAssembly to failureMode ::> fmMotorRunaway;
                connection : HasFailureMode connect element ::> airInLineSensor to failureMode ::> fmAirSensorSilent;
                connection : HasFailureMode connect element ::> occlusionSensor to failureMode ::> fmOcclusionDrift;
                connection : HasFailureMode connect element ::> bolusButton to failureMode ::> fmStuckBolusButton;
                connection : HasFailureMode connect element ::> batteryPack to failureMode ::> fmBatteryEarlyDepletion;
                connection : CausesEffect connect failureMode ::> fmMotorRunaway to failureEffect ::> feOverdose;
                connection : CausesEffect connect failureMode ::> fmStuckBolusButton to failureEffect ::> feOverdose;
                connection : CausesEffect connect failureMode ::> fmAirSensorSilent to failureEffect ::> feAirDelivered;
                connection : CausesEffect connect failureMode ::> fmOcclusionDrift to failureEffect ::> feTherapyInterrupted;
                connection : CausedBy connect failureMode ::> fmMotorRunaway to failureCause ::> fcMotorDriverFault;
                connection : CausedBy connect failureMode ::> fmAirSensorSilent to failureCause ::> fcTransducerAging;
                connection : CausedBy connect failureMode ::> fmStuckBolusButton to failureCause ::> fcPendantAbuse;
                connection : DetectedBy connect failureMode ::> fmMotorRunaway to detectionMethod ::> dmFlowCrossCheck;
                connection : DetectedBy connect failureMode ::> fmAirSensorSilent to detectionMethod ::> dmPostSensorCheck;
                connection : DetectedBy connect failureMode ::> fmStuckBolusButton to detectionMethod ::> dmStuckInputMonitor;
                connection : AddressedByAction connect failureMode ::> fmAirSensorSilent to fmeaAction ::> fmeaActionAirSensor;
                connection : ContributesToHazard connect failureMode ::> fmMotorRunaway to hazard ::> overdoseHazard;
                connection : ContributesToHazard connect failureMode ::> fmStuckBolusButton to hazard ::> overdoseHazard;
                connection : ContributesToHazard connect failureMode ::> fmAirSensorSilent to hazard ::> airEmbolismHazard;
                connection : ContributesToHazard connect failureMode ::> fmOcclusionDrift to hazard ::> underdoseHazard;
                connection : MitigatedByControl connect failureMode ::> fmMotorRunaway to riskControl ::> flowCrossCheckControl;
                connection : MitigatedByControl connect failureMode ::> fmStuckBolusButton to riskControl ::> lockoutControl;
                connection : InputToGate connect input ::> fteMotorRunaway to gate ::> ftgMotorAnd;
                connection : InputToGate connect input ::> fteCrossCheckFails to gate ::> ftgMotorAnd;
                connection : InputToGate connect input ::> fteLockoutFault to gate ::> ftgBolusAnd;
                connection : InputToGate connect input ::> fteStuckButtonUndetected to gate ::> ftgBolusAnd;
                connection : InputToGate connect input ::> ftgMotorAnd to gate ::> ftgOverdoseOr;
                connection : InputToGate connect input ::> ftgBolusAnd to gate ::> ftgOverdoseOr;
                connection : ProducesEvent connect gate ::> ftgOverdoseOr to event ::> fteOverdoseTop;
                connection : LeadsToHazard connect topEvent ::> fteOverdoseTop to hazard ::> overdoseHazard;
                connection : OriginatesFrom connect event ::> fteMotorRunaway to origin ::> pumpMotorAssembly;
                connection : OriginatesFrom connect event ::> fteStuckButtonUndetected to origin ::> bolusButton;
                connection : ContainsEvent connect cutSet ::> mcsMotorPath to event ::> fteMotorRunaway;
                connection : ContainsEvent connect cutSet ::> mcsMotorPath to event ::> fteCrossCheckFails;
                connection : ContainsEvent connect cutSet ::> mcsBolusPath to event ::> fteLockoutFault;
                connection : ContainsEvent connect cutSet ::> mcsBolusPath to event ::> fteStuckButtonUndetected;
                connection : BrokenByControl connect cutSet ::> mcsMotorPath to riskControl ::> flowCrossCheckControl;
                connection : BrokenByControl connect cutSet ::> mcsBolusPath to riskControl ::> lockoutControl;

                // ── Verification coverage (IEC 62304 §5.7) ──────────────────
                connection : VerifiedBy connect verificationTarget ::> reqCs01 to verificationCase ::> vcModeRange;
                connection : VerifiedBy connect verificationTarget ::> reqCs25 to verificationCase ::> vcLockout;
                connection : VerifiedBy connect verificationTarget ::> reqCs19 to verificationCase ::> vcSameStepAlarm;
                connection : VerifiedBy connect verificationTarget ::> reqDrugLibraryLimits to verificationCase ::> vcDrugLibrary;
                connection : VerifiedBy connect verificationTarget ::> reqCs09 to verificationCase ::> vcPrescriptionConfirm;
                connection : VerifiedBy connect verificationTarget ::> reqPost to verificationCase ::> vcPost;
                connection : VerifiedBy connect verificationTarget ::> reqPowerLossRetention to verificationCase ::> vcPowerLoss;
                connection : VerifiedBy connect verificationTarget ::> reqCs72 to verificationCase ::> vcAlarmLoudness;
                connection : VerifiedBy connect verificationTarget ::> reqCs75 to verificationCase ::> vcTemporalModeSafety;
                connection : VerifiedBy connect verificationTarget ::> reqCs21 to verificationCase ::> vcAirInLine;
                connection : VerifiedBy connect verificationTarget ::> reqOcclusion to verificationCase ::> vcOcclusion;
                connection : VerifiedBy connect verificationTarget ::> reqCs23 to verificationCase ::> vcEmptyReservoir;
                connection : VerifiedBy connect verificationTarget ::> reqDoorOpen to verificationCase ::> vcTemporalModeSafety;
                connection : VerifiedBy connect verificationTarget ::> reqMaxHourlyDose to verificationCase ::> vcHourlyMax;
                connection : VerifiedBy connect verificationTarget ::> reqCs78 to verificationCase ::> vcEventLog;
                connection : VerifiedBy connect verificationTarget ::> reqEventLogging to verificationCase ::> vcEventLog;
                connection : VerifiedBy connect verificationTarget ::> reqWatchdogSafeState to verificationCase ::> vcWatchdog;
                connection : VerifiedBy connect verificationTarget ::> reqStuckButton to verificationCase ::> vcStuckButton;
                connection : VerifiedBy connect verificationTarget ::> reqFlowCrossCheck to verificationCase ::> vcFlowCrossCheck;
                connection : VerifiedBy connect verificationTarget ::> reqPumpAccuracy to verificationCase ::> vcPumpAccuracy;
                connection : VerifiedBy connect verificationTarget ::> reqAlarmLoudness to verificationCase ::> vcAlarmLoudness;
                connection : VerifiedBy connect verificationTarget ::> reqBatteryBackup to verificationCase ::> vcPowerLoss;
                connection : VerifiedBy connect verificationTarget ::> reqFreeFlowPrevention to verificationCase ::> vcFreeFlow;
                // risk controls
                connection : VerifiedBy connect verificationTarget ::> lockoutControl to verificationCase ::> vcLockout;
                connection : VerifiedBy connect verificationTarget ::> airDetectionControl to verificationCase ::> vcAirInLine;
                connection : VerifiedBy connect verificationTarget ::> occlusionAlarmControl to verificationCase ::> vcOcclusion;
                connection : VerifiedBy connect verificationTarget ::> reservoirMonitorControl to verificationCase ::> vcEmptyReservoir;
                connection : VerifiedBy connect verificationTarget ::> drugLibraryControl to verificationCase ::> vcDrugLibrary;
                connection : VerifiedBy connect verificationTarget ::> freeFlowValveControl to verificationCase ::> vcFreeFlow;
                connection : VerifiedBy connect verificationTarget ::> watchdogControl to verificationCase ::> vcWatchdog;
                connection : VerifiedBy connect verificationTarget ::> flowCrossCheckControl to verificationCase ::> vcFlowCrossCheck;
                // behavior properties, contracts, and timing
                connection : VerifiedBy connect verificationTarget ::> propAlarmStopsSameStep to verificationCase ::> vcSameStepAlarm;
                connection : VerifiedBy connect verificationTarget ::> propLockoutTimerMonotonic to verificationCase ::> vcTemporalModeSafety;
                connection : VerifiedBy connect verificationTarget ::> guaranteeExclusiveMode to verificationCase ::> vcModeRange;
                connection : VerifiedBy connect verificationTarget ::> guaranteeLockoutPreventsBolus to verificationCase ::> vcLockout;
                connection : VerifiedBy connect verificationTarget ::> guaranteeAlarmStopsSameStep to verificationCase ::> vcSameStepAlarm;
                connection : VerifiedBy connect verificationTarget ::> temporalNoInvalidTransition to verificationCase ::> vcTemporalModeSafety;
                connection : VerifiedBy connect verificationTarget ::> tcAlarmLatency to verificationCase ::> vcSameStepAlarm;
                connection : VerifiedBy connect verificationTarget ::> tcBolusResponse to verificationCase ::> vcLockout;
                connection : VerifiedBy connect verificationTarget ::> tcWatchdogTimeout to verificationCase ::> vcWatchdog;
                // class-C software items
                connection : VerifiedBy connect verificationTarget ::> tlm to verificationCase ::> vcModeRange;
                connection : VerifiedBy connect verificationTarget ::> alarm to verificationCase ::> vcSameStepAlarm;
                connection : VerifiedBy connect verificationTarget ::> infusionMgr to verificationCase ::> vcLockout;
                connection : VerifiedBy connect verificationTarget ::> config to verificationCase ::> vcDrugLibrary;
                connection : VerifiedBy connect verificationTarget ::> logging to verificationCase ::> vcEventLog;
                connection : VerifiedBy connect verificationTarget ::> systemMonitor to verificationCase ::> vcPost;

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
                connection : ProducesEvidence connect producer ::> vcAlarmLoudness to producedEvidence ::> evidenceHardwareBench;
                connection : ProducesEvidence connect producer ::> vcFreeFlow to producedEvidence ::> evidenceHardwareBench;
                connection : ProducesEvidence connect producer ::> vcHourlyMax to producedEvidence ::> evidenceDoseProgramming;
                connection : ProducesEvidence connect producer ::> vcDrugLibrary to producedEvidence ::> evidenceDoseProgramming;
                connection : ProducesEvidence connect producer ::> vcPrescriptionConfirm to producedEvidence ::> evidenceDoseProgramming;
                connection : ProducesEvidence connect producer ::> vcEventLog to producedEvidence ::> evidenceDoseProgramming;
                connection : ProducesEvidence connect producer ::> vcPumpAccuracy to producedEvidence ::> evidenceDeliveryAccuracy;
                connection : ProducesEvidence connect producer ::> valSummativeUsability to producedEvidence ::> evidenceUsability;
                connection : IncludedIn connect sourceElement ::> evidenceLockout to targetView ::> rmfView;
                connection : IncludedIn connect sourceElement ::> evidenceSafetyAlarmSuite to targetView ::> vvView;
                connection : IncludedIn connect sourceElement ::> evidenceUsability to targetView ::> usabilityView;
                connection : IncludedIn connect sourceElement ::> fmeaDelivery to targetView ::> hazardAnalysisView;
                connection : IncludedIn connect sourceElement ::> ftaOverdose to targetView ::> hazardAnalysisView;
            }
        }
    }
}
