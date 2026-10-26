package memo_examples_sysml_diagram_samples_samples_tree_view {
    private import ScalarValues::*;
    private import memo_architecture_implementation_hardware_structure::*;

    private import memo_architecture_realization_physical::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_physical_physical_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
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
