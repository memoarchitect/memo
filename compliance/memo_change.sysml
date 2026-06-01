package memo {
    package compliance {
        package change {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;
            part def ChangeRequest specializes TraceableElement { attribute changeType : ChangeTypeKind; attribute impactAssessment : String; attribute approvalStatus : String; attribute affectedBaseline : String; }
            part def ConfigurationItem specializes TraceableElement { attribute version : String; attribute baseline : String; attribute controlLevel : String; }
        }
    }
}
