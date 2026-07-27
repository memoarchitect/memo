// Optical realization subgroup (§12). Light-path parts specialize the physical
// roots in memo_architecture_implementation_hardware_common.
package memo_architecture_implementation_hardware_optical {
    private import ScalarValues::*;
    private import memo_architecture_implementation_hardware_common::*;

    part def OpticalComponent specializes PhysicalComponent {
        attribute opticalFunction : String;
        attribute wavelengthRange : String;
    }
}
