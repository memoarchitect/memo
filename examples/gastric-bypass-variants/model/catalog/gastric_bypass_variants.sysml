// Illustrative operational model of a Roux-en-Y gastric bypass done three ways: laparoscopic
// instruments (current practice), a robot of ours, and a competitor's robot. It is a modelling
// example with invented numbers, not a clinical protocol or a cost study.
//
// Three workflows, one per level. The clinical workflow (level 1) uses each clinical action once, in
// order, and carries no number. A system workflow (level 2) per platform uses the SAME action
// definitions again as usages and sets the time, success probability and instruments on its own
// usage, so an action is defined once and never copied for the platform that does it; who does it
// is a `perform` from the platform part. The functional workflow (level 3) is a functional flow of
// our robot's functions, which a level-2 usage performs. Every occurrence of an action is a usage,
// so how often a step is repeated is the number of its usages.
//
// The platforms are the variants of one variation, so "current", "ours" and "a competitor's" are
// variants and not a state. The roll-ups of memo_architecture_operational_rollups derive each
// workflow's cost and duration, and `bypassTradeStudy` scores the three by them. A platform is a
// resource too, so its rate is built from capital, service and practical capacity, as
// time-driven activity-based costing does.
package memo_examples_gastric_bypass_variants {
    private import ScalarValues::*;
    private import ModelingMetadata::*;

    private import memo_core_enumerations::*;
    private import memo_core_stdlib_quantities::*;
    private import memo_core_stdlib_money::*;
    private import memo_core_stdlib_analysis::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_structure::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_workflows::*;
    private import memo_architecture_operational_scenarios::*;
    private import memo_architecture_operational_rollups::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_functional_functions::*;
    private import memo_extension_clinical::*;
    private import gastric_bypass_variants_anatomy_fma::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;

    // ── The project's one currency ──────────────────────────────
    attribute <EUR> euro : CurrencyUnit;

    // ── The clinical actions, each defined once ─────────────────
    part surgicalTeam : OperationalEntity {
        @MemoIdentity { :>> label = "Bariatric surgical team"; }
    }
    part stomach : Stomach {
        @MemoIdentity { :>> label = "Stomach"; }
    }
    part jejunum : Jejunum {
        @MemoIdentity { :>> label = "Jejunum"; }
    }
    action def EstablishPneumoperitoneumAndAccess specializes OperativeAction {
        @MemoIdentity { :>> label = "Establish pneumoperitoneum and access"; }
        ref :>> targets = stomach;
    }
    action def CreateGastricPouch specializes OperativeAction {
        @MemoIdentity { :>> label = "Create gastric pouch"; }
        ref :>> targets = stomach;
    }
    action def CreateGastrojejunostomy specializes OperativeAction {
        @MemoIdentity { :>> label = "Create gastrojejunostomy"; }
        ref :>> targets = jejunum;
    }
    action def PerformLeakTest specializes OperativeAction {
        @MemoIdentity { :>> label = "Perform leak test"; }
        ref :>> targets = stomach;
    }
    action def ConvertToOpenSurgery specializes OperativeAction {
        @MemoIdentity { :>> label = "Convert to open surgery"; }
        ref :>> targets = stomach;
    }

    // ── Tier 1: the clinical workflow ───────────────────────────
    use case ucRouxEnY : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        @MemoIdentity { :>> label = "Perform Roux-en-Y gastric bypass"; }
        attribute :>> goalStatement = "Create the gastric pouch and its anastomosis and confirm that it does not leak, whatever the platform.";
        subject :>> supportingSystem = surgicalTeam;
    }
    part wfRouxEnY : ClinicalProcedureWorkflow {
        @MemoIdentity { :>> label = "Clinical workflow: Roux-en-Y gastric bypass"; }
        attribute :>> entryCondition = "patient prepared; time-out complete";
        attribute :>> completionCondition = "pouch and anastomosis created and leak-tested";
        action scNominal : OperativeScenario {
            @MemoIdentity { :>> label = "Nominal path"; }
            action establishAccess : EstablishPneumoperitoneumAndAccess {
                @MemoIdentity { :>> label = "Establish pneumoperitoneum and access"; }
            }
            action createPouch : CreateGastricPouch {
                @MemoIdentity { :>> label = "Create gastric pouch"; }
            }
            action createGastrojejunostomy : CreateGastrojejunostomy {
                @MemoIdentity { :>> label = "Create gastrojejunostomy"; }
            }
            action performLeakTest : PerformLeakTest {
                @MemoIdentity { :>> label = "Perform leak test"; }
            }
            first establishAccess then createPouch;
            first createPouch then createGastrojejunostomy;
            first createGastrojejunostomy then performLeakTest;
        }
        action scConversion : OperativeScenario {
            attribute :>> scenarioKind = ScenarioKind::alternate;
            @MemoIdentity { :>> label = "Conversion to open"; }
            action convertToOpen : ConvertToOpenSurgery {
                @MemoIdentity { :>> label = "Convert to open surgery"; }
            }
        }
    }
    connection : RealizesUseCase connect realizingWorkflow ::> wfRouxEnY to realizedUseCase ::> ucRouxEnY;

    // ── Staff and functions ──────────────────────────────────────
    // Illustrative rates, authored for this example.
    part surgeon : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> label = "Surgeon"; }
        attribute :>> capacityCostRate = 420 [EUR/h];
    }
    part assistant : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> label = "Assistant"; }
        attribute :>> capacityCostRate = 260 [EUR/h];
    }
    part scrubNurse : User {
        attribute :>> actorKind = ActorKind::clinician;
        @MemoIdentity { :>> label = "Scrub nurse"; }
        attribute :>> capacityCostRate = 90 [EUR/h];
    }

    // ── Tier 3: our robot's functional workflow ──────────────────
    action fnDockPlatform : SystemFunction {
        @MemoIdentity { :>> label = "Dock the platform"; }
    }
    action fnTransectTissue : SystemFunction {
        @MemoIdentity { :>> label = "Transect tissue"; }
    }
    action fnFireStapler : SystemFunction {
        @MemoIdentity { :>> label = "Fire the stapler"; }
    }
    action fcOurRobotProcedure : FunctionalFlow {
        @MemoIdentity { :>> label = "Functional workflow: our robot's procedure"; }
        action dock :> fnDockPlatform;
        action transect :> fnTransectTissue;
        action fire :> fnFireStapler;
        first dock then transect;
        first transect then fire;
    }

    // ── The platforms: variants of one variation ─────────────────
    abstract part def SurgicalPlatform specializes System, MemoResource;
    part def Stapler specializes WorkflowResource;
    variation part platform : SurgicalPlatform {
        @MemoIdentity { :>> label = "Surgical platform"; }
        variant part laparoscopicTower : SurgicalPlatform {
            @MemoIdentity { :>> label = "Laparoscopic"; }
            perform wfRouxEnYLap.scLapNominal.establishAccess;
            perform wfRouxEnYLap.scLapNominal.createPouch;
            perform wfRouxEnYLap.scLapNominal.createGastrojejunostomy;
            perform wfRouxEnYLap.scLapNominal.performLeakTest;
            attribute :>> origin = SystemOriginKind::external;
            attribute :>> capacityCostRate = 120 [EUR/h];
        }
        variant part ourRobot : SurgicalPlatform {
            @MemoIdentity { :>> label = "Our robot"; }
            perform wfRouxEnYOur.scOurNominal.establishAccess;
            perform wfRouxEnYOur.scOurNominal.createPouch;
            perform wfRouxEnYOur.scOurNominal.createGastrojejunostomy;
            attribute :>> origin = SystemOriginKind::internal;
            attribute :>> capacityCostRate = 650 [EUR/h];
        }
        variant part competitorRobot : SurgicalPlatform {
            @MemoIdentity { :>> label = "Competitor robot"; }
            perform wfRouxEnYCmp.scCmpNominal.establishAccess;
            perform wfRouxEnYCmp.scCmpNominal.createPouch;
            perform wfRouxEnYCmp.scCmpNominal.createGastrojejunostomy;
            perform wfRouxEnYCmp.scCmpNominal.performLeakTest;
            attribute :>> origin = SystemOriginKind::external;
            attribute :>> capacityCostRate = 800 [EUR/h];
        }
    }
    allocate fnDockPlatform to platform.ourRobot;
    allocate fnTransectTissue to platform.ourRobot;
    allocate fnFireStapler to platform.ourRobot;

    // ── Tier 2: the system workflow, laparoscopic ──────────────────────
    use case ucRouxEnYLap : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        @MemoIdentity { :>> label = "Perform Roux-en-Y gastric bypass (laparoscopic)"; }
        subject :>> supportingSystem = platform.laparoscopicTower;
    }
    part wfRouxEnYLap : OperationalWorkflow {
        @MemoIdentity { :>> label = "System workflow: Roux-en-Y gastric bypass (laparoscopic)"; }
        attribute :>> entryCondition = "patient prepared; time-out complete";
        attribute :>> completionCondition = "pouch and anastomosis created and leak-tested";
        attribute :>> perProcedureCost = 450 [EUR];
        part staplerLap : Stapler {
            @MemoIdentity { :>> label = "Stapler (laparoscopic)"; }
            attribute :>> resourceKind = ResourceKind::consumable;
            attribute :>> unitCost = 180 [EUR];
        }
        action scLapNominal : OperativeScenario {
            @MemoIdentity { :>> label = "Nominal path (laparoscopic)"; }
            action establishAccess : EstablishPneumoperitoneumAndAccess {
                @MemoIdentity { :>> label = "Establish pneumoperitoneum and access"; }
                attribute :>> expectedDuration = 20 [min];
                attribute :>> plannedSuccessProbability = 0.99 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse, platform.laparoscopicTower);
            }
            action createPouch : CreateGastricPouch {
                @MemoIdentity { :>> label = "Create gastric pouch"; }
                attribute :>> expectedDuration = 25 [min];
                attribute :>> plannedSuccessProbability = 0.97 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse, platform.laparoscopicTower, staplerLap);
            }
            action createGastrojejunostomy : CreateGastrojejunostomy {
                @MemoIdentity { :>> label = "Create gastrojejunostomy"; }
                attribute :>> expectedDuration = 45 [min];
                attribute :>> plannedSuccessProbability = 0.94 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse, platform.laparoscopicTower, staplerLap);
            }
            action performLeakTest : PerformLeakTest {
                @MemoIdentity { :>> label = "Perform leak test"; }
                attribute :>> expectedDuration = 10 [min];
                attribute :>> plannedSuccessProbability = 0.99 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse, platform.laparoscopicTower);
            }
            first establishAccess then createPouch;
            first createPouch then createGastrojejunostomy;
            first createGastrojejunostomy then performLeakTest;
        }
        action scLapConversion : OperativeScenario {
            attribute :>> scenarioKind = ScenarioKind::alternate;
            @MemoIdentity { :>> label = "Conversion to open (laparoscopic)"; }
            attribute :>> likelihood = 0.06 [one];
            action convertToOpen : ConvertToOpenSurgery {
                @MemoIdentity { :>> label = "Convert to open surgery"; }
                attribute :>> expectedDuration = 35 [min];
                attribute :>> plannedSuccessProbability = 0.99 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse);
            }
        }
    }
    connection : RealizesUseCase connect realizingWorkflow ::> wfRouxEnYLap to realizedUseCase ::> ucRouxEnYLap;
    #refinement dependency wfRouxEnYLap::scLapNominal::establishAccess to wfRouxEnY::scNominal::establishAccess;
    #refinement dependency wfRouxEnYLap::scLapNominal::createPouch to wfRouxEnY::scNominal::createPouch;
    #refinement dependency wfRouxEnYLap::scLapNominal::createGastrojejunostomy to wfRouxEnY::scNominal::createGastrojejunostomy;
    #refinement dependency wfRouxEnYLap::scLapNominal::performLeakTest to wfRouxEnY::scNominal::performLeakTest;
    #refinement dependency wfRouxEnYLap::scLapConversion::convertToOpen to wfRouxEnY::scConversion::convertToOpen;

    // ── Tier 2: the system workflow, our robot ──────────────────────
    use case ucRouxEnYOur : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        @MemoIdentity { :>> label = "Perform Roux-en-Y gastric bypass (our robot)"; }
        subject :>> supportingSystem = platform.ourRobot;
    }
    part wfRouxEnYOur : OperationalWorkflow {
        @MemoIdentity { :>> label = "System workflow: Roux-en-Y gastric bypass (our robot)"; }
        attribute :>> entryCondition = "patient prepared; time-out complete";
        attribute :>> completionCondition = "pouch and anastomosis created and leak-tested";
        attribute :>> perProcedureCost = 900 [EUR];
        part staplerOur : Stapler {
            @MemoIdentity { :>> label = "Stapler (our robot)"; }
            attribute :>> resourceKind = ResourceKind::consumable;
            attribute :>> unitCost = 310 [EUR];
        }
        action scOurNominal : OperativeScenario {
            @MemoIdentity { :>> label = "Nominal path (our robot)"; }
            action establishAccess : EstablishPneumoperitoneumAndAccess {
                @MemoIdentity { :>> label = "Establish pneumoperitoneum and access"; }
                attribute :>> expectedDuration = 30 [min];
                attribute :>> plannedSuccessProbability = 0.99 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse, platform.ourRobot);
                perform fnDockPlatform;
            }
            action createPouch : CreateGastricPouch {
                @MemoIdentity { :>> label = "Create gastric pouch"; }
                attribute :>> expectedDuration = 18 [min];
                attribute :>> plannedSuccessProbability = 0.98 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse, platform.ourRobot, staplerOur);
                perform fnTransectTissue;
                perform fnFireStapler;
            }
            action createGastrojejunostomy : CreateGastrojejunostomy {
                @MemoIdentity { :>> label = "Create gastrojejunostomy"; }
                attribute :>> expectedDuration = 30 [min];
                attribute :>> plannedSuccessProbability = 0.97 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse, platform.ourRobot, staplerOur);
                perform fnTransectTissue;
                perform fnFireStapler;
            }
            action performLeakTest : PerformLeakTest {
                @MemoIdentity { :>> label = "Perform leak test"; }
                attribute :>> expectedDuration = 10 [min];
                attribute :>> plannedSuccessProbability = 0.99 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse, platform.ourRobot);
            }
            first establishAccess then createPouch;
            first createPouch then createGastrojejunostomy;
            first createGastrojejunostomy then performLeakTest;
        }
        action scOurConversion : OperativeScenario {
            attribute :>> scenarioKind = ScenarioKind::alternate;
            @MemoIdentity { :>> label = "Conversion to open (our robot)"; }
            attribute :>> likelihood = 0.03 [one];
            action convertToOpen : ConvertToOpenSurgery {
                @MemoIdentity { :>> label = "Convert to open surgery"; }
                attribute :>> expectedDuration = 35 [min];
                attribute :>> plannedSuccessProbability = 0.99 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse);
            }
        }
    }
    connection : RealizesUseCase connect realizingWorkflow ::> wfRouxEnYOur to realizedUseCase ::> ucRouxEnYOur;
    #refinement dependency wfRouxEnYOur::scOurNominal::establishAccess to wfRouxEnY::scNominal::establishAccess;
    #refinement dependency wfRouxEnYOur::scOurNominal::createPouch to wfRouxEnY::scNominal::createPouch;
    #refinement dependency wfRouxEnYOur::scOurNominal::createGastrojejunostomy to wfRouxEnY::scNominal::createGastrojejunostomy;
    #refinement dependency wfRouxEnYOur::scOurNominal::performLeakTest to wfRouxEnY::scNominal::performLeakTest;
    #refinement dependency wfRouxEnYOur::scOurConversion::convertToOpen to wfRouxEnY::scConversion::convertToOpen;

    // ── Tier 2: the system workflow, competitor robot ──────────────────────
    use case ucRouxEnYCmp : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        @MemoIdentity { :>> label = "Perform Roux-en-Y gastric bypass (competitor robot)"; }
        subject :>> supportingSystem = platform.competitorRobot;
    }
    part wfRouxEnYCmp : OperationalWorkflow {
        @MemoIdentity { :>> label = "System workflow: Roux-en-Y gastric bypass (competitor robot)"; }
        attribute :>> entryCondition = "patient prepared; time-out complete";
        attribute :>> completionCondition = "pouch and anastomosis created and leak-tested";
        attribute :>> perProcedureCost = 1100 [EUR];
        part staplerCmp : Stapler {
            @MemoIdentity { :>> label = "Stapler (competitor robot)"; }
            attribute :>> resourceKind = ResourceKind::consumable;
            attribute :>> unitCost = 340 [EUR];
        }
        action scCmpNominal : OperativeScenario {
            @MemoIdentity { :>> label = "Nominal path (competitor robot)"; }
            action establishAccess : EstablishPneumoperitoneumAndAccess {
                @MemoIdentity { :>> label = "Establish pneumoperitoneum and access"; }
                attribute :>> expectedDuration = 35 [min];
                attribute :>> plannedSuccessProbability = 0.98 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse, platform.competitorRobot);
            }
            action createPouch : CreateGastricPouch {
                @MemoIdentity { :>> label = "Create gastric pouch"; }
                attribute :>> expectedDuration = 22 [min];
                attribute :>> plannedSuccessProbability = 0.97 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse, platform.competitorRobot, staplerCmp);
            }
            action createGastrojejunostomy : CreateGastrojejunostomy {
                @MemoIdentity { :>> label = "Create gastrojejunostomy"; }
                attribute :>> expectedDuration = 35 [min];
                attribute :>> plannedSuccessProbability = 0.96 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse, platform.competitorRobot, staplerCmp);
            }
            action performLeakTest : PerformLeakTest {
                @MemoIdentity { :>> label = "Perform leak test"; }
                attribute :>> expectedDuration = 10 [min];
                attribute :>> plannedSuccessProbability = 0.99 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse, platform.competitorRobot);
            }
            first establishAccess then createPouch;
            first createPouch then createGastrojejunostomy;
            first createGastrojejunostomy then performLeakTest;
        }
        action scCmpConversion : OperativeScenario {
            attribute :>> scenarioKind = ScenarioKind::alternate;
            @MemoIdentity { :>> label = "Conversion to open (competitor robot)"; }
            attribute :>> likelihood = 0.04 [one];
            action convertToOpen : ConvertToOpenSurgery {
                @MemoIdentity { :>> label = "Convert to open surgery"; }
                attribute :>> expectedDuration = 35 [min];
                attribute :>> plannedSuccessProbability = 0.99 [one];
                ref :>> instruments = (surgeon, assistant, scrubNurse);
            }
        }
    }
    connection : RealizesUseCase connect realizingWorkflow ::> wfRouxEnYCmp to realizedUseCase ::> ucRouxEnYCmp;
    #refinement dependency wfRouxEnYCmp::scCmpNominal::establishAccess to wfRouxEnY::scNominal::establishAccess;
    #refinement dependency wfRouxEnYCmp::scCmpNominal::createPouch to wfRouxEnY::scNominal::createPouch;
    #refinement dependency wfRouxEnYCmp::scCmpNominal::createGastrojejunostomy to wfRouxEnY::scNominal::createGastrojejunostomy;
    #refinement dependency wfRouxEnYCmp::scCmpNominal::performLeakTest to wfRouxEnY::scNominal::performLeakTest;
    #refinement dependency wfRouxEnYCmp::scCmpConversion::convertToOpen to wfRouxEnY::scConversion::convertToOpen;

    // ── The roll-ups of each platform's workflow ─────────────────
    calc costLap : ProcedureCost { in workflow = wfRouxEnYLap; }
    calc durationLap : ProcedureDuration { in workflow = wfRouxEnYLap; }
    calc successLap : ScenarioSuccess { in scenario = wfRouxEnYLap.scLapNominal; }
    calc costOur : ProcedureCost { in workflow = wfRouxEnYOur; }
    calc durationOur : ProcedureDuration { in workflow = wfRouxEnYOur; }
    calc successOur : ScenarioSuccess { in scenario = wfRouxEnYOur.scOurNominal; }
    calc costCmp : ProcedureCost { in workflow = wfRouxEnYCmp; }
    calc durationCmp : ProcedureDuration { in workflow = wfRouxEnYCmp; }
    calc successCmp : ScenarioSuccess { in scenario = wfRouxEnYCmp.scCmpNominal; }

    // ── The comparison ───────────────────────────────────────────
    // The alternatives are the three platforms' workflows; the evaluation is the expected cost of a
    // procedure, which the roll-up derives from the activities' times, the resources' rates and the
    // alternate scenarios' likelihoods. The lowest wins.
    analysis bypassTradeStudy : TradeStudy {
        subject : OperationalWorkflow = (wfRouxEnYLap, wfRouxEnYOur, wfRouxEnYCmp);
        objective : MinimizeObjective;

        calc :>> evaluationFunction {
            in part aWorkflow :>> alternative : OperationalWorkflow;

            calc procedureCost : ProcedureCost { in workflow = aWorkflow; return cost; }

            return :>> result : Real = procedureCost.cost.num;
        }

        return part :>> selectedAlternative : OperationalWorkflow;
    }
}
