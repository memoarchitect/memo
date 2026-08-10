// Deployment (allocation) view: SoftwareModule buildsInto DeploymentUnit;
// DeploymentUnit deploysTo ProcessingNode. Software deploys only to capable
// execution nodes (rules/crosslayer).
//
// `HostedBy` is NOT part of that chain, and this comment used to claim it was
// ("SoftwareComponent hostedBy ProcessingNode"). It is
// `processingNode : ArchitectureElement -> hostAssembly : ArchitectureElement`:
// physical hosting of a node by the assembly it is mounted in, running the
// other way and between different things. Software reaches a node through
// DeploysTo.
package memo_architecture_realization_deployment {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;
    // The standard's allocation base, which the two AADL bindings below root
    // on alongside MemoRelationship.
    private import Allocations::Allocation;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_implementation_software_structure::*;
    private import memo_architecture_implementation_software_runtime::*;
    private import memo_architecture_implementation_hardware_electrical::*;   // NetworkMedium
    private import memo_architecture_realization_physical::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_logical_interfaces::*;                   // ComponentExchange

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
        end module : SoftwareModule :>> source;
        end deploymentUnit : DeploymentUnit :>> target;
    }
    abstract connection buildsIntoLinks : BuildsInto[*];
    metadata def <buildsInto> BuildsIntoMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = buildsIntoLinks meta SysML::Usage;
    }
    connection def DeploysTo :> MemoRelationship {
        attribute deploymentKind : DeploymentKind;
        end deploymentUnit : DeploymentUnit :>> source;
        end node : ProcessingNode :>> target;
    }
    abstract connection deploysToLinks : DeploysTo[*];
    metadata def <deploysTo> DeploysToMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = deploysToLinks meta SysML::Usage;
    }
    connection def ProvidesEnvironment :> MemoRelationship {
        end node : ProcessingNode :>> source;
        end environment : RuntimeEnvironment :>> target;
    }
    abstract connection providesEnvironmentLinks : ProvidesEnvironment[*];
    metadata def <providesEnvironment> ProvidesEnvironmentMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = providesEnvironmentLinks meta SysML::Usage;
    }

    // ─── AADL bindings (SAE AS5506) — plan C1 ────────────────────────────
    //
    // AADL's analytic power is that EVERYTHING is bound to something, and the
    // binding is where latency, bandwidth and fault propagation accrue. MEMO
    // had one binding of three: `DeploysTo` is `actual_processor_binding`.
    // Without the other two, `SoftwareComponent.memoryBudget` is unanalysable
    // and `EndToEndFlow.latencyBudgetMs` cannot be checked against the media
    // the flow traverses — the analysis the flow comment below describes and
    // the model could not perform.
    //
    // Both are `allocation def`s rooted on the standard's
    // `Allocations::Allocation`, because a binding IS an allocation and the
    // language says so. The double specialization keeps MEMO's identification
    // core from `MemoRelationship` while adding the standard's allocation
    // semantics; both root on `Connections::BinaryConnection`, so this is a
    // diamond and not a conflict. Verified under `syside check` against a
    // negative control (a non-existent supertype is reported), so the clean
    // result is the checker agreeing rather than the checker skipping.

    // AADL `actual_memory_binding`. Which memory a software component's code
    // and data occupy — what makes a memory budget a claim about a device
    // rather than a string.
    allocation def MemoryBinding :> MemoRelationship, Allocations::Allocation {
        attribute bindingKind : String;
        end boundComponent : SoftwareComponent :>> source;
        end memory : MemoryDevice :>> target;
    }
    abstract connection memoryBindingLinks : MemoryBinding[*];
    metadata def <memoryBinding> MemoryBindingMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::AllocationDefinition;
        :> annotatedElement : SysML::AllocationUsage;
        :>> baseType = memoryBindingLinks meta SysML::Usage;
    }

    // AADL `actual_connection_binding`. Which physical medium carries a
    // component exchange. The source is the ComponentExchange rather than the
    // `ComponentConnects` link, because the exchange is the ELEMENT that owns
    // the budget (§19.3) and a link instance is not something the graph can
    // bind to; it is also exactly where the latency the medium contributes has
    // to be accounted.
    allocation def ConnectionBinding :> MemoRelationship, Allocations::Allocation {
        attribute allocatedBandwidth : String;
        attribute mediumLatencyMs : Real;
        end boundExchange : ComponentExchange :>> source;
        end medium : NetworkMedium :>> target;
    }
    abstract connection connectionBindingLinks : ConnectionBinding[*];
    metadata def <connectionBinding> ConnectionBindingMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::AllocationDefinition;
        :> annotatedElement : SysML::AllocationUsage;
        :>> baseType = connectionBindingLinks meta SysML::Usage;
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
        ref sourceFunction : MemoFunction[0..1];
        ref sinkFunction : MemoFunction[0..1];
        ref logicalSegments : LogicalComponent[0..*];
        // Runtime C&C components (SEI) — the elements actually bound to hardware.
        ref softwareSegments : SoftwareComponent[0..*];
        ref hostNodes : ProcessingNode[0..*];
    }
    // The end-to-end flow is realized by an ordered flow specification, one
    // segment per traversed component boundary (AADL flow-spec → end-to-end).
    connection def FlowComprisesSpec :> MemoRelationship {
        attribute segmentOrder : Integer;
        end endToEndFlow : EndToEndFlow :>> source;
        end spec : FlowSpecification :>> target;
    }
    abstract connection flowComprisesSpecLinks : FlowComprisesSpec[*];
    metadata def <flowComprisesSpec> FlowComprisesSpecMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = flowComprisesSpecLinks meta SysML::Usage;
    }
    // The flow traverses a software→hardware binding; latency accrues here.
    connection def FlowTraversesBinding :> MemoRelationship {
        end endToEndFlow : EndToEndFlow :>> source;
        end deploymentUnit : DeploymentUnit :>> target;
    }
    abstract connection flowTraversesBindingLinks : FlowTraversesBinding[*];
    metadata def <flowTraversesBinding> FlowTraversesBindingMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = flowTraversesBindingLinks meta SysML::Usage;
    }
}
