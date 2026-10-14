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
        // The release a change affects is `#AffectsRelease dependency from <request> to <record>;`
        // (below), not a string naming a baseline.
    }

    part def ConfigurationItem :> MemoPart {
        // No version and no baseline: both belong to a release of the item, not to the item
        // (plan O2). A `ReleaseRecord` whose `#ReleaseOf` is this item carries them.
        attribute controlLevel : String;
    }

    // A release record is one release of one item: rev D and rev E of a part, or its EU and its US
    // release, are separate records, each with its own part number and revision (plan O2). The
    // definition of the item is held once and carries no revision. The record is an element with a
    // status (inherited from MemoPart: proposed, draft, ... released), so a release moves through
    // the lifecycle the way any element does.
    //
    //   part relPumpD : ReleaseRecord {
    //       :>> partNumber = "PN-1001"; :>> revision = "D"; :>> modelCommit = "9f2c...";
    //   }
    //   #ReleaseOf dependency from relPumpD to PumpSystem;
    //
    // `softwareVersion` and `codeTag` are for an item that is software; a record of anything else
    // leaves them out. The links are typed dependencies, because a record's item is a definition and
    // a `ref` cannot point at one: a Dependency's client and supplier are any element
    // (SysML-textual-bnf.kebnf:51-59), and the metadata prefix names the kind (`:52`).
    //
    // A release of a system of systems is the same record with a system of systems for its item. It
    // `#Contains` the records of the system releases it pins, and is the validated configuration:
    // `#VerifiedByCase` names the verification cases that validated it.
    part def ReleaseRecord :> MemoPart {
        attribute partNumber : String[1];
        attribute revision : String[1];
        attribute softwareVersion : String[0..1];
        attribute codeTag : String[0..1];
        // The commit of the model this release was built from. A record cannot hold the hash of the
        // commit that adds it, so it is written after the commit it pins and is always found in a
        // folder that is not itself pinned (`sos/`).
        attribute modelCommit : String[1];
    }

    metadata def ReleaseOf :> MemoTypedDependency {
        doc /* `#ReleaseOf dependency from <record> to <item definition>;` The record is a release of this item. One record, one item. */
    }
    metadata def Contains :> MemoTypedDependency {
        doc /* `#Contains dependency from <record> to <record>, <record>;` The release pins these releases: a system of systems version its systems, a system release its components. */
    }
    metadata def Implements :> MemoTypedDependency {
        doc /* `#Implements dependency from <record> to <interface record>;` The release implements this revision of an interface. */
    }
    metadata def VerifiedByCase :> MemoTypedDependency {
        doc /* `#VerifiedByCase dependency from <record> to <verification case>;` The case that verified, or for a system of systems version validated, this release. `verifiedBy` is taken by the native relation from a requirement to its case. */
    }
    metadata def AffectsRelease :> MemoTypedDependency {
        doc /* `#AffectsRelease dependency from <change request> to <record>;` The release a change request is raised against. */
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
