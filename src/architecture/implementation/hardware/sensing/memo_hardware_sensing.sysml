// Sensing / actuation realization subgroup. Transducers that measure or act on
// the physical world specialize the physical roots in
// memo_architecture_implementation_hardware_common.
package memo_architecture_implementation_hardware_sensing {
    private import ScalarValues::*;
    private import memo_core_common::MemoIdentity;
    private import memo_architecture_implementation_hardware_common::*;

    part def Sensor specializes PhysicalComponent {
        @MemoIdentity { :>> label = "Sensor"; }
        attribute measurand : String;
        attribute rangeSummary : String;
        attribute accuracySummary : String;
    }
    part def Actuator specializes PhysicalComponent {
        @MemoIdentity { :>> label = "Actuator"; }
        attribute actuationKind : String;
        attribute outputRange : String;
    }
}
