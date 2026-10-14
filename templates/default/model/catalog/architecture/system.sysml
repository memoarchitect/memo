package project_architecture {
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_architecture_logical_structure::*;

    // The product, as a System: the kind a workspace is made from, and a kind the explorer files
    // under Architecture. (A bare `MemoPart` is the abstract base and files under evidence.)
    part def ProductSystem specializes System {
        @MemoIdentity { :>> label = "{{name}}"; }
    }
}
