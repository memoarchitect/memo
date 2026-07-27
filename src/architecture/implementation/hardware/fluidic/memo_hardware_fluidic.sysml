// Fluidic / pneumatic realization subgroup (§12). Fluid- and gas-path parts
// specialize the physical roots in memo_architecture_implementation_hardware_common.
package memo_architecture_implementation_hardware_fluidic {
    private import ScalarValues::*;
    private import memo_architecture_implementation_hardware_common::*;

    part def FluidicComponent specializes PhysicalComponent {
        attribute fluidPathRole : String;
        attribute pressureRating : String;
    }
    part def PneumaticComponent specializes PhysicalComponent {
        attribute pneumaticRole : String;
    }
}
