package memo_extension_container_methodology {
    private import ScalarValues::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part containerExtensionMethod : MethodologyDefinition {
        @MemoIdentity { :>> providedId = "EXT-CONTAINER-001"; :>> label = "ContainerDeploymentExtension"; }
        attribute :>> version = "0.13.2";
        attribute :>> domain = "containerized deployment";
        doc /* Adds OCI container images and container runtimes as deployment content. */
        ref :>> baseMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;
        attribute :>> includedModule = "memo_extension_container";
    }
}
