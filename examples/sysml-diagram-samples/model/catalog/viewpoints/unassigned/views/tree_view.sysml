package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_tree_view {
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned::*;
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
        attribute :>> name = "Root A";
        part branchA1 : HardwareAssembly {
            attribute :>> name = "Branch A.1";
            part leafA11 : HardwareAssembly {
                attribute :>> name = "Leaf A.1.1";
                attribute :>> partNumber = "PN-1";
            }
            part leafA12 : HardwareAssembly { attribute :>> name = "Leaf A.1.2"; }
        }
        part branchA2 : HardwareAssembly {
            attribute :>> name = "Branch A.2 With A Deliberately Long Label";
            part leafA21 : HardwareAssembly { attribute :>> name = "Leaf A.2.1"; }
        }
        part rootB : HardwareAssembly {
            attribute :>> name = "Root B";
            part branchB1 : HardwareAssembly {
                attribute :>> name = "Branch B.1";
                part leafB11 : HardwareAssembly { attribute :>> name = "Leaf B.1.1"; }
            }
        }
    }
}
