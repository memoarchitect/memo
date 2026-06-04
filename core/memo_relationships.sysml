package memo {
    package core {
        package relationships {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;

            part def SemanticLink specializes TraceableElement { attribute linkStatus : LinkStatusKind; }
            part def DerivesFrom specializes SemanticLink { attribute sourceRole : String; part sourceDriver : RequirementDriver; part targetRequirement : VerifiableElement; }
            part def SatisfiedBy specializes SemanticLink { part requirement : VerifiableElement; part satisfyingElement : ArchitectureElement; }
            part def MitigatesHazard specializes SemanticLink { part riskControl : VerifiableElement; part mitigatedHazard : TraceableElement; }
            part def AllocatedTo specializes SemanticLink { part function : ArchitectureElement; part allocatedElement : ArchitectureElement; }
            part def RealizesInterface specializes SemanticLink { part logicalInterface : InterfaceElement; part physicalInterface : InterfaceElement; }
            part def VerifiedBy specializes SemanticLink { part verificationTarget : VerifiableElement; part verificationCase : VerifiableElement; }
            part def ProducesEvidence specializes SemanticLink { part producer : VerifiableElement; part producedEvidence : EvidenceElement; }
            part def IncludedIn specializes SemanticLink { part sourceElement : TraceableElement; part targetView : TraceableElement; }
            part def TracesRisk specializes SemanticLink { attribute riskRole : String; part sourceRiskElement : TraceableElement; part targetRiskElement : TraceableElement; }
            part def Precedes specializes SemanticLink { attribute sameStepRequired : Boolean; attribute precedenceRationale : String; part predecessor : ArchitectureElement; part successor : ArchitectureElement; }
            part def ResolvesToMethodology specializes SemanticLink { part boundModelElement : TraceableElement; part resolvedMethodology : TraceableElement; }

            part def ThreatenedBy specializes SemanticLink { attribute threatRole : String; part protectedAsset : ArchitectureElement; part realizedThreat : RequirementDriver; }
            part def Exploits specializes SemanticLink { part realizedThreat : RequirementDriver; part enablingVulnerability : TraceableElement; }
            part def RealizedByScenario specializes SemanticLink { part realizedThreat : RequirementDriver; part scenario : TraceableElement; }
            part def MitigatesVulnerability specializes SemanticLink { part enablingVulnerability : TraceableElement; part mitigation : VerifiableElement; }
            part def DerivesCyberRequirement specializes SemanticLink { part sourceThreatOrRisk : RequirementDriver; part targetRequirement : VerifiableElement; }
            part def ImpactsSafety specializes SemanticLink { attribute tracePurpose : String; part cyberElement : TraceableElement; part safetyElement : TraceableElement; }
            part def CrossesTrustBoundary specializes SemanticLink { attribute crossingKind : InterfaceKind; part boundary : InterfaceElement; part crossingItem : TraceableElement; }

            part def DerivesInto specializes SemanticLink { part parentRequirement : VerifiableElement; part childRequirement : VerifiableElement; }
            part def DeploysOnto specializes SemanticLink { attribute deploymentKind : DeploymentKind; part softwareComponent : ArchitectureElement; part hostAssembly : ArchitectureElement; }
            part def Validates specializes SemanticLink { part validationTarget : VerifiableElement; part validationCase : VerifiableElement; }
            part def DependsOnSoup specializes SemanticLink { part component : ArchitectureElement; part soupItem : TraceableElement; }

            part def Performs specializes SemanticLink { part entity : OperationalEntity; part activity : OperationalActivity; }
            part def ContributesToCapability specializes SemanticLink { part activity : OperationalActivity; part capability : OperationalCapability; }
            part def SequencesStep specializes SemanticLink { part activity : OperationalActivity; part nextActivity : OperationalActivity; }
            part def DerivesSystemNeed specializes SemanticLink { part activity : OperationalActivity; part systemNeed : VerifiableElement; }

            part def RealizesCapability specializes SemanticLink { part functionalChain : FunctionalChain; part capability : SystemCapability; }
            part def InvolvesFunction specializes SemanticLink { part functionalChain : FunctionalChain; part function : LogicalFunction; }
            part def RealizesScenario specializes SemanticLink { part functionalChain : FunctionalChain; part scenario : SystemScenario; }

            part def HostedBy specializes SemanticLink { part processingNode : ArchitectureElement; part hostAssembly : ArchitectureElement; }
            part def RealizesComponentExchange specializes SemanticLink { part physicalLink : ArchitectureElement; part componentExchange : ArchitectureElement; }

            part def HasFailureMode specializes SemanticLink { part element : ArchitectureElement; part failureMode : TraceableElement; }
            part def CausesEffect specializes SemanticLink { part failureMode : TraceableElement; part failureEffect : TraceableElement; }
            part def CausedBy specializes SemanticLink { part failureMode : TraceableElement; part failureCause : TraceableElement; }
            part def DetectedBy specializes SemanticLink { part failureMode : TraceableElement; part detectionMethod : TraceableElement; }
            part def AddressedByAction specializes SemanticLink { part failureMode : TraceableElement; part fmeaAction : VerifiableElement; }

            part def InputToGate specializes SemanticLink { part input : TraceableElement; part gate : TraceableElement; }
            part def ProducesEvent specializes SemanticLink { part gate : TraceableElement; part event : TraceableElement; }
            part def OriginatesFrom specializes SemanticLink { part event : TraceableElement; part origin : ArchitectureElement; }
            part def ContainsEvent specializes SemanticLink { part cutSet : TraceableElement; part event : TraceableElement; }

            part def Decides specializes SemanticLink { part decision : TraceableElement; part affectedElement : TraceableElement; }

            part def Composes specializes SemanticLink { part parent : ArchitectureElement; part child : ArchitectureElement; }
            part def AllocatesExchange specializes SemanticLink { part functionalFlow : ArchitectureElement; part componentExchange : ArchitectureElement; }

            part def ContributesToHazard specializes SemanticLink { part failureMode : TraceableElement; part hazard : TraceableElement; }
            part def LeadsToHazard specializes SemanticLink { part topEvent : TraceableElement; part hazard : TraceableElement; }
            part def IdentifiesHazard specializes SemanticLink { part deviation : TraceableElement; part hazard : TraceableElement; }
            part def AnalyzedBy specializes SemanticLink { part element : ArchitectureElement; part analysisArtifact : TraceableElement; }
            part def MitigatedByControl specializes SemanticLink { part failureMode : TraceableElement; part riskControl : VerifiableElement; }
            part def BrokenByControl specializes SemanticLink { part cutSet : TraceableElement; part riskControl : VerifiableElement; }

            part def Changes specializes SemanticLink { part changeRequest : TraceableElement; part changedElement : TraceableElement; }
            part def TestedByUsability specializes SemanticLink { part uiElementOrTask : TraceableElement; part usabilityTest : VerifiableElement; }
            part def FeedsBackTo specializes SemanticLink { part feedbackItem : TraceableElement; part designElement : TraceableElement; }
            part def BindsToInterface specializes SemanticLink { part port : InterfaceElement; part boundInterface : InterfaceElement; }
        }
    }
}
