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
    allocation allocDrive : AllocatedTo allocate fnDriveActuator to lcPumpMechanism;
    allocation allocMeasure : AllocatedTo allocate fnMeasureDelivered to lcPumpMechanism;
    allocation allocComputeRate : AllocatedTo allocate fnComputeRate to lcDoseController;
    allocation allocValidate : AllocatedTo allocate fnValidatePrescription to lcDoseController;
    allocation allocOcclusion : AllocatedTo allocate fnDetectOcclusion to lcOcclusionChannel;
    allocation allocAirInLine : AllocatedTo allocate fnDetectAirInLine to lcOcclusionChannel;
    // Two channels carry the same protective function — the redundancy shows
    // up in the matrix as two marks on one row.
    allocation allocLimitsWatchdog : AllocatedTo allocate fnEnforceDoseLimits to lcWatchdogChannel;
    allocation allocLimitsPressure : AllocatedTo allocate fnEnforceDoseLimits to lcPressureIntegrityChannel;
    allocation allocRender : AllocatedTo allocate fnRenderStatus to lcDisplayManager;
    allocation allocAlarm : AllocatedTo allocate fnAnnunciateAlarm to lcAlarmAnnunciator;
    allocation allocInput : AllocatedTo allocate fnAcceptInput to lcKeypadHandler;
    allocation allocBattery : AllocatedTo allocate fnMonitorBattery to lcBatteryManager;
    allocation allocPowerSource : AllocatedTo allocate fnSelectPowerSource to lcPowerRailMonitor;
    // A capability allocated at subsystem level rather than to one component:
    // collapsed, it lands in the same cell as its children's allocations.
    allocation allocMeterFluid : AllocatedTo allocate fnMeterFluid to subFluidPath;
    // ── Requirement → function satisfaction ──────────────────────











}
