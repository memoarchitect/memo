// Containerized deployment (OCI). Technology-neutral across orchestrators, so
// a project that containerizes anything can include this module on its own;
// `memo_extension_ros` specializes both types rather than restating them.
//
// This is where `imageReference` and `orchestrationPlatform` live now. They
// were optional attributes on `SoftwareComponent` documented "set only when
// runtimeKind = container" — a subtype family in disguise, and a technology
// choice the base ontology had no business asserting. On the types below they
// are unconditional, which is what makes them checkable.
package memo_extension_container {
    private import ScalarValues::*;

    private import memo_architecture_realization_deployment::*;

    // The built artifact. `BuildsInto` (SoftwareModule -> DeploymentUnit)
    // reaches it unchanged, which is the test that the base is factored
    // correctly: a whole packaging technology lands without touching a base
    // relation.
    part def ContainerImage specializes DeploymentUnit {
        // The pullable reference, e.g. "registry.example.com/screening:1.4.0".
        attribute imageReference : String;
        attribute registry : String;
        // The content digest. A tag can be re-pointed; a digest is what a
        // design history file can argue reproducibility from.
        attribute digest : String;
        attribute baseImage : String;
    }

    // The environment a node provides. `ProvidesEnvironment` (ProcessingNode
    // -> RuntimeEnvironment) reaches it unchanged.
    part def ContainerRuntime specializes RuntimeEnvironment {
        // Kubernetes, Nomad, Docker Compose, systemd-nspawn, none.
        attribute orchestrationPlatform : String;
        // The engine below the orchestrator — containerd, CRI-O, Docker.
        attribute runtimeEngine : String;
    }
}
