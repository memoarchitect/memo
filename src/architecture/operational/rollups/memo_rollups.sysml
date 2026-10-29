// Roll-ups of a level-2 procedure flow (plan decision 9). A number is entered once, on an
// activity (`expectedDuration`, `plannedSuccessProbability`, the cost rates of its `instruments`),
// and every figure above it is derived here: a scenario, a procedure, a variant. A `TradeStudy`
// compares variants by these, so nothing a study reads is typed in twice.
//
// ─── Traversal ──────────────────────────────────────────────────────────
// `ActivitiesOf` is the one place that decides which activities count, and every roll-up reads
// it. It reads `enclosedPerformances`, which holds a step's composite `subactions`, the activities
// it `perform`s by reference (a scenario that performs activities declared once and used in
// several), and the `includedUseCases` of a use case, which are `enclosedPerformances` and not
// `subactions`, so a walk over `subactions` alone would miss every reusable system use case. It
// descends only into what can hold activities: an activity, a scenario or a use case. A
// `perform` of a `SystemFunction` is therefore never entered, which is the point of the stop:
// level 3 is how the system does its share, not more time, and following it would count the
// same work twice.
//
// ─── Sums ───────────────────────────────────────────────────────────────
// Sums and products use `QuantityCalculations`, so a cost, a duration and a probability stay
// quantities with units; money is `memo_core_stdlib_money`, in the project's one currency.
// A cost is the activity's duration times each instrument's capacity cost rate, plus each
// instrument's unit cost. Parallel branches are each paid for, because each resource used is
// paid for. Time is the sum along the path; a fork whose branches overlap in time is not yet
// reduced to its longest branch here.
//
// `memo evaluate` runs them from these bodies over the built model (memo-tools, analysis/calc), and a
// `TradeStudy` reads the results, so no figure is written twice. Units follow the SysML library's own
// conversions, so minutes and hours add and a rate times a duration is an amount.
package memo_architecture_operational_rollups {
    private import ScalarValues::*;
    private import memo_core_stdlib_functions::*;
    private import memo_core_stdlib_quantities::*;
    private import memo_core_stdlib_money::*;
    private import memo_core_common::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_scenarios::*;
    private import memo_architecture_operational_workflows::*;
    private import memo_architecture_operational_use_cases::*;

    calc def ActivitiesOf {
        in owner : MemoAction[1];
        return activities : OperativeAction[0..*] = (
            owner.enclosedPerformances->select { in inner : MemoAction[1]; inner istype OperativeAction },
            owner.enclosedPerformances
                ->select { in inner : MemoAction[1];
                    inner istype OperativeAction or inner istype OperativeScenario or inner istype UseCase }
                ->collect { in inner : MemoAction[1]; ActivitiesOf(inner) });
    }

    calc def ActivityCost {
        in activity : OperativeAction[1];
        return cost : MoneyValue[1] = QuantityCalculations::sum((
            activity.instruments.capacityCostRate->collect { in rate : CostRateValue[1]; (rate * activity.expectedDuration) as MoneyValue },
            activity.instruments.unitCost));
    }

    calc def ScenarioCost {
        in scenario : MemoAction[1];
        return cost : MoneyValue[1] = QuantityCalculations::sum(
            ActivitiesOf(scenario)->collect { in activity : OperativeAction[1]; ActivityCost(activity) });
    }

    calc def ScenarioDuration {
        in scenario : MemoAction[1];
        return duration : DurationValue[1] = QuantityCalculations::sum(
            ActivitiesOf(scenario)->collect { in activity : OperativeAction[1]; activity.expectedDuration });
    }

    calc def ScenarioSuccess {
        in scenario : MemoAction[1];
        return success : ProbabilityValue[1] = QuantityCalculations::product(
            ActivitiesOf(scenario).plannedSuccessProbability);
    }

    calc def ProcedureCost {
        in workflow : OperationalWorkflow[1];
        return cost : MoneyValue[1] = QuantityCalculations::sum((
            workflow.ownedActions->select { in s : MemoAction[1]; s istype OperativeScenario }
                ->collect { in s : OperativeScenario[1]; (ScenarioWeight(s) * ScenarioCost(s)) as MoneyValue },
            workflow.perProcedureCost));
    }

    calc def ProcedureDuration {
        in workflow : OperationalWorkflow[1];
        return duration : DurationValue[1] = QuantityCalculations::sum(
            workflow.ownedActions->select { in s : MemoAction[1]; s istype OperativeScenario }
                ->collect { in s : OperativeScenario[1]; (ScenarioWeight(s) * ScenarioDuration(s)) as DurationValue });
    }

    calc def ScenarioWeight {
        in scenario : OperativeScenario[1];
        return weight : Real[1] = if scenario.scenarioKind == ScenarioKind::nominal ? 1.0 else scenario.likelihood;
    }

    calc def HighDemandCount {
        in assessments : TaskDifficultyAssessment[0..*];
        return count : Natural[1] = assessments->select { in a : TaskDifficultyAssessment[1];
            a.overallDifficulty == DemandLevelKind::high or a.overallDifficulty == DemandLevelKind::extreme }->size();
    }

    calc def HighestDemand {
        in assessments : TaskDifficultyAssessment[0..*];
        return demand : DemandLevelKind[1] =
            if assessments->exists { in a : TaskDifficultyAssessment[1]; a.overallDifficulty == DemandLevelKind::extreme } ? DemandLevelKind::extreme
            else if assessments->exists { in a : TaskDifficultyAssessment[1]; a.overallDifficulty == DemandLevelKind::high } ? DemandLevelKind::high
            else if assessments->exists { in a : TaskDifficultyAssessment[1]; a.overallDifficulty == DemandLevelKind::moderate } ? DemandLevelKind::moderate
            else if assessments->exists { in a : TaskDifficultyAssessment[1]; a.overallDifficulty == DemandLevelKind::low } ? DemandLevelKind::low
            else DemandLevelKind::minimal;
    }
}
