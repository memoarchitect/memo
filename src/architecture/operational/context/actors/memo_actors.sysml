// Actor hierarchy (§4). An Actor interacts with the system; it is distinct
// from a Stakeholder (memo_context_stakeholders), who has concerns about the
// system but need not interact with it. "User" is reserved for a human who
// interacts with the medical device.
package memo_context_actors {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    abstract part def Actor specializes MemoPart {
        attribute actorKind : ActorKind;
        attribute trainingLevel : String;
        attribute responsibility : String;
    }

    // A human who interacts with the medical device (IEC 62366-1 intended user).
    // User is the only human actor type: do not add an alternative type name.
    // The human actor. The specific role is given by actorKind
    // (patient / clinician / caregiver / technician / administrator); the
    // role-specific fields below are set only for the relevant actorKind.
    part def User specializes Actor {
        attribute userPopulation : String;
        attribute impairmentConsiderations : String;
        attribute intendedTraining : String;
        attribute intendedQualification : String;
        attribute clinicalRole : String[0..1];
        attribute patientPopulation : String[0..1];
        attribute layCaregiver : Boolean[0..1];
        attribute serviceScope : String[0..1];
    }

    // A non-human actor (external system, external device, or environmental
    // agent). The specific kind is described by externalKind.
    part def NonHumanActor specializes Actor {
        attribute externalKind : String[0..1];
    }
}
