// Standard SysML v2 activity sample (actionflow view kind, `afd` diagram type).
//
// The view over `activity_example::FulfillOrder`, the standard-SysML activity
// fixture in `model/sysml_v2_activity_example.sysml`. It exists because the
// fixture's whole point is the node types `action_flow_view.sysml` does not
// have — decision, merge, fork, join, accept, send, terminate, and guarded
// successions. Without a view exposing it the fixture parses into the model and
// is never drawn, which is indistinguishable from a renderer that cannot draw
// decisions.
//
// Nothing here specializes a MEMO kind: the fixture is plain standard SysML,
// and that is the property under test. The renderer classifies its nodes from
// the metamodel (`activity-notation.ts`), not from an ontology kind.
package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_standard_activity_view {
    private import ScalarValues::*;

    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    private import activity_example::*;

    view standardActivityView : MemoDiagramView {
        expose FulfillOrder::**;
        attribute depth = 2;
        attribute :>> title = "Sample · Standard SysML Activity";
        attribute :>> shortDescription = "Standard SysML v2 activity notation — decision, merge, fork, join, accept, send, and terminate nodes with guarded successions.";
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "afd";
    }

    connection : IncludedIn connect sourceElement ::> FulfillOrder::receiveOrder to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> FulfillOrder::validateOrder to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> FulfillOrder::routeOrder to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> FulfillOrder::processOrder to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> FulfillOrder::rejectOrder to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> FulfillOrder::afterDecision to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> FulfillOrder::parallelWork to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> FulfillOrder::prepareShipment to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> FulfillOrder::createInvoice to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> FulfillOrder::readyToNotify to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> FulfillOrder::notifyCustomer to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> FulfillOrder::sendReceipt to targetView ::> standardActivityView;
    // The terminate node is unnamed in the source, so it is included by the id
    // the toolchain derives for it from its owning action.
    connection : IncludedIn connect sourceElement ::> FulfillOrder::FulfillOrder__terminate to targetView ::> standardActivityView;
}
