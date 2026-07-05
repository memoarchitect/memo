package memo {
    package core {
        package relationships {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;

            // All MEMO relations are native SysML v2 `connection def`s (each is a
            // Connection/Association), specializing the SemanticLink base. The
            // relationship name is the verb; the RelationshipRegistry derives the
            // navigable type as camelCase(name) and navigation is bidirectional.
            connection def SemanticLink { attribute linkStatus : LinkStatusKind; }

            connection def DerivesFrom :> SemanticLink {
                // Drivers include needs and hazards (ISO 14971: hazards drive
                // requirements), so the source stays at TraceableElement
                end sourceDriver : TraceableElement;
                end targetRequirement : VerifiableElement;
            }
            connection def SatisfiedBy :> SemanticLink {
                end requirement : VerifiableElement;
                end satisfyingElement : ArchitectureElement;
            }
            connection def MitigatesHazard :> SemanticLink {
                end riskControl : VerifiableElement;
                end mitigatedHazard : TraceableElement;
            }
            connection def AllocatedTo :> SemanticLink {
                end function : ArchitectureElement;
                end allocatedElement : ArchitectureElement;
            }
            connection def RealizesInterface :> SemanticLink {
                end logicalInterface : InterfaceElement;
                end physicalInterface : InterfaceElement;
            }
            connection def VerifiedBy :> SemanticLink {
                // Requirements, risk controls, and architecture components are
                // all legitimate verification targets
                end verificationTarget : TraceableElement;
                end verificationCase : VerifiableElement;
            }
            connection def ProducesEvidence :> SemanticLink {
                end producer : VerifiableElement;
                end producedEvidence : EvidenceElement;
            }
            connection def IncludedIn :> SemanticLink {
                end sourceElement : TraceableElement;
                end targetView : TraceableElement;
            }
            connection def Precedes :> SemanticLink {
                attribute sameStepRequired : Boolean;
                attribute precedenceRationale : String;
                end predecessor : ArchitectureElement;
                end successor : ArchitectureElement;
            }
            connection def ResolvesToMethodology :> SemanticLink {
                end boundModelElement : TraceableElement;
                end resolvedMethodology : TraceableElement;
            }

            // ISO 14971 risk chain — distinct sequence-of-events relations over risk elements.
            connection def TracesRisk :> SemanticLink {
                end sourceRiskElement : TraceableElement;
                end targetRiskElement : TraceableElement;
            }
            connection def AssessedAgainst :> SemanticLink {
                end risk : TraceableElement;
                end riskMatrix : TraceableElement;
            }

            connection def ThreatenedBy :> SemanticLink {
                attribute threatRole : String;
                end protectedAsset : ArchitectureElement;
                end realizedThreat : RequirementDriver;
            }
            connection def Exploits :> SemanticLink {
                end realizedThreat : RequirementDriver;
                end enablingVulnerability : TraceableElement;
            }
            connection def RealizedByScenario :> SemanticLink {
                end realizedThreat : RequirementDriver;
                end scenario : TraceableElement;
            }
            connection def MitigatesVulnerability :> SemanticLink {
                end enablingVulnerability : TraceableElement;
                end mitigation : VerifiableElement;
            }
            connection def DerivesCyberRequirement :> SemanticLink {
                end sourceThreatOrRisk : RequirementDriver;
                end targetRequirement : VerifiableElement;
            }
            connection def ImpactsSafety :> SemanticLink {
                attribute tracePurpose : String;
                end cyberElement : TraceableElement;
                end safetyElement : TraceableElement;
            }
            connection def CrossesTrustBoundary :> SemanticLink {
                attribute crossingKind : InterfaceKind;
                end boundary : InterfaceElement;
                end crossingItem : TraceableElement;
            }

            connection def DerivesInto :> SemanticLink {
                end parentRequirement : VerifiableElement;
                end childRequirement : VerifiableElement;
            }
            connection def DeploysOnto :> SemanticLink {
                attribute deploymentKind : DeploymentKind;
                end softwareComponent : ArchitectureElement;
                end hostAssembly : ArchitectureElement;
            }
            connection def Validates :> SemanticLink {
                end validationTarget : VerifiableElement;
                end validationCase : VerifiableElement;
            }
            connection def DependsOnSoup :> SemanticLink {
                end component : ArchitectureElement;
                end soupItem : TraceableElement;
            }

            // Performs, ContributesToCapability, SequencesStep, DerivesSystemNeed
            // (operational-entity ends) and RealizesCapability, InvolvesFunction,
            // RealizesScenario (functional-chain ends) live in their owning
            // architecture layer packages — memo::architecture::operational and
            // memo::architecture::system respectively — because core must not
            // depend on architecture-layer types. See memo_operational.sysml and
            // memo_system_analysis.sysml.

            connection def HostedBy :> SemanticLink {
                end processingNode : ArchitectureElement;
                end hostAssembly : ArchitectureElement;
            }
            connection def RealizesComponentExchange :> SemanticLink {
                end physicalLink : ArchitectureElement;
                end componentExchange : ArchitectureElement;
            }

            connection def HasFailureMode :> SemanticLink {
                end element : ArchitectureElement;
                end failureMode : TraceableElement;
            }
            connection def CausesEffect :> SemanticLink {
                end failureMode : TraceableElement;
                end failureEffect : TraceableElement;
            }
            connection def CausedBy :> SemanticLink {
                end failureMode : TraceableElement;
                end failureCause : TraceableElement;
            }
            connection def DetectedBy :> SemanticLink {
                end failureMode : TraceableElement;
                end detectionMethod : TraceableElement;
            }
            connection def AddressedByAction :> SemanticLink {
                end failureMode : TraceableElement;
                end fmeaAction : VerifiableElement;
            }

            connection def InputToGate :> SemanticLink {
                end input : TraceableElement;
                end gate : TraceableElement;
            }
            connection def ProducesEvent :> SemanticLink {
                end gate : TraceableElement;
                end event : TraceableElement;
            }
            connection def OriginatesFrom :> SemanticLink {
                end event : TraceableElement;
                end origin : ArchitectureElement;
            }
            connection def ContainsEvent :> SemanticLink {
                end cutSet : TraceableElement;
                end event : TraceableElement;
            }

            connection def Decides :> SemanticLink {
                end decision : TraceableElement;
                end affectedElement : TraceableElement;
            }

            connection def Composes :> SemanticLink {
                end parent : ArchitectureElement;
                end child : ArchitectureElement;
            }
            connection def AllocatesExchange :> SemanticLink {
                end functionalFlow : ArchitectureElement;
                end componentExchange : ArchitectureElement;
            }

            connection def ContributesToHazard :> SemanticLink {
                end failureMode : TraceableElement;
                end hazard : TraceableElement;
            }
            connection def LeadsToHazard :> SemanticLink {
                end topEvent : TraceableElement;
                end hazard : TraceableElement;
            }
            connection def IdentifiesHazard :> SemanticLink {
                end deviation : TraceableElement;
                end hazard : TraceableElement;
            }
            connection def AnalyzedBy :> SemanticLink {
                end element : ArchitectureElement;
                end analysisArtifact : TraceableElement;
            }
            connection def MitigatedByControl :> SemanticLink {
                end failureMode : TraceableElement;
                end riskControl : VerifiableElement;
            }
            connection def BrokenByControl :> SemanticLink {
                end cutSet : TraceableElement;
                end riskControl : VerifiableElement;
            }

            connection def Changes :> SemanticLink {
                end changeRequest : TraceableElement;
                end changedElement : TraceableElement;
            }
            connection def TestedByUsability :> SemanticLink {
                end uiElementOrTask : TraceableElement;
                end usabilityTest : VerifiableElement;
            }
            connection def FeedsBackTo :> SemanticLink {
                end feedbackItem : TraceableElement;
                end designElement : TraceableElement;
            }
            connection def BindsToInterface :> SemanticLink {
                end port : InterfaceElement;
                end boundInterface : InterfaceElement;
            }
        }
    }
}
