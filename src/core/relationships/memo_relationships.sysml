package memo_core_relationships {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import Connections::BinaryConnection;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    private import Allocations::Allocation;
    // All MEMO relations are native SysML v2 `connection def`s (each is a
    // Connection/Association), specializing the MemoRelationship base. The
    // relationship name is the verb; the RelationshipRegistry derives the
    // navigable type as camelCase(name) and navigation is bidirectional.
    //
    // MemoRelationship roots on the SysML v2 standard library's
    // Connections::BinaryConnection rather than floating free. Every two-ended
    // `connection def` implicitly specializes it anyway; saying so explicitly
    // is what lets MEMO relations be read as ordinary SysML connections by any
    // conforming tool instead of as a MEMO-private construct.
    //
    // A relation is a MEMO element like any other, so it carries the same
    // identification core as the part/action/item/requirement bases in
    // memo_core_common — with four exceptions: `name`, `description`,
    // `rationale` and `status` are native.
    //
    // Their native forms: - `name`        → the connection usage's own declared
    // name (`connection linkFoo : Bar …`), which every usage already has. -
    // `description` → `doc /* … */` on the usage. - `rationale`   → standard
    // `Rationale` metadata: `@Rationale { :>> text = "…"; }`
    // (ModelingMetadata.sysml:95). `text` is exported into
    // `rel.attributes.rationale` by the builder. - `status`      → standard
    // `StatusInfo` metadata: `@StatusInfo { :>> status = StatusKind::…; }`
    // (ModelingMetadata.sysml:60). StatusKind (open/tbd/tbr/tbc/done/closed) is
    // NOT ElementStatusKind
    // (proposed/draft/inReview/approved/released/deprecated/retired) — the
    // mapping between them, and why no MEMO-side conversion code exists, is
    // recorded in docs/reference/naming-and-native-constructs.md. Exported into
    // `rel.attributes.status`. Both metadata defs live in the standard
    // `ModelingMetadata` package; `private import ModelingMetadata::*;`
    // wherever they are applied.
    //
    // isReflexive/isUnique are structural properties of the relation itself,
    // declared here so authoring and validation read them from the ontology
    // instead of assuming them. Both are unset on the base and carry the
    // conservative reading: a relation forbids self-links and forbids repeats
    // unless it says otherwise. A subtype opts out by redefining, e.g.
    // `attribute :>> isReflexive = true;`.
    abstract connection def MemoRelationship :> Connections::BinaryConnection {
        @MemoIdentity { :>> label = "Relationship"; }
        attribute id : String;
        attribute uuid : String;
        attribute shortDescription : String;
        attribute sourceReference : String;
        doc /* True when an element may be related to itself by this relation.
             * Unset is read as false. */
        attribute isReflexive : Boolean;
        doc /* True when at most one link of this type may join the same ordered
             * pair of elements — KerML Feature::isUnique over the relation.
             * Unset is read as true. */
        attribute isUnique : Boolean;
        doc /* True when this relation is a connector between two parts, the kind of link that makes a part
             * count as wired in an internal block diagram (rule AR-IBD-001). Trace, allocation, deployment and
             * satisfaction links are not. Unset is read as false. Interface and flow usages are connectors by
             * their language construct and need no value. */
        attribute isConnector : Boolean;
        doc /* True when this relation records where an element's obligation comes from or how it is answered:
             * a link to a requirement, a risk, a verification, a standard or a controlled document. Authoring
             * surfaces offer these as traces, and a coverage report reads them as traceability. Structure,
             * allocation, deployment and context links are not. Unset is read as false. */
        attribute isTrace : Boolean;
    }

    // ─── Typed dependencies ─────────────────────────────────────────────
    //
    // A link whose ends are not both usages cannot be a `connection def`: a
    // connection joins features, and a `ref` cannot point at a definition. SysML
    // already has the construct for a client and a supplier that are any element,
    // the Dependency (SysML-textual-bnf.kebnf:51-59), and a metadata prefix
    // names what kind of dependency it is (`#RealizesFeature dependency from a to
    // b;`, PrefixMetadataAnnotation, kebnf:52). A `metadata def` that specializes
    // this marker declares such a link as a MEMO relation: it joins the
    // relationship registry under camelCase(name), is navigated like any other
    // relation, and needs a row in the workspace-membership table. A metadata
    // def that does not specialize it (`EnforcesClause`) is plain metadata on a
    // dependency and builds no relation. Source is the client, target the
    // supplier. Ends are untyped: what a relation may join is a rule's to say
    // (see the note above on metaclass-neutral ends).
    abstract metadata def MemoTypedDependency;

    // ─── Metaclass-neutral ends ──────────────────────────────
    //
    // An end is left UNTYPED (`:>> source` / `:>> target`) wherever its
    // legitimate endpoints do not share a MEMO base, and a rule in
    // memo_rules_ontology states the constraint.
    //
    // The reason is structural, not stylistic. KerML will not let a port or a
    // behaviour specialize a part-based type, so a `MemoPart`-typed end forces
    // everything it accepts to be a part. It would also make `allocate
    // <function> to <actor>` — ARCADIA's own System Analysis mechanism —
    // illegal, since Actor is a MemoPart but not a narrower part subtype.
    //
    // Ends that are typed are typed on purpose: `verificationCase` and
    // `validationCase` are verification defs, `performed` and `enabled` are
    // MemoActions, `targetRequirement` is a MemoRequirementElement. Those ends
    // name one metaclass and mean it.
    //
    // The constraints on untyped ends are rules: see CR-ONT-060..CR-ONT-071 in
    // src/rules/ontology/ontology_invariants.sysml.
    //
    // There is no general MEMO relation joining any two elements whatever
    // their metaclass: SysML's native `dependency` already is one. Use
    // `dependency` when no specific relation carries the meaning, and say why
    // in a comment — an untyped link with no stated reason is an audit gap,
    // not a model fact.

    // An item belongs to the scope of one system or system of systems: a need,
    // requirement, risk or verification case that describes, constrains or
    // assesses that system and is its to deliver or verify. Imported records
    // arrive with no design element to anchor them (a requirement is not
    // allocated to anything yet), so this is how an import says whose they are;
    // without it they are Unassigned in every workspace. The target is the
    // system, typed as a part (a System and a SystemOfSystems both are). The
    // source stays untyped: the items span metaclasses (a need is a requirement
    // def, a risk an item, a verification case an action), as for DerivesFrom.
    connection def ScopedTo :> MemoRelationship {
        @MemoIdentity { :>> label = "Scoped to"; }
        end scopedItem :>> source;
        end scopeSystem : MemoPart :>> target;
    }
    abstract connection scopedToLinks : ScopedTo[*];
    metadata def <scopedTo> ScopedToMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = scopedToLinks meta SysML::Usage;
    }

    connection def DerivesFrom :> MemoRelationship {
        @MemoIdentity { :>> label = "Derives from"; }
        attribute :>> isTrace = true;
        // Drivers span metaclasses — a need is a requirement def, a hazard an
        // item, a threat an item — so the source end stays untyped. The target
        // is now typed: since Requirement re-rooted onto MemoRequirement, one
        // type name covers the whole requirement family.
        end sourceDriver :>> source;
        end targetRequirement : MemoRequirementElement :>> target;
    }
    abstract connection derivesFromLinks : DerivesFrom[*];
    metadata def <derivesFrom> DerivesFromMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = derivesFromLinks meta SysML::Usage;
    }
    // A realization (realizing/concrete element → realized/abstract element) is
    // native `#refinement dependency`: write `#refinement dependency
    // <realizing> to <realized>;`. `#refinement` places no metaclass
    // restriction on either end.
    connection def ProducesEvidence :> MemoRelationship {
        @MemoIdentity { :>> label = "Produces evidence"; }
        attribute :>> isTrace = true;
        end producer : MemoVerificationCase :>> source;
        end producedEvidence : MemoEvidence :>> target;
    }
    abstract connection producesEvidenceLinks : ProducesEvidence[*];
    metadata def <producesEvidence> ProducesEvidenceMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = producesEvidenceLinks meta SysML::Usage;
    }
    // Precedence is native `succession` (`first a then b;`).

    connection def DerivesCyberRequirement :> MemoRelationship {
        @MemoIdentity { :>> label = "Derives cyber requirement"; }
        attribute :>> isTrace = true;
        end sourceThreatOrRisk : RequirementDriver :>> source;
        end targetRequirement : MemoRequirementElement :>> target;
    }
    abstract connection derivesCyberRequirementLinks : DerivesCyberRequirement[*];
    metadata def <derivesCyberRequirement> DerivesCyberRequirementMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = derivesCyberRequirementLinks meta SysML::Usage;
    }
    connection def CrossesTrustBoundary :> MemoRelationship {
        @MemoIdentity { :>> label = "Crosses trust boundary"; }
        attribute crossingKind : InterfaceKind;
        end boundary :>> source;
        end crossingItem :>> target;
    }
    abstract connection crossesTrustBoundaryLinks : CrossesTrustBoundary[*];
    metadata def <crossesTrustBoundary> CrossesTrustBoundaryMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = crossesTrustBoundaryLinks meta SysML::Usage;
    }

    connection def Validates :> MemoRelationship {
        @MemoIdentity { :>> label = "Validates"; }
        attribute :>> isTrace = true;
        // Validation targets include use cases and other behavioural elements,
        // so the target remains untyped across SysML metaclass families.
        end validationTarget :>> source;
        end validationCase : MemoVerificationCase :>> target;
    }
    abstract connection validatesLinks : Validates[*];
    metadata def <validates> ValidatesMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = validatesLinks meta SysML::Usage;
    }

    // An enabling system or function enabling a workflow or activity is a
    // native `dependency`: write `dependency from <enabling> to <enabled>;`.

    // A processing node hosted by an assembly is allocated to it. The builder
    // binds ends by position, so write them in this order. See the
    // reversed-end-name lint in memo-tools.
    allocation def HostedBy :> MemoRelationship, Allocations::Allocation {
        @MemoIdentity { :>> label = "Hosted by"; }
        end processingNode : MemoPart :>> source;
        end hostAssembly : MemoPart :>> target;
    }
    abstract connection hostedByLinks : HostedBy[*];
    metadata def <hostedBy> HostedByMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::AllocationDefinition;
        :> annotatedElement : SysML::AllocationUsage;
        :>> baseType = hostedByLinks meta SysML::Usage;
    }




    // Containment is NESTING — the child is declared inside the parent — which
    // is how SysML v2 models composition: composite feature ownership, not a
    // link.
    //
    // The builder synthesizes a `composes` edge from every nested part and
    // item, so rules, the DSM and traceability read containment as a graph. The
    // edge type is registered natively in memo-tools' relationship registry.


    connection def BindsToInterface :> MemoRelationship {
        @MemoIdentity { :>> label = "Binds to interface"; }
        end portElement :>> source;
        end boundInterface :>> target;
    }
    abstract connection bindsToInterfaceLinks : BindsToInterface[*];
    metadata def <bindsToInterface> BindsToInterfaceMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = bindsToInterfaceLinks meta SysML::Usage;
    }
}
