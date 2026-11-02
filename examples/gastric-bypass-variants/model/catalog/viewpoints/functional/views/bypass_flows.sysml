// Our robot's functional workflow: the functions it performs, in order. Functions are inside the
// system, so this view belongs to the functional viewpoint, not the operational one.
package memo_examples_gastric_bypass_variants_viewpoints_functional_views {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view bypassFlowFunctional : MemoDiagramView {
        @MemoIdentity { :>> label = "Functional workflow: our robot"; }
        expose memo_examples_gastric_bypass_variants::fcOurRobotProcedure::**;
        attribute depth = 2;
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = functionalViewpoint;
    }
}
