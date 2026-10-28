// Re-export-only wrapper. No new types.
//
// The trade-study framework (`TradeStudy`, `EvaluationFunction`, `MinimizeObjective`,
// `MaximizeObjective`) a comparison of alternatives is written with: current practice, ours and a
// competitor's are the alternatives, an evaluation function over their roll-ups scores each, and
// the objective says which score is best.
package memo_core_stdlib_analysis {
    private import ScalarValues::*;

    public import TradeStudies::*;
}
