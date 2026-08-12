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
    allocate fnDriveActuator to lcPumpMechanism;
    allocate fnMeasureDelivered to lcPumpMechanism;
    allocate fnComputeRate to lcDoseController;
    allocate fnValidatePrescription to lcDoseController;
    allocate fnDetectOcclusion to lcOcclusionChannel;
    allocate fnDetectAirInLine to lcOcclusionChannel;
    // Two channels carry the same protective function — the redundancy shows
    // up in the matrix as two marks on one row.
    allocate fnEnforceDoseLimits to lcWatchdogChannel;
    allocate fnEnforceDoseLimits to lcPressureIntegrityChannel;
    allocate fnRenderStatus to lcDisplayManager;
    allocate fnAnnunciateAlarm to lcAlarmAnnunciator;
    allocate fnAcceptInput to lcKeypadHandler;
    allocate fnMonitorBattery to lcBatteryManager;
    allocate fnSelectPowerSource to lcPowerRailMonitor;
    // A capability allocated at subsystem level rather than to one component:
    // collapsed, it lands in the same cell as its children's allocations.
    allocate fnMeterFluid to subFluidPath;
    // ── Requirement → function satisfaction ──────────────────────











}
