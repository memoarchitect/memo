// Functional architecture — the row axis of the DSM.
//
// Four capability trees, each decomposed with Composes, plus the functional
// exchanges between the leaves. The exchanges are deliberately not a clean
// pipeline: DriveActuator and MeasureDeliveredVolume feed each other, so a
// partitioned DSM still shows one genuine feedback mark instead of an empty
// lower triangle.
package memo_examples_nested_architecture_dsm_architecture_functional_functions {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_functional_functions::*;

    // ── Deliver therapy ──────────────────────────────────────────
    part fnDeliverTherapy : SystemFunction {
        attribute :>> id = "NDS-FN-001"; attribute :>> name = "DeliverTherapy";
        attribute :>> functionCategory = "therapy";
        attribute :>> criticality = CriticalityKind::catastrophic;
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> outputSummary = "fluid delivered to the patient line at the prescribed rate";
    }
    part fnMeterFluid : SystemFunction {
        attribute :>> id = "NDS-FN-002"; attribute :>> name = "MeterFluid";
        attribute :>> functionCategory = "therapy";
        attribute :>> criticality = CriticalityKind::catastrophic;
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> outputSummary = "measured volume displaced per control period";
    }
    part fnDriveActuator : SystemFunction {
        attribute :>> id = "NDS-FN-003"; attribute :>> name = "DriveActuator";
        attribute :>> functionCategory = "therapy";
        attribute :>> criticality = CriticalityKind::catastrophic;
        attribute :>> trigger = "rate command from the dose control loop";
        attribute :>> concernKind = ConcernKind::safety;
    }
    part fnMeasureDelivered : SystemFunction {
        attribute :>> id = "NDS-FN-004"; attribute :>> name = "MeasureDeliveredVolume";
        attribute :>> functionCategory = "therapy";
        attribute :>> criticality = CriticalityKind::high;
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> outputSummary = "cumulative delivered volume";
    }
    part fnControlDose : SystemFunction {
        attribute :>> id = "NDS-FN-005"; attribute :>> name = "ControlDose";
        attribute :>> functionCategory = "therapy";
        attribute :>> criticality = CriticalityKind::catastrophic;
        attribute :>> concernKind = ConcernKind::safety;
    }
    part fnComputeRate : SystemFunction {
        attribute :>> id = "NDS-FN-006"; attribute :>> name = "ComputeInfusionRate";
        attribute :>> functionCategory = "therapy";
        attribute :>> criticality = CriticalityKind::catastrophic;
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> outputSummary = "rate command, saturated at the prescribed ceiling";
    }
    part fnValidatePrescription : SystemFunction {
        attribute :>> id = "NDS-FN-007"; attribute :>> name = "ValidatePrescription";
        attribute :>> functionCategory = "therapy";
        attribute :>> criticality = CriticalityKind::high;
        attribute :>> concernKind = ConcernKind::clinical;
        attribute :>> outputSummary = "accepted or rejected prescription, with the reason";
    }
    connection : Composes connect parent ::> fnDeliverTherapy to child ::> fnMeterFluid;
    connection : Composes connect parent ::> fnDeliverTherapy to child ::> fnControlDose;
    connection : Composes connect parent ::> fnMeterFluid to child ::> fnDriveActuator;
    connection : Composes connect parent ::> fnMeterFluid to child ::> fnMeasureDelivered;
    connection : Composes connect parent ::> fnControlDose to child ::> fnComputeRate;
    connection : Composes connect parent ::> fnControlDose to child ::> fnValidatePrescription;

    // ── Ensure safety ────────────────────────────────────────────
    part fnEnsureSafety : SystemFunction {
        attribute :>> id = "NDS-FN-008"; attribute :>> name = "EnsureSafety";
        attribute :>> functionCategory = "protection";
        attribute :>> criticality = CriticalityKind::catastrophic;
        attribute :>> concernKind = ConcernKind::safety;
    }
    part fnDetectOcclusion : SystemFunction {
        attribute :>> id = "NDS-FN-009"; attribute :>> name = "DetectOcclusion";
        attribute :>> functionCategory = "protection";
        attribute :>> criticality = CriticalityKind::catastrophic;
        attribute :>> trigger = "line pressure above the occlusion threshold";
        attribute :>> concernKind = ConcernKind::safety;
    }
    part fnDetectAirInLine : SystemFunction {
        attribute :>> id = "NDS-FN-010"; attribute :>> name = "DetectAirInLine";
        attribute :>> functionCategory = "protection";
        attribute :>> criticality = CriticalityKind::catastrophic;
        attribute :>> trigger = "air bolus detected in the patient line";
        attribute :>> concernKind = ConcernKind::safety;
    }
    part fnEnforceDoseLimits : SystemFunction {
        attribute :>> id = "NDS-FN-011"; attribute :>> name = "EnforceDoseLimits";
        attribute :>> functionCategory = "protection";
        attribute :>> criticality = CriticalityKind::catastrophic;
        attribute :>> concernKind = ConcernKind::safety;
        attribute :>> outputSummary = "delivery stopped when the commanded dose leaves the accepted envelope";
    }
    connection : Composes connect parent ::> fnEnsureSafety to child ::> fnDetectOcclusion;
    connection : Composes connect parent ::> fnEnsureSafety to child ::> fnDetectAirInLine;
    connection : Composes connect parent ::> fnEnsureSafety to child ::> fnEnforceDoseLimits;

    // ── Inform the user ──────────────────────────────────────────
    part fnInformUser : SystemFunction {
        attribute :>> id = "NDS-FN-012"; attribute :>> name = "InformUser";
        attribute :>> functionCategory = "interaction";
        attribute :>> criticality = CriticalityKind::high;
        attribute :>> concernKind = ConcernKind::usability;
    }
    part fnRenderStatus : SystemFunction {
        attribute :>> id = "NDS-FN-013"; attribute :>> name = "RenderTherapyStatus";
        attribute :>> functionCategory = "interaction";
        attribute :>> criticality = CriticalityKind::high;
        attribute :>> concernKind = ConcernKind::usability;
        attribute :>> outputSummary = "rate, volume delivered and time remaining";
    }
    part fnAnnunciateAlarm : SystemFunction {
        attribute :>> id = "NDS-FN-014"; attribute :>> name = "AnnunciateAlarm";
        attribute :>> functionCategory = "interaction";
        attribute :>> criticality = CriticalityKind::catastrophic;
        attribute :>> trigger = "any active alarm condition";
        attribute :>> concernKind = ConcernKind::safety;
    }
    part fnAcceptInput : SystemFunction {
        attribute :>> id = "NDS-FN-015"; attribute :>> name = "AcceptClinicianInput";
        attribute :>> functionCategory = "interaction";
        attribute :>> criticality = CriticalityKind::high;
        attribute :>> concernKind = ConcernKind::usability;
        attribute :>> outputSummary = "confirmed prescription changes";
    }
    connection : Composes connect parent ::> fnInformUser to child ::> fnRenderStatus;
    connection : Composes connect parent ::> fnInformUser to child ::> fnAnnunciateAlarm;
    connection : Composes connect parent ::> fnInformUser to child ::> fnAcceptInput;

    // ── Manage power ─────────────────────────────────────────────
    part fnManagePower : SystemFunction {
        attribute :>> id = "NDS-FN-016"; attribute :>> name = "ManagePower";
        attribute :>> functionCategory = "platform";
        attribute :>> criticality = CriticalityKind::high;
        attribute :>> concernKind = ConcernKind::reliability;
    }
    part fnMonitorBattery : SystemFunction {
        attribute :>> id = "NDS-FN-017"; attribute :>> name = "MonitorBatteryState";
        attribute :>> functionCategory = "platform";
        attribute :>> criticality = CriticalityKind::high;
        attribute :>> concernKind = ConcernKind::reliability;
        attribute :>> outputSummary = "state of charge and remaining run time";
    }
    part fnSelectPowerSource : SystemFunction {
        attribute :>> id = "NDS-FN-018"; attribute :>> name = "SelectPowerSource";
        attribute :>> functionCategory = "platform";
        attribute :>> criticality = CriticalityKind::high;
        attribute :>> trigger = "mains loss or rail brownout";
        attribute :>> concernKind = ConcernKind::reliability;
    }
    connection : Composes connect parent ::> fnManagePower to child ::> fnMonitorBattery;
    connection : Composes connect parent ::> fnManagePower to child ::> fnSelectPowerSource;

    // ── Functional exchange ──────────────────────────────────────
    // Cross-tree marks are the interesting ones: they are what a collapsed DSM
    // rolls up into a single number between two capabilities.
    connection : ExchangesWith connect source ::> fnMeasureDelivered to target ::> fnComputeRate;
    connection : ExchangesWith connect source ::> fnComputeRate to target ::> fnDriveActuator;
    connection : ExchangesWith connect source ::> fnDriveActuator to target ::> fnMeasureDelivered;
    connection : ExchangesWith connect source ::> fnValidatePrescription to target ::> fnComputeRate;
    connection : ExchangesWith connect source ::> fnAcceptInput to target ::> fnValidatePrescription;
    connection : ExchangesWith connect source ::> fnDetectOcclusion to target ::> fnEnforceDoseLimits;
    connection : ExchangesWith connect source ::> fnDetectAirInLine to target ::> fnAnnunciateAlarm;
    connection : ExchangesWith connect source ::> fnEnforceDoseLimits to target ::> fnDriveActuator;
    connection : ExchangesWith connect source ::> fnMeasureDelivered to target ::> fnRenderStatus;
    connection : ExchangesWith connect source ::> fnMonitorBattery to target ::> fnAnnunciateAlarm;
    connection : ExchangesWith connect source ::> fnSelectPowerSource to target ::> fnDriveActuator;
    connection : ExchangesWith connect source ::> fnDetectOcclusion to target ::> fnAnnunciateAlarm;
}
