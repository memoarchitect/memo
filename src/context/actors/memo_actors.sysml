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
    part def User specializes Actor {
        attribute userPopulation : String;
        attribute impairmentConsiderations : String;
        attribute intendedTraining : String;
        attribute intendedQualification : String;
    }
    part def ClinicalUser specializes User {
        attribute clinicalRole : String;
    }
    part def PatientUser specializes User {
        attribute patientPopulation : String;
    }
    part def CaregiverUser specializes User {
        attribute layCaregiver : Boolean;
    }
    part def TechnicianUser specializes User {
        attribute serviceScope : String;
    }

    part def NonHumanActor specializes Actor;
    part def ExternalSystemActor specializes NonHumanActor {
        attribute systemKind : String;
    }
    part def ExternalDeviceActor specializes NonHumanActor {
        attribute deviceKind : String;
    }
    part def EnvironmentalAgent specializes NonHumanActor {
        attribute agentKind : String;
    }
}
