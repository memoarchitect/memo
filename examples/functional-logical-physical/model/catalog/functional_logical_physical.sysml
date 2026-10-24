// Focused example: the realization graph across perspectives.
    private import memo_assurance_verification_validation::*;
// One function is allocated to a logical component and realized by BOTH a
// software module and a mechanical part — realization is a many-to-many
// graph, and no layer is a mandatory pipeline stage.
package memo_examples_functional_logical_physical {
    private import ScalarValues::*;
    private import ModelingMetadata::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_implementation_software_structure::*;
    private import memo_architecture_implementation_hardware_structure::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part def FunctionalLogicalPhysicalSystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The device whose functional, logical and physical design this example separates: the system this example models, with the software and hardware that realize it.";
    }
    // Operational world: what the clinician does.
    action actOcclusionResponse : OperativeAction {
        @MemoIdentity { :>> providedId = "FLP-ACT-001"; :>> label = "RespondToLineOcclusion"; }
        attribute :>> criticality = CriticalityKind::high;
    }

    // Functional: technology-independent responsibility.
    action fnLimitLinePressure : SystemFunction {
        @MemoIdentity { :>> providedId = "FLP-FN-001"; :>> label = "LimitLinePressure"; }
        attribute :>> criticality = CriticalityKind::high;
    }
    dependency from fnLimitLinePressure to actOcclusionResponse;

    // Logical: solution structure, still technology-independent.
    part lcPressureProtection : LogicalComponent {
        @MemoIdentity { :>> providedId = "FLP-LC-001"; :>> label = "PressureProtectionElement"; }
        attribute :>> controlledVariable = "line pressure";
    }
    allocate fnLimitLinePressure to lcPressureProtection;
    // Implementation: the SAME logical element is realized by software
    // (pressure-limit supervision) AND mechanics (mechanical relief valve).
    part swPressureSupervisor : SoftwareModule {
        @MemoIdentity { :>> providedId = "FLP-SW-001"; :>> label = "PressureSupervisor"; }
        attribute :>> responsibility = "Pause pumping when measured pressure exceeds threshold.";
        attribute :>> safetyClass = SafetyClassKind::C;
    }
    part mechReliefValve : MechanicalPart {
        @MemoIdentity { :>> providedId = "FLP-HW-001"; :>> label = "MechanicalReliefValve"; }
        attribute :>> mechanicalFunction = "vents line pressure above mechanical set point, independent of software";
        attribute :>> patientContact = false;
    }
    #refinement dependency swPressureSupervisor to lcPressureProtection;
    #refinement dependency mechReliefValve to lcPressureProtection;
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification vcAuthoredSwPressureSupervisor : VerificationCase {
        @MemoIdentity { :>> providedId = "FLP-VC-A01"; :>> label = "VerifyPressureSupervisor"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "unit, integration and system tests of 'PressureSupervisor' with the coverage IEC 62304 requires for software safety class C";
        subject verified : Base::Anything[*] = (swPressureSupervisor);
    }
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification vcAuthoredFnLimitLinePressure : VerificationCase {
        @MemoIdentity { :>> providedId = "FLP-VC-A02"; :>> label = "VerifyLimitLinePressure"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "'LimitLinePressure' meets its specified behaviour across its range, including the fault cases";
        subject verified : Base::Anything[*] = (fnLimitLinePressure);
    }
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredActOcclusionResponse : ValidationCase {
        @MemoIdentity { :>> providedId = "FLP-VC-A03"; :>> label = "VerifyRespondToLineOcclusion"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'RespondToLineOcclusion' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect validationTarget ::> actOcclusionResponse to validationCase ::> valAuthoredActOcclusionResponse;
}
