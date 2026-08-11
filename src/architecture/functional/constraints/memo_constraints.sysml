package memo_architecture_functional_constraints {
    private import ScalarValues::*;
    private import memo_core_common::*;

    doc /* Reusable quantitative constraint definitions. */

    constraint def MaxResponseTimeConstraint :> MemoConstraint {
        attribute responseTimeMs : Real;
        attribute maxAllowedMs : Real;
    }
    constraint def LockoutIntervalConstraint :> MemoConstraint {
        attribute elapsedMs : Real;
        attribute lockoutMs : Real;
    }
}
