package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_drill_down_view {
    private import memo_core_relationships::*;
    private import memo_core_enumerations::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned::*;
    private import ScalarValues::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_functional_functions::*;
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;

    // Parts and actions that are TYPED by a definition, so each way into a
    // lower level can be tried on its own. The overview draws only the usages;
    // what is inside each comes from the definition it is typed by.
    //
    //   gearbox     typed by DrillGearbox: has an authored child view
    //               (gearboxInside), so it shows the ↗ button and a way back.
    //   motor       typed by DrillMotor: parts, two levels deep, and NO view,
    //               so only the generated level opens; drill again for
    //               windings, then back out.
    //   controller  typed by DrillController: ports and no parts, so there is
    //               nothing to drill into and no view to open.
    part def DrillGearbox specializes LogicalComponent {
        in port shaftIn : DataPort { in item payload : MemoItem; }
        out port shaftOut : DataPort { out item payload : MemoItem; }
        part inputStage : LogicalComponent {
            in port torqueIn : DataPort { in item payload : MemoItem; }
            out port torqueOut : DataPort { out item payload : MemoItem; }
        }
        part outputStage : LogicalComponent {
            in port torqueIn : DataPort { in item payload : MemoItem; }
            out port torqueOut : DataPort { out item payload : MemoItem; }
        }
            connection : LogicalConnector connect sourceComponent ::> inputStage to targetComponent ::> outputStage {
            attribute :>> contentKind = FlowContentKind::energy;
            attribute :>> direction = DirectionKind::output;
        }
}

    part def DrillMotor specializes LogicalComponent {
        in port powerIn : DataPort { in item payload : MemoItem; }
        out port torqueOut : DataPort { out item payload : MemoItem; }
        part rotor : LogicalComponent {
            out port torqueOut : DataPort { out item payload : MemoItem; }
        }
        part stator : LogicalComponent {
            in port powerIn : DataPort { in item payload : MemoItem; }
            part windings : LogicalComponent {
                in port currentIn : DataPort { in item payload : MemoItem; }
            }
        }
            connection : LogicalConnector connect sourceComponent ::> stator.windings to targetComponent ::> rotor {
            attribute :>> contentKind = FlowContentKind::energy;
            attribute :>> direction = DirectionKind::output;
        }
}

    part def DrillController specializes LogicalComponent {
        in port commandIn : DataPort { in item payload : MemoItem; }
        out port powerOut : DataPort { out item payload : MemoItem; }
    }

    part def DrillDrive specializes LogicalComponent {
        part gearbox : DrillGearbox;
        part motor : DrillMotor;
        part controller : DrillController;
            connection : LogicalConnector connect sourceComponent ::> controller to targetComponent ::> motor {
            attribute :>> contentKind = FlowContentKind::command;
            attribute :>> direction = DirectionKind::output;
        }
        connection : LogicalConnector connect sourceComponent ::> motor to targetComponent ::> gearbox {
            attribute :>> contentKind = FlowContentKind::energy;
            attribute :>> direction = DirectionKind::output;
        }
}

    part drive : DrillDrive {
@MemoIdentity { :>> label = "Drive"; }
    }

    // The same two cases for an action flow: calibrate has an authored child
    // view (calibrateDetail), confirm has child actions and none.
    action def DrillCalibrate specializes SystemFunction {
        action measure : SystemFunction;
        action adjust : SystemFunction;
        first start then measure;
        first measure then adjust;
        first adjust then done;
    }

    action def DrillVerify specializes SystemFunction {
        action compare : SystemFunction;
        action sign : SystemFunction;
        first start then compare;
        first compare then sign;
        first sign then done;
    }

    action servicing : SystemFunction {
        action calibrate : DrillCalibrate;
        action confirm : DrillVerify;
        first start then calibrate;
        first calibrate then confirm;
        first confirm then done;
    }
    // The drive's controller carries out the servicing procedure.
    allocate servicing to drive.controller;
    allocate servicing.calibrate to drive.controller;
    allocate servicing.confirm to drive.controller;
    allocate servicing.calibrate.measure to drive.controller;
    allocate servicing.calibrate.adjust to drive.controller;
    allocate servicing.confirm.compare to drive.controller;
    allocate servicing.confirm.sign to drive.controller;
}
