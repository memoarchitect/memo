// Focused example: the realization graph across perspectives.
// One function is allocated to a logical component and realized by BOTH a
// software module and a mechanical part — realization is a many-to-many
// graph, and no layer is a mandatory pipeline stage.
package memo_examples_functional_logical_physical {
    private import memo::*;
    private import ScalarValues::*;


    part def FunctionalLogicalPhysicalSystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The device whose functional, logical and physical design this example separates: the system this example models, with the software and hardware that realize it.";
    }
    // Operational world: what the clinician does.
    action actOcclusionResponse : OperativeAction {
        @MemoIdentity { :>> providedId = "FLP-ACT-001"; :>> label = "Respond to line occlusion"; }
        attribute :>> criticality = CriticalityKind::high;
        perform fnLimitLinePressure;
    }

    // Functional: technology-independent responsibility.
    action fnLimitLinePressure : SystemFunction {
        @MemoIdentity { :>> providedId = "FLP-FN-001"; :>> label = "Limit line pressure"; }
        attribute :>> criticality = CriticalityKind::high;
    }

    // Logical: solution structure, still technology-independent.
    part lcPressureProtection : LogicalComponent {
        @MemoIdentity { :>> providedId = "FLP-LC-001"; :>> label = "Pressure protection element"; }
        attribute :>> controlledVariable = "line pressure";
    }
    allocate fnLimitLinePressure to lcPressureProtection;
    // Implementation: the SAME logical element is realized by software
    // (pressure-limit supervision) AND mechanics (mechanical relief valve).
    part swPressureSupervisor : SoftwareModule {
        @MemoIdentity { :>> providedId = "FLP-SW-001"; :>> label = "Pressure supervisor"; }
        attribute :>> responsibility = "Pause pumping when measured pressure exceeds threshold.";
        attribute :>> safetyClass = SafetyClassKind::C;
    }
    part mechReliefValve : MechanicalPart {
        @MemoIdentity { :>> providedId = "FLP-HW-001"; :>> label = "Mechanical relief valve"; }
        attribute :>> mechanicalFunction = "vents line pressure above mechanical set point, independent of software";
        attribute :>> patientContact = false;
    }
    allocation : RealizedBy allocate lcPressureProtection to swPressureSupervisor;
    allocation : RealizedBy allocate lcPressureProtection to mechReliefValve;
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification vcAuthoredSwPressureSupervisor : VerificationCase {
        @MemoIdentity { :>> providedId = "FLP-VC-A01"; :>> label = "Verify pressure supervisor"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "unit, integration and system tests of 'Pressure supervisor' with the coverage IEC 62304 requires for software safety class C";
        subject verified : Base::Anything[*] = (swPressureSupervisor);
    }
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification vcAuthoredFnLimitLinePressure : VerificationCase {
        @MemoIdentity { :>> providedId = "FLP-VC-A02"; :>> label = "Verify limit line pressure"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "'Limit line pressure' meets its specified behaviour across its range, including the fault cases";
        subject verified : Base::Anything[*] = (fnLimitLinePressure);
    }
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredActOcclusionResponse : ValidationCase {
        @MemoIdentity { :>> providedId = "FLP-VC-A03"; :>> label = "Verify respond to line occlusion"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'Respond to line occlusion' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect actOcclusionResponse to valAuthoredActOcclusionResponse;
    // Illustrative: authored for this example, not the record of a real test run.
    part evAuthoredVcAuthoredSwPressureSupervisor : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "FLP-EV-A01"; :>> label = "Verify pressure supervisor report"; }
        attribute :>> evidenceType = "test report";
        attribute :>> resultSummary = "Illustrative result: the acceptance criteria are met.";
    }
    connection : ProducesEvidence connect vcAuthoredSwPressureSupervisor to evAuthoredVcAuthoredSwPressureSupervisor;
    // Illustrative: authored for this example, not the record of a real test run.
    part evAuthoredVcAuthoredFnLimitLinePressure : MemoEvidence {
        attribute :>> evidenceKind = EvidenceKind::evidence;
        @MemoIdentity { :>> providedId = "FLP-EV-A02"; :>> label = "Verify limit line pressure report"; }
        attribute :>> evidenceType = "test report";
        attribute :>> resultSummary = "Illustrative result: the acceptance criteria are met.";
    }
    connection : ProducesEvidence connect vcAuthoredFnLimitLinePressure to evAuthoredVcAuthoredFnLimitLinePressure;
    // Illustrative: authored for this example.
    requirement reqAuthoredSwPressureSupervisor : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "FLP-REQ-A01"; :>> label = "Pressure supervisor requirement"; }
        doc /* The software item PressureSupervisor shall perform the function allocated to it in the software architecture. */
        attribute :>> status = ElementStatusKind::draft;
    }
    satisfy reqAuthoredSwPressureSupervisor by swPressureSupervisor;
    // Illustrative: authored for this example.
    requirement needAuthoredSafeOperation : Need {
        attribute :>> needKind = NeedKind::'stakeholder';
        @MemoIdentity { :>> providedId = "FLP-NEED-A01"; :>> label = "Safe operation"; }
        doc /* The device shall operate safely and as intended. */
        attribute :>> priority = "high";
    }
    connection : DerivesFrom connect needAuthoredSafeOperation to reqAuthoredSwPressureSupervisor;
    // Illustrative: authored for this example.
    action fcAuthoredLimitLinePressure : FunctionalFlow {
        @MemoIdentity { :>> providedId = "FLP-FC-A01"; :>> label = "Limit line pressure chain"; }
        attribute :>> flowCategory = FunctionalFlowKind::nominal;
        attribute :>> safetyRelevant = true;
        attribute :>> securityRelevant = false;
        action fcsLimitLinePressure :> fnLimitLinePressure {
            @MemoIdentity { :>> providedId = "FLP-FCS-A01"; :>> label = "Limit line pressure chain step"; }
        }
    }
}
