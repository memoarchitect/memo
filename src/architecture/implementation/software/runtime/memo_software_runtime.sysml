// Software runtime (component-and-connector) view, matching the SEI Views and
// Beyond distinction between runtime components and implementation modules.
// Runtime structure carries concurrency, scheduling, health monitoring, fault
// containment, and update/rollback semantics. Module structure lives in
// memo_architecture_implementation_software_structure; allocation in
// memo_architecture_realization_deployment.
//
// Detailed AADL categories live in the AADL correspondence profile, which is an
// extension package: `extensions/aadl`. It carries the process / thread /
// virtual-processor families and a correspondence rule per mapped name and
// property. This comment pointed at `examples/aadl-mapping` for a long time and
// that directory never existed; the pointer above resolves.
package memo_architecture_implementation_software_runtime {
    private import memo_core_stdlib_quantities::*;
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
        @MemoIdentity { :>> label = "Software component"; }
        attribute runtimeKind : RuntimeKind;
        attribute responsibility : String;
        attribute periodMs : DurationValue;
        attribute deadlineMs : DurationValue;
        attribute wcetMs : DurationValue;
        attribute schedulingPolicy : SchedulingPolicyKind;
        attribute priority : Integer;
        attribute activation : String;
        attribute synchronizationMechanism : String;
        attribute sharedResources : String;
        // Maximum resident memory allocation in megabytes.  The public name
        // predates MEMO's unit-suffixed scalar convention, so document the
        // unit here rather than silently changing the published feature name.
        attribute memoryBudget : StorageCapacityValue;
        attribute healthMonitoring : String;
        attribute restartPolicy : String;
        attribute faultContainment : String;
        attribute version : String;
        attribute cybersecurityCriticality : CriticalityKind;
        attribute auditable : Boolean;
        attribute updatePolicy : String;
        attribute rollbackPolicy : String;
        // An attribute that applies to only one `runtimeKind` lives on a type
        // in an extension, where it is unconditional and therefore checkable
        // (extensions/README.md):
        //
        //   addressSpaceIsolated, owningProcessName,
        //   partitionBudget, isolationMechanism          -> extensions/aadl
        //   serviceContract, discoveryMechanism,
        //   storageKind, retentionPolicy                 -> extensions/cloud
        //   imageReference, orchestrationPlatform        -> extensions/container
        //   deliverySemantics, topicStructure            -> extensions/messaging
        //
        // The last two are not component properties at all: a component does
        // not have a topic, a publication does.
        //
        // What is here is what is true of EVERY runtime component in every
        // regulated project — the AADL thread properties above and the
        // assurance ones — plus `runtimeKind` itself, which says which family a
        // component belongs to without claiming to describe it.
    }

    // A runtime service or process that exists only because an OTS module is
    // deployed. Optional: a library the product links normally needs only the
    // module.
    part def OTSSoftwareComponent specializes SoftwareComponent {
        @MemoIdentity { :>> label = "OTS software component"; }
        ref sourceModule : OTSSoftwareModule[0..1];
    }

}
