// Electrical / electronic realization subgroup (§12). Electrical power and
// signal parts, plus cabling and connectivity media, specialize the physical
// roots in memo_architecture_implementation_hardware_common.
package memo_architecture_implementation_hardware_electrical {
    private import ScalarValues::*;
    private import memo_architecture_implementation_hardware_common::*;

    part def ElectricalComponent specializes PhysicalComponent {
        attribute ratedVoltageV : String;
        attribute ratedCurrentA : String;
    }
    part def ElectronicComponent specializes PhysicalComponent {
        attribute componentFamily : String;
    }
    part def PowerSupply specializes ElectricalComponent {
        attribute inputRange : String;
        attribute outputRails : String;
    }
    part def Battery specializes ElectricalComponent {
        attribute chemistry : String;
        attribute capacity : String;
        attribute rechargeable : Boolean;
    }
    part def Cable specializes PhysicalComponent {
        attribute conductorCount : String;
        attribute shielding : String;
    }
    part def PhysicalConnectorPart specializes PhysicalComponent {
        attribute connectorStandard : String;
        attribute matingCycles : String;
    }
    part def NetworkMedium specializes PhysicalComponent {
        attribute mediumKind : String;
        attribute bandwidthSummary : String;
    }
}
