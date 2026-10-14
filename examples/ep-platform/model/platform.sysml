// The parts every product of the EP lab family shares, versioned on their own.
// A family model depends on this package (`dependencies:` in its
// memo.package.yaml) and builds on these definitions; it never edits them. A
// change here is a new version of the platform, which each family adopts when
// it chooses to.
package ep_platform {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_architecture_logical_structure::*;

    part def PatientIsolationModule specializes LogicalComponent {
        @MemoIdentity { :>> providedId = "EPF-LC-001"; :>> label = "Patient Isolation Module"; }
        attribute :>> responsibility = "Isolate patient-connected electrodes from mains-referenced electronics.";
    }
}
