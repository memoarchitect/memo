package memo_architecture_operational {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    part def OperationalEntity specializes ArchitectureElement {
        attribute entityKind : OperationalEntityKind;
        attribute operationalDomain : String;
        attribute responsibility : String;
    }
    part def OperationalActivity specializes ArchitectureElement {
        attribute trigger : String;
        attribute preCondition : String;
        attribute postCondition : String;
        attribute criticality : CriticalityKind;
    }
    part def OperationalCapability specializes ArchitectureElement {
        attribute capabilityLevel : String;
        attribute preCondition : String;
        attribute postCondition : String;
    }
    part def OperationalScenario specializes TraceableElement {
        attribute scenarioKind : ScenarioKind;
        attribute preCondition : String;
        attribute postCondition : String;
        attribute sequenceDescription : String;
    }
    part def OperationalInteraction specializes ArchitectureElement {
        attribute exchangeKind : FlowKind;
        attribute direction : DirectionKind;
        attribute latencyConstraint : String;
    }

    connection def Performs :> SemanticLink {
        end entity : OperationalEntity;
        end activity : OperationalActivity;
    }
    connection def ContributesToCapability :> SemanticLink {
        end activity : OperationalActivity;
        end capability : OperationalCapability;
    }
    connection def SequencesStep :> SemanticLink {
        end activity : OperationalActivity;
        end nextActivity : OperationalActivity;
    }
    connection def DerivesSystemNeed :> SemanticLink {
        end activity : OperationalActivity;
        end systemNeed : VerifiableElement;
    }
}
