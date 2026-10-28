// Illustrative operational model of a Roux-en-Y gastric bypass done three ways: laparoscopic
// instruments (current practice), a robot of ours, and a competitor's robot. It is a modelling
// example with invented numbers, not a clinical protocol or a cost study.
//
// Level 1 is the clinical baseline: a use case whose subject is the surgical team, a workflow and
// steps that carry no number, because a number on a step would belong to no platform. Level 2 is
// one use case, workflow and set of activities per platform; each activity refines the level-1 step
// it carries out and carries the time, success probability and instruments. The platforms are the
// variants of one variation, so "current", "ours" and "a competitor's" are variants and not a state.
// The roll-ups of memo_architecture_operational_rollups derive each workflow's cost and duration,
// and `bypassTradeStudy` scores the three by them. A platform is a resource too, so its rate is
// built from capital, service and practical capacity, as time-driven activity-based costing does.
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
    private import memo_extension_clinical::*;
    private import gastric_bypass_variants_anatomy_fma::*;
    private import memo_architecture_functional_functions::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;

    // ── The project's one currency ──────────────────────────────
    attribute <EUR> euro : CurrencyUnit;

    // ── Level 1: what must happen to the patient ────────────────
    part surgicalTeam : OperationalEntity {
        @MemoIdentity { :>> label = "Bariatric surgical team"; }
    }
    // The anatomy is FMA's, generated into the project's anatomy library (see the project file).
    part stomach : Stomach {
        @MemoIdentity { :>> label = "Stomach"; }
    }
    part jejunum : Jejunum {
        @MemoIdentity { :>> label = "Jejunum"; }
    }

    use case ucRouxEnY : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        @MemoIdentity { :>> label = "Perform Roux-en-Y gastric bypass"; }
        attribute :>> goalStatement = "Create the gastric pouch and its anastomosis and confirm that it does not leak, whatever the platform.";
        subject :>> supportingSystem = surgicalTeam;
    }
    action stepAccess : OperativeAction {
        @MemoIdentity { :>> label = "Establish pneumoperitoneum and access"; }
        ref :>> targets = stomach;
    }
    action stepPouch : OperativeAction {
        @MemoIdentity { :>> label = "Create gastric pouch"; }
        ref :>> targets = stomach;
    }
    action stepGastrojejunostomy : OperativeAction {
        @MemoIdentity { :>> label = "Create gastrojejunostomy"; }
        ref :>> targets = jejunum;
    }
    action stepLeakTest : OperativeAction {
        @MemoIdentity { :>> label = "Perform leak test"; }
        ref :>> targets = stomach;
    }
    action stepConvertToOpen : OperativeAction {
        @MemoIdentity { :>> label = "Convert to open surgery"; }
        ref :>> targets = stomach;
    }

    part wfRouxEnY : ClinicalProcedureWorkflow {
        @MemoIdentity { :>> label = "Roux-en-Y gastric bypass workflow"; }
        attribute :>> entryCondition = "patient prepared; time-out complete";
        attribute :>> completionCondition = "pouch and anastomosis created and leak-tested";
        action scNominal : OperativeScenario {
        @MemoIdentity { :>> label = "Nominal path"; }
            perform stepAccess;
            perform stepPouch;
            perform stepGastrojejunostomy;
            perform stepLeakTest;
            first stepAccess then stepPouch;
            first stepPouch then stepGastrojejunostomy;
            first stepGastrojejunostomy then stepLeakTest;
        }
        action scConversion : OperativeScenario {
        @MemoIdentity { :>> label = "Conversion to open"; }
            attribute :>> scenarioKind = ScenarioKind::alternate;
            perform stepConvertToOpen;
        }
    }
    connection : RealizesUseCase connect realizingWorkflow ::> wfRouxEnY to realizedUseCase ::> ucRouxEnY;

    // ── Staff: resources with a rate, and the people who perform ─
    // Illustrative rates, authored for this example.
    part surgeon : User {
        @MemoIdentity { :>> label = "Surgeon"; }
        attribute :>> actorKind = ActorKind::clinician;
        attribute :>> capacityCostRate = 420 [EUR/h];
    }
    part assistant : User {
        @MemoIdentity { :>> label = "Assistant"; }
        attribute :>> actorKind = ActorKind::clinician;
        attribute :>> capacityCostRate = 260 [EUR/h];
    }
    part scrubNurse : User {
        @MemoIdentity { :>> label = "Scrub nurse"; }
        attribute :>> actorKind = ActorKind::clinician;
        attribute :>> capacityCostRate = 90 [EUR/h];
    }

    // ── Functions our robot carries out (level 3 is ours only) ───
    action fnDockPlatform : SystemFunction {
        @MemoIdentity { :>> label = "Dock the platform"; }
    }
    action fnTransectTissue : SystemFunction {
        @MemoIdentity { :>> label = "Transect tissue"; }
    }
    action fnFireStapler : SystemFunction {
        @MemoIdentity { :>> label = "Fire the stapler"; }
    }

    // ── The platforms: variants of one variation ─────────────────
    abstract part def SurgicalPlatform specializes System, MemoResource;
    part def Stapler specializes WorkflowResource;
    variation part platform : SurgicalPlatform {
        @MemoIdentity { :>> label = "Surgical platform"; }
        variant part laparoscopicTower : SurgicalPlatform {
        @MemoIdentity { :>> label = "Laparoscopic tower"; }
            perform actAccessLap;
            perform actPouchLap;
            perform actGastrojejunostomyLap;
            perform actLeakTestLap;
            attribute :>> origin = SystemOriginKind::external;
            attribute :>> capacityCostRate = 120 [EUR/h];
        }
        variant part ourRobot : SurgicalPlatform {
        @MemoIdentity { :>> label = "Our robot"; }
            perform actAccessOur;
            perform actPouchOur;
            perform actGastrojejunostomyOur;
            attribute :>> origin = SystemOriginKind::internal;
            attribute :>> capacityCostRate = 650 [EUR/h];
        }
        variant part competitorRobot : SurgicalPlatform {
        @MemoIdentity { :>> label = "Competitor robot"; }
            perform actAccessCmp;
            perform actPouchCmp;
            perform actGastrojejunostomyCmp;
            perform actLeakTestCmp;
            attribute :>> origin = SystemOriginKind::external;
            attribute :>> capacityCostRate = 800 [EUR/h];
        }
    }
    allocate fnDockPlatform to platform.ourRobot;
    allocate fnTransectTissue to platform.ourRobot;
    allocate fnFireStapler to platform.ourRobot;

    // ── Level 2: Laparoscopic ──────────────────────────────────
    use case ucRouxEnYLap : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        @MemoIdentity { :>> label = "Perform Roux-en-Y gastric bypass (laparoscopic)"; }
        subject :>> supportingSystem = platform.laparoscopicTower;
    }
    action actAccessLap : OperativeAction {
        @MemoIdentity { :>> label = "Establish pneumoperitoneum and access (laparoscopic)"; }
        attribute :>> expectedDuration = 20 [min];
        attribute :>> plannedSuccessProbability = 0.99 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse, platform.laparoscopicTower);
        ref :>> targets = stomach;
    }
    #refinement dependency actAccessLap to stepAccess;
    action actPouchLap : OperativeAction {
        @MemoIdentity { :>> label = "Create gastric pouch (laparoscopic)"; }
        attribute :>> expectedDuration = 25 [min];
        attribute :>> plannedSuccessProbability = 0.97 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse, platform.laparoscopicTower, wfRouxEnYLap.staplerLap);
        ref :>> targets = stomach;
    }
    #refinement dependency actPouchLap to stepPouch;
    action actGastrojejunostomyLap : OperativeAction {
        @MemoIdentity { :>> label = "Create gastrojejunostomy (laparoscopic)"; }
        attribute :>> expectedDuration = 45 [min];
        attribute :>> plannedSuccessProbability = 0.94 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse, platform.laparoscopicTower, wfRouxEnYLap.staplerLap);
        ref :>> targets = jejunum;
    }
    #refinement dependency actGastrojejunostomyLap to stepGastrojejunostomy;
    action actLeakTestLap : OperativeAction {
        @MemoIdentity { :>> label = "Perform leak test (laparoscopic)"; }
        attribute :>> expectedDuration = 10 [min];
        attribute :>> plannedSuccessProbability = 0.99 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse, platform.laparoscopicTower);
        ref :>> targets = stomach;
    }
    #refinement dependency actLeakTestLap to stepLeakTest;
    action actConvertLap : OperativeAction {
        @MemoIdentity { :>> label = "Convert to open surgery (laparoscopic)"; }
        attribute :>> expectedDuration = 35 [min];
        attribute :>> plannedSuccessProbability = 0.99 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse);
        ref :>> targets = stomach;
    }
    #refinement dependency actConvertLap to stepConvertToOpen;
    part wfRouxEnYLap : OperationalWorkflow {
        @MemoIdentity { :>> label = "Roux-en-Y gastric bypass workflow (laparoscopic)"; }
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
            perform actAccessLap;
            perform actPouchLap;
            perform actGastrojejunostomyLap;
            perform actLeakTestLap;
            first actAccessLap then actPouchLap;
            first actPouchLap then actGastrojejunostomyLap;
            first actGastrojejunostomyLap then actLeakTestLap;
        }
        action scLapConversion : OperativeScenario {
        @MemoIdentity { :>> label = "Conversion to open (laparoscopic)"; }
            attribute :>> scenarioKind = ScenarioKind::alternate;
            attribute :>> likelihood = 0.06 [one];
            perform actConvertLap;
        }
    }
    connection : RealizesUseCase connect realizingWorkflow ::> wfRouxEnYLap to realizedUseCase ::> ucRouxEnYLap;

    // ── Level 2: OurRobot ──────────────────────────────────
    use case ucRouxEnYOur : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        @MemoIdentity { :>> label = "Perform Roux-en-Y gastric bypass (our robot)"; }
        subject :>> supportingSystem = platform.ourRobot;
    }
    action actAccessOur : OperativeAction {
        @MemoIdentity { :>> label = "Establish pneumoperitoneum and access (our robot)"; }
        attribute :>> expectedDuration = 30 [min];
        attribute :>> plannedSuccessProbability = 0.99 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse, platform.ourRobot);
        ref :>> targets = stomach;
        perform fnDockPlatform;
    }
    #refinement dependency actAccessOur to stepAccess;
    action actPouchOur : OperativeAction {
        @MemoIdentity { :>> label = "Create gastric pouch (our robot)"; }
        attribute :>> expectedDuration = 18 [min];
        attribute :>> plannedSuccessProbability = 0.98 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse, platform.ourRobot, wfRouxEnYOur.staplerOur);
        ref :>> targets = stomach;
        perform fnTransectTissue;
        perform fnFireStapler;
    }
    #refinement dependency actPouchOur to stepPouch;
    action actGastrojejunostomyOur : OperativeAction {
        @MemoIdentity { :>> label = "Create gastrojejunostomy (our robot)"; }
        attribute :>> expectedDuration = 30 [min];
        attribute :>> plannedSuccessProbability = 0.97 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse, platform.ourRobot, wfRouxEnYOur.staplerOur);
        ref :>> targets = jejunum;
        perform fnTransectTissue;
        perform fnFireStapler;
    }
    #refinement dependency actGastrojejunostomyOur to stepGastrojejunostomy;
    action actLeakTestOur : OperativeAction {
        @MemoIdentity { :>> label = "Perform leak test (our robot)"; }
        attribute :>> expectedDuration = 10 [min];
        attribute :>> plannedSuccessProbability = 0.99 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse, platform.ourRobot);
        ref :>> targets = stomach;
    }
    #refinement dependency actLeakTestOur to stepLeakTest;
    action actConvertOur : OperativeAction {
        @MemoIdentity { :>> label = "Convert to open surgery (our robot)"; }
        attribute :>> expectedDuration = 35 [min];
        attribute :>> plannedSuccessProbability = 0.99 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse);
        ref :>> targets = stomach;
    }
    #refinement dependency actConvertOur to stepConvertToOpen;
    part wfRouxEnYOur : OperationalWorkflow {
        @MemoIdentity { :>> label = "Roux-en-Y gastric bypass workflow (our robot)"; }
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
            perform actAccessOur;
            perform actPouchOur;
            perform actGastrojejunostomyOur;
            perform actLeakTestOur;
            first actAccessOur then actPouchOur;
            first actPouchOur then actGastrojejunostomyOur;
            first actGastrojejunostomyOur then actLeakTestOur;
        }
        action scOurConversion : OperativeScenario {
        @MemoIdentity { :>> label = "Conversion to open (our robot)"; }
            attribute :>> scenarioKind = ScenarioKind::alternate;
            attribute :>> likelihood = 0.03 [one];
            perform actConvertOur;
        }
    }
    connection : RealizesUseCase connect realizingWorkflow ::> wfRouxEnYOur to realizedUseCase ::> ucRouxEnYOur;

    // ── Level 2: CompetitorRobot ──────────────────────────────────
    use case ucRouxEnYCmp : UseCase {
        attribute :>> useCaseKind = UseCaseKind::clinical;
        @MemoIdentity { :>> label = "Perform Roux-en-Y gastric bypass (competitor robot)"; }
        subject :>> supportingSystem = platform.competitorRobot;
    }
    action actAccessCmp : OperativeAction {
        @MemoIdentity { :>> label = "Establish pneumoperitoneum and access (competitor robot)"; }
        attribute :>> expectedDuration = 35 [min];
        attribute :>> plannedSuccessProbability = 0.98 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse, platform.competitorRobot);
        ref :>> targets = stomach;
    }
    #refinement dependency actAccessCmp to stepAccess;
    action actPouchCmp : OperativeAction {
        @MemoIdentity { :>> label = "Create gastric pouch (competitor robot)"; }
        attribute :>> expectedDuration = 22 [min];
        attribute :>> plannedSuccessProbability = 0.97 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse, platform.competitorRobot, wfRouxEnYCmp.staplerCmp);
        ref :>> targets = stomach;
    }
    #refinement dependency actPouchCmp to stepPouch;
    action actGastrojejunostomyCmp : OperativeAction {
        @MemoIdentity { :>> label = "Create gastrojejunostomy (competitor robot)"; }
        attribute :>> expectedDuration = 35 [min];
        attribute :>> plannedSuccessProbability = 0.96 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse, platform.competitorRobot, wfRouxEnYCmp.staplerCmp);
        ref :>> targets = jejunum;
    }
    #refinement dependency actGastrojejunostomyCmp to stepGastrojejunostomy;
    action actLeakTestCmp : OperativeAction {
        @MemoIdentity { :>> label = "Perform leak test (competitor robot)"; }
        attribute :>> expectedDuration = 10 [min];
        attribute :>> plannedSuccessProbability = 0.99 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse, platform.competitorRobot);
        ref :>> targets = stomach;
    }
    #refinement dependency actLeakTestCmp to stepLeakTest;
    action actConvertCmp : OperativeAction {
        @MemoIdentity { :>> label = "Convert to open surgery (competitor robot)"; }
        attribute :>> expectedDuration = 35 [min];
        attribute :>> plannedSuccessProbability = 0.99 [one];
        ref :>> instruments = (surgeon, assistant, scrubNurse);
        ref :>> targets = stomach;
    }
    #refinement dependency actConvertCmp to stepConvertToOpen;
    part wfRouxEnYCmp : OperationalWorkflow {
        @MemoIdentity { :>> label = "Roux-en-Y gastric bypass workflow (competitor robot)"; }
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
            perform actAccessCmp;
            perform actPouchCmp;
            perform actGastrojejunostomyCmp;
            perform actLeakTestCmp;
            first actAccessCmp then actPouchCmp;
            first actPouchCmp then actGastrojejunostomyCmp;
            first actGastrojejunostomyCmp then actLeakTestCmp;
        }
        action scCmpConversion : OperativeScenario {
        @MemoIdentity { :>> label = "Conversion to open (competitor robot)"; }
            attribute :>> scenarioKind = ScenarioKind::alternate;
            attribute :>> likelihood = 0.04 [one];
            perform actConvertCmp;
        }
    }
    connection : RealizesUseCase connect realizingWorkflow ::> wfRouxEnYCmp to realizedUseCase ::> ucRouxEnYCmp;

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
