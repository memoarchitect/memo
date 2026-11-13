// Electrical / electronic realization subgroup. Electrical power and signal
// parts, plus cabling and connectivity media, specialize the physical roots in
// memo_architecture_implementation_hardware_common.
package memo_architecture_implementation_hardware_electrical {
    private import ScalarValues::*;
    private import memo_core_common::MemoIdentity;
    private import memo_architecture_implementation_hardware_common::*;

    part def ElectricalComponent specializes PhysicalComponent {
        @MemoIdentity { :>> label = "Electrical component"; }
        attribute ratedVoltageV : String;
        attribute ratedCurrentA : String;
    }
    part def ElectronicComponent specializes PhysicalComponent {
        @MemoIdentity { :>> label = "Electronic component"; }
        attribute componentFamily : String;
    }
    part def PowerSupply specializes ElectricalComponent {
        @MemoIdentity { :>> label = "Power supply"; }
        attribute inputRange : String;
        attribute outputRails : String;
    }
    part def Battery specializes ElectricalComponent {
        @MemoIdentity { :>> label = "Battery"; }
        attribute chemistry : String;
        attribute capacity : String;
        attribute rechargeable : Boolean;
    }
    part def Cable specializes PhysicalComponent {
        @MemoIdentity { :>> label = "Cable"; }
        attribute conductorCount : String;
        attribute shielding : String;
    }
    part def PhysicalConnectorPart specializes PhysicalComponent {
        @MemoIdentity { :>> label = "Physical connector part"; }
        attribute connectorStandard : String;
        attribute matingCycles : String;
    }
    part def NetworkMedium specializes PhysicalComponent {
        @MemoIdentity { :>> label = "Network medium"; }
        attribute mediumKind : String;
        attribute bandwidthSummary : String;
    }
}
