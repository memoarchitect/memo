// Verification cases — the far end of the trace chain, and a third axis for
// the traceability matrix (function → verification case).
package memo_examples_nested_architecture_dsm_assurance_verification_validation {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_assurance_verification_validation::*;
    private import memo_examples_nested_architecture_dsm_architecture_functional_functions::*;
    private import memo_examples_nested_architecture_dsm_assurance_requirements::*;

    verification vcDoseAccuracy : VerificationCase {
        attribute :>> id = "NDS-VER-001"; attribute :>> name = "VerifyDoseAccuracy";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Gravimetric delivery over 60 minutes is within ±5% of the prescribed volume at 1, 25 and 999 mL/h.";
        attribute :>> status = "planned";
    }
    verification vcOcclusionResponse : VerificationCase {
        attribute :>> id = "NDS-VER-002"; attribute :>> name = "VerifyOcclusionResponse";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Delivery stops within 2 s of the occlusion threshold being crossed, at every supported rate.";
        attribute :>> status = "planned";
    }
    verification vcAirInLineResponse : VerificationCase {
        attribute :>> id = "NDS-VER-003"; attribute :>> name = "VerifyAirInLineResponse";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "A 0.1 mL air bolus stops delivery and raises a high-priority alarm.";
        attribute :>> status = "planned";
    }
    verification vcAlarmSignals : VerificationCase {
        attribute :>> id = "NDS-VER-004"; attribute :>> name = "VerifyAlarmSignals";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Alarm signals conform to IEC 60601-1-8 for every priority, and persist until cleared or acknowledged.";
        attribute :>> status = "planned";
    }
    verification vcBatteryEndurance : VerificationCase {
        attribute :>> id = "NDS-VER-005"; attribute :>> name = "VerifyBatteryEndurance";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Delivery continues for at least 4 hours at 25 mL/h from a fully charged battery after mains loss.";
        attribute :>> status = "planned";
    }
    verification vcConfirmationFlow : VerificationCase {
        attribute :>> id = "NDS-VER-006"; attribute :>> name = "VerifyConfirmationFlow";
        attribute :>> methodKind = VerificationMethodKind::demonstration;
        attribute :>> acceptanceCriteria = "No rate change reaches the controller without an explicit confirmation step.";
        attribute :>> status = "planned";
    }
    verification vcStatusLegibility : VerificationCase {
        attribute :>> id = "NDS-VER-007"; attribute :>> name = "VerifyStatusLegibility";
        attribute :>> methodKind = VerificationMethodKind::inspection;
        attribute :>> acceptanceCriteria = "Rate and volume delivered are readable at 1 m under 100–1000 lux.";
        attribute :>> status = "planned";
    }
    verification vcPowerSourceSwitch : VerificationCase {
        attribute :>> id = "NDS-VER-008"; attribute :>> name = "VerifyPowerSourceSwitch";
        attribute :>> methodKind = VerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Rail brownout switches source without interrupting delivery.";
        attribute :>> status = "planned";
    }

    // Requirement → verification case.
    connection verDoseAccuracy : VerifiedBy connect verificationTarget ::> reqDoseAccuracy to verificationCase ::> vcDoseAccuracy;
    connection verOcclusion : VerifiedBy connect verificationTarget ::> reqOcclusionDetection to verificationCase ::> vcOcclusionResponse;
    connection verAirInLine : VerifiedBy connect verificationTarget ::> reqAirInLine to verificationCase ::> vcAirInLineResponse;
    connection verAlarm : VerifiedBy connect verificationTarget ::> reqAlarmAnnunciation to verificationCase ::> vcAlarmSignals;
    connection verBattery : VerifiedBy connect verificationTarget ::> reqBatteryEndurance to verificationCase ::> vcBatteryEndurance;
    connection verConfirmation : VerifiedBy connect verificationTarget ::> reqPrescriptionConfirmation to verificationCase ::> vcConfirmationFlow;
    connection verStatus : VerifiedBy connect verificationTarget ::> reqStatusVisibility to verificationCase ::> vcStatusLegibility;

    // Function → verification case, so safety-critical functions carry their
    // own verification rather than inheriting it through a requirement.
    connection verFnDeliverTherapy : VerifiedBy connect verificationTarget ::> fnDeliverTherapy to verificationCase ::> vcDoseAccuracy;
    connection verFnMeterFluid : VerifiedBy connect verificationTarget ::> fnMeterFluid to verificationCase ::> vcDoseAccuracy;
    connection verFnDriveActuator : VerifiedBy connect verificationTarget ::> fnDriveActuator to verificationCase ::> vcDoseAccuracy;
    connection verFnMeasureDelivered : VerifiedBy connect verificationTarget ::> fnMeasureDelivered to verificationCase ::> vcDoseAccuracy;
    connection verFnControlDose : VerifiedBy connect verificationTarget ::> fnControlDose to verificationCase ::> vcDoseAccuracy;
    connection verFnComputeRate : VerifiedBy connect verificationTarget ::> fnComputeRate to verificationCase ::> vcDoseAccuracy;
    connection verFnValidatePrescription : VerifiedBy connect verificationTarget ::> fnValidatePrescription to verificationCase ::> vcConfirmationFlow;
    connection verFnEnsureSafety : VerifiedBy connect verificationTarget ::> fnEnsureSafety to verificationCase ::> vcOcclusionResponse;
    connection verFnDetectOcclusion : VerifiedBy connect verificationTarget ::> fnDetectOcclusion to verificationCase ::> vcOcclusionResponse;
    connection verFnDetectAirInLine : VerifiedBy connect verificationTarget ::> fnDetectAirInLine to verificationCase ::> vcAirInLineResponse;
    connection verFnEnforceDoseLimits : VerifiedBy connect verificationTarget ::> fnEnforceDoseLimits to verificationCase ::> vcOcclusionResponse;
    connection verFnInformUser : VerifiedBy connect verificationTarget ::> fnInformUser to verificationCase ::> vcStatusLegibility;
    connection verFnRenderStatus : VerifiedBy connect verificationTarget ::> fnRenderStatus to verificationCase ::> vcStatusLegibility;
    connection verFnAnnunciateAlarm : VerifiedBy connect verificationTarget ::> fnAnnunciateAlarm to verificationCase ::> vcAlarmSignals;
    connection verFnAcceptInput : VerifiedBy connect verificationTarget ::> fnAcceptInput to verificationCase ::> vcConfirmationFlow;
    connection verFnManagePower : VerifiedBy connect verificationTarget ::> fnManagePower to verificationCase ::> vcBatteryEndurance;
    connection verFnMonitorBattery : VerifiedBy connect verificationTarget ::> fnMonitorBattery to verificationCase ::> vcBatteryEndurance;
    connection verFnSelectPowerSource : VerifiedBy connect verificationTarget ::> fnSelectPowerSource to verificationCase ::> vcPowerSourceSwitch;
}
