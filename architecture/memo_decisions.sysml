package memo {
    package architecture {
        package decisions {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;
            part def DesignDecision specializes TraceableElement { attribute decisionKind : String; attribute alternatives : String; attribute selectedOption : String; attribute decisionStatus : DesignDecisionStatusKind; }
        }
    }
}
