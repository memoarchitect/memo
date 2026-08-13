package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_interconnection_view {
    private import ScalarValues::*;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_context_use_context::*;

    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_logical_structure::*;
    private import memo_core_common::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_logical_logical_viewpoint::*;
    private import memo_core_enumerations::*;

    // Ports are owned by the part whose boundary they are, which is what lets
    // a delegation be written at all: SysML v2 checks a flow's source for
    // `out`-ness relative to the owner, so a boundary port only reads as a
    // source from INSIDE its part. Declaring ports beside their parts and
    // linking them with `Composes` also made a port the whole of a
    // decomposition, which CR-ONT-065 forbids.
    part coffeeMachine : LogicalComponent {
        attribute :>> name = "Coffee Machine";
        in port mainsWaterIn : DataPort { in item payload : MemoItem; }
        out port beverageOut : DataPort { out item payload : MemoItem; }
        inout port serviceInterface : DataPort {
            inout item payload : MemoItem;
            out port diagnostics : DataPort { out item payload : MemoItem; }
        }
    }
    part waterSupply : LogicalComponent {
        attribute :>> name = "Water Supply";
        out port supplyWaterOut : DataPort { out item payload : MemoItem; }
    }
    part waterTank : LogicalComponent {
        attribute :>> name = "Water Reservoir";
        out port tankWaterOut : DataPort { out item payload : MemoItem; }
        in port tankWaterIn : DataPort { in item payload : MemoItem; }
    }
    part heaterAssembly : LogicalComponent {
        attribute :>> name = "Thermal Control Assembly";
        in port heaterWaterIn : DataPort { in item payload : MemoItem; }
        out port heatedWaterOut : DataPort { out item payload : MemoItem; }
    }
    part heatingElement : LogicalComponent {
        attribute :>> name = "Water Heating Element";
        out port heaterStatusOut : DataPort { out item payload : MemoItem; }
    }
    part brewGroup : LogicalComponent {
        attribute :>> name = "Brew Group";
        in port brewWaterIn : DataPort { in item payload : MemoItem; }
        out port brewedCoffeeOut : DataPort { out item payload : MemoItem; }
    }
    part cup : LogicalComponent {
        attribute :>> name = "Cup";
        in port cupBeverageIn : DataPort { in item payload : MemoItem; }
    }

    connection : Composes connect parent ::> coffeeMachine to child ::> waterTank;
    connection : Composes connect parent ::> coffeeMachine to child ::> heaterAssembly;
    connection : Composes connect parent ::> coffeeMachine to child ::> brewGroup;
    connection : Composes connect parent ::> heaterAssembly to child ::> heatingElement;

    // Transport between two components: `out` to `in`, one item moving.
    flow from waterSupply.supplyWaterOut to coffeeMachine.mainsWaterIn;
    flow from waterTank.tankWaterOut to heaterAssembly.heaterWaterIn;
    flow from heaterAssembly.heatedWaterOut to brewGroup.brewWaterIn;
    flow from coffeeMachine.beverageOut to cup.cupBeverageIn;

    // Delegation between a boundary port and the interior it stands for. These
    // are `in`-to-`in` and `out`-to-`out`, because nothing travels: the two
    // features are the same feature. SysML v2 spells that `bind` (training
    // ch. 12), not `flow` (ch. 13).
    bind coffeeMachine.mainsWaterIn = waterTank.tankWaterIn;
    bind brewGroup.brewedCoffeeOut = coffeeMachine.beverageOut;
    bind heatingElement.heaterStatusOut = coffeeMachine.serviceInterface.diagnostics;

    view sampleInterconnectionView : MemoDiagramView {
        expose coffeeMachine::**;
        expose waterSupply::**;
        expose cup::**;
        attribute depth = 2;
        attribute :>> title = "Coffee Machine · Thermal & Fluid IBD";
        attribute :>> shortDescription = "Balanced internal architecture with readable boundary ports, nested service diagnostics, and external water and beverage interfaces.";
        attribute :>> viewKind = DiagramViewKind::interconnection;
        attribute :>> diagramType = "ibd";
        part :>> viewpointDefinition = logicalArchitectureViewpoint;
        part :>> selectionQuery {
            attribute :>> includeRelationshipKinds = ("Composes", "flow", "bind");
        }
    }

    connection : IncludedIn connect sourceElement ::> coffeeMachine to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> waterSupply to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> waterTank to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> heaterAssembly to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> heatingElement to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> brewGroup to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> cup to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> coffeeMachine.mainsWaterIn to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> coffeeMachine.beverageOut to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> waterSupply.supplyWaterOut to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> cup.cupBeverageIn to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> coffeeMachine.serviceInterface to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> coffeeMachine.serviceInterface.diagnostics to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> waterTank.tankWaterOut to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> waterTank.tankWaterIn to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> heaterAssembly.heaterWaterIn to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> heaterAssembly.heatedWaterOut to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> brewGroup.brewWaterIn to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> brewGroup.brewedCoffeeOut to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> heatingElement.heaterStatusOut to targetView ::> sampleInterconnectionView;
}
