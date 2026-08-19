package memo_core_relationships {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import Connections::BinaryConnection;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

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
    // memo_core_common — with four exceptions, R10-S5 (2026-08-13). `name`,
    // `description`, `rationale` and `status` were declared here too, and a
    // tree measurement found them dead weight: across every connection usage
    // in src/ and examples/ (876 of them, 77 with a body at all), exactly one
    // ever set `rationale` and none ever set `name`, `description` or
    // `status`. The former `linkStatus` (planned/active/verified/obsolete) is
    // already gone for the same reason: a link being "verified" was never an
    // editorial state.
    //
    // The replacement is native, not a MEMO-authored substitute:
    //   - `name`        → the connection usage's own declared name
    //     (`connection linkFoo : Bar …`), which every usage already has.
    //   - `description` → `doc /* … */` on the usage.
    //   - `rationale`   → standard `Rationale` metadata: `@Rationale { :>> text
    //     = "…"; }` (ModelingMetadata.sysml:95). `text` is exported into
    //     `rel.attributes.rationale` by the builder, same key as before.
    //   - `status`      → standard `StatusInfo` metadata: `@StatusInfo { :>>
    //     status = StatusKind::…; }` (ModelingMetadata.sysml:60). StatusKind
    //     (open/tbd/tbr/tbc/done/closed) is NOT ElementStatusKind
    //     (proposed/draft/inReview/approved/released/deprecated/retired) — the
    //     mapping between them, and why no MEMO-side conversion code exists, is
    //     recorded in docs/reference/naming-and-native-constructs.md. Exported
    //     into `rel.attributes.status`.
    // Both metadata defs live in the standard `ModelingMetadata` package;
    // `private import ModelingMetadata::*;` wherever they are applied.
    //
    // isReflexive/isUnique are structural properties of the relation itself,
    // declared here so authoring and validation read them from the ontology
    // instead of assuming them. Both are unset on the base and carry the
    // conservative reading: a relation forbids self-links and forbids repeats
    // unless it says otherwise. A subtype opts out by redefining, e.g.
    // `attribute :>> isReflexive = true;`.
    abstract connection def MemoRelationship :> Connections::BinaryConnection {
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
    }

    // ─── Metaclass-neutral ends (Track A0) ──────────────────────────────
    //
    // An end is left UNTYPED (`:>> source` / `:>> target`) wherever its
    // legitimate endpoints do not share a MEMO base, and a rule in
    // memo_rules_ontology states the constraint the type used to state.
    //
    // The reason is structural, not stylistic. KerML will not let a port or a
    // behaviour specialize a part-based type, so a `MemoPart`-typed end forces
    // everything it accepts to be a part. That is what made PhysicalPort and
    // SoftwarePort part defs (so they could terminate exchanges), what made
    // SystemFunction a part def with its behaviour stapled on through a
    // separate action def, and what makes `allocate <function> to <actor>` —
    // ARCADIA's own System Analysis mechanism — illegal, since Actor is a
    // MemoPart but not a narrower part subtype.
    //
    // Several of the relaxed ends were ALREADY being violated by real content
    // before they were relaxed: `composes` links parts to OperativeAction
    // (an action def) and to SoftwarePort/PhysicalPort;
    // `precedes` links OperativeAction to OperativeAction; `allocatedTo`
    // has ActionUsage sources; `bindsToInterface` targets an `interface def`,
    // which an InterfaceElement-typed end cannot hold. The types were not
    // buying the strictness they appeared to buy.
    //
    // What is NOT relaxed stays typed on purpose: `verificationCase` and
    // `validationCase` are verification defs, `performed` and `enabled` are
    // MemoActions, `targetRequirement` is a MemoRequirementElement. Those ends
    // name one metaclass and mean it.
    //
    // The strictness did not evaporate — see CR-ONT-060..CR-ONT-071 in
    // src/rules/ontology/ontology_invariants.sysml. Relaxing the ends without
    // those rules would have been a silent loss of every constraint the ends
    // were carrying.
    //
    // The general relation that can join any two model elements, whatever
    // their metaclass. MemoLink leaves both ends untyped and adds no
    // domain-specific semantics, which is what makes it universal.
    //
    // It is deliberately the weakest relation in the ontology. Reach for it
    // only when no specific relation carries the meaning, and say why in the
    // inherited `rationale` — an untyped link with no stated reason is an
    // audit gap, not a model fact.

    connection def DerivesFrom :> MemoRelationship {
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
    // `Realizes` (realizing/concrete element → realized/abstract element) is
    // native `#refinement dependency` (R10-S6): write
    // `#refinement dependency <realizing> to <realized>;` instead. It used to
    // unify RealizesInterface, RealizesComponentExchange,
    // RealizedByArchitecture, RealizesScenario, ModuleRealizesLogical,
    // ComponentRealizesModule, PhysicalModuleRealizesLogical,
    // Implements{Component,Procedure}, UIRealizesFunctional,
    // FunctionalRealizesOper{ative,ational} and ScenarioRealizesUseCase; the
    // native form keeps that reach, since `#refinement` places no metaclass
    // restriction on either end.
    connection def ProducesEvidence :> MemoRelationship {
        end producer : MemoVerificationCase :>> source;
        end producedEvidence : MemoEvidence :>> target;
    }
    abstract connection producesEvidenceLinks : ProducesEvidence[*];
    metadata def <producesEvidence> ProducesEvidenceMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = producesEvidenceLinks meta SysML::Usage;
    }
    // `Precedes` is native `succession` (`first a then b;`), R10-S6.
    // `sameStepRequired`/`precedenceRationale` had zero usages anywhere in
    // the tree (same free-deletion shape R10-S5 found for `rationale`), so
    // there was no content to carry forward.

    connection def ThreatenedBy :> MemoRelationship {
        attribute threatRole : String;
        end protectedAsset : MemoPart :>> source;
        end realizedThreat : RequirementDriver :>> target;
    }
    abstract connection threatenedByLinks : ThreatenedBy[*];
    metadata def <threatenedBy> ThreatenedByMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = threatenedByLinks meta SysML::Usage;
    }
    connection def DerivesCyberRequirement :> MemoRelationship {
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

    // Enables unifies the former EnablesWorkflow / EnablesActivity synonyms
    // (an enabling system/function enables a workflow/activity).
    connection def Enables :> MemoRelationship {
        end enabling :>> source;
        end enabled : MemoAction :>> target;
    }
    abstract connection enablesLinks : Enables[*];
    metadata def <enables> EnablesMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = enablesLinks meta SysML::Usage;
    }

    connection def HostedBy :> MemoRelationship {
        end processingNode : MemoPart :>> source;
        end hostAssembly : MemoPart :>> target;
    }
    abstract connection hostedByLinks : HostedBy[*];
    metadata def <hostedBy> HostedByMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = hostedByLinks meta SysML::Usage;
    }




    // `Composes` is deleted (R10-S7). Containment is NESTING — the child is
    // declared inside the parent — which is how SysML v2 models composition:
    // composite feature ownership, not a link. The relation specialized
    // `Connections::BinaryConnection`, "a link between two things WITHIN some
    // containing structure", so it was the wrong category for the containment
    // itself, and the corpus has no composition connection to specialize.
    //
    // Nothing is lost: the builder synthesizes a `composes` edge from every
    // nested part and item, so rules, the DSM and traceability read exactly the
    // graph they read before. The edge type is registered natively in
    // memo-tools' relationship registry.

    connection def AnalyzedBy :> MemoRelationship {
        end element : MemoPart :>> source;
        end analysisArtifact : AnalysisArtifact :>> target;
    }
    abstract connection analyzedByLinks : AnalyzedBy[*];
    metadata def <analyzedBy> AnalyzedByMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = analyzedByLinks meta SysML::Usage;
    }

    connection def BindsToInterface :> MemoRelationship {
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
