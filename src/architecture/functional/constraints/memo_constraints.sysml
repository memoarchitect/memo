package memo_architecture_functional_constraints {
    private import memo_core_stdlib_quantities::*;
    private import ScalarValues::*;
    private import memo_core_common::*;

    doc /* Reusable quantitative constraint definitions. */

    constraint def MaxResponseTimeConstraint :> MemoConstraint {
        attribute responseTimeMs : DurationValue;
        attribute maxAllowedMs : DurationValue;
    }
    constraint def LockoutIntervalConstraint :> MemoConstraint {
        attribute elapsedMs : DurationValue;
        attribute lockoutMs : DurationValue;
    }
}
