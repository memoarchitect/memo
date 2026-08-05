// Cross-axis links: allocation and satisfaction.
//
// These are what make the two matrices show different things over the same
// model. The DSM reads allocation as a dependency between a function and the
// block that carries it; the traceability view reads satisfaction as coverage
// of a requirement. Keeping both in one file makes the cross-axis story easy
// to read, and easy to extend from the traceability view's editor.
package memo_examples_nested_architecture_dsm_traces {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_examples_nested_architecture_dsm_architecture_functional_functions::*;
    private import memo_examples_nested_architecture_dsm_architecture_logical_structure::*;
    private import memo_examples_nested_architecture_dsm_assurance_requirements::*;

    // ── Function → block allocation ──────────────────────────────
    connection allocDrive : AllocatedTo connect function ::> fnDriveActuator to allocatedElement ::> lcPumpMechanism;
    connection allocMeasure : AllocatedTo connect function ::> fnMeasureDelivered to allocatedElement ::> lcPumpMechanism;
    connection allocComputeRate : AllocatedTo connect function ::> fnComputeRate to allocatedElement ::> lcDoseController;
    connection allocValidate : AllocatedTo connect function ::> fnValidatePrescription to allocatedElement ::> lcDoseController;
    connection allocOcclusion : AllocatedTo connect function ::> fnDetectOcclusion to allocatedElement ::> lcOcclusionChannel;
    connection allocAirInLine : AllocatedTo connect function ::> fnDetectAirInLine to allocatedElement ::> lcOcclusionChannel;
    // Two channels carry the same protective function — the redundancy shows
    // up in the matrix as two marks on one row.
    connection allocLimitsWatchdog : AllocatedTo connect function ::> fnEnforceDoseLimits to allocatedElement ::> lcWatchdogChannel;
    connection allocLimitsPressure : AllocatedTo connect function ::> fnEnforceDoseLimits to allocatedElement ::> lcPressureIntegrityChannel;
    connection allocRender : AllocatedTo connect function ::> fnRenderStatus to allocatedElement ::> lcDisplayManager;
    connection allocAlarm : AllocatedTo connect function ::> fnAnnunciateAlarm to allocatedElement ::> lcAlarmAnnunciator;
    connection allocInput : AllocatedTo connect function ::> fnAcceptInput to allocatedElement ::> lcKeypadHandler;
    connection allocBattery : AllocatedTo connect function ::> fnMonitorBattery to allocatedElement ::> lcBatteryManager;
    connection allocPowerSource : AllocatedTo connect function ::> fnSelectPowerSource to allocatedElement ::> lcPowerRailMonitor;
    // A capability allocated at subsystem level rather than to one component:
    // collapsed, it lands in the same cell as its children's allocations.
    connection allocMeterFluid : AllocatedTo connect function ::> fnMeterFluid to allocatedElement ::> subFluidPath;

    // ── Requirement → function satisfaction ──────────────────────
    connection satDoseAccuracyRate : SatisfiedBy connect requiredElement ::> reqDoseAccuracy to satisfyingElement ::> fnComputeRate;
    connection satDoseAccuracyDrive : SatisfiedBy connect requiredElement ::> reqDoseAccuracy to satisfyingElement ::> fnDriveActuator;
    connection satOcclusion : SatisfiedBy connect requiredElement ::> reqOcclusionDetection to satisfyingElement ::> fnDetectOcclusion;
    connection satOcclusionLimits : SatisfiedBy connect requiredElement ::> reqOcclusionDetection to satisfyingElement ::> fnEnforceDoseLimits;
    connection satAirInLine : SatisfiedBy connect requiredElement ::> reqAirInLine to satisfyingElement ::> fnDetectAirInLine;
    connection satAirInLineAlarm : SatisfiedBy connect requiredElement ::> reqAirInLine to satisfyingElement ::> fnAnnunciateAlarm;
    connection satAlarm : SatisfiedBy connect requiredElement ::> reqAlarmAnnunciation to satisfyingElement ::> fnAnnunciateAlarm;
    connection satBatteryMonitor : SatisfiedBy connect requiredElement ::> reqBatteryEndurance to satisfyingElement ::> fnMonitorBattery;
    connection satBatterySource : SatisfiedBy connect requiredElement ::> reqBatteryEndurance to satisfyingElement ::> fnSelectPowerSource;
    connection satConfirmation : SatisfiedBy connect requiredElement ::> reqPrescriptionConfirmation to satisfyingElement ::> fnAcceptInput;
    connection satConfirmationValidate : SatisfiedBy connect requiredElement ::> reqPrescriptionConfirmation to satisfyingElement ::> fnValidatePrescription;
}
