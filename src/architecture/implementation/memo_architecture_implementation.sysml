// The implementation (software, hardware, user interface) layer as one package.
//
// A layer is a namespace of packages: every package whose name begins
// `memo_architecture_implementation_`. This package publicly imports each of them, so
// `public import memo_architecture_implementation::*;` in a methodology's package selects the whole
// layer, and the same import in any package makes the layer's definitions
// visible. It declares nothing of its own. test/package.test.mjs holds the list
// to exactly the packages in the namespace, so a package added to the layer is
// selected with it.
package memo_architecture_implementation {
    public import memo_architecture_implementation_hardware_common::*;
    public import memo_architecture_implementation_hardware_electrical::*;
    public import memo_architecture_implementation_hardware_fluidic::*;
    public import memo_architecture_implementation_hardware_mechanical::*;
    public import memo_architecture_implementation_hardware_optical::*;
    public import memo_architecture_implementation_hardware_sensing::*;
    public import memo_architecture_implementation_hardware_structure::*;
    public import memo_architecture_implementation_software_runtime::*;
    public import memo_architecture_implementation_software_structure::*;
    public import memo_architecture_implementation_ui::*;
}
