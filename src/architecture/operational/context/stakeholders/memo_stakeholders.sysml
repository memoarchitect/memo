// ISO/IEC/IEEE 42010 architecture-description core (§4): ArchitectureDescription,
// ModelKind, and CorrespondenceRule below. Stakeholders and concerns — 42010's
// other cornerstones — are native SysML v2 constructs (stakeholder memberships
// and `concern def`), used directly rather than reinvented as MEMO types. A
// View (memo_viewpoints_definitions::MemoView) conforms to a Viewpoint within
// an ArchitectureDescription.
package memo_architecture_operational_context_stakeholders {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_context_actors::*;
    part def ArchitectureDescription specializes MemoPart {
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

    // Governs unifies GovernsCorrespondence / GovernsUse, keyed by governKind.
    enum def GovernKind {
        enum correspondence;
        enum 'use';
    }
    connection def Governs :> MemoRelationship {
        attribute governKind : GovernKind;
        end governor : MemoPart :>> source;
        end governedElement : MemoPart :>> target;
    }
    abstract connection governsLinks : Governs[*];
    metadata def <governs> GovernsMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = governsLinks meta SysML::Usage;
    }
}
