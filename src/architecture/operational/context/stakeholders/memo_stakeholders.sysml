// ISO/IEC/IEEE 42010 architecture-description core (§4). A stakeholder has
// interests in the system; a Viewpoint frames concerns; a View
// (memo_viewpoints_definitions::MemoView) is governed by a viewpoint within an
// ArchitectureDescription. The same real-world entity may play both the
// Stakeholder and operational-participant concerns stay distinct from the
// architecture-description types below.
package memo_architecture_operational_context_stakeholders {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_context_actors::*;
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
