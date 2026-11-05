package memo_examples_sysml_diagram_samples_samples_grid_view {
    private import memo::*;
    // Grid sample (grid view kind, `fmea` diagram type). The grid template groups
    // rows by kind and derives columns from whichever attributes the rows
    // actually carry — no fixed schema, so three FailureMode rows render as one
    // FMEA worksheet table.
    private import ScalarValues::*;



    item fmMotorRunaway : FailureMode {
        @MemoIdentity { :>> label = "Pump motor runaway"; }
        attribute :>> failureModeKind = FailureModeKind::unintendedFunction;
        attribute :>> effect = "Excess drug delivered beyond the prescribed rate.";
        attribute :>> severityRating = 1;
        attribute :>> occurrenceRating = 2;
        attribute :>> probability = ProbabilityKind::improbable;
        attribute :>> detectionRating = 3;
        attribute :>> rpn = 6;
        attribute :>> criticality = CriticalityKind::catastrophic;
    }
    item fmAirSensorSilent : FailureMode {
        @MemoIdentity { :>> label = "Air sensor fails silent"; }
        attribute :>> failureModeKind = FailureModeKind::lossOfFunction;
        attribute :>> effect = "Air embolism reaches the patient undetected.";
        attribute :>> severityRating = 1;
        attribute :>> occurrenceRating = 3;
        attribute :>> probability = ProbabilityKind::remote;
        attribute :>> detectionRating = 4;
        attribute :>> rpn = 12;
        attribute :>> criticality = CriticalityKind::catastrophic;
    }
    item fmOcclusionDrift : FailureMode {
        @MemoIdentity { :>> label = "Occlusion sensor drift"; }
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
