// Project identity and method binding — the project's native entrypoint.
//
// The imports below name the reusable packages this project resolves, and the
// binding names its methodology with a typed SysML reference. Nothing outside
// SysML selects model content: delete every YAML file beside this one and the
// model still means exactly what it means now.
package connected_device_catalog {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    private import connected_device_architecture::*;
    private import connected_device_assurance::*;
    private import connected_device_artifacts::*;

    part projectMethodBinding : ProjectMethodBinding {
        attribute :>> id = "PMB-001";
        attribute :>> name = "{{name}}ProjectMethodBinding";
        attribute :>> projectName = "{{name}}";
        ref :>> selectedMethodology = mdDefaultDefinition;
        // The project adds no modules of its own yet. Under `explicit` an
        // empty additive list means exactly that — no additions — rather than
        // being read as "everything".
        attribute :>> scopeMode = ScopeModeKind::explicit;
    }
}
