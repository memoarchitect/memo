package memo_examples_gpca_pump_model_samples_tree_view {
    private import ScalarValues::*;
    private import memo_architecture_hardware_structure::*;

    private import memo_architecture_physical::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    part rootA : HardwareAssembly { attribute :>> name = "Root A"; }
    part rootB : HardwareAssembly { attribute :>> name = "Root B"; }
    part branchA1 : HardwareAssembly { attribute :>> name = "Branch A.1"; }
    part branchA2 : HardwareAssembly { attribute :>> name = "Branch A.2 With A Deliberately Long Label"; }
    part branchB1 : HardwareAssembly { attribute :>> name = "Branch B.1"; }
    part leafA11 : HardwareAssembly {
        attribute :>> name = "Leaf A.1.1";
        attribute :>> partNumber = "PN-001";
    }
    part leafA12 : HardwareAssembly { attribute :>> name = "Leaf A.1.2"; }
    part leafA21 : HardwareAssembly { attribute :>> name = "Leaf A.2.1"; }
    part leafB11 : HardwareAssembly { attribute :>> name = "Leaf B.1.1"; }

    connection : Composes connect parent ::> rootA to child ::> branchA1;
    connection : Composes connect parent ::> rootA to child ::> branchA2;
    connection : Composes connect parent ::> rootA to child ::> rootB;
    connection : Composes connect parent ::> branchA1 to child ::> leafA11;
    connection : Composes connect parent ::> branchA1 to child ::> leafA12;
    connection : Composes connect parent ::> branchA2 to child ::> leafA21;
    connection : Composes connect parent ::> rootB to child ::> branchB1;
    connection : Composes connect parent ::> branchB1 to child ::> leafB11;

    part sampleTreeView : DiagramView {
        attribute :>> title = "Sample · Tree";
        attribute :>> shortDescription = "One connected dummy hierarchy with varied branch depths for tree layout development.";
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
        attribute :>> layoutHint = "tree";
        attribute :>> styleHint = "expanded:rootA,rootB,branchA1,branchB1";
        part :>> selectionQuery {
            attribute :>> includeRelationshipKinds = ("Composes");
        }
    }

    connection : IncludedIn connect sourceElement ::> rootA to targetView ::> sampleTreeView;
    connection : IncludedIn connect sourceElement ::> rootB to targetView ::> sampleTreeView;
    connection : IncludedIn connect sourceElement ::> branchA1 to targetView ::> sampleTreeView;
    connection : IncludedIn connect sourceElement ::> branchA2 to targetView ::> sampleTreeView;
    connection : IncludedIn connect sourceElement ::> branchB1 to targetView ::> sampleTreeView;
    connection : IncludedIn connect sourceElement ::> leafA11 to targetView ::> sampleTreeView;
    connection : IncludedIn connect sourceElement ::> leafA12 to targetView ::> sampleTreeView;
    connection : IncludedIn connect sourceElement ::> leafA21 to targetView ::> sampleTreeView;
    connection : IncludedIn connect sourceElement ::> leafB11 to targetView ::> sampleTreeView;
}
