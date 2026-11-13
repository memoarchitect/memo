// Optical realization subgroup. Light-path parts specialize the physical roots
// in memo_architecture_implementation_hardware_common.
package memo_architecture_implementation_hardware_optical {
    private import ScalarValues::*;
    private import memo_core_common::MemoIdentity;
    private import memo_architecture_implementation_hardware_common::*;

    part def OpticalComponent specializes PhysicalComponent {
        @MemoIdentity { :>> label = "Optical component"; }
        attribute opticalFunction : String;
        attribute wavelengthRange : String;
    }
}
