// ISO/IEC/IEEE 42010 architecture-description core (§4). A Stakeholder has
// interests (Concerns) in the system; a Viewpoint frames concerns; a View
// (memo_viewpoints_definitions::MemoView) is governed by a viewpoint within an
// ArchitectureDescription. The same real-world entity may play both the
// Stakeholder and the Actor role — expressed by ActsAsActor, never by merging
// the types.
package memo_architecture_operational_context_stakeholders {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_context_actors::*;

    part def Stakeholder specializes MemoPart {
        attribute stakeholderCategory : String;
        attribute influence : String;
    }

    part def Concern specializes MemoPart {
        attribute concernKind : ConcernKind;
        attribute question : String;
    }

    part def ArchitectureDescription specializes DocumentedElement {
        attribute systemOfInterest : String;
        attribute version : String;
    }

    part def ModelKind specializes MemoPart {
        attribute conventions : String;
        attribute notationReference : String;
    }

    // 42010 correspondence: a rule that must hold between architecture
    // description elements (e.g. consistency between two views).
    part def CorrespondenceRule specializes MemoPart {
        attribute ruleExpression : String;
    }

    connection def HasConcern :> MemoRelationship {
        end interestedStakeholder : Stakeholder;
        end stakeholderConcern : Concern;
    }
    connection def FramesConcern :> MemoRelationship {
        end framingViewpoint : MemoPart;
        end framedConcern : Concern;
    }
    // Links the stakeholder to the actor role the same entity plays, if any.
    connection def ActsAsActor :> MemoRelationship {
        end interestedStakeholder : Stakeholder;
        end actorRole : Actor;
    }
    // Governs unifies GovernsCorrespondence / GovernsUse, keyed by governKind.
    enum def GovernKind {
        enum correspondence;
        enum 'use';
    }
    connection def Governs :> MemoRelationship {
        attribute governKind : GovernKind;
        end governor : MemoPart;
        end governedElement : MemoPart;
    }
}
