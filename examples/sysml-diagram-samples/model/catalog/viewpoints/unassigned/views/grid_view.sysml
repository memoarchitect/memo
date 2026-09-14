package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_grid_view {
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned::*;
    // Grid sample (grid view kind, `fmea` diagram type). The grid template groups
    // rows by kind and derives columns from whichever attributes the rows
    // actually carry — no fixed schema, so three FailureMode rows render as one
    // FMEA worksheet table.
    private import ScalarValues::*;

    private import memo_assurance_safety_risk_analysis::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;

    part fmMotorRunaway : FailureMode {
        attribute :>> name = "PumpMotorRunaway";
        attribute :>> failureModeKind = FailureModeKind::unintendedFunction;
        attribute :>> effect = "Excess drug delivered beyond the prescribed rate.";
        attribute :>> severityRating = 1;
        attribute :>> occurrenceRating = 2;
        attribute :>> probability = ProbabilityKind::improbable;
        attribute :>> detectionRating = 3;
        attribute :>> rpn = 6;
        attribute :>> criticality = CriticalityKind::catastrophic;
    }
    part fmAirSensorSilent : FailureMode {
        attribute :>> name = "AirSensorFailsSilent";
        attribute :>> failureModeKind = FailureModeKind::lossOfFunction;
        attribute :>> effect = "Air embolism reaches the patient undetected.";
        attribute :>> severityRating = 1;
        attribute :>> occurrenceRating = 3;
        attribute :>> probability = ProbabilityKind::remote;
        attribute :>> detectionRating = 4;
        attribute :>> rpn = 12;
        attribute :>> criticality = CriticalityKind::catastrophic;
    }
    part fmOcclusionDrift : FailureMode {
        attribute :>> name = "OcclusionSensorDrift";
        attribute :>> failureModeKind = FailureModeKind::degradedFunction;
        attribute :>> effect = "Occlusion is detected late, interrupting therapy.";
        attribute :>> severityRating = 7;
        attribute :>> occurrenceRating = 4;
        attribute :>> probability = ProbabilityKind::occasional;
        attribute :>> detectionRating = 4;
        attribute :>> rpn = 112;
        attribute :>> criticality = CriticalityKind::high;
    }
}
