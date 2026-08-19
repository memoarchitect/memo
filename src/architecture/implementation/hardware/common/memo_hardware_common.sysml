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

    // The shared root of the physical family.
    //
    // `PhysicalAssembly` and `PhysicalComponent` each specialized `MemoPart`
    // directly, so the family had two roots and no single type that means
    // "a physical thing". A containment rule has to name one type, and
    // `conformsTo(MemoPart)` is far too wide — it admits a requirement or a
    // hazard. This is that type, and it carries nothing of its own: the split
    // between an assembly and a component is what the two subtypes are for.
    abstract part def PhysicalElement specializes MemoPart { }

    part def PhysicalAssembly specializes PhysicalElement {
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

    part def PhysicalComponent specializes PhysicalElement {
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
