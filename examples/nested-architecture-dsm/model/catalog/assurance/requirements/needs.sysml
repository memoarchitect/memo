// Stakeholder needs — the outermost row of a full trace chain.
//
// Need → Requirement → Function → VerificationCase is the chain the
// traceability view is meant to walk one hop at a time.
package memo_examples_nested_architecture_dsm_assurance_requirements_needs {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_examples_nested_architecture_dsm_assurance_requirements::*;
    private import memo_examples_nested_architecture_dsm_architecture_operational_context::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    requirement needAccurateTherapy : Need {
        @MemoIdentity { :>> providedId = "NDS-NEED-001"; } attribute :>> name = "AccurateTherapyDelivery";
        attribute :>> needKind = NeedKind::'stakeholder';
        attribute :>> statement = "Clinicians need the delivered dose to match the prescription closely enough to be clinically safe.";
        attribute :>> priority = "high";
    }
    requirement needProtectionFromHarm : Need {
        @MemoIdentity { :>> providedId = "NDS-NEED-002"; } attribute :>> name = "ProtectionFromDeliveryFaults";
        attribute :>> needKind = NeedKind::'stakeholder';
        attribute :>> statement = "Patients need delivery to stop before a line fault or air bolus reaches them.";
        attribute :>> priority = "high";
    }
    requirement needUninterruptedTherapy : Need {
        @MemoIdentity { :>> providedId = "NDS-NEED-003"; } attribute :>> name = "UninterruptedTherapy";
        attribute :>> needKind = NeedKind::operational;
        attribute :>> statement = "Wards need therapy to continue through transport and mains interruptions.";
        attribute :>> priority = "medium";
        ref :>> useContext = ctxIntraHospitalTransport;
    }
    requirement needLegibleStatus : Need {
        @MemoIdentity { :>> providedId = "NDS-NEED-004"; } attribute :>> name = "LegibleTherapyStatus";
        attribute :>> needKind = NeedKind::'stakeholder';
        attribute :>> statement = "Clinicians need to read therapy state and alarms correctly from the bedside.";
        attribute :>> priority = "high";
    }

    // Need → Requirement.
    connection derAccuracy : DerivesFrom connect sourceDriver ::> needAccurateTherapy to targetRequirement ::> reqDoseAccuracy;
    connection derOcclusion : DerivesFrom connect sourceDriver ::> needProtectionFromHarm to targetRequirement ::> reqOcclusionDetection;
    connection derAirInLine : DerivesFrom connect sourceDriver ::> needProtectionFromHarm to targetRequirement ::> reqAirInLine;
    connection derAlarm : DerivesFrom connect sourceDriver ::> needLegibleStatus to targetRequirement ::> reqAlarmAnnunciation;
    connection derBattery : DerivesFrom connect sourceDriver ::> needUninterruptedTherapy to targetRequirement ::> reqBatteryEndurance;
    connection derConfirmation : DerivesFrom connect sourceDriver ::> needLegibleStatus to targetRequirement ::> reqPrescriptionConfirmation;
    connection derStatus : DerivesFrom connect sourceDriver ::> needLegibleStatus to targetRequirement ::> reqStatusVisibility;

    // Software requirements derive from the system requirement they refine
    // (IEC 62304), which is a second, requirement-to-requirement trace axis.
    connection derAlarmFromSystem : DerivesFrom connect sourceDriver ::> reqOcclusionDetection to targetRequirement ::> reqAlarmAnnunciation;
    connection derConfirmationFromSystem : DerivesFrom connect sourceDriver ::> reqDoseAccuracy to targetRequirement ::> reqPrescriptionConfirmation;
    // Whose need this is. The nurse's characteristics are on the User.
    connection heldLegible : HeldBy connect need ::> needLegibleStatus to holder ::> usrWardNurse;
    connection heldAccurate : HeldBy connect need ::> needAccurateTherapy to holder ::> usrWardNurse;
}
