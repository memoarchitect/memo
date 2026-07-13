package memo {
    package architecture {
        package requirements {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;
            requirement def StakeholderNeed specializes RequirementDriver {
                attribute statement : String;
                attribute priority : String;
            }
            part def RiskDriver specializes RequirementDriver { attribute driverKind : String; }
            requirement def Requirement specializes VerifiableElement {
                attribute statement : String;
                attribute sourceKind : RequirementSourceKind;
                attribute concernKind : ConcernKind;
                attribute status : RequirementStatusKind;
                attribute acceptanceCriteria : String;
                attribute subjectDescription : String;
                attribute actorDescription : String;
                attribute assumptionSummary : String;
                attribute guaranteeSummary : String;
                // Authoring notation. `notation` selects the syntactic discipline the
                // `statement` follows; the slot attributes below carry the parsed clauses
                // so tools can lint pattern conformance and render either style.
                attribute notation : RequirementNotationKind;
                attribute earsPattern : EarsPatternKind;   // applies when notation = ears
                attribute obligation : ObligationKind;      // shall/should/will (RFC 2119, SOPHIST legal-obligation)
                attribute conditionClause : String;         // EARS When/While/If/Where or SOPHIST condition clause
                attribute systemResponse : String;          // the "shall <system response>" predicate
            }
            requirement def SystemRequirement specializes Requirement;
            requirement def SoftwareRequirement specializes Requirement { attribute safetyClass : SafetyClassKind; }
            requirement def HardwareRequirement specializes Requirement { attribute electricalSafetyRelevant : Boolean; }
            // Named constant defined by a source requirements document (e.g. CriSys
            // GPCA App. A.4) and referenced from requirement statements.
            part def SystemConstant specializes TraceableElement {
                attribute symbol : String;          // identifier as written in the source, e.g. "Tolerance_Max const"
                attribute unit : String;
                attribute valueType : String;
                attribute constantValue : String;   // empty when the source leaves the value open
                attribute valueCondition : String;  // constraints on the value stated by the source
            }
            // One row of a notification/alarm action table (e.g. CriSys GPCA REQ 59):
            // a named notification, its priority, and the actions the system must take.
            part def NotificationSpec specializes TraceableElement {
                attribute priority : NotificationPriorityKind;
                attribute visualNotification : Boolean;
                attribute audioNotification : Boolean;
                attribute inhibitInfusion : Boolean;
                attribute inhibitSquareBolus : Boolean;
                attribute inhibitPatientBolus : Boolean;
                attribute stopBolus : Boolean;
            }
        }
    }
}
