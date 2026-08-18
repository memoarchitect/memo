// The AADL correspondence profile (plan §C5).
//
// `memo_software_runtime.sysml` pointed at `examples/aadl-mapping` for a long
// time, and that directory never existed. A dangling pointer to a profile is
// worse than no profile, so this is the profile.
//
// It is written as model content, not prose: each correspondence is a
// `CorrespondenceRule` — MEMO's own ISO/IEC/IEEE 42010 element for relating
// elements across architecture descriptions — carrying the MEMO name, the AADL
// name, and the direction. That makes the mapping greppable, exportable, and
// checkable, which a comment block is not.
//
// Scope: the correspondence records what MEMO already means in AADL terms. It
// does not claim MEMO is AADL. Where AADL has no MEMO counterpart (subprogram,
// device, abstract) or MEMO has no AADL counterpart (every assurance
// discipline), there is simply no rule.
package memo_extension_aadl_correspondence {
    private import ScalarValues::*;

    private import memo_architecture_operational_context_stakeholders::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    // ── Component categories ────────────────────────────────────────────
    part aadlCorrProcess : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-001"; }
        attribute :>> name = "ProcessCorrespondence";
        attribute :>> ruleExpression = "memo_extension_aadl_runtime::AadlProcess <-> AADL component category `process`";
        attribute :>> description = "A MEMO SoftwareComponent with runtimeKind = process, carrying addressSpaceIsolated.";
    }
    part aadlCorrThread : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-002"; }
        attribute :>> name = "ThreadCorrespondence";
        attribute :>> ruleExpression = "memo_extension_aadl_runtime::AadlThread <-> AADL component category `thread`";
        attribute :>> description = "Schedulable unit inside one process; owningProcessName names the containing process.";
    }
    part aadlCorrVirtualProcessor : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-003"; }
        attribute :>> name = "VirtualProcessorCorrespondence";
        attribute :>> ruleExpression = "memo_extension_aadl_runtime::AadlVirtualProcessor <-> AADL component category `virtual processor`";
        attribute :>> description = "An ARINC 653 partition. partitionBudget is the guaranteed time and memory; isolationMechanism is what enforces it.";
    }
    part aadlCorrProcessor : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-004"; }
        attribute :>> name = "ProcessorCorrespondence";
        attribute :>> ruleExpression = "memo_architecture_realization_physical::ProcessingNode <-> AADL component category `processor`";
    }
    part aadlCorrMemory : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-005"; }
        attribute :>> name = "MemoryCorrespondence";
        attribute :>> ruleExpression = "memo_architecture_realization_physical::MemoryDevice <-> AADL component category `memory`";
    }
    part aadlCorrBus : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-006"; }
        attribute :>> name = "BusCorrespondence";
        attribute :>> ruleExpression = "memo_architecture_implementation_hardware_electrical::NetworkMedium <-> AADL component category `bus`";
    }
    part aadlCorrSystem : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-007"; }
        attribute :>> name = "SystemCorrespondence";
        attribute :>> ruleExpression = "memo_architecture_logical_structure::System <-> AADL component category `system`";
        attribute :>> description = "AADL's system is the composition unit, which is MEMO's logical System rather than any runtime element.";
    }

    // ── Bindings. AADL's analytic power is that everything is bound to
    // something, and the binding is where latency, bandwidth, and fault
    // propagation accrue. MEMO has all three (plan C1). ────────────────────
    part aadlCorrProcessorBinding : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-010"; }
        attribute :>> name = "ActualProcessorBindingCorrespondence";
        attribute :>> ruleExpression = "memo_architecture_realization_deployment::DeploysTo <-> AADL property `Actual_Processor_Binding`";
    }
    part aadlCorrMemoryBinding : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-011"; }
        attribute :>> name = "ActualMemoryBindingCorrespondence";
        attribute :>> ruleExpression = "memo_architecture_realization_deployment::MemoryBinding <-> AADL property `Actual_Memory_Binding`";
    }
    part aadlCorrConnectionBinding : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-012"; }
        attribute :>> name = "ActualConnectionBindingCorrespondence";
        attribute :>> ruleExpression = "memo_architecture_realization_deployment::ConnectionBinding <-> AADL property `Actual_Connection_Binding`";
        attribute :>> description = "The bound element is the ComponentExchange, because the exchange is what owns the budget the medium spends.";
    }

    // ── Ports and flows ─────────────────────────────────────────────────
    part aadlCorrPortCategory : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-020"; }
        attribute :>> name = "PortCategoryCorrespondence";
        attribute :>> ruleExpression = "memo_core_enumerations::PortCategoryKind (data | 'event' | eventData) <-> AADL `data port` | `event port` | `event data port`";
        attribute :>> description = "Determines whether a missed deadline loses a sample or grows a queue — two failure modes with two mitigations.";
    }
    part aadlCorrFlowSpec : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-021"; }
        attribute :>> name = "FlowSpecificationCorrespondence";
        attribute :>> ruleExpression = "memo_architecture_realization_deployment::FlowSpecification (FlowSpecKind source | sink | path) <-> AADL `flow source` | `flow sink` | `flow path`";
    }
    part aadlCorrEndToEndFlow : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-022"; }
        attribute :>> name = "EndToEndFlowCorrespondence";
        attribute :>> ruleExpression = "memo_architecture_realization_deployment::EndToEndFlow <-> AADL `end to end flow`";
    }

    // ── Properties. AADL's property sets are the technology-specific half of
    // the language; these are the ones MEMO already carries by another name.
    part aadlCorrPeriod : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-030"; }
        attribute :>> name = "PeriodCorrespondence";
        attribute :>> ruleExpression = "SoftwareComponent.periodMs <-> AADL `Timing_Properties::Period` (ms)";
    }
    part aadlCorrDeadline : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-031"; }
        attribute :>> name = "DeadlineCorrespondence";
        attribute :>> ruleExpression = "SoftwareComponent.deadlineMs <-> AADL `Timing_Properties::Deadline` (ms)";
    }
    part aadlCorrComputeExecutionTime : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-032"; }
        attribute :>> name = "ComputeExecutionTimeCorrespondence";
        attribute :>> ruleExpression = "SoftwareComponent.wcetMs <-> upper bound of AADL `Timing_Properties::Compute_Execution_Time` (ms)";
        attribute :>> description = "AADL records a range; MEMO records the worst case, which is the bound a schedulability argument uses.";
    }
    part aadlCorrPriority : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-033"; }
        attribute :>> name = "PriorityCorrespondence";
        attribute :>> ruleExpression = "SoftwareComponent.priority <-> AADL `Thread_Properties::Priority`";
    }
    part aadlCorrSchedulingProtocol : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-034"; }
        attribute :>> name = "SchedulingProtocolCorrespondence";
        attribute :>> ruleExpression = "SoftwareComponent.schedulingPolicy <-> AADL `Deployment_Properties::Scheduling_Protocol`";
    }
    part aadlCorrLatency : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-035"; }
        attribute :>> name = "LatencyCorrespondence";
        attribute :>> ruleExpression = "EndToEndFlow.latencyBudgetMs <-> AADL `Communication_Properties::Latency` upper bound (ms)";
    }
    part aadlCorrBandwidth : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-036"; }
        attribute :>> name = "BandwidthCorrespondence";
        attribute :>> ruleExpression = "ConnectionBinding.allocatedBandwidth <-> AADL `Communication_Properties::Bandwidth_Budget`";
    }

    // ── Where the correspondence stops ──────────────────────────────────
    part aadlCorrNoCounterpart : CorrespondenceRule {
        @MemoIdentity { :>> providedId = "EXT-AADL-C-090"; }
        attribute :>> name = "NoCounterpartNote";
        attribute :>> ruleExpression = "no correspondence: AADL `subprogram`, `device`, `abstract`; MEMO's five assurance disciplines";
        attribute :>> description = "Recorded so the gap is a stated boundary of the profile rather than an omission a reader has to discover.";
    }
}
