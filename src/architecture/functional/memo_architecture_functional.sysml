// The functional (system) analysis layer as one package.
//
// A layer is a namespace of packages: every package whose name begins
// `memo_architecture_functional_`. This package publicly imports each of them, so
// `public import memo_architecture_functional::*;` in a methodology's package selects the whole
// layer, and the same import in any package makes the layer's definitions
// visible. It declares nothing of its own. test/package.test.mjs holds the list
// to exactly the packages in the namespace, so a package added to the layer is
// selected with it.
package memo_architecture_functional {
    public import memo_architecture_functional_behavior::*;
    public import memo_architecture_functional_constraints::*;
    public import memo_architecture_functional_functions::*;
}
