// Verification cases — the far end of the trace chain, and a third axis for
// the traceability matrix (function → verification case).
package memo_examples_nested_architecture_dsm_assurance_verification_validation {
    private import ScalarValues::*;
    private import memo_core_dimensions::*;   // ElementStatusKind

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_assurance_verification_validation::*;
    private import memo_examples_nested_architecture_dsm_architecture_functional_functions::*;
    private import memo_examples_nested_architecture_dsm_assurance_requirements::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    verification vcDoseAccuracy : VerificationCase {
        @MemoIdentity { :>> providedId = "NDS-VER-001"; } attribute :>> name = "VerifyDoseAccuracy";
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Gravimetric delivery over 60 minutes is within ±5% of the prescribed volume at 1, 25 and 999 mL/h.";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqDoseAccuracy; }
        subject verified : Base::Anything[*] = (fnDeliverTherapy, fnDeliverTherapy.fnMeterFluid, fnDeliverTherapy.fnMeterFluid.fnDriveActuator, fnDeliverTherapy.fnMeterFluid.fnMeasureDelivered, fnDeliverTherapy.fnControlDose, fnDeliverTherapy.fnControlDose.fnComputeRate);
    }
    verification vcOcclusionResponse : VerificationCase {
        @MemoIdentity { :>> providedId = "NDS-VER-002"; } attribute :>> name = "VerifyOcclusionResponse";
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Delivery stops within 2 s of the occlusion threshold being crossed, at every supported rate.";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqOcclusionDetection; }
        subject verified : Base::Anything[*] = (fnEnsureSafety, fnEnsureSafety.fnDetectOcclusion, fnEnsureSafety.fnEnforceDoseLimits);
    }
    verification vcAirInLineResponse : VerificationCase {
        @MemoIdentity { :>> providedId = "NDS-VER-003"; } attribute :>> name = "VerifyAirInLineResponse";
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "A 0.1 mL air bolus stops delivery and raises a high-priority alarm.";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqAirInLine; }
        subject verified : Base::Anything[*] = (fnEnsureSafety.fnDetectAirInLine);
    }
    verification vcAlarmSignals : VerificationCase {
        @MemoIdentity { :>> providedId = "NDS-VER-004"; } attribute :>> name = "VerifyAlarmSignals";
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Alarm signals conform to IEC 60601-1-8 for every priority, and persist until cleared or acknowledged.";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqAlarmAnnunciation; }
        subject verified : Base::Anything[*] = (fnInformUser.fnAnnunciateAlarm);
    }
    verification vcBatteryEndurance : VerificationCase {
        @MemoIdentity { :>> providedId = "NDS-VER-005"; } attribute :>> name = "VerifyBatteryEndurance";
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Delivery continues for at least 4 hours at 25 mL/h from a fully charged battery after mains loss.";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqBatteryEndurance; }
        subject verified : Base::Anything[*] = (fnManagePower, fnManagePower.fnMonitorBattery);
    }
    verification vcConfirmationFlow : VerificationCase {
        @MemoIdentity { :>> providedId = "NDS-VER-006"; } attribute :>> name = "VerifyConfirmationFlow";
        attribute :>> methodKind = MemoVerificationMethodKind::demonstration;
        attribute :>> acceptanceCriteria = "No rate change reaches the controller without an explicit confirmation step.";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqPrescriptionConfirmation; }
        subject verified : Base::Anything[*] = (fnDeliverTherapy.fnControlDose.fnValidatePrescription, fnInformUser.fnAcceptInput);
    }
    verification vcStatusLegibility : VerificationCase {
        @MemoIdentity { :>> providedId = "NDS-VER-007"; } attribute :>> name = "VerifyStatusLegibility";
        attribute :>> methodKind = MemoVerificationMethodKind::inspection;
        attribute :>> acceptanceCriteria = "Rate and volume delivered are readable at 1 m under 100–1000 lux.";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqStatusVisibility; }
        subject verified : Base::Anything[*] = (fnInformUser, fnInformUser.fnRenderStatus);
    }
    verification vcPowerSourceSwitch : VerificationCase {
        @MemoIdentity { :>> providedId = "NDS-VER-008"; } attribute :>> name = "VerifyPowerSourceSwitch";
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Rail brownout switches source without interrupting delivery.";
        attribute :>> status = ElementStatusKind::approved;

        subject verified : Base::Anything[*] = (fnManagePower.fnSelectPowerSource);
    }

    // Requirement → verification case.







    // Function → verification case, so safety-critical functions carry their
    // own verification rather than inheriting it through a requirement.


















}
