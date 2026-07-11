package samples {
    private import memo::architecture::logical_structure::*;
    private import memo::viewpoints::definitions::*;
    private import memo::core::enumerations::*;

    item def DataPacket;
    item def EnergyToken;
    item def MaterialBatch;

    action def ReceiveInput { out received : DataPacket; }
    action def ValidateInput { in received : DataPacket; out validated : EnergyToken; }
    action def ProcessInput { in validated : EnergyToken; out result : MaterialBatch; }
    action def RecordResult { in result : MaterialBatch; }

    part laneA : LogicalComponent { attribute redefines name = "Lane A"; }
    part laneB : LogicalComponent { attribute redefines name = "Lane B"; }

    action sampleActionFlow {
        action receive : ReceiveInput;
        action validate : ValidateInput;
        action process : ProcessInput {
            action processStepA : ValidateInput;
            action processStepB : ProcessInput;
            first start then processStepA;
            first processStepA then processStepB;
            first processStepB then done;
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

    allocate receive to laneA;
    allocate validate to laneA;
    allocate process to laneB;
    allocate processStepA to laneB;
    allocate processStepB to laneB;
    allocate record to laneB;

    part sampleActionFlowView : DiagramView {
        attribute redefines title = "Sample · Action Flow";
        attribute redefines shortDescription = "Dummy actions, typed item flows, successions, and a composite action for renderer development.";
        attribute redefines viewKind = DiagramViewKind::actionflow;
        attribute redefines diagramType = "afd";
    }

    connection : IncludedIn connect sourceElement ::> receive to targetView ::> sampleActionFlowView;
    connection : IncludedIn connect sourceElement ::> validate to targetView ::> sampleActionFlowView;
    connection : IncludedIn connect sourceElement ::> process to targetView ::> sampleActionFlowView;
    connection : IncludedIn connect sourceElement ::> processStepA to targetView ::> sampleActionFlowView;
    connection : IncludedIn connect sourceElement ::> processStepB to targetView ::> sampleActionFlowView;
    connection : IncludedIn connect sourceElement ::> record to targetView ::> sampleActionFlowView;
}
