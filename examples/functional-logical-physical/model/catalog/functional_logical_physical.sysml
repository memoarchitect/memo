// Focused example: the realization graph across perspectives.
// One function is allocated to a logical component and realized by BOTH a
// software module and a mechanical part — realization is a many-to-many
// graph, and no layer is a mandatory pipeline stage.
package memo_examples_functional_logical_physical {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_implementation_software_structure::*;
    private import memo_architecture_implementation_hardware_structure::*;

    // Operational world: what the clinician does.
    action actOcclusionResponse : OperationalActivity {
        attribute :>> id = "FLP-ACT-001"; attribute :>> name = "RespondToLineOcclusion";
        attribute :>> criticality = CriticalityKind::high;
    }

    // Functional: technology-independent responsibility.
    action fnLimitLinePressure : SystemFunction {
        attribute :>> id = "FLP-FN-001"; attribute :>> name = "LimitLinePressure";
        attribute :>> criticality = CriticalityKind::high;
    }
    connection : Enables connect enabling ::> fnLimitLinePressure to enabled ::> actOcclusionResponse;

    // Logical: solution structure, still technology-independent.
    part lcPressureProtection : LogicalComponent {
        attribute :>> id = "FLP-LC-001"; attribute :>> name = "PressureProtectionElement";
        attribute :>> controlledVariable = "line pressure";
    }
    allocation : AllocatedTo allocate fnLimitLinePressure to lcPressureProtection;
    // Implementation: the SAME logical element is realized by software
    // (pressure-limit supervision) AND mechanics (mechanical relief valve).
    part swPressureSupervisor : SoftwareModule {
        attribute :>> id = "FLP-SW-001"; attribute :>> name = "PressureSupervisor";
        attribute :>> responsibility = "Pause pumping when measured pressure exceeds threshold.";
        attribute :>> safetyClass = SafetyClassKind::C;
    }
    part mechReliefValve : MechanicalPart {
        attribute :>> id = "FLP-HW-001"; attribute :>> name = "MechanicalReliefValve";
        attribute :>> mechanicalFunction = "vents line pressure above mechanical set point, independent of software";
        attribute :>> patientContact = false;
    }
    #refinement dependency swPressureSupervisor to lcPressureProtection;
    #refinement dependency mechReliefValve to lcPressureProtection;
}
