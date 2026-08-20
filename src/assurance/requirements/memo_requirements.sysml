package memo_assurance_requirements {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    // StakeholderNeed and the needs hierarchy now live in memo_assurance_requirements_needs.
    private import memo_assurance_requirements_needs::*;
    part def RiskDriver specializes RequirementDriver { attribute driverKind : String; }

    // What a requirement is about: the system, the software, the hardware, or
    // the instructions for use. One axis, and the members are its values.
    //
    // It carried a second axis until now. `systemSpecification`,
    // `softwareSpecification`, `hardwareSpecification` and `designControl` are
    // the design-control ROLE — input versus output, 21 CFR 820.30(c)/(d) and
    // ISO 13485 §7.3.3/§7.3.4 — multiplied into the subject. A requirement then
    // could not say "software" without also committing to a role, the grid was
    // incomplete by construction (there is no `ifuSpecification`, and there
    // would have to be one for every future pairing), and nothing ever used the
    // four: 250 requirements across the examples say system, software or
    // hardware. A role, if a project needs one, is its own attribute.
    //
    // The instructions for use are neither hardware nor software: the device
    // satisfies such a requirement with words rather than with a part or a
    // module, and it is verified by reviewing the IFU rather than by testing a
    // build (EU MDR Annex I §23.4, ISO 20417, IEC 62366-1 §7.2).
    enum def RequirementTypeKind {
        enum system;
        enum software;
        enum hardware;
        enum ifu;
    }

    requirement def Requirement specializes MemoRequirement {
        attribute requirementType : RequirementTypeKind;
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
