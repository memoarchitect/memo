// Focused example: robotic cyber-physical system. Multivalued technology
// domains; redundant + monitor channels with declared independence; an
// interlock; a mechanical-force flow; and a haptic UI element.
package memo_examples_surgical_robot {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_implementation_hardware_structure::*;
    private import memo_architecture_implementation_ui::*;

    // Control channels: primary + diverse monitor, with declared independence.
    part chMotionPrimary : LogicalComponent {
        attribute :>> id = "SR-LC-001"; attribute :>> name = "MotionControlChannel";
        attribute :>> channelRole = ChannelRoleKind::primary;
    }
    part chMotionMonitor : LogicalComponent {
        attribute :>> id = "SR-LC-002"; attribute :>> name = "MotionMonitorChannel";
        attribute :>> channelRole = ChannelRoleKind::monitor;
        attribute :>> diversityBasis = "independent encoder set and diverse processor family";
    }
    connection : IndependentOf connect channel ::> chMotionMonitor to otherChannel ::> chMotionPrimary {
        attribute :>> independenceBasis = "separate sensing, power, and processing; common-cause analysis SR-CCA-01";
    }
    connection : MonitorsChannel connect monitorChannel ::> chMotionMonitor to monitoredComponent ::> chMotionPrimary;

    // Interlock: instrument exchange blocked while arm is in motion.
    part chExchangeInterlock : LogicalComponent {
        attribute :>> id = "SR-LC-003"; attribute :>> name = "InstrumentExchangeInterlock";
        attribute :>> channelRole = ChannelRoleKind::interlock;
    }

    // Mechanical-force flow from actuator to instrument tip.
    part exTipForce : LogicalExchange {
        attribute :>> id = "SR-EX-001"; attribute :>> name = "TipForceTransmission";
        attribute :>> contentKind = FlowContentKind::mechanicalForce;
        attribute :>> direction = DirectionKind::output;
    }
    part actJointDrive : Actuator {
        attribute :>> id = "SR-HW-001"; attribute :>> name = "JointDriveActuator";
        attribute :>> actuationKind = "brushless DC servo with harmonic drive";
    }
    part instrShaft : MechanicalPart {
        attribute :>> id = "SR-HW-002"; attribute :>> name = "InstrumentShaft";
        attribute :>> mechanicalFunction = "transmits actuation to end effector";
        attribute :>> patientContact = true;
        attribute :>> contactNature = "internal tissue, direct";
        attribute :>> contactDuration = "limited (<24 h)";
    }

    // Surgeon console: haptic feedback element.
    part elHapticGrip : UIElement {
        attribute :>> id = "SR-UI-001"; attribute :>> name = "HapticMasterGrip";
        attribute :>> formKind = UIElementFormKind::hapticIndicator;
        attribute :>> guardedAgainstInadvertentActuation = true;
    }
}
