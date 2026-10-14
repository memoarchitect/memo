// What more than one system of the family uses: the signals that cross between
// them, the ports that carry those signals, a component two systems both
// contain, and the people who use the lab. A system imports this package and
// nothing else of the family; it never names the system of systems or another
// system.
package ep_lab_family_shared {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_core_enumerations::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_operational_context_actors::*;

    // ─── Signals that cross a system boundary ───────────────────────────
    item def Electrogram specializes InterfaceItem {
        @MemoIdentity { :>> providedId = "EPF-IT-001"; :>> label = "Intracardiac Electrogram"; }
        doc /* Sampled intracardiac signals from the catheter electrodes, with their acquisition timestamps. */
    }
    item def CatheterLocation specializes InterfaceItem {
        @MemoIdentity { :>> providedId = "EPF-IT-002"; :>> label = "Catheter Location"; }
        doc /* Position and orientation of the catheter tip in the reconstructed chamber geometry. */
    }
    item def AblationEvent specializes InterfaceItem {
        @MemoIdentity { :>> providedId = "EPF-IT-003"; :>> label = "Ablation Event"; }
        doc /* One energy delivery: start and stop time, delivered power, and the electrode it was delivered on. */
    }

    // ─── The ports those signals cross through ──────────────────────────
    // Defined once here so that each system types its own boundary with them
    // and the interface control documents at the system-of-systems level
    // connect them, without either side naming the other.
    port def ElectrogramPort specializes LogicalPort {
        out item electrogram : Electrogram;
    }
    port def AblationEventPort specializes LogicalPort {
        out item ablationEvent : AblationEvent;
    }

    // ─── A component two systems both contain ───────────────────────────
    // It lives in the platform package, which this family depends on and does
    // not edit. Re-exported here so a system imports this package and nothing else.
    public import ep_platform::PatientIsolationModule;

    // ─── The people who use the lab ─────────────────────────────────────
    part electrophysiologist : User {
        @MemoIdentity { :>> providedId = "EPF-ACT-001"; :>> label = "Electrophysiologist"; }
        attribute :>> actorKind = ActorKind::clinician;
    }
    part labTechnician : User {
        @MemoIdentity { :>> providedId = "EPF-ACT-002"; :>> label = "EP Lab Technician"; }
        attribute :>> actorKind = ActorKind::technician;
    }
}
