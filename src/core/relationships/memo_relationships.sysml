package memo_core_relationships {
    private import ScalarValues::*;

    private import Connections::BinaryConnection;

    private import memo_core_common::*;
    private import memo_core_dimensions::*;   // ElementStatusKind
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
    // memo_core_common — including `status`. The former `linkStatus`
    // (planned/active/verified/obsolete) is gone: a link being "verified" was
    // never an editorial state, and the other three duplicated
    // ElementStatusKind under different words.
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
        attribute name : String;
        attribute shortDescription : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
        attribute status : ElementStatusKind;
        doc /* True when an element may be related to itself by this relation.
             * Unset is read as false. */
        attribute isReflexive : Boolean;
        doc /* True when at most one link of this type may join the same ordered
             * pair of elements — KerML Feature::isUnique over the relation.
             * Unset is read as true. */
        attribute isUnique : Boolean;
    }

    // The general relation that can join any two model elements, whatever
    // their metaclass. Most specific relations type their ends against a
    // foundation (MemoPart, VerifiableElement, …). A small number of specific
    // cross-metaclass relations leave an end untyped because their accepted
    // constructs have no shared MEMO base; their names and attributes still
    // carry a precise engineering meaning. MemoLink leaves both ends untyped
    // and adds no domain-specific semantics, which is what makes it universal.
    //
    // It is deliberately the weakest relation in the ontology. Reach for it
    // only when no specific relation carries the meaning, and say why in the
    // inherited `rationale` — an untyped link with no stated reason is an
    // audit gap, not a model fact.
    connection def MemoLink :> MemoRelationship {
        doc /* Generic association between any two model elements. */
        end linkSource :>> source;
        end linkTarget :>> target;
    }

    connection def DerivesFrom :> MemoRelationship {
        // Drivers span metaclasses — a need is a requirement def, a hazard an
        // item, a threat an item — so the source end stays untyped. The target
        // is now typed: since Requirement re-rooted onto MemoRequirement, one
        // type name covers the whole requirement family.
        end sourceDriver :>> source;
        end targetRequirement : MemoRequirementElement :>> target;
    }
    connection def SatisfiedBy :> MemoRelationship {
        // MemoRequirementElement covers Need and Requirement alike.
        end requiredElement : MemoRequirementElement :>> source;
        end satisfyingElement : ArchitectureElement :>> target;
    }
    connection def AllocatedTo :> MemoRelationship {
        end function : ArchitectureElement :>> source;
        end allocatedElement : ArchitectureElement :>> target;
    }
    // Realizes is the single realization relation (realizing/concrete element →
    // realized/abstract element). It unifies RealizesInterface,
    // RealizesComponentExchange, RealizedByArchitecture, RealizesScenario,
    // ModuleRealizesLogical, ComponentRealizesModule, PhysicalModuleRealizesLogical,
    // Implements{Component,Procedure}, UIRealizesFunctional,
    // FunctionalRealizesOper{ative,ational} and ScenarioRealizesUseCase.
    connection def Realizes :> MemoRelationship {
        // Realization crosses structural and behavioral metaclasses (for
        // example a FunctionalFlow route realizing a FunctionalScenario).
        end realizing :>> source;
        end realized :>> target;
    }
    connection def VerifiedBy :> MemoRelationship {
        // Requirements, risk controls, and architecture components are
        // all legitimate verification targets
        end verificationTarget : MemoPart :>> source;
        end verificationCase : MemoVerificationCase :>> target;
    }
    connection def ProducesEvidence :> MemoRelationship {
        end producer : MemoVerificationCase :>> source;
        end producedEvidence : MemoEvidence :>> target;
    }
    connection def Precedes :> MemoRelationship {
        attribute sameStepRequired : Boolean;
        attribute precedenceRationale : String;
        end predecessor : ArchitectureElement :>> source;
        end successor : ArchitectureElement :>> target;
    }


    connection def ThreatenedBy :> MemoRelationship {
        attribute threatRole : String;
        end protectedAsset : ArchitectureElement :>> source;
        end realizedThreat : RequirementDriver :>> target;
    }
    connection def DerivesCyberRequirement :> MemoRelationship {
        end sourceThreatOrRisk : RequirementDriver :>> source;
        end targetRequirement : MemoRequirementElement :>> target;
    }
    connection def CrossesTrustBoundary :> MemoRelationship {
        attribute crossingKind : InterfaceKind;
        end boundary : InterfaceElement :>> source;
        end crossingItem : MemoExchangeItem :>> target;
    }

    connection def Validates :> MemoRelationship {
        // Validation targets include use cases and other behavioural elements,
        // so the target remains untyped across SysML metaclass families.
        end validationTarget :>> source;
        end validationCase : MemoVerificationCase :>> target;
    }

    // Performs unifies the former Performs / PerformsActivity / PerformsFunction
    // synonyms. The performer (operational entity, actor, or system action) and
    // the performed element (activity or function) are distinguished by the end
    // instance types, so generic MemoPart ends keep this in core without a
    // dependency on architecture-layer types.
    connection def Performs :> MemoRelationship {
        end performer : MemoPart :>> source;
        end performed : MemoAction :>> target;
    }

    // Enables unifies the former EnablesWorkflow / EnablesActivity synonyms
    // (an enabling system/function enables a workflow/activity).
    connection def Enables :> MemoRelationship {
        end enabling : MemoPart :>> source;
        end enabled : MemoAction :>> target;
    }

    connection def HostedBy :> MemoRelationship {
        end processingNode : ArchitectureElement :>> source;
        end hostAssembly : ArchitectureElement :>> target;
    }




    // Composes is the single whole/part decomposition relation. It unifies the
    // former ComposesLogical / AssemblyComprises / Contains{Component,Element} /
    // {Workflow,Task,Activity,Scenario}Comprises* / FlowComprisesSpec /
    // Collection membership is carried by the end instance.
    // types, so the ends are generic MemoPart.
    connection def Composes :> MemoRelationship {
        end parent : MemoPart :>> source;
        end child : MemoPart :>> target;
    }

    connection def AnalyzedBy :> MemoRelationship {
        end element : ArchitectureElement :>> source;
        end analysisArtifact : AnalysisArtifact :>> target;
    }

    connection def BindsToInterface :> MemoRelationship {
        end portElement : InterfaceElement :>> source;
        end boundInterface : InterfaceElement :>> target;
    }
}
