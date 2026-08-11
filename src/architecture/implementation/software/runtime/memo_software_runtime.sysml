// Software runtime (component-and-connector) view (§11), matching the SEI
// Views and Beyond distinction between runtime components and implementation
// modules. Runtime structure carries concurrency, scheduling, health
// monitoring, fault containment, and update/rollback semantics. Module structure lives in
// memo_architecture_implementation_software_structure; allocation in
// memo_architecture_realization_deployment.
//
// Detailed AADL categories live in the AADL correspondence profile, which is
// an extension package: `extensions/aadl` (plan §C5). It carries the process /
// thread / virtual-processor families and a correspondence rule per mapped
// name and property. This comment pointed at `examples/aadl-mapping` for a
// long time and that directory never existed; the pointer above resolves.
package memo_architecture_implementation_software_runtime {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_implementation_software_structure::*;

    // process / thread / task / service / container / partition /
    // dataStore / messageBroker.
    enum def RuntimeKind {
        enum process;
        enum thread;
        enum task;
        enum service;
        enum container;
        enum partition;
        enum dataStore;
        enum messageBroker;
    }

    part def SoftwareComponent specializes SoftwareElement {
        attribute runtimeKind : RuntimeKind;
        attribute responsibility : String;
        attribute periodMs : Real;
        attribute deadlineMs : Real;
        attribute wcetMs : Real;
        attribute schedulingPolicy : SchedulingPolicyKind;
        attribute priority : Integer;
        attribute activation : String;
        attribute synchronizationMechanism : String;
        attribute sharedResources : String;
        attribute memoryBudget : String;
        attribute healthMonitoring : String;
        attribute restartPolicy : String;
        attribute faultContainment : String;
        attribute version : String;
        attribute cybersecurityCriticality : CriticalityKind;
        attribute auditable : Boolean;
        attribute updatePolicy : String;
        attribute rollbackPolicy : String;
        // Twelve runtime-kind-conditional attributes used to follow, each
        // documented "set only for the relevant runtimeKind" — which is a
        // subtype family in disguise, and a technology the base ontology had
        // no business asserting. They are gone; every one of them now lives on
        // a type in an extension, where it is unconditional and therefore
        // checkable (plan §10.3 D3, extensions/README.md):
        //
        //   addressSpaceIsolated, owningProcessName,
        //   partitionBudget, isolationMechanism          -> extensions/aadl
        //   serviceContract, discoveryMechanism,
        //   storageKind, retentionPolicy                 -> extensions/cloud
        //   imageReference, orchestrationPlatform        -> extensions/container
        //   deliverySemantics, topicStructure            -> extensions/messaging
        //
        // The last two were also on the wrong metaclass: a component does not
        // have a topic, a publication does.
        //
        // What stays is what is true of EVERY runtime component in every
        // regulated project — the AADL thread properties above and the
        // assurance ones — plus `runtimeKind` itself, which says which family
        // a component belongs to without claiming to describe it.
    }

    connection def ComponentConnects :> MemoRelationship {
        attribute protocolSummary : String;
        end sourceComponent : SoftwareComponent :>> source;
        end targetComponent : SoftwareComponent :>> target;
    }
    abstract connection componentConnectsLinks : ComponentConnects[*];
    metadata def <componentConnects> ComponentConnectsMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = componentConnectsLinks meta SysML::Usage;
    }
}
