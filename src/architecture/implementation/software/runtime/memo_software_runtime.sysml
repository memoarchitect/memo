// Software runtime (component-and-connector) view (§11). Runtime structure
// with concurrency, scheduling, health monitoring, fault containment, and
// update/rollback semantics. Module structure lives in
// memo_architecture_software_structure; allocation in
// memo_architecture_deployment. Detailed AADL categories stay in the AADL
// correspondence profile (examples/aadl-mapping).
package memo_architecture_software_runtime {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_software_structure::*;

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

    part def SoftwareComponent specializes ArchitectureElement {
        attribute runtimeKind : RuntimeKind;
        attribute responsibility : String;
        attribute safetyClass : SafetyClassKind;
        attribute complexity : ComplexityKind;
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
        end sourceComponent : SoftwareComponent;
        end targetComponent : SoftwareComponent;
    }
}
