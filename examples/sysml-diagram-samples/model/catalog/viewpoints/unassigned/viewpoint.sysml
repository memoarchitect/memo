// Diagram-type viewpoints for the sample gallery.
//
// The standard MEMO viewpoints group by engineering concern (Functional,
// Operational, …). These example-only viewpoints group by diagram kind
// so a user exploring the gallery finds each renderer demo in an
// obviously-named folder.
package memo_examples_sysml_diagram_samples_viewpoints_unassigned {
    private import ScalarValues::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;
    private import memo_viewpoints_stakeholders_concerns::*;
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;

    viewpoint contextDiagramViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-DEMO-CTX"; }
        attribute :>> name = "Context Diagram";
        @MemoIdentity { :>> shortDescription = "System context — actors, external systems, and boundary interactions."; }
        attribute :>> explorerOrder = 1;
    }

    viewpoint actionFlowViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-DEMO-AFD"; }
        attribute :>> name = "Action Flow";
        @MemoIdentity { :>> shortDescription = "Swimlane action flows with typed item flows and composite actions."; }
        attribute :>> explorerOrder = 2;
    }

    viewpoint ibdViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-DEMO-IBD"; }
        attribute :>> name = "Internal Block Diagram";
        @MemoIdentity { :>> shortDescription = "Internal structure — parts, ports, and connectors."; }
        attribute :>> explorerOrder = 3;
    }

    viewpoint stateMachineViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-DEMO-STD"; }
        attribute :>> name = "State Machine";
        @MemoIdentity { :>> shortDescription = "State transitions with composite states and guards."; }
        attribute :>> explorerOrder = 4;
    }

    viewpoint sequenceViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-DEMO-SEQ"; }
        attribute :>> name = "Sequence Diagram";
        @MemoIdentity { :>> shortDescription = "Message sequences with combined fragments (loop, alt)."; }
        attribute :>> explorerOrder = 5;
    }

    viewpoint useCaseViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-DEMO-UCD"; }
        attribute :>> name = "Use Case Diagram";
        @MemoIdentity { :>> shortDescription = "Actors, use cases, include/extend/generalization."; }
        attribute :>> explorerOrder = 6;
    }

    viewpoint requirementsDiagramViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-DEMO-REQ"; }
        attribute :>> name = "Requirements Diagram";
        @MemoIdentity { :>> shortDescription = "Needs, requirements, and derivation traces."; }
        attribute :>> explorerOrder = 7;
    }

    viewpoint browserViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-DEMO-BRW"; }
        attribute :>> name = "Browser View";
        @MemoIdentity { :>> shortDescription = "Hierarchical membership tree of model elements."; }
        attribute :>> explorerOrder = 8;
    }

    viewpoint gridViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-DEMO-GRD"; }
        attribute :>> name = "Grid / Table View";
        @MemoIdentity { :>> shortDescription = "Tabular worksheet rendering of model attributes."; }
        attribute :>> explorerOrder = 9;
    }

    viewpoint treeViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-DEMO-TRE"; }
        attribute :>> name = "Decomposition Diagram";
        @MemoIdentity { :>> shortDescription = "Block decomposition — hierarchical breakdown rendered as a tree."; }
        attribute :>> explorerOrder = 10;
    }
}
