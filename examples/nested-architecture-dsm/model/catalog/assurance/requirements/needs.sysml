// Stakeholder needs — the outermost row of a full trace chain.
//
// Need → Requirement → Function → VerificationCase is the chain the
// traceability view is meant to walk one hop at a time.
package memo_examples_nested_architecture_dsm_assurance_requirements_needs {
    private import memo::*;
    private import ScalarValues::*;

    private import memo_examples_nested_architecture_dsm_assurance_requirements::*;
    private import memo_examples_nested_architecture_dsm_architecture_operational_context::*;

    requirement needAccurateTherapy : Need {
        @MemoIdentity { :>> providedId = "NDS-NEED-001"; :>> label = "Accurate therapy delivery"; }
        attribute :>> needKind = NeedKind::'stakeholder';
        doc /* Clinicians need the delivered dose to match the prescription closely enough to be clinically safe. */
        attribute :>> priority = "high";
    }
    requirement needProtectionFromHarm : Need {
        @MemoIdentity { :>> providedId = "NDS-NEED-002"; :>> label = "Protection from delivery faults"; }
        attribute :>> needKind = NeedKind::'stakeholder';
        doc /* Patients need delivery to stop before a line fault or air bolus reaches them. */
        attribute :>> priority = "high";
    }
    requirement needUninterruptedTherapy : Need {
        @MemoIdentity { :>> providedId = "NDS-NEED-003"; :>> label = "Uninterrupted therapy"; }
        attribute :>> needKind = NeedKind::operational;
        doc /* Wards need therapy to continue through transport and mains interruptions. */
        attribute :>> priority = "medium";
        ref :>> useContext = ctxIntraHospitalTransport;
    }
    requirement needLegibleStatus : Need {
        @MemoIdentity { :>> providedId = "NDS-NEED-004"; :>> label = "Legible therapy status"; }
        attribute :>> needKind = NeedKind::'stakeholder';
        doc /* Clinicians need to read therapy state and alarms correctly from the bedside. */
        attribute :>> priority = "high";
    }

    // Need → Requirement.
    connection derAccuracy : DerivesFrom connect needAccurateTherapy to reqDoseAccuracy;
    connection derOcclusion : DerivesFrom connect needProtectionFromHarm to reqOcclusionDetection;
    connection derAirInLine : DerivesFrom connect needProtectionFromHarm to reqAirInLine;
    connection derAlarm : DerivesFrom connect needLegibleStatus to reqAlarmAnnunciation;
    connection derBattery : DerivesFrom connect needUninterruptedTherapy to reqBatteryEndurance;
    connection derConfirmation : DerivesFrom connect needLegibleStatus to reqPrescriptionConfirmation;
    connection derStatus : DerivesFrom connect needLegibleStatus to reqStatusVisibility;

    // Software requirements derive from the system requirement they refine
    // (IEC 62304), which is a second, requirement-to-requirement trace axis.
    connection derAlarmFromSystem : DerivesFrom connect reqOcclusionDetection to reqAlarmAnnunciation;
    connection derConfirmationFromSystem : DerivesFrom connect reqDoseAccuracy to reqPrescriptionConfirmation;
    // Whose need this is. The nurse's characteristics are on the User.
    connection heldLegible : HeldBy connect needLegibleStatus to usrWardNurse;
    connection heldAccurate : HeldBy connect needAccurateTherapy to usrWardNurse;
}
