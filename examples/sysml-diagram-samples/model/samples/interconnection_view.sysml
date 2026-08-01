package memo_examples_sysml_diagram_samples_model_samples_interconnection_view {
    private import ScalarValues::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_context_use_context::*;

    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_logical_structure::*;
    private import memo_core_common::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    part coffeeMachine : LogicalComponent { attribute :>> name = "Coffee Machine"; }
    part waterSupply : LogicalComponent { attribute :>> name = "Water Supply"; }
    part waterTank : LogicalComponent { attribute :>> name = "Water Reservoir"; }
    part heaterAssembly : LogicalComponent { attribute :>> name = "Thermal Control Assembly"; }
    part heatingElement : LogicalComponent { attribute :>> name = "Water Heating Element"; }
    part brewGroup : LogicalComponent { attribute :>> name = "Brew Group"; }
    part cup : LogicalComponent { attribute :>> name = "Cup"; }

    in port mainsWaterIn : DataPort { in item payload : MemoExchangeItem; }
    out port beverageOut : DataPort { out item payload : MemoExchangeItem; }
    out port supplyWaterOut : DataPort { out item payload : MemoExchangeItem; }
    in port cupBeverageIn : DataPort { in item payload : MemoExchangeItem; }
    inout port serviceInterface : DataPort { inout item payload : MemoExchangeItem; }
    out port diagnostics : DataPort { out item payload : MemoExchangeItem; }
    out port tankWaterOut : DataPort { out item payload : MemoExchangeItem; }
    in port tankWaterIn : DataPort { in item payload : MemoExchangeItem; }
    in port heaterWaterIn : DataPort { in item payload : MemoExchangeItem; }
    out port heatedWaterOut : DataPort { out item payload : MemoExchangeItem; }
    in port brewWaterIn : DataPort { in item payload : MemoExchangeItem; }
    out port brewedCoffeeOut : DataPort { out item payload : MemoExchangeItem; }
    out port heaterStatusOut : DataPort { out item payload : MemoExchangeItem; }

    connection : Composes connect parent ::> coffeeMachine to child ::> waterTank;
    connection : Composes connect parent ::> coffeeMachine to child ::> heaterAssembly;
    connection : Composes connect parent ::> coffeeMachine to child ::> brewGroup;
    connection : Composes connect parent ::> coffeeMachine to child ::> mainsWaterIn;
    connection : Composes connect parent ::> coffeeMachine to child ::> beverageOut;
    connection : Composes connect parent ::> coffeeMachine to child ::> serviceInterface;
    connection : Composes connect parent ::> serviceInterface to child ::> diagnostics;
    connection : Composes connect parent ::> waterTank to child ::> tankWaterOut;
    connection : Composes connect parent ::> waterTank to child ::> tankWaterIn;
    connection : Composes connect parent ::> heaterAssembly to child ::> heatingElement;
    connection : Composes connect parent ::> heaterAssembly to child ::> heaterWaterIn;
    connection : Composes connect parent ::> heaterAssembly to child ::> heatedWaterOut;
    connection : Composes connect parent ::> brewGroup to child ::> brewWaterIn;
    connection : Composes connect parent ::> brewGroup to child ::> brewedCoffeeOut;
    connection : Composes connect parent ::> heatingElement to child ::> heaterStatusOut;
    connection : Composes connect parent ::> waterSupply to child ::> supplyWaterOut;
    connection : Composes connect parent ::> cup to child ::> cupBeverageIn;

    connection : ExchangesWith connect source ::> supplyWaterOut to target ::> mainsWaterIn;
    connection : ExchangesWith connect source ::> mainsWaterIn to target ::> tankWaterIn;
    connection : ExchangesWith connect source ::> tankWaterOut to target ::> heaterWaterIn;
    connection : ExchangesWith connect source ::> heatedWaterOut to target ::> brewWaterIn;
    connection : ExchangesWith connect source ::> brewedCoffeeOut to target ::> beverageOut;
    connection : ExchangesWith connect source ::> beverageOut to target ::> cupBeverageIn;
    connection : ExchangesWith connect source ::> heaterStatusOut to target ::> diagnostics;

    view sampleInterconnectionView : MemoDiagramView {
        expose coffeeMachine::**;
        expose waterSupply::**;
        expose cup::**;
        attribute depth = 2;
        attribute :>> title = "Coffee Machine · Thermal & Fluid IBD";
        attribute :>> shortDescription = "Balanced internal architecture with readable boundary ports, nested service diagnostics, and external water and beverage interfaces.";
        attribute :>> viewKind = DiagramViewKind::interconnection;
        attribute :>> diagramType = "ibd";
        part :>> selectionQuery {
            attribute :>> includeRelationshipKinds = ("Composes", "ExchangesWith");
        }
    }

    connection : IncludedIn connect sourceElement ::> coffeeMachine to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> waterSupply to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> waterTank to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> heaterAssembly to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> heatingElement to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> brewGroup to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> cup to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> mainsWaterIn to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> beverageOut to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> supplyWaterOut to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> cupBeverageIn to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> serviceInterface to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> diagnostics to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> tankWaterOut to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> tankWaterIn to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> heaterWaterIn to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> heatedWaterOut to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> brewWaterIn to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> brewedCoffeeOut to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> heaterStatusOut to targetView ::> sampleInterconnectionView;
}
