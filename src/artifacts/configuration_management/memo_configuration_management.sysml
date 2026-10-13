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

    // What a release is, as far as selecting features needs it: an element with a
    // status (inherited from MemoPart) that `#SelectsFeature` links to the features
    // it contains. Part number, revision, what it contains and what it implements
    // are the release model (plan O2, O3, O4) and arrive with it; this is only the
    // shell they hang from, so there is one release concept and not two.
    part def ReleaseRecord :> MemoPart;

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
