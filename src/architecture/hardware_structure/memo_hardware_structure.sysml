// Physical realization taxonomy (§12). "Physical" encompasses hardware,
// mechanical, fluidic, pneumatic, optical, acoustic, and thermal realization —
// not only electronics. Assemblies compose components; patient-contacting
// parts must declare contact characteristics (ISO 10993-1; rules/crosslayer).
package memo_architecture_hardware_structure {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;

    part def PhysicalAssembly specializes ArchitectureElement {
        attribute responsibility : String;
        attribute safetyRole : String;
        attribute partNumber : String;
        attribute mtbfHours : String;
        attribute protectionClass : String;
        attribute ipRating : String;
    }
    part def PhysicalSubassembly specializes PhysicalAssembly;
    // Retained name from 0.4; an electronics-centred assembly.
    part def HardwareAssembly specializes PhysicalAssembly;

    part def PhysicalComponent specializes ArchitectureElement {
        attribute partNumber : String;
        attribute materialSummary : String;
        // ISO 10993-1 contact characterization; required when true.
        attribute patientContact : Boolean;
        attribute contactNature : String;
        attribute contactDuration : String;
    }

    part def HardwareComponent specializes PhysicalComponent;
    part def MechanicalPart specializes PhysicalComponent {
        attribute mechanicalFunction : String;
    }
    part def ElectricalComponent specializes PhysicalComponent {
        attribute ratedVoltageV : String;
        attribute ratedCurrentA : String;
    }
    part def ElectronicComponent specializes PhysicalComponent {
        attribute componentFamily : String;
    }
    part def Sensor specializes PhysicalComponent {
        attribute measurand : String;
        attribute rangeSummary : String;
        attribute accuracySummary : String;
    }
    part def Actuator specializes PhysicalComponent {
        attribute actuationKind : String;
        attribute outputRange : String;
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
    part def Enclosure specializes MechanicalPart {
        attribute ingressProtection : String;
        attribute cleanability : String;
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
    part def FluidicComponent specializes PhysicalComponent {
        attribute fluidPathRole : String;
        attribute pressureRating : String;
    }
    part def PneumaticComponent specializes PhysicalComponent {
        attribute pneumaticRole : String;
    }
    part def OpticalComponent specializes PhysicalComponent {
        attribute opticalFunction : String;
        attribute wavelengthRange : String;
    }
    part def AcousticComponent specializes PhysicalComponent {
        attribute acousticFunction : String;
    }
    part def ThermalComponent specializes PhysicalComponent {
        attribute thermalFunction : String;
        attribute operatingRange : String;
    }

    connection def AssemblyComprises :> MemoRelationship {
        end assembly : PhysicalAssembly;
        end component : PhysicalComponent;
    }
    connection def PhysicalRealizesLogical :> MemoRelationship {
        end physicalElement : ArchitectureElement;
        end logicalElement : ArchitectureElement;
    }
}
