// Focused architecture example: a passive manual instrument (needle holder).
// It demonstrates physical decomposition and patient-contact declarations
// without adding functional, logical, or software layers.
package memo_examples_manual_surgical_instrument {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_implementation_hardware_structure::*;

    // ── Modeled product and physical structure ──────────────────
    part needleHolder : PhysicalAssembly {
        attribute :>> id = "MSI-DEV-001";
        attribute :>> name = "NeedleHolder";
        attribute :>> responsibility = "grasp and drive a suture needle";
    }
    part jawAssembly : MechanicalPart {
        attribute :>> id = "MSI-PART-001";
        attribute :>> name = "TungstenCarbideJaws";
        attribute :>> mechanicalFunction = "serrated needle grip";
        attribute :>> patientContact = true;
        attribute :>> contactNature = "intact tissue / surgical site, indirect";
        attribute :>> contactDuration = "limited (<24 h)";
    }
    part ratchetLock : MechanicalPart {
        attribute :>> id = "MSI-PART-002";
        attribute :>> name = "RatchetLock";
        attribute :>> mechanicalFunction = "maintains jaw clamping force without continuous grip";
        attribute :>> patientContact = false;
    }
    #refinement dependency needleHolder to jawAssembly;
    #refinement dependency needleHolder to ratchetLock;

    // A task may be traced to the architecture later when the project has a
    // specific allocation or interaction claim to make.
    action taskPlaceSutures : UserTask {
        attribute :>> id = "MSI-TASK-001";
        attribute :>> name = "PlaceSutures";
        attribute :>> taskGoal = "place interrupted sutures";
    }
}
