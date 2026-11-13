package memo_artifacts_configuration_management {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;
    private import memo_core_relationships::*;   // MemoRelationship

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    part def ChangeRequest :> MemoPart {
        @MemoIdentity { :>> label = "Change request"; }
        attribute changeType : ChangeTypeKind;
        attribute impactAssessment : String;
        attribute approvalStatus : String;
        // The release a change affects is `#AffectsRelease dependency from <request> to <record>;`
        // (below), not a string naming a baseline.
    }

    part def ConfigurationItem :> MemoPart {
        @MemoIdentity { :>> label = "Configuration item"; }
        // No version and no baseline: both belong to a release of the item, not
        // to the item. A `ReleaseRecord` whose `#ReleaseOf` is this item
        // carries them.
        attribute controlLevel : String;
    }

    // A release record is one release of one item: rev D and rev E of a part,
    // or its EU and its US release, are separate records, each with its own
    // part number and revision. The definition of the item is held once and
    // carries no revision. The record is an element with a status (inherited
    // from MemoPart: proposed, draft, ... released), so a release moves through
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
        @MemoIdentity { :>> label = "Release record"; }
        attribute :>> partNumber : String[1];
        attribute :>> revision : String[1];
        attribute softwareVersion : String[0..1];
        attribute codeTag : String[0..1];
        // The commit of the model this release was built from. A record cannot hold the hash of the
        // commit that adds it, so it is written after the commit it pins and is always found in a
        // folder that is not itself pinned (`sos/`).
        attribute modelCommit : String[1];
    }

    metadata def ReleaseOf :> MemoTypedDependency {
        doc /* `#ReleaseOf dependency from <record> to <item definition>;` The record is a release of this item. One record, one item. */
        @MemoIdentity { :>> label = "Release of"; }
    }
    metadata def Contains :> MemoTypedDependency {
        doc /* `#Contains dependency from <record> to <record>, <record>;` The release pins these releases: a system of systems version its systems, a system release its components. */
        @MemoIdentity { :>> label = "Contains"; }
    }
    metadata def Implements :> MemoTypedDependency {
        doc /* `#Implements dependency from <record> to <interface record>;` The release implements this revision of an interface. */
        @MemoIdentity { :>> label = "Implements"; }
    }
    metadata def VerifiedByCase :> MemoTypedDependency {
        doc /* `#VerifiedByCase dependency from <record> to <verification case>;` The case that verified, or for a system of systems version validated, this release. `verifiedBy` is taken by the native relation from a requirement to its case. */
        @MemoIdentity { :>> label = "Verified by case"; }
    }
    metadata def AffectsRelease :> MemoTypedDependency {
        doc /* `#AffectsRelease dependency from <change request> to <record>;` The release a change request is raised against. */
        @MemoIdentity { :>> label = "Affects release"; }
    }

    // A regulated device is one approval in one jurisdiction: the thing a
    // regulator is asked to clear. It is not an item and not a release: it
    // COVERS the system releases the approval names, so two markets can ship
    // different releases of one system, each with its own design history and
    // risk file.
    //
    //   part deviceFda : RegulatedDevice {
    //       attribute :>> jurisdiction = RegulatoryRegimeKind::FDA_510k;
    //       attribute :>> submissionId = "K123456";
    //   }
    //   #Covers dependency from deviceFda to relPumpD;
    //
    // The jurisdiction is a `RegulatoryRegimeKind`, the same enum the standards
    // library and the document templates (`required_for`) are written against,
    // so a device selects the standards it must meet and the documents it must
    // have. `ModelMethodBinding.regulatoryRegime` states one regime set for a
    // whole model and is read only when the model declares no device.
    //
    // The device's other two links, both typed dependencies like `Covers`:
    //
    //   #IntendedUseOf dependency from pumpIntendedUse to deviceFda;
    //   #UsedWith dependency from deviceFda to deviceInfusionSet;
    //
    // `IntendedUseOf` runs from the intended use (a `requirement def`,
    // `IntendedUse`) to the device, as its name reads; a device can have one
    // per indication. `UsedWith` runs between regulated devices: the compatible
    // devices and accessories that are themselves approved. An accessory that
    // is not a device is not a target.
    part def RegulatedDevice :> MemoPart {
        @MemoIdentity { :>> label = "Regulated device"; }
        attribute jurisdiction : RegulatoryRegimeKind[1];
        attribute submissionId : String[0..1];
    }

    metadata def Covers :> MemoTypedDependency {
        doc /* `#Covers dependency from <device>, to <record>, <record>;` The approval covers these system releases. */
        @MemoIdentity { :>> label = "Covers"; }
    }
    metadata def IntendedUseOf :> MemoTypedDependency {
        doc /* `#IntendedUseOf dependency from <intended use> to <device>;` The intended use (a requirement) states what this device is for. */
        @MemoIdentity { :>> label = "Intended use of"; }
    }
    metadata def UsedWith :> MemoTypedDependency {
        doc /* `#UsedWith dependency from <device> to <device>, <device>;` The device is used with these regulated devices (compatible devices and approved accessories). */
        @MemoIdentity { :>> label = "Used with"; }
    }

    // A project is a change set in an iteration: the work that produces
    // releases. It holds a link to where the work is tracked and nothing else;
    // the merge request is the approval. It FEEDS the release records it
    // contributes to, and a variant records the project that introduced it, so
    // "which work gave us this option, and which releases did it reach" is two
    // links.
    //
    //   part prjIrrigatedTip : Project { attribute :>> trackerLink = "https://tracker.example/PRJ-12"; }
    //   #Feeds dependency from prjIrrigatedTip to relGeneratorEu, relGeneratorUs;
    //   #IntroducedBy dependency from outputStage::usOutput to prjIrrigatedTip;
    part def Project :> MemoPart {
        @MemoIdentity { :>> label = "Project"; }
        attribute trackerLink : String[0..1];
    }

    metadata def Feeds :> MemoTypedDependency {
        doc /* `#Feeds dependency from <project> to <record>, <record>;` The project's work is in these releases. */
        @MemoIdentity { :>> label = "Feeds"; }
    }
    metadata def IntroducedBy :> MemoTypedDependency {
        doc /* `#IntroducedBy dependency from <variant> to <project>;` The project that introduced this variant. */
        @MemoIdentity { :>> label = "Introduced by"; }
    }

    // ── Relations owned by this package ─────────────────────────────
    // Moved out of memo_core_relationships: their ends are typed against
    // types declared here, and core must not depend on a domain package.
    connection def Changes :> MemoRelationship {
        @MemoIdentity { :>> label = "Changes"; }
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
