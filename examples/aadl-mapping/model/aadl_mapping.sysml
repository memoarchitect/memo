// AADL correspondence profile (§22, ADR-0004). AADL (SAE AS5506D) remains a
// mapping for analyzable embedded implementation architecture — MEMO's core
// stays small. Category and property correspondences are modeled as data so
// tools can drive an AADL export without new metamodel surface.
package memo_examples_aadl_mapping {
    private import ScalarValues::*;

    private import memo_core_common::*;

    part def AadlCategoryMapping specializes MemoPart {
        attribute aadlCategory : String;
        attribute memoConcept : String;
        attribute notes : String;
    }
    part def AadlPropertyMapping specializes MemoPart {
        attribute aadlProperty : String;
        attribute memoAttribute : String;
    }

    part mapSystem : AadlCategoryMapping {
        attribute :>> aadlCategory = "system";
        attribute :>> memoConcept = "LogicalSystem / SoftwareSystem";
        attribute :>> notes = "top-level composition";
    }
    part mapProcess : AadlCategoryMapping {
        attribute :>> aadlCategory = "process";
        attribute :>> memoConcept = "memo_architecture_software_runtime::Process";
        attribute :>> notes = "address-space isolation";
    }
    part mapThread : AadlCategoryMapping {
        attribute :>> aadlCategory = "thread";
        attribute :>> memoConcept = "memo_architecture_software_runtime::Thread / Task";
        attribute :>> notes = "schedulable unit";
    }
    part mapProcessor : AadlCategoryMapping {
        attribute :>> aadlCategory = "processor";
        attribute :>> memoConcept = "memo_architecture_physical::ProcessingNode";
        attribute :>> notes = "execution platform binding target";
    }
    part mapMemory : AadlCategoryMapping {
        attribute :>> aadlCategory = "memory";
        attribute :>> memoConcept = "memo_architecture_physical::MemoryDevice";
        attribute :>> notes = "";
    }
    part mapBus : AadlCategoryMapping {
        attribute :>> aadlCategory = "bus";
        attribute :>> memoConcept = "NetworkMedium / DigitalInterface";
        attribute :>> notes = "connection binding target";
    }
    part mapDevice : AadlCategoryMapping {
        attribute :>> aadlCategory = "device";
        attribute :>> memoConcept = "Sensor / Actuator";
        attribute :>> notes = "environment-facing hardware";
    }

    part propPeriod : AadlPropertyMapping {
        attribute :>> aadlProperty = "Timing_Properties::Period";
        attribute :>> memoAttribute = "RuntimeComponent.periodMs";
    }
    part propDeadline : AadlPropertyMapping {
        attribute :>> aadlProperty = "Timing_Properties::Deadline";
        attribute :>> memoAttribute = "RuntimeComponent.deadlineMs";
    }
    part propWcet : AadlPropertyMapping {
        attribute :>> aadlProperty = "Timing_Properties::Compute_Execution_Time";
        attribute :>> memoAttribute = "RuntimeComponent.wcetMs";
    }
    part propBinding : AadlPropertyMapping {
        attribute :>> aadlProperty = "Deployment_Properties::Actual_Processor_Binding";
        attribute :>> memoAttribute = "HostsRuntime (node -> runtimeComponent)";
    }
}
