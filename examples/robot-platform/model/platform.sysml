// The parts every product of the robot cell family shares, versioned on their own.
// A family model depends on this package (`dependencies:` in its
// memo.package.yaml) and builds on these definitions; it never edits them. A
// change here is a new version of the platform, which each family adopts when
// it chooses to.
package robot_platform {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_architecture_logical_structure::*;

    part def SafetyRelayModule specializes LogicalComponent {
        @MemoIdentity { :>> providedId = "RCF-LC-001"; :>> label = "Safety Relay Module"; }
        attribute :>> responsibility = "Isolate the safety-rated circuits from the motion drives' mains supply.";
    }
}
