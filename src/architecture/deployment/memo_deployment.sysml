// Deployment (allocation) view (§11, ADR-0004): SoftwareModule buildsInto
// DeploymentUnit; DeploymentUnit deploysTo ProcessingNode; RuntimeComponent
// hostedBy ProcessingNode. Software deploys only to capable execution nodes
// (rules/crosslayer).
package memo_architecture_deployment {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_software_structure::*;
    private import memo_architecture_software_runtime::*;
    private import memo_architecture_physical::*;

    part def DeploymentUnit specializes ArchitectureElement {
        attribute unitKind : String;
        attribute version : String;
        attribute integrityProtection : String;
        attribute installationMechanism : String;
    }

    part def RuntimeEnvironment specializes ArchitectureElement {
        attribute environmentKind : String;
        attribute osOrRtos : String;
        attribute providedServices : String;
        attribute certificationEvidence : String;
    }

    connection def BuildsInto :> MemoRelationship {
        end module : SoftwareComponent;
        end deploymentUnit : DeploymentUnit;
    }
    connection def DeploysTo :> MemoRelationship {
        attribute deploymentKind : DeploymentKind;
        end deploymentUnit : DeploymentUnit;
        end node : ProcessingNode;
    }
    connection def HostsRuntime :> MemoRelationship {
        end node : ProcessingNode;
        end runtimeComponent : RuntimeComponent;
    }
    connection def ProvidesEnvironment :> MemoRelationship {
        end node : ProcessingNode;
        end environment : RuntimeEnvironment;
    }
}
