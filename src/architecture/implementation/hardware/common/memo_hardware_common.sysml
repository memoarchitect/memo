// Physical realization taxonomy (§12) — shared roots. "Physical" encompasses
// hardware, mechanical, fluidic, pneumatic, optical, acoustic, and thermal
// realization — not only electronics. Assemblies compose components; patient-
// contacting parts must declare contact characteristics (ISO 10993-1;
// rules/crosslayer). Technology-domain subgroups (electrical, mechanical,
// fluidic, optical, sensing) nest in sibling packages and specialize the roots
// declared here; acoustic and thermal parts have no dedicated subgroup and stay
// with the roots.
package memo_architecture_implementation_hardware_common {
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

    part def AcousticComponent specializes PhysicalComponent {
        attribute acousticFunction : String;
    }
    part def ThermalComponent specializes PhysicalComponent {
        attribute thermalFunction : String;
        attribute operatingRange : String;
    }
}
