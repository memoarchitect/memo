package samples {
    private import memo::architecture::physical::*;
    private import memo::core::relationships::*;
    private import memo::viewpoints::definitions::*;
    private import memo::core::enumerations::*;

    part rootA : HardwareAssembly { attribute redefines name = "Root A"; }
    part rootB : HardwareAssembly { attribute redefines name = "Root B"; }
    part branchA1 : HardwareAssembly { attribute redefines name = "Branch A.1"; }
    part branchA2 : HardwareAssembly { attribute redefines name = "Branch A.2 With A Deliberately Long Label"; }
    part branchB1 : HardwareAssembly { attribute redefines name = "Branch B.1"; }
    part leafA11 : HardwareAssembly {
        attribute redefines name = "Leaf A.1.1";
        attribute redefines partNumber = "PN-001";
    }
    part leafA12 : HardwareAssembly { attribute redefines name = "Leaf A.1.2"; }
    part leafA21 : HardwareAssembly { attribute redefines name = "Leaf A.2.1"; }
    part leafB11 : HardwareAssembly { attribute redefines name = "Leaf B.1.1"; }

    connection : Composes connect parent ::> rootA to child ::> branchA1;
    connection : Composes connect parent ::> rootA to child ::> branchA2;
    connection : Composes connect parent ::> rootA to child ::> rootB;
    connection : Composes connect parent ::> branchA1 to child ::> leafA11;
    connection : Composes connect parent ::> branchA1 to child ::> leafA12;
    connection : Composes connect parent ::> branchA2 to child ::> leafA21;
    connection : Composes connect parent ::> rootB to child ::> branchB1;
    connection : Composes connect parent ::> branchB1 to child ::> leafB11;

    part sampleTreeView : DiagramView {
        attribute redefines title = "Sample · Tree";
        attribute redefines shortDescription = "One connected dummy hierarchy with varied branch depths for tree layout development.";
        attribute redefines viewKind = DiagramViewKind::general;
        attribute redefines diagramType = "bdd";
        attribute redefines layoutHint = "tree";
        attribute redefines styleHint = "expanded:rootA,rootB,branchA1,branchB1";
        part selectionQuery {
            attribute redefines includeRelationshipKinds = {"Composes"};
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
