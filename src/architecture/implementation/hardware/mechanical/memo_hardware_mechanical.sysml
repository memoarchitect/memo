// Mechanical realization subgroup (§12). Structural and housing parts
// specialize the physical roots in memo_architecture_hardware_common.
package memo_architecture_hardware_mechanical {
    private import ScalarValues::*;
    private import memo_architecture_hardware_common::*;

    part def MechanicalPart specializes PhysicalComponent {
        attribute mechanicalFunction : String;
    }
    part def Enclosure specializes MechanicalPart {
        attribute ingressProtection : String;
        attribute cleanability : String;
    }
}
