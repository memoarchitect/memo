package memo_assurance_requirements {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    // StakeholderNeed and the needs hierarchy now live in memo_assurance_requirements_needs.
    private import memo_assurance_requirements_needs::*;
    part def RiskDriver specializes RequirementDriver { attribute driverKind : String; }

    // The kind of requirement. Was a subclass branch (SystemRequirement /
    // SoftwareRequirement / HardwareRequirement) plus a parallel design-control
    // specification hierarchy (DesignControlSpecification / System- / Software- /
    // HardwareSpecification); now one attribute. The role-specific attributes
    // below are all optional so a requirement carries only the ones its kind
    // needs. IEC 62304 / design-control classification is preserved as the
    // enum value, not lost.
    enum def RequirementKind {
        enum system;
        enum software;
        enum hardware;
        enum systemSpecification;
        enum softwareSpecification;
        enum hardwareSpecification;
        enum designControl;
    }

    requirement def Requirement specializes MemoRequirement {
        attribute requirementKind : RequirementKind;
        attribute :>> statement : String;
        attribute sourceKind : RequirementSourceKind;
        attribute concernKind : ConcernKind;
        // Editorial state is the inherited `status : ElementStatusKind` — the
        // one status vocabulary in MEMO. Whether a requirement is implemented,
        // verified, or validated is read from its Realizes / VerifiedBy /
        // Validates links, not restated here.
        attribute :>> acceptanceCriteria : String;
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
        // software requirement / specification (IEC 62304)
        attribute safetyClass : SafetyClassKind[0..1];
        // hardware requirement
        attribute electricalSafetyRelevant : Boolean;
        // design-control specification (ISO 13485 design output)
        attribute specificationDomain : String;
        attribute sourceFolder : String;
        attribute linkedUserNeeds : String;
        attribute linkedRisks : String;
        attribute linkedTests : String;
    }
    // Named constant defined by a source requirements document (e.g. CriSys
    // GPCA App. A.4) and referenced from requirement statements.
    part def SystemConstant specializes MemoPart {
        attribute symbol : String;          // identifier as written in the source, e.g. "Tolerance_Max const"
        attribute unit : String;
        attribute valueType : String;
        attribute constantValue : String;   // empty when the source leaves the value open
        attribute valueCondition : String;  // constraints on the value stated by the source
    }
    // One row of a notification/alarm action table (e.g. CriSys GPCA REQ 59):
    // a named notification, its priority, and the actions the system must take.
    part def NotificationSpec specializes MemoPart {
        attribute priority : NotificationPriorityKind;
        attribute visualNotification : Boolean;
        attribute audioNotification : Boolean;
        attribute inhibitInfusion : Boolean;
        attribute inhibitSquareBolus : Boolean;
        attribute inhibitPatientBolus : Boolean;
        attribute stopBolus : Boolean;
    }
}
