// Sensing / actuation realization subgroup (§12). Transducers that measure or
// act on the physical world specialize the physical roots in
// memo_architecture_implementation_hardware_common.
package memo_architecture_implementation_hardware_sensing {
    private import ScalarValues::*;
    private import memo_architecture_implementation_hardware_common::*;

    part def Sensor specializes PhysicalComponent {
        attribute measurand : String;
        attribute rangeSummary : String;
        attribute accuracySummary : String;
    }
    part def Actuator specializes PhysicalComponent {
        attribute actuationKind : String;
        attribute outputRange : String;
    }
}
