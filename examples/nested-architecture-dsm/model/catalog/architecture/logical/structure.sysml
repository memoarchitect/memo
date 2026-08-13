// Logical structure — the column axis of the DSM.
//
// Four levels deep on purpose (System → Subsystem → Subsystem → component),
// so expanding and collapsing the matrix has something real to do. Containment
// is native nesting; the builder synthesizes the `composes` relationship the
// DSM reads to build the column tree, so no explicit Composes edge is written.
package memo_examples_nested_architecture_dsm_architecture_logical_structure {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_operational_context_use_context::*;

    // ── Level 0: the system ──────────────────────────────────────
    part sysTherapyDelivery : System {
        attribute :>> id = "NDS-SYS-001"; attribute :>> name = "TherapyDeliverySystem";
        attribute :>> componentRole = ComponentRoleKind::generic;
        attribute :>> systemType = SystemTypeKind::logical;
        attribute :>> systemBoundaryDescription = "Everything inside the pump enclosure, including its power path and user interface.";
        attribute :>> responsibility = "Deliver a prescribed infusion safely and report what it delivered.";

        // ── Level 1: subsystems ──────────────────────────────────
        part subFluidPath : Subsystem {
            attribute :>> id = "NDS-SUB-001"; attribute :>> name = "FluidPathSubsystem";
            attribute :>> componentRole = ComponentRoleKind::generic;
            attribute :>> systemType = SystemTypeKind::hardware;
            attribute :>> responsibility = "Move fluid from the reservoir to the patient line at a commanded rate.";

            // ── Level 2/3: components ─────────────────────────────
            part lcPumpMechanism : LogicalComponent {
                attribute :>> id = "NDS-LC-001"; attribute :>> name = "PumpMechanism";
                attribute :>> componentRole = ComponentRoleKind::controlElement;
                attribute :>> systemType = SystemTypeKind::hardware;
                attribute :>> responsibility = "Displace fluid under command.";
                attribute :>> controlledVariable = "delivered volume per stroke";
            }
            part lcOcclusionChannel : LogicalComponent {
                attribute :>> id = "NDS-LC-002"; attribute :>> name = "OcclusionSensingChannel";
                attribute :>> componentRole = ComponentRoleKind::channel;
                attribute :>> systemType = SystemTypeKind::hardware;
                attribute :>> responsibility = "Sense line pressure and air in line.";
                attribute :>> channelRole = ChannelRoleKind::primary;
            }
            part lcReservoirInterface : LogicalComponent {
                attribute :>> id = "NDS-LC-003"; attribute :>> name = "ReservoirInterface";
                attribute :>> componentRole = ComponentRoleKind::generic;
                attribute :>> systemType = SystemTypeKind::hardware;
                attribute :>> responsibility = "Seat the reservoir and expose its remaining volume.";
            }
        }
        part subControl : Subsystem {
            attribute :>> id = "NDS-SUB-002"; attribute :>> name = "ControlSubsystem";
            attribute :>> componentRole = ComponentRoleKind::controlElement;
            attribute :>> systemType = SystemTypeKind::software;
            attribute :>> responsibility = "Decide what the fluid path should do, and hold the therapy state.";

            // ── Level 2: a subsystem inside a subsystem ───────────
            // The safety monitor is nested one level deeper than its peers,
            // which is what makes a collapsed ControlSubsystem row a genuine
            // roll-up rather than a rename of its children.
            part subSafetyMonitor : Subsystem {
                attribute :>> id = "NDS-SUB-005"; attribute :>> name = "SafetyMonitorSubsystem";
                attribute :>> componentRole = ComponentRoleKind::channel;
                attribute :>> systemType = SystemTypeKind::software;
                attribute :>> responsibility = "Watch the control path from outside it and stop delivery on breach.";
                attribute :>> safetyPartition = "monitor partition, separate MPU region from the control partition";

                part lcWatchdogChannel : LogicalComponent {
                    attribute :>> id = "NDS-LC-006"; attribute :>> name = "WatchdogChannel";
                    attribute :>> componentRole = ComponentRoleKind::channel;
                    attribute :>> systemType = SystemTypeKind::software;
                    attribute :>> responsibility = "Reset to the safe state when the control loop misses its deadline.";
                    attribute :>> channelRole = ChannelRoleKind::monitor;
                    attribute :>> diversityBasis = "independent time base from the control partition";
                }
                part lcPressureIntegrityChannel : LogicalComponent {
                    attribute :>> id = "NDS-LC-007"; attribute :>> name = "PressureIntegrityChannel";
                    attribute :>> componentRole = ComponentRoleKind::channel;
                    attribute :>> systemType = SystemTypeKind::software;
                    attribute :>> responsibility = "Cross-check pressure against the commanded rate and stop on divergence.";
                    attribute :>> channelRole = ChannelRoleKind::monitor;
                    attribute :>> diversityBasis = "different measurement principle from the primary occlusion channel";
                }
            }
            part lcDoseController : LogicalComponent {
                attribute :>> id = "NDS-LC-004"; attribute :>> name = "DoseController";
                attribute :>> componentRole = ComponentRoleKind::controlElement;
                attribute :>> systemType = SystemTypeKind::software;
                attribute :>> responsibility = "Turn a prescription into rate commands.";
                attribute :>> controlLaw = "closed loop on delivered volume, saturated at the prescribed limit";
                attribute :>> controlledVariable = "infusion rate";
            }
            part lcTherapyStateStore : LogicalComponent {
                attribute :>> id = "NDS-LC-005"; attribute :>> name = "TherapyStateStore";
                attribute :>> componentRole = ComponentRoleKind::dataStore;
                attribute :>> systemType = SystemTypeKind::software;
                attribute :>> responsibility = "Hold the active therapy record across power cycles.";
                attribute :>> persistenceRequirement = "survives power loss with the last completed transaction intact";
                attribute :>> integrityRequirement = "CRC per record, rejected on mismatch";
            }
        }
        part subUserInterface : Subsystem {
            attribute :>> id = "NDS-SUB-003"; attribute :>> name = "UserInterfaceSubsystem";
            attribute :>> componentRole = ComponentRoleKind::userInterface;
            attribute :>> systemType = SystemTypeKind::software;
            attribute :>> responsibility = "Present therapy state to the clinician and accept their input.";

            part lcDisplayManager : LogicalComponent {
                attribute :>> id = "NDS-LC-008"; attribute :>> name = "DisplayManager";
                attribute :>> componentRole = ComponentRoleKind::userInterface;
                attribute :>> systemType = SystemTypeKind::software;
                attribute :>> responsibility = "Render therapy state on the main screen.";
                attribute :>> interactionSummary = "read-only status surface, refreshed once per second";
            }
            part lcAlarmAnnunciator : LogicalComponent {
                attribute :>> id = "NDS-LC-009"; attribute :>> name = "AlarmAnnunciator";
                attribute :>> componentRole = ComponentRoleKind::userInterface;
                attribute :>> systemType = SystemTypeKind::software;
                attribute :>> responsibility = "Raise audible and visible alarms by priority.";
                attribute :>> interactionSummary = "IEC 60601-1-8 alarm signals";
            }
            part lcKeypadHandler : LogicalComponent {
                attribute :>> id = "NDS-LC-010"; attribute :>> name = "KeypadHandler";
                attribute :>> componentRole = ComponentRoleKind::userInterface;
                attribute :>> systemType = SystemTypeKind::software;
                attribute :>> responsibility = "Debounce and interpret key presses.";
                attribute :>> interactionSummary = "physical keypad, confirm-before-apply for every rate change";
            }
        }
        part subPower : Subsystem {
            attribute :>> id = "NDS-SUB-004"; attribute :>> name = "PowerSubsystem";
            attribute :>> componentRole = ComponentRoleKind::generic;
            attribute :>> systemType = SystemTypeKind::hardware;
            attribute :>> responsibility = "Supply and monitor power across mains and battery operation.";

            part lcBatteryManager : LogicalComponent {
                attribute :>> id = "NDS-LC-011"; attribute :>> name = "BatteryManager";
                attribute :>> componentRole = ComponentRoleKind::generic;
                attribute :>> systemType = SystemTypeKind::hardware;
                attribute :>> responsibility = "Charge, gauge and protect the battery.";
            }
            part lcPowerRailMonitor : LogicalComponent {
                attribute :>> id = "NDS-LC-012"; attribute :>> name = "PowerRailMonitor";
                attribute :>> componentRole = ComponentRoleKind::channel;
                attribute :>> systemType = SystemTypeKind::hardware;
                attribute :>> responsibility = "Detect rail brownout and request a source switch.";
                attribute :>> channelRole = ChannelRoleKind::monitor;
            }
        }

        // ── Component-to-component dependency ─────────────────────
        // What the DSM plots when both axes are architecture: who needs whom.
        flow from subFluidPath.lcOcclusionChannel to subControl.lcDoseController;
        flow from subControl.lcDoseController to subFluidPath.lcPumpMechanism;
        flow from subFluidPath.lcPumpMechanism to subControl.lcTherapyStateStore;
        flow from subControl.lcTherapyStateStore to subUserInterface.lcDisplayManager;
        flow from subControl.subSafetyMonitor.lcWatchdogChannel to subControl.lcDoseController;
        flow from subControl.subSafetyMonitor.lcPressureIntegrityChannel to subUserInterface.lcAlarmAnnunciator;
        flow from subUserInterface.lcKeypadHandler to subControl.lcDoseController;
        flow from subFluidPath.lcReservoirInterface to subFluidPath.lcPumpMechanism;
        flow from subPower.lcBatteryManager to subPower.lcPowerRailMonitor;
        flow from subPower.lcPowerRailMonitor to subUserInterface.lcAlarmAnnunciator;
    }
}
