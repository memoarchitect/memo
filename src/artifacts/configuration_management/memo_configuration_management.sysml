package memo_artifacts_configuration_management {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;
    private import memo_core_relationships::*;   // MemoRelationship

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    part def ChangeRequest :> MemoPart {
        attribute changeType : ChangeTypeKind;
        attribute impactAssessment : String;
        attribute approvalStatus : String;
        attribute affectedBaseline : String;
    }

    part def ConfigurationItem :> MemoPart {
        attribute version : String;
        attribute baseline : String;
        attribute controlLevel : String;
    }

    // ── Relations owned by this package ─────────────────────────────
    // Moved out of memo_core_relationships: their ends are typed against
    // types declared here, and core must not depend on a domain package.
    connection def Changes :> MemoRelationship {
        end changeRequest : ChangeRequest :>> source;
        end changedElement : MemoPart :>> target;
    }
    abstract connection changesLinks : Changes[*];
    metadata def <changes> ChangesMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = changesLinks meta SysML::Usage;
    }
}
