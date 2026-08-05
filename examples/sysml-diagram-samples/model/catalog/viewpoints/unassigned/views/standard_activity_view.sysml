// Standard SysML v2 activity sample (actionflow view kind, `afd` diagram type).
//
// The view over `activity_example::CustomerProcess`, the standard-SysML activity
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
    private import memo_viewpoints_functional_functional_viewpoint::*;
    private import memo_core_enumerations::*;

    private import activity_example::*;

    view standardActivityView : MemoDiagramView {
        expose CustomerProcess::**;
        attribute depth = 2;
        attribute :>> title = "Sample · Customer Purchase Process";
        attribute :>> shortDescription = "Customer login, guarded validation, shopping loop, checkout, credit approval, and explicit completion outcomes.";
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "afd";
        part :>> viewpointDefinition = functionalViewpoint;
    }

    connection : IncludedIn connect sourceElement ::> CustomerProcess::customerLogsIn to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::validUserDecision to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::rejected to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::browseCatalog to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::viewBookStore to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::selectBookForPurchase to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::addToShoppingBasket to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::viewShoppingBasket to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::shoppingDecision to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::commitOrder to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::supplyCreditCardDetails to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::creditDecision to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::rejectCreditCard to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::closeOrder to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::confirmPurchase to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::itemsDelivered to targetView ::> standardActivityView;
    connection : IncludedIn connect sourceElement ::> CustomerProcess::orderComplete to targetView ::> standardActivityView;
}
