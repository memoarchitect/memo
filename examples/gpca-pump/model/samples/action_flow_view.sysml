package memo_examples_gpca_pump_model_samples_action_flow_view {
    private import ScalarValues::*;
    private import memo_core_relationships::*;

    private import memo_architecture_logical_structure::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    item def DataPacket;
    item def EnergyToken;
    item def MaterialBatch;

    action def ReceiveInput { out received : DataPacket; }
    action def ValidateInput { in received : DataPacket; out validated : EnergyToken; }
    action def ProcessInput { in validated : EnergyToken; out result : MaterialBatch; }
    action def RecordResult { in result : MaterialBatch; }

    part laneA : LogicalComponent { attribute :>> name = "Lane A"; }
    part laneB : LogicalComponent { attribute :>> name = "Lane B"; }

    action sampleActionFlow {
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

    view sampleActionFlowView : MemoDiagramView {
        expose sampleActionFlow::**;
        expose laneA;
        expose laneB;
        attribute depth = 2;
        attribute :>> title = "Sample · Action Flow";
        attribute :>> shortDescription = "Dummy actions, typed item flows, successions, and a composite action for renderer development.";
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "afd";
    }

    connection : IncludedIn connect sourceElement ::> sampleActionFlow.receive to targetView ::> sampleActionFlowView;
    connection : IncludedIn connect sourceElement ::> sampleActionFlow.validate to targetView ::> sampleActionFlowView;
    connection : IncludedIn connect sourceElement ::> sampleActionFlow.process to targetView ::> sampleActionFlowView;
    connection : IncludedIn connect sourceElement ::> sampleActionFlow.process.processStepA to targetView ::> sampleActionFlowView;
    connection : IncludedIn connect sourceElement ::> sampleActionFlow.process.processStepB to targetView ::> sampleActionFlowView;
    connection : IncludedIn connect sourceElement ::> sampleActionFlow.process.processStepC to targetView ::> sampleActionFlowView;
    connection : IncludedIn connect sourceElement ::> sampleActionFlow.record to targetView ::> sampleActionFlowView;
}
