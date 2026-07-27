package memo_architecture_functional_constraints {
    private import ScalarValues::*;

    doc /* Reusable quantitative constraint definitions. */

    constraint def MaxResponseTimeConstraint {
        attribute responseTimeMs : Real;
        attribute maxAllowedMs : Real;
    }
    constraint def LockoutIntervalConstraint {
        attribute elapsedMs : Real;
        attribute lockoutMs : Real;
    }
}
