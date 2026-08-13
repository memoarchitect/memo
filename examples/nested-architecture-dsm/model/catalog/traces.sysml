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
    allocate fnDeliverTherapy.fnMeterFluid.fnDriveActuator to sysTherapyDelivery.subFluidPath.lcPumpMechanism;
    allocate fnDeliverTherapy.fnMeterFluid.fnMeasureDelivered to sysTherapyDelivery.subFluidPath.lcPumpMechanism;
    allocate fnDeliverTherapy.fnControlDose.fnComputeRate to sysTherapyDelivery.subControl.lcDoseController;
    allocate fnDeliverTherapy.fnControlDose.fnValidatePrescription to sysTherapyDelivery.subControl.lcDoseController;
    allocate fnEnsureSafety.fnDetectOcclusion to sysTherapyDelivery.subFluidPath.lcOcclusionChannel;
    allocate fnEnsureSafety.fnDetectAirInLine to sysTherapyDelivery.subFluidPath.lcOcclusionChannel;
    // Two channels carry the same protective function — the redundancy shows
    // up in the matrix as two marks on one row.
    allocate fnEnsureSafety.fnEnforceDoseLimits to sysTherapyDelivery.subControl.subSafetyMonitor.lcWatchdogChannel;
    allocate fnEnsureSafety.fnEnforceDoseLimits to sysTherapyDelivery.subControl.subSafetyMonitor.lcPressureIntegrityChannel;
    allocate fnInformUser.fnRenderStatus to sysTherapyDelivery.subUserInterface.lcDisplayManager;
    allocate fnInformUser.fnAnnunciateAlarm to sysTherapyDelivery.subUserInterface.lcAlarmAnnunciator;
    allocate fnInformUser.fnAcceptInput to sysTherapyDelivery.subUserInterface.lcKeypadHandler;
    allocate fnManagePower.fnMonitorBattery to sysTherapyDelivery.subPower.lcBatteryManager;
    allocate fnManagePower.fnSelectPowerSource to sysTherapyDelivery.subPower.lcPowerRailMonitor;
    // A capability allocated at subsystem level rather than to one component:
    // collapsed, it lands in the same cell as its children's allocations.
    allocate fnDeliverTherapy.fnMeterFluid to sysTherapyDelivery.subFluidPath;
    // ── Requirement → function satisfaction ──────────────────────











}
