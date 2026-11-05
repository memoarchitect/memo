// Logical structure — the column axis of the DSM.
//
// Four levels deep on purpose (System → Subsystem → Subsystem → component),
// so expanding and collapsing the matrix has something real to do. Containment
// is native nesting; the builder synthesizes the `composes` relationship the
// DSM reads to build the column tree, so no explicit Composes edge is written.
package memo_examples_nested_architecture_dsm_architecture_logical_structure {
    private import memo::*;
    private import ScalarValues::*;


    // ── Level 0: the system ──────────────────────────────────────
    part sysTherapyDelivery : System {
        @MemoIdentity { :>> providedId = "NDS-SYS-001"; :>> label = "Therapy delivery system"; }
        attribute :>> componentRole = ComponentRoleKind::generic;
        attribute :>> systemType = SystemTypeKind::logical;
        attribute :>> systemBoundaryDescription = "Everything inside the pump enclosure, including its power path and user interface.";
        attribute :>> responsibility = "Deliver a prescribed infusion safely and report what it delivered.";

        // ── Level 1: subsystems ──────────────────────────────────
        part subFluidPath : Subsystem {
            @MemoIdentity { :>> providedId = "NDS-SUB-001"; :>> label = "Fluid path subsystem"; }
            attribute :>> componentRole = ComponentRoleKind::generic;
            attribute :>> systemType = SystemTypeKind::hardware;
            attribute :>> responsibility = "Move fluid from the reservoir to the patient line at a commanded rate.";

            // ── Level 2/3: components ─────────────────────────────
            part lcPumpMechanism : LogicalComponent {
                @MemoIdentity { :>> providedId = "NDS-LC-001"; :>> label = "Pump mechanism"; }
                attribute :>> componentRole = ComponentRoleKind::controlElement;
                attribute :>> systemType = SystemTypeKind::hardware;
                attribute :>> responsibility = "Displace fluid under command.";
                attribute :>> controlledVariable = "delivered volume per stroke";
            }
            part lcOcclusionChannel : LogicalComponent {
                @MemoIdentity { :>> providedId = "NDS-LC-002"; :>> label = "Occlusion sensing channel"; }
                attribute :>> componentRole = ComponentRoleKind::channel;
                attribute :>> systemType = SystemTypeKind::hardware;
                attribute :>> responsibility = "Sense line pressure and air in line.";
                attribute :>> channelRole = ChannelRoleKind::primary;
            }
            part lcReservoirInterface : LogicalComponent {
                @MemoIdentity { :>> providedId = "NDS-LC-003"; :>> label = "Reservoir interface"; }
                attribute :>> componentRole = ComponentRoleKind::generic;
                attribute :>> systemType = SystemTypeKind::hardware;
                attribute :>> responsibility = "Seat the reservoir and expose its remaining volume.";
            }
        }
        part subControl : Subsystem {
            @MemoIdentity { :>> providedId = "NDS-SUB-002"; :>> label = "Control subsystem"; }
            attribute :>> componentRole = ComponentRoleKind::controlElement;
            attribute :>> systemType = SystemTypeKind::software;
            attribute :>> responsibility = "Decide what the fluid path should do, and hold the therapy state.";

            // ── Level 2: a subsystem inside a subsystem ───────────
            // The safety monitor is nested one level deeper than its peers,
            // which is what makes a collapsed ControlSubsystem row a genuine
            // roll-up rather than a rename of its children.
            part subSafetyMonitor : Subsystem {
                @MemoIdentity { :>> providedId = "NDS-SUB-005"; :>> label = "Safety monitor subsystem"; }
                attribute :>> componentRole = ComponentRoleKind::channel;
                attribute :>> systemType = SystemTypeKind::software;
                attribute :>> responsibility = "Watch the control path from outside it and stop delivery on breach.";
                attribute :>> safetyPartition = "monitor partition, separate MPU region from the control partition";

                part lcWatchdogChannel : LogicalComponent {
                    @MemoIdentity { :>> providedId = "NDS-LC-006"; :>> label = "Watchdog channel"; }
                    attribute :>> componentRole = ComponentRoleKind::channel;
                    attribute :>> systemType = SystemTypeKind::software;
                    attribute :>> responsibility = "Reset to the safe state when the control loop misses its deadline.";
                    attribute :>> channelRole = ChannelRoleKind::monitor;
                    attribute :>> diversityBasis = "independent time base from the control partition";
                }
                part lcPressureIntegrityChannel : LogicalComponent {
                    @MemoIdentity { :>> providedId = "NDS-LC-007"; :>> label = "Pressure integrity channel"; }
                    attribute :>> componentRole = ComponentRoleKind::channel;
                    attribute :>> systemType = SystemTypeKind::software;
                    attribute :>> responsibility = "Cross-check pressure against the commanded rate and stop on divergence.";
                    attribute :>> channelRole = ChannelRoleKind::monitor;
                    attribute :>> diversityBasis = "different measurement principle from the primary occlusion channel";
                }
            }
            part lcDoseController : LogicalComponent {
                @MemoIdentity { :>> providedId = "NDS-LC-004"; :>> label = "Dose controller"; }
                attribute :>> componentRole = ComponentRoleKind::controlElement;
                attribute :>> systemType = SystemTypeKind::software;
                attribute :>> responsibility = "Turn a prescription into rate commands.";
                attribute :>> controlLaw = "closed loop on delivered volume, saturated at the prescribed limit";
                attribute :>> controlledVariable = "infusion rate";
            }
            part lcTherapyStateStore : LogicalComponent {
                @MemoIdentity { :>> providedId = "NDS-LC-005"; :>> label = "Therapy state store"; }
                attribute :>> componentRole = ComponentRoleKind::dataStore;
                attribute :>> systemType = SystemTypeKind::software;
                attribute :>> responsibility = "Hold the active therapy record across power cycles.";
                attribute :>> persistenceRequirement = "survives power loss with the last completed transaction intact";
                attribute :>> integrityRequirement = "CRC per record, rejected on mismatch";
            }
        }
        part subUserInterface : Subsystem {
            @MemoIdentity { :>> providedId = "NDS-SUB-003"; :>> label = "User interface subsystem"; }
            attribute :>> componentRole = ComponentRoleKind::userInterface;
            attribute :>> systemType = SystemTypeKind::software;
            attribute :>> responsibility = "Present therapy state to the clinician and accept their input.";

            part lcDisplayManager : LogicalComponent {
                @MemoIdentity { :>> providedId = "NDS-LC-008"; :>> label = "Display manager"; }
                attribute :>> componentRole = ComponentRoleKind::userInterface;
                attribute :>> systemType = SystemTypeKind::software;
                attribute :>> responsibility = "Render therapy state on the main screen.";
                attribute :>> interactionSummary = "read-only status surface, refreshed once per second";
            }
            part lcAlarmAnnunciator : LogicalComponent {
                @MemoIdentity { :>> providedId = "NDS-LC-009"; :>> label = "Alarm annunciator"; }
                attribute :>> componentRole = ComponentRoleKind::userInterface;
                attribute :>> systemType = SystemTypeKind::software;
                attribute :>> responsibility = "Raise audible and visible alarms by priority.";
                attribute :>> interactionSummary = "IEC 60601-1-8 alarm signals";
            }
            part lcKeypadHandler : LogicalComponent {
                @MemoIdentity { :>> providedId = "NDS-LC-010"; :>> label = "Keypad handler"; }
                attribute :>> componentRole = ComponentRoleKind::userInterface;
                attribute :>> systemType = SystemTypeKind::software;
                attribute :>> responsibility = "Debounce and interpret key presses.";
                attribute :>> interactionSummary = "physical keypad, confirm-before-apply for every rate change";
            }
        }
        part subPower : Subsystem {
            @MemoIdentity { :>> providedId = "NDS-SUB-004"; :>> label = "Power subsystem"; }
            attribute :>> componentRole = ComponentRoleKind::generic;
            attribute :>> systemType = SystemTypeKind::hardware;
            attribute :>> responsibility = "Supply and monitor power across mains and battery operation.";

            part lcBatteryManager : LogicalComponent {
                @MemoIdentity { :>> providedId = "NDS-LC-011"; :>> label = "Battery manager"; }
                attribute :>> componentRole = ComponentRoleKind::generic;
                attribute :>> systemType = SystemTypeKind::hardware;
                attribute :>> responsibility = "Charge, gauge and protect the battery.";
            }
            part lcPowerRailMonitor : LogicalComponent {
                @MemoIdentity { :>> providedId = "NDS-LC-012"; :>> label = "Power rail monitor"; }
                attribute :>> componentRole = ComponentRoleKind::channel;
                attribute :>> systemType = SystemTypeKind::hardware;
                attribute :>> responsibility = "Detect rail brownout and request a source switch.";
                attribute :>> channelRole = ChannelRoleKind::monitor;
            }
        }

        // ── Component-to-component dependency ─────────────────────
        // What the DSM plots when both axes are architecture: who needs whom.
        flow lcOcclusionChannelToLcDoseController from subFluidPath.lcOcclusionChannel to subControl.lcDoseController;
        flow lcDoseControllerToLcPumpMechanism from subControl.lcDoseController to subFluidPath.lcPumpMechanism;
        flow lcPumpMechanismToLcTherapyStateStore from subFluidPath.lcPumpMechanism to subControl.lcTherapyStateStore;
        flow lcTherapyStateStoreToLcDisplayManager from subControl.lcTherapyStateStore to subUserInterface.lcDisplayManager;
        flow lcWatchdogChannelToLcDoseController from subControl.subSafetyMonitor.lcWatchdogChannel to subControl.lcDoseController;
        flow lcPressureIntegrityChannelToLcAlarmAnnunciator from subControl.subSafetyMonitor.lcPressureIntegrityChannel to subUserInterface.lcAlarmAnnunciator;
        flow lcKeypadHandlerToLcDoseController from subUserInterface.lcKeypadHandler to subControl.lcDoseController;
        flow lcReservoirInterfaceToLcPumpMechanism from subFluidPath.lcReservoirInterface to subFluidPath.lcPumpMechanism;
        flow lcBatteryManagerToLcPowerRailMonitor from subPower.lcBatteryManager to subPower.lcPowerRailMonitor;
        flow lcPowerRailMonitorToLcAlarmAnnunciator from subPower.lcPowerRailMonitor to subUserInterface.lcAlarmAnnunciator;
    }
}
