package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_action_flow_view {
    private import ScalarValues::*;
    private import memo_core_relationships::*;
    private import ModelingMetadata::*;

    private import memo_architecture_logical_structure::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_functional_functions::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;
    private import memo_core_enumerations::*;

    item def DataPacket specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::data;
    }
    item def EnergyToken specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::energy;
    }
    item def MaterialBatch specializes InterfaceItem {
        attribute :>> itemKind = InterfaceItemKind::material;
    }

    action def ReceiveInput specializes SystemFunction { out item received : DataPacket; }
    action def ValidateInput specializes SystemFunction { in item received : DataPacket; out item validated : EnergyToken; }
    action def ProcessInput specializes SystemFunction { in item validated : EnergyToken; out item result : MaterialBatch; }
    action def RecordResult specializes SystemFunction { in item result : MaterialBatch; }

    part laneA : LogicalComponent { attribute :>> name = "Lane A"; }
    part laneB : LogicalComponent { attribute :>> name = "Lane B"; }

    action sampleActionFlow : SystemFunction {
        action receive : ReceiveInput;
        action validate : ValidateInput;
        action process : ProcessInput {
            action processStepA : ValidateInput;
            action processStepB : ProcessInput;
            action processStepC : ProcessInput;
            first start then processStepA;
            first processStepA then processStepB;
            first processStepB then processStepC;
            first processStepC then done;
        }
        action record : RecordResult;

        flow of DataPacket from receive.received to validate.received;
        flow of EnergyToken from validate.validated to process.validated;
        flow of MaterialBatch from process.result to record.result;

        first start then receive;
        first receive then validate;
        first validate then process;
        first process then record;
        first record then done;
    }

    allocate sampleActionFlow.receive to laneA;
    allocate sampleActionFlow.validate to laneA;
    allocate sampleActionFlow.process to laneB;
    allocate sampleActionFlow.process.processStepA to laneB;
    allocate sampleActionFlow.process.processStepB to laneB;
    allocate sampleActionFlow.process.processStepC to laneB;
    allocate sampleActionFlow.record to laneB;

    // MemoLink sample — the universal relation, exercised where nothing else
    // reaches. laneB is a `part` (LogicalComponent :> ArchitectureElement) and
    // `sampleActionFlow.process` is an action usage (:> MemoAction). Those
    // foundations share no supertype, so every typed relation in the ontology
    // is unavailable here: legalRelationshipTypes returns MemoLink and nothing
    // else.
    //
    // The target is the action *usage*, not the `ProcessInput` definition.
    // Binding a value to a definition is not portable — SysIDE rejects it,
    // because a value must be a feature and a definition is not.
    connection linkLaneBProcessesInput : MemoLink
        connect linkSource ::> laneB to linkTarget ::> sampleActionFlow.process {
        @Rationale {
            :>> text =
                "Lane B is the swimlane that carries the ProcessInput behaviour. The association crosses the part/action metaclass boundary, so no typed relation can express it.";
        }
    }

    view sampleActionFlowView : MemoDiagramView {
        expose sampleActionFlow::**;
        expose laneA;
        expose laneB;
        attribute depth = 2;
        attribute :>> title = "Sample · Action Flow";
        attribute :>> shortDescription = "Dummy actions, typed item flows, successions, and a composite action for renderer development.";
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "afd";
        part :>> viewpointDefinition = functionalViewpoint;
    }
}
