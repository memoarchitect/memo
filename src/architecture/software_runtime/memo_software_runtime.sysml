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

    part def RuntimeComponent specializes ArchitectureElement {
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
    }

    part def Process specializes RuntimeComponent {
        attribute addressSpaceIsolated : Boolean;
    }
    part def Thread specializes RuntimeComponent {
        attribute owningProcessName : String;
    }
    part def Task specializes RuntimeComponent {
        attribute taskKind : String;
    }
    part def Service specializes RuntimeComponent {
        attribute serviceContract : String;
        attribute discoveryMechanism : String;
    }
    part def Container specializes RuntimeComponent {
        attribute imageReference : String;
        attribute orchestrationPlatform : String;
    }
    // Time/space partition (e.g. hypervisor or ARINC-style partitioning).
    part def RuntimePartition specializes RuntimeComponent {
        attribute partitionBudget : String;
        attribute isolationMechanism : String;
    }
    part def DataStore specializes RuntimeComponent {
        attribute storageKind : String;
        attribute retentionPolicy : String;
    }
    part def MessageBroker specializes RuntimeComponent {
        attribute deliverySemantics : String;
        attribute topicStructure : String;
    }

    connection def RuntimeRealizesModule :> MemoRelationship {
        end runtimeComponent : RuntimeComponent;
        end module : SoftwareComponent;
    }
    connection def RuntimeConnects :> MemoRelationship {
        attribute protocolSummary : String;
        end sourceComponent : RuntimeComponent;
        end targetComponent : RuntimeComponent;
    }
    connection def PartitionHosts :> MemoRelationship {
        end partition : RuntimePartition;
        end hostedComponent : RuntimeComponent;
    }
}
