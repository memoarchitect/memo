// Focused example: robotic cyber-physical system. Multivalued technology
// domains; redundant + monitor channels with declared independence; an
// interlock; a mechanical-force flow; and a haptic UI element.
package memo_examples_surgical_robot {
    private import memo::*;
    private import ScalarValues::*;


    part def SurgicalRobotSystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The surgical robot: the system this example models, with the software and hardware that realize it.";
    }
    // Control channels: primary + diverse monitor, with declared independence.
    part chMotionPrimary : LogicalComponent {
        @MemoIdentity { :>> providedId = "SR-LC-001"; :>> label = "Motion control channel"; }
        attribute :>> channelRole = ChannelRoleKind::primary;
    }
    part chMotionMonitor : LogicalComponent {
        @MemoIdentity { :>> providedId = "SR-LC-002"; :>> label = "Motion monitor channel"; }
        attribute :>> channelRole = ChannelRoleKind::monitor;
        attribute :>> diversityBasis = "independent encoder set and diverse processor family";
    }
    connection : IndependentOf connect chMotionMonitor to chMotionPrimary {
        attribute :>> independenceBasis = "separate sensing, power, and processing; common-cause analysis SR-CCA-01";
    }
    dependency chMotionMonitor to chMotionPrimary;

    // Interlock: instrument exchange blocked while arm is in motion.
    part chExchangeInterlock : LogicalComponent {
        @MemoIdentity { :>> providedId = "SR-LC-003"; :>> label = "Instrument exchange interlock"; }
        attribute :>> channelRole = ChannelRoleKind::interlock;
    }

    part actJointDrive : Actuator {
        @MemoIdentity { :>> providedId = "SR-HW-001"; :>> label = "Joint drive actuator"; }
        attribute :>> patientContact = false;
        attribute :>> actuationKind = "brushless DC servo with harmonic drive";
        out port pDriveOut : PhysicalPort;
    }
    part instrShaft : MechanicalPart {
        in port pDriveIn : PhysicalPort;
        @MemoIdentity { :>> providedId = "SR-HW-002"; :>> label = "Instrument shaft"; }
        attribute :>> mechanicalFunction = "transmits actuation to end effector";
        attribute :>> patientContact = true;
        attribute :>> contactNature = "internal tissue, direct";
        attribute :>> contactDuration = "limited (<24 h)";
    }
    // Mechanical-force flow from actuator to instrument tip.
    flow exTipForce : LogicalTransfer from actJointDrive.pDriveOut to instrShaft.pDriveIn {
        @MemoIdentity { :>> providedId = "SR-EX-001"; :>> label = "Tip force transmission"; }
        attribute :>> contentKind = FlowContentKind::mechanicalForce;
    }

    // Surgeon console: haptic feedback element. The grip is hardware the
    // surgeon holds, so it is an OperatorInterfaceElement (a PhysicalComponent)
    // rather than a UIElement — UIElement is software.
    part elHapticGrip : OperatorInterfaceElement {
        @MemoIdentity { :>> providedId = "SR-UI-001"; :>> label = "Haptic master grip"; }
        attribute :>> patientContact = false;
        attribute :>> formKind = OperatorInterfaceFormKind::hapticIndicator;
        attribute :>> guardedAgainstInadvertentActuation = true;
    }
}
