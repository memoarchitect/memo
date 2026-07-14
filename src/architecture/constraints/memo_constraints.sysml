package memo_architecture_constraints {
    private import ScalarValues::*;

    doc /* archLayer: constraints */

    constraint def MaxResponseTimeConstraint {
        attribute responseTimeMs : Real;
        attribute maxAllowedMs : Real;
    }
    constraint def LockoutIntervalConstraint {
        attribute elapsedMs : Real;
        attribute lockoutMs : Real;
    }
}
