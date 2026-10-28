// The operational analysis layer as one package.
//
// A layer is a namespace of packages: every package whose name begins
// `memo_architecture_operational_`. This package publicly imports each of them, so
// `public import memo_architecture_operational::*;` in a methodology's package selects the whole
// layer, and the same import in any package makes the layer's definitions
// visible. It declares nothing of its own. test/package.test.mjs holds the list
// to exactly the packages in the namespace, so a package added to the layer is
// selected with it.
package memo_architecture_operational {
    public import memo_architecture_operational_activities::*;
    public import memo_architecture_operational_context_actors::*;
    public import memo_architecture_operational_context_stakeholders::*;
    public import memo_architecture_operational_context_use_context::*;
    public import memo_architecture_operational_rollups::*;
    public import memo_architecture_operational_scenarios::*;
    public import memo_architecture_operational_structure::*;
    public import memo_architecture_operational_use_cases::*;
    public import memo_architecture_operational_workflows::*;
}
