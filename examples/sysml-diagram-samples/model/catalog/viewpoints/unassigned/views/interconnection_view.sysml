package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_interconnection_view {
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned::*;
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

    private import memo_core_common::MemoIdentity;
    // Ports are owned by the part whose boundary they are, which is what lets
    // a delegation be written at all: SysML v2 checks a flow's source for
    // `out`-ness relative to the owner, so a boundary port only reads as a
    // source from INSIDE its part. The subassemblies are nested the same way —
    // real containment, not a port-to-port `Composes` edge, which is what
    // CR-ONT-65 used to forbid before nesting made the rule unnecessary.
    part coffeeMachine : LogicalComponent {
        attribute :>> name = "Coffee Machine";
        in port mainsWaterIn : DataPort { in item payload : MemoItem; }
        out port beverageOut : DataPort { out item payload : MemoItem; }
        inout port serviceInterface : DataPort {
            inout item payload : MemoItem;
            out port diagnostics : DataPort { out item payload : MemoItem; }
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

            part thermostat : LogicalComponent {
                attribute :>> name = "Thermostat";
                in port tempReadingIn : DataPort { in item payload : MemoItem; }
                out port powerCommandOut : DataPort { out item payload : MemoItem; }
            }

            part heatingElement : LogicalComponent {
                attribute :>> name = "Water Heating Element";
                in port powerIn : DataPort { in item payload : MemoItem; }
                out port heaterStatusOut : DataPort { out item payload : MemoItem; }

                part resistiveCoil : LogicalComponent {
                    attribute :>> name = "Resistive Coil";
                    in port coilPowerIn : DataPort { in item payload : MemoItem; }
                    out port heatOut : DataPort { out item payload : MemoItem; }
                }
                part temperatureSensor : LogicalComponent {
                    attribute :>> name = "Temperature Sensor";
                    in port heatIn : DataPort { in item payload : MemoItem; }
                    out port sensorReadingOut : DataPort { out item payload : MemoItem; }
                }
            }
        }
        part brewGroup : LogicalComponent {
            attribute :>> name = "Brew Group";
            in port brewWaterIn : DataPort { in item payload : MemoItem; }
            out port brewedCoffeeOut : DataPort { out item payload : MemoItem; }
        }
    }
    part waterSupply : LogicalComponent {
        attribute :>> name = "Water Supply";
        out port supplyWaterOut : DataPort { out item payload : MemoItem; }
    }
    part cup : LogicalComponent {
        attribute :>> name = "Cup";
        in port cupBeverageIn : DataPort { in item payload : MemoItem; }
    }

    // Transport between two components: `out` to `in`, one item moving.
    flow from waterSupply.supplyWaterOut to coffeeMachine.mainsWaterIn;
    flow from coffeeMachine.waterTank.tankWaterOut to coffeeMachine.heaterAssembly.heaterWaterIn;
    flow from coffeeMachine.heaterAssembly.heatedWaterOut to coffeeMachine.brewGroup.brewWaterIn;
    flow from coffeeMachine.beverageOut to cup.cupBeverageIn;

    // Delegation between a boundary port and the interior it stands for. These
    // are `in`-to-`in` and `out`-to-`out`, because nothing travels: the two
    // features are the same feature. SysML v2 spells that `bind` (training
    // ch. 12), not `flow` (ch. 13).
    bind coffeeMachine.mainsWaterIn = coffeeMachine.waterTank.tankWaterIn;
    bind coffeeMachine.brewGroup.brewedCoffeeOut = coffeeMachine.beverageOut;
    bind coffeeMachine.heaterAssembly.heatingElement.heaterStatusOut = coffeeMachine.serviceInterface.diagnostics;

    // Internal flows within the heater assembly
    flow from coffeeMachine.heaterAssembly.thermostat.powerCommandOut to coffeeMachine.heaterAssembly.heatingElement.powerIn;
    flow from coffeeMachine.heaterAssembly.heatingElement.heaterStatusOut to coffeeMachine.heaterAssembly.thermostat.tempReadingIn;

    // Internal flows within the heating element
    flow from coffeeMachine.heaterAssembly.heatingElement.resistiveCoil.heatOut to coffeeMachine.heaterAssembly.heatingElement.temperatureSensor.heatIn;
    bind coffeeMachine.heaterAssembly.heatingElement.powerIn = coffeeMachine.heaterAssembly.heatingElement.resistiveCoil.coilPowerIn;
    bind coffeeMachine.heaterAssembly.heatingElement.temperatureSensor.sensorReadingOut = coffeeMachine.heaterAssembly.heatingElement.heaterStatusOut;
}
