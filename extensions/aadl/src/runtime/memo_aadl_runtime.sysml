// AADL (SAE AS5506) runtime component families.
//
// `SoftwareComponent.runtimeKind` says WHICH family a component belongs to and
// the base stops there, deliberately: the timing and assurance properties
// (period, deadline, WCET, scheduling policy, priority, health monitoring,
// restart policy, fault containment) are true of every runtime component in
// every regulated project, so they stay on the base.
//
// What the base used to carry as well was a set of attributes documented "set
// only for the relevant runtimeKind" — a subtype family in disguise, and one
// with a specific technology behind it. `addressSpaceIsolated` and
// `owningProcessName` are AADL's process/thread distinction; `partitionBudget`
// and `isolationMechanism` are AADL's virtual processor, which is what an
// ARINC 653 partition is modelled as. Each is unconditional on the type that
// owns it here, which is the whole point: an optional attribute that is only
// meaningful for one enum value cannot be checked, and a required attribute on
// a type can.
package memo_extension_aadl_runtime {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_architecture_implementation_software_runtime::*;

    // AADL `process`: a protected address space. Threads execute inside it;
    // the process itself is the fault-containment and memory-protection
    // boundary, which is why safety arguments quote it.
    part def AadlProcess specializes SoftwareComponent {
        attribute :>> runtimeKind = RuntimeKind::process;
        // Whether the runtime enforces memory protection at this boundary.
        // A process without address-space isolation is a scheduling unit, not
        // a containment boundary, and no partitioning claim may rest on it.
        attribute addressSpaceIsolated : Boolean;
    }

    // AADL `thread`: a schedulable unit of concurrency, always executing
    // within exactly one process. The base's period / deadline / WCET /
    // priority are AADL thread properties already; what was missing was the
    // containing process.
    part def AadlThread specializes SoftwareComponent {
        attribute :>> runtimeKind = RuntimeKind::thread;
        attribute owningProcessName : String;
    }

    // AADL `virtual processor`: a partition scheduled on a processor with a
    // guaranteed budget. This is how an ARINC 653 partition is modelled, and
    // the budget is what a temporal-partitioning argument is made of.
    part def AadlVirtualProcessor specializes SoftwareComponent {
        attribute :>> runtimeKind = RuntimeKind::partition;
        // Time and memory guaranteed to the partition, e.g. "2 ms window per
        // 10 ms major frame; 4 MB".
        attribute partitionBudget : String;
        // What enforces the partition — MMU, MPU, hypervisor, ARINC 653 module
        // OS. A budget nothing enforces is a plan, not a control.
        attribute isolationMechanism : String;
    }
}
