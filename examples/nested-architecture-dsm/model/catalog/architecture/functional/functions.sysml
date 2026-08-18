// Functional architecture — the row axis of the DSM.
//
// Four capability trees, each a native containment tree, plus the functional
// exchanges between the leaves. The exchanges are deliberately not a clean
// pipeline: DriveActuator and MeasureDeliveredVolume feed each other, so a
// partitioned DSM still shows one genuine feedback mark instead of an empty
// lower triangle.
package memo_examples_nested_architecture_dsm_architecture_functional_functions {
    private import memo_examples_nested_architecture_dsm_assurance_requirements::*;
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_operational_context_use_context::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    // ── Deliver therapy ──────────────────────────────────────────
    action fnDeliverTherapy : SystemFunction {
        @MemoIdentity { :>> providedId = "NDS-FN-001"; } attribute :>> name = "DeliverTherapy";
        attribute :>> functionCategory = "therapy";
        attribute :>> criticality = CriticalityKind::catastrophic;
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> outputSummary = "fluid delivered to the patient line at the prescribed rate";

        action fnMeterFluid : SystemFunction {
            @MemoIdentity { :>> providedId = "NDS-FN-002"; } attribute :>> name = "MeterFluid";
            attribute :>> functionCategory = "therapy";
            attribute :>> criticality = CriticalityKind::catastrophic;
            attribute :>> concernKind = ConcernKind::safety;
            attribute :>> outputSummary = "measured volume displaced per control period";

            action fnDriveActuator : SystemFunction {
                @MemoIdentity { :>> providedId = "NDS-FN-003"; } attribute :>> name = "DriveActuator";
                attribute :>> functionCategory = "therapy";
                attribute :>> criticality = CriticalityKind::catastrophic;
                attribute :>> trigger = "rate command from the dose control loop";
                attribute :>> concernKind = ConcernKind::safety;
            }
            action fnMeasureDelivered : SystemFunction {
                @MemoIdentity { :>> providedId = "NDS-FN-004"; } attribute :>> name = "MeasureDeliveredVolume";
                attribute :>> functionCategory = "therapy";
                attribute :>> criticality = CriticalityKind::high;
                attribute :>> concernKind = ConcernKind::safety;
                attribute :>> outputSummary = "cumulative delivered volume";
            }
        }
        action fnControlDose : SystemFunction {
            @MemoIdentity { :>> providedId = "NDS-FN-005"; } attribute :>> name = "ControlDose";
            attribute :>> functionCategory = "therapy";
            attribute :>> criticality = CriticalityKind::catastrophic;
            attribute :>> concernKind = ConcernKind::safety;

            action fnComputeRate : SystemFunction {
                @MemoIdentity { :>> providedId = "NDS-FN-006"; } attribute :>> name = "ComputeInfusionRate";
                attribute :>> functionCategory = "therapy";
                attribute :>> criticality = CriticalityKind::catastrophic;
                attribute :>> concernKind = ConcernKind::safety;
                attribute :>> outputSummary = "rate command, saturated at the prescribed ceiling";
            }
            action fnValidatePrescription : SystemFunction {
                @MemoIdentity { :>> providedId = "NDS-FN-007"; } attribute :>> name = "ValidatePrescription";
                attribute :>> functionCategory = "therapy";
                attribute :>> criticality = CriticalityKind::high;
                attribute :>> concernKind = ConcernKind::clinical;
                attribute :>> outputSummary = "accepted or rejected prescription, with the reason";
            }
        }
    }

    // ── Ensure safety ────────────────────────────────────────────
    action fnEnsureSafety : SystemFunction {
        @MemoIdentity { :>> providedId = "NDS-FN-008"; } attribute :>> name = "EnsureSafety";
        attribute :>> functionCategory = "protection";
        attribute :>> criticality = CriticalityKind::catastrophic;
        attribute :>> concernKind = ConcernKind::safety;

        action fnDetectOcclusion : SystemFunction {
            @MemoIdentity { :>> providedId = "NDS-FN-009"; } attribute :>> name = "DetectOcclusion";
            attribute :>> functionCategory = "protection";
            attribute :>> criticality = CriticalityKind::catastrophic;
            attribute :>> trigger = "line pressure above the occlusion threshold";
            attribute :>> concernKind = ConcernKind::safety;
        }
        action fnDetectAirInLine : SystemFunction {
            @MemoIdentity { :>> providedId = "NDS-FN-010"; } attribute :>> name = "DetectAirInLine";
            attribute :>> functionCategory = "protection";
            attribute :>> criticality = CriticalityKind::catastrophic;
            attribute :>> trigger = "air bolus detected in the patient line";
            attribute :>> concernKind = ConcernKind::safety;
        }
        action fnEnforceDoseLimits : SystemFunction {
            @MemoIdentity { :>> providedId = "NDS-FN-011"; } attribute :>> name = "EnforceDoseLimits";
            attribute :>> functionCategory = "protection";
            attribute :>> criticality = CriticalityKind::catastrophic;
            attribute :>> concernKind = ConcernKind::safety;
            attribute :>> outputSummary = "delivery stopped when the commanded dose leaves the accepted envelope";
        }
    }

    // ── Inform the user ──────────────────────────────────────────
    action fnInformUser : SystemFunction {
        @MemoIdentity { :>> providedId = "NDS-FN-012"; } attribute :>> name = "InformUser";
        attribute :>> functionCategory = "interaction";
        attribute :>> criticality = CriticalityKind::high;
        attribute :>> concernKind = ConcernKind::usability;

        action fnRenderStatus : SystemFunction {
            @MemoIdentity { :>> providedId = "NDS-FN-013"; } attribute :>> name = "RenderTherapyStatus";
            attribute :>> functionCategory = "interaction";
            attribute :>> criticality = CriticalityKind::high;
            attribute :>> concernKind = ConcernKind::usability;
            attribute :>> outputSummary = "rate, volume delivered and time remaining";
        }
        action fnAnnunciateAlarm : SystemFunction {
            @MemoIdentity { :>> providedId = "NDS-FN-014"; } attribute :>> name = "AnnunciateAlarm";
            attribute :>> functionCategory = "interaction";
            attribute :>> criticality = CriticalityKind::catastrophic;
            attribute :>> trigger = "any active alarm condition";
            attribute :>> concernKind = ConcernKind::safety;
        }
        action fnAcceptInput : SystemFunction {
            @MemoIdentity { :>> providedId = "NDS-FN-015"; } attribute :>> name = "AcceptClinicianInput";
            attribute :>> functionCategory = "interaction";
            attribute :>> criticality = CriticalityKind::high;
            attribute :>> concernKind = ConcernKind::usability;
            attribute :>> outputSummary = "confirmed prescription changes";
        }
    }

    // ── Manage power ─────────────────────────────────────────────
    action fnManagePower : SystemFunction {
        @MemoIdentity { :>> providedId = "NDS-FN-016"; } attribute :>> name = "ManagePower";
        attribute :>> functionCategory = "platform";
        attribute :>> criticality = CriticalityKind::high;
        attribute :>> concernKind = ConcernKind::reliability;

        action fnMonitorBattery : SystemFunction {
            @MemoIdentity { :>> providedId = "NDS-FN-017"; } attribute :>> name = "MonitorBatteryState";
            attribute :>> functionCategory = "platform";
            attribute :>> criticality = CriticalityKind::high;
            attribute :>> concernKind = ConcernKind::reliability;
            attribute :>> outputSummary = "state of charge and remaining run time";
        }
        action fnSelectPowerSource : SystemFunction {
            @MemoIdentity { :>> providedId = "NDS-FN-018"; } attribute :>> name = "SelectPowerSource";
            attribute :>> functionCategory = "platform";
            attribute :>> criticality = CriticalityKind::high;
            attribute :>> trigger = "mains loss or rail brownout";
            attribute :>> concernKind = ConcernKind::reliability;
        }
    }

    // ── Functional exchange ──────────────────────────────────────
    // Cross-tree marks are the interesting ones: they are what a collapsed DSM
    // rolls up into a single number between two capabilities.
    flow from fnDeliverTherapy.fnMeterFluid.fnMeasureDelivered to fnDeliverTherapy.fnControlDose.fnComputeRate;
    flow from fnDeliverTherapy.fnControlDose.fnComputeRate to fnDeliverTherapy.fnMeterFluid.fnDriveActuator;
    flow from fnDeliverTherapy.fnMeterFluid.fnDriveActuator to fnDeliverTherapy.fnMeterFluid.fnMeasureDelivered;
    flow from fnDeliverTherapy.fnControlDose.fnValidatePrescription to fnDeliverTherapy.fnControlDose.fnComputeRate;
    flow from fnInformUser.fnAcceptInput to fnDeliverTherapy.fnControlDose.fnValidatePrescription;
    flow from fnEnsureSafety.fnDetectOcclusion to fnEnsureSafety.fnEnforceDoseLimits;
    flow from fnEnsureSafety.fnDetectAirInLine to fnInformUser.fnAnnunciateAlarm;
    flow from fnEnsureSafety.fnEnforceDoseLimits to fnDeliverTherapy.fnMeterFluid.fnDriveActuator;
    flow from fnDeliverTherapy.fnMeterFluid.fnMeasureDelivered to fnInformUser.fnRenderStatus;
    flow from fnManagePower.fnMonitorBattery to fnInformUser.fnAnnunciateAlarm;
    flow from fnManagePower.fnSelectPowerSource to fnDeliverTherapy.fnMeterFluid.fnDriveActuator;
    flow from fnEnsureSafety.fnDetectOcclusion to fnInformUser.fnAnnunciateAlarm;
    satisfy reqDoseAccuracy by fnDeliverTherapy.fnControlDose.fnComputeRate;
    satisfy reqDoseAccuracy by fnDeliverTherapy.fnMeterFluid.fnDriveActuator;
    satisfy reqOcclusionDetection by fnEnsureSafety.fnDetectOcclusion;
    satisfy reqOcclusionDetection by fnEnsureSafety.fnEnforceDoseLimits;
    satisfy reqAirInLine by fnEnsureSafety.fnDetectAirInLine;
    satisfy reqAirInLine by fnInformUser.fnAnnunciateAlarm;
    satisfy reqAlarmAnnunciation by fnInformUser.fnAnnunciateAlarm;
    satisfy reqBatteryEndurance by fnManagePower.fnMonitorBattery;
    satisfy reqBatteryEndurance by fnManagePower.fnSelectPowerSource;
    satisfy reqPrescriptionConfirmation by fnInformUser.fnAcceptInput;
    satisfy reqPrescriptionConfirmation by fnDeliverTherapy.fnControlDose.fnValidatePrescription;
}
