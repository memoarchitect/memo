package samples {
    private import memo::architecture::interfaces::*;
    private import memo::architecture::logical_structure::*;
    private import memo::core::relationships::*;
    private import memo::viewpoints::definitions::*;
    private import memo::core::enumerations::*;

    part coffeeMachine : LogicalComponent { attribute redefines name = "Coffee Machine"; }
    part waterSupply : LogicalComponent { attribute redefines name = "Water Supply"; }
    part waterTank : LogicalComponent { attribute redefines name = "Water Reservoir"; }
    part heaterAssembly : LogicalComponent { attribute redefines name = "Thermal Control Assembly"; }
    part heatingElement : LogicalComponent { attribute redefines name = "Water Heating Element"; }
    part brewGroup : LogicalComponent { attribute redefines name = "Brew Group"; }
    part cup : LogicalComponent { attribute redefines name = "Cup"; }

    port mainsWaterIn : DataPort { attribute direction = DirectionKind::in; }
    port beverageOut : DataPort { attribute direction = DirectionKind::out; }
    port supplyWaterOut : DataPort { attribute direction = DirectionKind::out; }
    port cupBeverageIn : DataPort { attribute direction = DirectionKind::in; }
    port serviceInterface : DataPort { attribute direction = DirectionKind::bidirectional; }
    port diagnostics : DataPort { attribute direction = DirectionKind::out; }
    port tankWaterOut : DataPort { attribute direction = DirectionKind::out; }
    port tankWaterIn : DataPort { attribute direction = DirectionKind::in; }
    port heaterWaterIn : DataPort { attribute direction = DirectionKind::in; }
    port heatedWaterOut : DataPort { attribute direction = DirectionKind::out; }
    port brewWaterIn : DataPort { attribute direction = DirectionKind::in; }
    port brewedCoffeeOut : DataPort { attribute direction = DirectionKind::out; }
    port heaterStatusOut : DataPort { attribute direction = DirectionKind::out; }

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

    part sampleInterconnectionView : DiagramView {
        attribute redefines title = "Coffee Machine · Thermal & Fluid IBD";
        attribute redefines shortDescription = "Balanced internal architecture with readable boundary ports, nested service diagnostics, and external water and beverage interfaces.";
        attribute redefines viewKind = DiagramViewKind::interconnection;
        attribute redefines diagramType = "ibd";
        part selectionQuery {
            attribute redefines includeRelationshipKinds = {"Composes", "ExchangesWith"};
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
