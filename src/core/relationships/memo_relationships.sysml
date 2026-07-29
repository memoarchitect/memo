package memo_core_relationships {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    // All MEMO relations are native SysML v2 `connection def`s (each is a
    // Connection/Association), specializing the MemoRelationship base. The
    // relationship name is the verb; the RelationshipRegistry derives the
    // navigable type as camelCase(name) and navigation is bidirectional.
    // Structural properties of a relation, declared here so authoring and
    // validation read them from the ontology instead of assuming them. Both are
    // unset on the base and carry the conservative reading: a relation forbids
    // self-links and forbids repeats unless it says otherwise. A subtype opts
    // out by redefining, e.g. `attribute :>> isReflexive = true;`.
    abstract connection def MemoRelationship {
        attribute linkStatus : LinkStatusKind;
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
    // only when no specific relation carries the meaning, and say why in
    // linkRationale — an untyped link with no stated reason is an audit gap,
    // not a model fact.
    connection def MemoLink :> MemoRelationship {
        doc /* Generic association between any two model elements. */
        attribute linkRationale : String;
        end linkSource;
        end linkTarget;
    }

    connection def DerivesFrom :> MemoRelationship {
        // Drivers include needs and hazards (ISO 14971: hazards drive
        // requirements). targetRequirement is untyped: Need is a requirement def
        // (MemoNeed + RequirementDriver) and does not conform to VerifiableElement
        // under SysIDE related-feature-conformance.
        end sourceDriver : MemoPart;
        end targetRequirement;
    }
    connection def SatisfiedBy :> MemoRelationship {
        // Untyped: Need (requirement) instances must participate alongside Requirement.
        end requiredElement;
        end satisfyingElement : ArchitectureElement;
    }
    // Mitigates unifies the control/action → risk-element edges of the
    // ISO 14971 / FMEA / FTA / cyber chains — MitigatesHazard,
    // MitigatesVulnerability, MitigatedByControl, BrokenByControl,
    // AddressedByAction — keyed by mitigationKind. control is the mitigating
    // control/action; mitigatedElement is the hazard/vulnerability/failure/cut set.
    enum def MitigationKind {
        enum hazard;
        enum vulnerability;
        enum failureMode;
        enum cutSet;
        enum fmeaAction;
    }
    connection def Mitigates :> MemoRelationship {
        attribute mitigationKind : MitigationKind;
        // Untyped: controls/hazards may be item defs (RiskControlMeasure, Hazard, …).
        end control;
        end mitigatedElement;
    }
    connection def AllocatedTo :> MemoRelationship {
        end function : ArchitectureElement;
        end allocatedElement : ArchitectureElement;
    }
    // Realizes is the single realization relation (realizing/concrete element →
    // realized/abstract element). It unifies RealizesInterface,
    // RealizesComponentExchange, RealizedByArchitecture, RealizesScenario,
    // ModuleRealizesLogical, ComponentRealizesModule, PhysicalModuleRealizesLogical,
    // Implements{Component,Procedure}, UIRealizesFunctional,
    // FunctionalRealizesOper{ative,ational} and ScenarioRealizesUseCase.
    connection def Realizes :> MemoRelationship {
        end realizing : MemoPart;
        end realized : MemoPart;
    }
    connection def VerifiedBy :> MemoRelationship {
        // Requirements, risk controls, and architecture components are
        // all legitimate verification targets
        end verificationTarget : MemoPart;
        end verificationCase : MemoVerificationCase;
    }
    connection def ProducesEvidence :> MemoRelationship {
        end producer : MemoVerificationCase;
        end producedEvidence : MemoEvidence;
    }
    connection def IncludedIn :> MemoRelationship {
        end sourceElement : MemoPart;
        end targetView : MemoPart;
    }
    connection def Precedes :> MemoRelationship {
        attribute sameStepRequired : Boolean;
        attribute precedenceRationale : String;
        end predecessor : ArchitectureElement;
        end successor : ArchitectureElement;
    }
    connection def ResolvesToMethodology :> MemoRelationship {
        end boundModelElement : MemoPart;
        end resolvedMethodology : MemoPart;
    }

    // ISO 14971 risk chain — distinct sequence-of-events relations over risk elements.
    connection def TracesRisk :> MemoRelationship {
        end sourceRiskElement : MemoPart;
        end targetRiskElement : MemoPart;
    }
    connection def AssessedAgainst :> MemoRelationship {
        end risk : MemoPart;
        end riskMatrix : MemoPart;
    }

    connection def ThreatenedBy :> MemoRelationship {
        attribute threatRole : String;
        end protectedAsset : ArchitectureElement;
        end realizedThreat : RequirementDriver;
    }
    connection def Exploits :> MemoRelationship {
        end realizedThreat : RequirementDriver;
        end enablingVulnerability : MemoPart;
    }
    connection def RealizedByScenario :> MemoRelationship {
        end realizedThreat : RequirementDriver;
        end scenario : MemoPart;
    }
    connection def DerivesCyberRequirement :> MemoRelationship {
        end sourceThreatOrRisk : RequirementDriver;
        end targetRequirement : VerifiableElement;
    }
    connection def ImpactsSafety :> MemoRelationship {
        attribute tracePurpose : String;
        end cyberElement : MemoPart;
        end safetyElement : MemoPart;
    }
    connection def CrossesTrustBoundary :> MemoRelationship {
        attribute crossingKind : InterfaceKind;
        end boundary : InterfaceElement;
        end crossingItem : MemoPart;
    }

    connection def Validates :> MemoRelationship {
        // Validation targets include use cases and other behavioural elements,
        // so the target remains untyped across SysML metaclass families.
        end validationTarget;
        end validationCase : MemoVerificationCase;
    }
    connection def DependsOnSoup :> MemoRelationship {
        end component : ArchitectureElement;
        end soupItem : MemoPart;
    }

    // Performs unifies the former Performs / PerformsActivity / PerformsFunction
    // synonyms. The performer (operational entity, actor, or system action) and
    // the performed element (activity or function) are distinguished by the end
    // instance types, so generic MemoPart ends keep this in core without a
    // dependency on architecture-layer types.
    connection def Performs :> MemoRelationship {
        end performer : MemoPart;
        end performed : MemoPart;
    }

    // Enables unifies the former EnablesWorkflow / EnablesActivity synonyms
    // (an enabling system/function enables a workflow/activity).
    connection def Enables :> MemoRelationship {
        end enabling : MemoPart;
        end enabled : MemoPart;
    }

    connection def HostedBy :> MemoRelationship {
        end processingNode : ArchitectureElement;
        end hostAssembly : ArchitectureElement;
    }

    connection def HasFailureMode :> MemoRelationship {
        end element : ArchitectureElement;
        end failureMode : MemoPart;
    }
    // Causes unifies the former causal edges of the ISO 14971 / FMEA / FTA
    // chains — CausesEffect, CausedBy, ContributesToHazard, LeadsToHazard,
    // OriginatesFrom, UseErrorLeadsToHazard — keyed by causeKind. cause is the
    // originating element, effect the consequence.
    enum def CauseKind {
        enum failureCausesEffect;
        enum failureCausedBy;
        enum contributesToHazard;
        enum leadsToHazard;
        enum originatesFrom;
        enum useErrorLeadsToHazard;
    }
    connection def Causes :> MemoRelationship {
        attribute causeKind : CauseKind;
        end cause : MemoPart;
        end effect : MemoPart;
    }
    connection def DetectedBy :> MemoRelationship {
        end failureMode : MemoPart;
        end detectionMethod : MemoPart;
    }

    connection def InputToGate :> MemoRelationship {
        end input : MemoPart;
        end gate : MemoPart;
    }
    connection def ProducesEvent :> MemoRelationship {
        end gate : MemoPart;
        end eventElement : MemoPart;
    }
    connection def ContainsEvent :> MemoRelationship {
        end cutSet : MemoPart;
        end eventElement : MemoPart;
    }

    connection def Decides :> MemoRelationship {
        end decision : MemoPart;
        end affectedElement : MemoPart;
    }

    // Composes is the single whole/part decomposition relation. It unifies the
    // former ComposesLogical / AssemblyComprises / Contains{Component,Element} /
    // {Workflow,Task,Activity,Scenario}Comprises* / FlowComprisesSpec /
    // Collection membership is carried by the end instance.
    // types, so the ends are generic MemoPart.
    connection def Composes :> MemoRelationship {
        end parent : MemoPart;
        end child : MemoPart;
    }

    connection def IdentifiesHazard :> MemoRelationship {
        end deviation : MemoPart;
        end hazard : MemoPart;
    }
    connection def AnalyzedBy :> MemoRelationship {
        end element : ArchitectureElement;
        end analysisArtifact : AnalysisArtifact;
    }

    connection def Changes :> MemoRelationship {
        end changeRequest : MemoPart;
        end changedElement : MemoPart;
    }
    connection def TestedByUsability :> MemoRelationship {
        end uiElementOrTask : MemoPart;
        end usabilityTest : VerifiableElement;
    }
    connection def FeedsBackTo :> MemoRelationship {
        end feedbackItem : MemoPart;
        end designElement : MemoPart;
    }
    connection def BindsToInterface :> MemoRelationship {
        end portElement : InterfaceElement;
        end boundInterface : InterfaceElement;
    }
}
