package memo_architecture_logical_structure {
    private import ScalarValues::*;

    private import memo_core_common::*;
    part def LogicalComponent specializes ArchitectureElement {
        attribute responsibility : String;
        attribute decompositionLevel : String;
        attribute safetyPartition : String;
    }
}
