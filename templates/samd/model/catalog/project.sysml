// Project identity and method binding — the project's native entrypoint.
//
// The imports below name the reusable packages this project resolves, and the
// binding names its methodology with a typed SysML reference. Nothing outside
// SysML selects model content: delete every YAML file beside this one and the
// model still means exactly what it means now.
package samd_catalog {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    private import samd_architecture::*;
    private import samd_assurance::*;
    private import samd_artifacts::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part projectMethodBinding : ProjectMethodBinding {
        @MemoIdentity { :>> providedId = "PMB-001"; }
        attribute :>> name = "{{name}}ProjectMethodBinding";
        attribute :>> projectName = "{{name}}";
        ref :>> selectedMethodology = mdDefaultDefinition;
        // The project adds no modules of its own yet. Under `explicit` an
        // empty additive list means exactly that — no additions — rather than
        // being read as "everything".
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
