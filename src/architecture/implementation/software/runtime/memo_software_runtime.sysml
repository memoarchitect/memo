// Software runtime (component-and-connector) view (§11). Runtime structure
// with concurrency, scheduling, health monitoring, fault containment, and
// update/rollback semantics. Module structure lives in
// memo_architecture_implementation_software_structure; allocation in
// memo_architecture_realization_deployment.
//
// Detailed AADL categories are PLANNED to live in an AADL correspondence
// profile built as an extension package — plans/memo-arcadia-native-coverage.md
// §C5, session 4. This comment used to point at `examples/aadl-mapping` as
// though it existed; it never has. A dangling pointer to a profile is worse
// than no profile, so it says "planned" until the profile is there.
package memo_architecture_implementation_software_runtime {
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

    part def SoftwareComponent specializes SoftwareItem {
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
        // runtime-kind-specific detail (set only for the relevant runtimeKind)
        attribute addressSpaceIsolated : Boolean[0..1];
        attribute owningProcessName : String[0..1];
        attribute serviceContract : String[0..1];
        attribute discoveryMechanism : String[0..1];
        attribute imageReference : String[0..1];
        attribute orchestrationPlatform : String[0..1];
        attribute partitionBudget : String[0..1];
        attribute isolationMechanism : String[0..1];
        attribute storageKind : String[0..1];
        attribute retentionPolicy : String[0..1];
        attribute deliverySemantics : String[0..1];
        attribute topicStructure : String[0..1];
    }

    connection def ComponentConnects :> MemoRelationship {
        attribute protocolSummary : String;
        end sourceComponent : SoftwareComponent :>> source;
        end targetComponent : SoftwareComponent :>> target;
    }
}
