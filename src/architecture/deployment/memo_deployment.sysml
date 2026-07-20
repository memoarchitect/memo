// Deployment (allocation) view: SoftwareModule buildsInto
// DeploymentUnit; DeploymentUnit deploysTo ProcessingNode; SoftwareComponent
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
    private import memo_architecture_functions::*;
    private import memo_architecture_logical_structure::*;

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
        end module : SoftwareModule;
        end deploymentUnit : DeploymentUnit;
    }
    connection def DeploysTo :> MemoRelationship {
        attribute deploymentKind : DeploymentKind;
        end deploymentUnit : DeploymentUnit;
        end node : ProcessingNode;
    }
    connection def ProvidesEnvironment :> MemoRelationship {
        end node : ProcessingNode;
        end environment : RuntimeEnvironment;
    }

    // ─── AADL-style flow modeling (SAE AS5506) ───────────────────────────
    // AADL separates a flow *specification* (declared at a component boundary
    // as source / sink / path through ports) from a flow *implementation*
    // (its routing through subcomponents and connectors), and traces a
    // complete source→sink flow as an *end-to-end flow* across the assembly.
    // MEMO keeps software and hardware as distinct families (SoftwareModule
    // vs ProcessingNode) and analyses the flow across their binding — the same
    // way AADL end-to-end flows account for processor/bus bindings — enabling
    // latency and fault-propagation analysis.
    enum def FlowSpecKind {
        enum source;
        enum sink;
        enum path;
    }
    // A flow declared at a logical component boundary (in-port → out-port).
    part def FlowSpecification specializes ArchitectureElement {
        attribute flowKind : FlowSpecKind;
        ref inPort : LogicalPort[0..1];
        ref outPort : LogicalPort[0..1];
    }
    // A complete source→sink flow traced across the layers and the software→
    // hardware binding it traverses. `latencyBudgetMs` and `analysisPurpose`
    // (latency | fault-propagation | security) drive the AADL-style analysis.
    part def EndToEndFlow specializes ArchitectureElement {
        attribute latencyBudgetMs : Real;
        attribute analysisPurpose : String;
        ref sourceFunction : SystemFunction[0..1];
        ref sinkFunction : SystemFunction[0..1];
        ref logicalSegments : LogicalComponent[0..*];
        // Runtime C&C components (SEI) — the elements actually bound to hardware.
        ref softwareSegments : SoftwareComponent[0..*];
        ref hostNodes : ProcessingNode[0..*];
    }
    // The end-to-end flow is realized by an ordered flow specification, one
    // segment per traversed component boundary (AADL flow-spec → end-to-end).
    connection def FlowComprisesSpec :> MemoRelationship {
        attribute segmentOrder : Integer;
        end flow : EndToEndFlow;
        end spec : FlowSpecification;
    }
    // The flow traverses a software→hardware binding; latency accrues here.
    connection def FlowTraversesBinding :> MemoRelationship {
        end flow : EndToEndFlow;
        end deploymentUnit : DeploymentUnit;
    }
}
