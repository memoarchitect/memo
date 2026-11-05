// Who holds the needs, and where they arise.
//
// Both were prose on the Need — `userPopulationReference = "ward nurses,
// including those wearing corrective lenses"` and an
// `operationalContextReference` sentence. A user's characteristics belong on
// the User, where IEC 62366-1's profile is already typed, and a need reaches
// its user through HeldBy.
package memo_examples_nested_architecture_dsm_architecture_operational_context {
    private import memo::*;
    private import ScalarValues::*;


    part usrWardNurse : User {
        @MemoIdentity { :>> providedId = "NDS-USR-001"; :>> label = "Ward nurse"; }
        attribute :>> userPopulation = "ward nurses";
        attribute :>> impairmentConsiderations = "some wear corrective lenses; display legibility at bedside distance";
        attribute :>> intendedTraining = "device orientation at ward induction";
        attribute :>> intendedQualification = "registered nurse";
        attribute :>> clinicalRole = "bedside therapy management";
    }

    part ctxIntraHospitalTransport : UseContext {
        @MemoIdentity { :>> providedId = "NDS-CTX-001"; :>> label = "Intra hospital transport"; }
        attribute :>> careSetting = "inpatient ward and transfer between wards";
        attribute :>> environment = "moving bed, up to four hours away from mains power";
        attribute :>> connectedUse = false;
    }
}
