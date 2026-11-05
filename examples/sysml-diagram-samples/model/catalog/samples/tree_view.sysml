package memo_examples_sysml_diagram_samples_samples_tree_view {
    private import memo::*;
    private import ScalarValues::*;


    part rootA : HardwareAssembly {
        @MemoIdentity { :>> label = "Root A"; }
        part branchA1 : HardwareAssembly {
            @MemoIdentity { :>> label = "Branch A.1"; }
            part leafA11 : HardwareAssembly {
                @MemoIdentity { :>> label = "Leaf A.1.1"; }
                attribute :>> partNumber = "PN-1";
            }
            part leafA12 : HardwareAssembly {@MemoIdentity { :>> label = "Leaf A.1.2"; } }
        }
        part branchA2 : HardwareAssembly {
            @MemoIdentity { :>> label = "Branch A.2 With A Deliberately Long Label"; }
            part leafA21 : HardwareAssembly {@MemoIdentity { :>> label = "Leaf A.2.1"; } }
        }
        part rootB : HardwareAssembly {
            @MemoIdentity { :>> label = "Root B"; }
            part branchB1 : HardwareAssembly {
                @MemoIdentity { :>> label = "Branch B.1"; }
                part leafB11 : HardwareAssembly {@MemoIdentity { :>> label = "Leaf B.1.1"; } }
            }
        }
    }
}
