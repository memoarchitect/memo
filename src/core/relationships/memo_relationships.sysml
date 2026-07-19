package memo_core_relationships {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    // All MEMO relations are native SysML v2 `connection def`s (each is a
    // Connection/Association), specializing the MemoRelationship base. The
    // relationship name is the verb; the RelationshipRegistry derives the
    // navigable type as camelCase(name) and navigation is bidirectional.
    abstract connection def MemoRelationship { attribute linkStatus : LinkStatusKind; }

    connection def DerivesFrom :> MemoRelationship {
        // Drivers include needs and hazards (ISO 14971: hazards drive
        // requirements), so the source stays at TraceableElement
        end sourceDriver : TraceableElement;
        end targetRequirement : VerifiableElement;
    }
    connection def SatisfiedBy :> MemoRelationship {
        end requiredElement : VerifiableElement;
        end satisfyingElement : ArchitectureElement;
    }
    connection def MitigatesHazard :> MemoRelationship {
        end riskControl : VerifiableElement;
        end mitigatedHazard : TraceableElement;
    }
    connection def AllocatedTo :> MemoRelationship {
        end function : ArchitectureElement;
        end allocatedElement : ArchitectureElement;
    }
    connection def RealizesInterface :> MemoRelationship {
        end logicalInterface : InterfaceElement;
        end physicalInterface : InterfaceElement;
    }
    connection def VerifiedBy :> MemoRelationship {
        // Requirements, risk controls, and architecture components are
        // all legitimate verification targets
        end verificationTarget : TraceableElement;
        end verificationCase : VerifiableElement;
    }
    connection def ProducesEvidence :> MemoRelationship {
        end producer : VerifiableElement;
        end producedEvidence : MemoEvidence;
    }
    connection def IncludedIn :> MemoRelationship {
        end sourceElement : TraceableElement;
        end targetView : TraceableElement;
    }
    connection def Precedes :> MemoRelationship {
        attribute sameStepRequired : Boolean;
        attribute precedenceRationale : String;
        end predecessor : ArchitectureElement;
        end successor : ArchitectureElement;
    }
    connection def ResolvesToMethodology :> MemoRelationship {
        end boundModelElement : TraceableElement;
        end resolvedMethodology : TraceableElement;
    }

    // ISO 14971 risk chain — distinct sequence-of-events relations over risk elements.
    connection def TracesRisk :> MemoRelationship {
        end sourceRiskElement : TraceableElement;
        end targetRiskElement : TraceableElement;
    }
    connection def AssessedAgainst :> MemoRelationship {
        end risk : TraceableElement;
        end riskMatrix : TraceableElement;
    }

    connection def ThreatenedBy :> MemoRelationship {
        attribute threatRole : String;
        end protectedAsset : ArchitectureElement;
        end realizedThreat : RequirementDriver;
    }
    connection def Exploits :> MemoRelationship {
        end realizedThreat : RequirementDriver;
        end enablingVulnerability : TraceableElement;
    }
    connection def RealizedByScenario :> MemoRelationship {
        end realizedThreat : RequirementDriver;
        end scenario : TraceableElement;
    }
    connection def MitigatesVulnerability :> MemoRelationship {
        end enablingVulnerability : TraceableElement;
        end mitigation : VerifiableElement;
    }
    connection def DerivesCyberRequirement :> MemoRelationship {
        end sourceThreatOrRisk : RequirementDriver;
        end targetRequirement : VerifiableElement;
    }
    connection def ImpactsSafety :> MemoRelationship {
        attribute tracePurpose : String;
        end cyberElement : TraceableElement;
        end safetyElement : TraceableElement;
    }
    connection def CrossesTrustBoundary :> MemoRelationship {
        attribute crossingKind : InterfaceKind;
        end boundary : InterfaceElement;
        end crossingItem : TraceableElement;
    }

    connection def DerivesInto :> MemoRelationship {
        end parentRequirement : VerifiableElement;
        end childRequirement : VerifiableElement;
    }
    connection def DeploysOnto :> MemoRelationship {
        attribute deploymentKind : DeploymentKind;
        end softwareComponent : ArchitectureElement;
        end hostAssembly : ArchitectureElement;
    }
    connection def Validates :> MemoRelationship {
        end validationTarget : VerifiableElement;
        end validationCase : VerifiableElement;
    }
    connection def DependsOnSoup :> MemoRelationship {
        end component : ArchitectureElement;
        end soupItem : TraceableElement;
    }

    // Performs, ContributesToCapability, SequencesStep, DerivesSystemNeed
    // (operational-entity ends) and InvolvesFunction,
    // RealizesScenario (functional-chain ends) live in their owning
    // architecture layer packages — memo::architecture::operational and
    // memo::architecture::system respectively — because core must not
    // depend on architecture-layer types. See memo_operational.sysml and
    // memo_system_analysis.sysml.

    connection def HostedBy :> MemoRelationship {
        end processingNode : ArchitectureElement;
        end hostAssembly : ArchitectureElement;
    }
    connection def RealizesComponentExchange :> MemoRelationship {
        end physicalLink : ArchitectureElement;
        end componentExchange : ArchitectureElement;
    }

    connection def HasFailureMode :> MemoRelationship {
        end element : ArchitectureElement;
        end failureMode : TraceableElement;
    }
    connection def CausesEffect :> MemoRelationship {
        end failureMode : TraceableElement;
        end failureEffect : TraceableElement;
    }
    connection def CausedBy :> MemoRelationship {
        end failureMode : TraceableElement;
        end failureCause : TraceableElement;
    }
    connection def DetectedBy :> MemoRelationship {
        end failureMode : TraceableElement;
        end detectionMethod : TraceableElement;
    }
    connection def AddressedByAction :> MemoRelationship {
        end failureMode : TraceableElement;
        end fmeaAction : VerifiableElement;
    }

    connection def InputToGate :> MemoRelationship {
        end input : TraceableElement;
        end gate : TraceableElement;
    }
    connection def ProducesEvent :> MemoRelationship {
        end gate : TraceableElement;
        end eventElement : TraceableElement;
    }
    connection def OriginatesFrom :> MemoRelationship {
        end eventElement : TraceableElement;
        end origin : ArchitectureElement;
    }
    connection def ContainsEvent :> MemoRelationship {
        end cutSet : TraceableElement;
        end eventElement : TraceableElement;
    }

    connection def Decides :> MemoRelationship {
        end decision : TraceableElement;
        end affectedElement : TraceableElement;
    }

    connection def Composes :> MemoRelationship {
        end parent : ArchitectureElement;
        end child : ArchitectureElement;
    }
    connection def AllocatesExchange :> MemoRelationship {
        end functionalFlow : ArchitectureElement;
        end componentExchange : ArchitectureElement;
    }

    connection def ContributesToHazard :> MemoRelationship {
        end failureMode : TraceableElement;
        end hazard : TraceableElement;
    }
    connection def LeadsToHazard :> MemoRelationship {
        end topEvent : TraceableElement;
        end hazard : TraceableElement;
    }
    connection def IdentifiesHazard :> MemoRelationship {
        end deviation : TraceableElement;
        end hazard : TraceableElement;
    }
    connection def AnalyzedBy :> MemoRelationship {
        end element : ArchitectureElement;
        end analysisArtifact : TraceableElement;
    }
    connection def MitigatedByControl :> MemoRelationship {
        end failureMode : TraceableElement;
        end riskControl : VerifiableElement;
    }
    connection def BrokenByControl :> MemoRelationship {
        end cutSet : TraceableElement;
        end riskControl : VerifiableElement;
    }

    connection def Changes :> MemoRelationship {
        end changeRequest : TraceableElement;
        end changedElement : TraceableElement;
    }
    connection def TestedByUsability :> MemoRelationship {
        end uiElementOrTask : TraceableElement;
        end usabilityTest : VerifiableElement;
    }
    connection def FeedsBackTo :> MemoRelationship {
        end feedbackItem : TraceableElement;
        end designElement : TraceableElement;
    }
    connection def BindsToInterface :> MemoRelationship {
        end portElement : InterfaceElement;
        end boundInterface : InterfaceElement;
    }
}
