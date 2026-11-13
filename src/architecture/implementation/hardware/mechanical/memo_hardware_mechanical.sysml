// Mechanical realization subgroup. Structural and housing parts specialize the
// physical roots in memo_architecture_implementation_hardware_common.
package memo_architecture_implementation_hardware_mechanical {
    private import ScalarValues::*;
    private import memo_core_common::MemoIdentity;
    private import memo_architecture_implementation_hardware_common::*;

    part def MechanicalPart specializes PhysicalComponent {
        @MemoIdentity { :>> label = "Mechanical part"; }
        attribute mechanicalFunction : String;
    }
    part def Enclosure specializes MechanicalPart {
        @MemoIdentity { :>> label = "Enclosure"; }
        attribute ingressProtection : String;
        attribute cleanability : String;
    }
}
