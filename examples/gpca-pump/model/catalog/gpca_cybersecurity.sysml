package memo_examples_gpca_pump_gpca_cybersecurity {
    private import memo::*;
    private import ScalarValues::*;
    private import memo_core_dimensions::*;   // ElementStatusKind

    private import memo_examples_gpca_pump_gpca_architecture::*;
    private import memo_examples_gpca_pump_gpca_risk::*;
    private import memo_examples_gpca_pump_gpca_requirements::*;
    private import memo_examples_gpca_pump_gpca_verification::*;

    part therapyConfigurationAsset : CybersecurityAsset {
        @MemoIdentity { :>> providedId = "AST-CYB-001"; }
        attribute :>> assetKind = AssetKind::configuration;
        attribute :>> confidentialityNeed = SecurityNeedKind::medium;
        attribute :>> integrityNeed = SecurityNeedKind::veryHigh;
        attribute :>> availabilityNeed = SecurityNeedKind::high;
        attribute :>> privacyRelevant = false;
        attribute :>> safetyRelevant = true;
        ref :>> holder = gpcaSoftware.config;
    }

    part patientEventLogAsset : CybersecurityAsset {
        @MemoIdentity { :>> providedId = "AST-CYB-002"; }
        attribute :>> assetKind = AssetKind::auditRecord;
        attribute :>> confidentialityNeed = SecurityNeedKind::high;
        attribute :>> integrityNeed = SecurityNeedKind::high;
        attribute :>> availabilityNeed = SecurityNeedKind::medium;
        attribute :>> privacyRelevant = true;
        attribute :>> safetyRelevant = false;
        ref :>> holder = gpcaSoftware.logging;
    }

    part maintenancePortBoundary : TrustBoundary {
        @MemoIdentity { :>> providedId = "TB-001"; }
        attribute :>> boundaryType = "service-access";
        attribute :>> crossingConstraint = "Boundary between service tooling and therapy controller runtime.";
        attribute :>> trustAssumption = "Service tooling on the untrusted side requires authentication before any crossing is permitted.";
    }

    // --8<-- [start:threat]
    part unauthorizedConfigChangeThreat : Threat {
        @MemoIdentity { :>> providedId = "TH-001"; :>> label = "Unauthorized therapy configuration change"; }
        attribute :>> driverKind = "cybersecurity";
        attribute :>> threatCategory = ThreatCategoryKind::tampering;
        attribute :>> attackVector = "maintenance port";
        attribute :>> threatSource = "unauthorized actor with local access";
        attribute :>> precondition = "maintenance interface exposed without strong authentication";
        attribute :>> affectedConcern = ConcernKind::cybersecurity;
        // --8<-- [end:threat]
    }

    part eventLogTamperingThreat : Threat {
        @MemoIdentity { :>> providedId = "TH-002"; :>> label = "Patient event log tampering"; }
        attribute :>> driverKind = "cybersecurity";
        attribute :>> threatCategory = ThreatCategoryKind::repudiation;
        attribute :>> attackVector = "maintenance port";
        attribute :>> threatSource = "unauthorized actor with local access";
        attribute :>> precondition = "audit log writable without integrity protection";
        attribute :>> affectedConcern = ConcernKind::cybersecurity;
    }

    // --8<-- [start:vulnerability]
    item weakServiceAuthentication : Vulnerability {
        @MemoIdentity { :>> providedId = "VULN-001"; }
        attribute :>> weakness = "service mode relies on shared default credential";
        attribute :>> exploitability = "moderate";
        attribute :>> discoveryMethod = "architecture review";
        ref :>> affectedElement = gpcaSoftware.config;
        attribute :>> cweReference = "CWE-798";
        // --8<-- [end:vulnerability]
    }

    action tamperedConfigurationScenario : OperativeScenario {
        @MemoIdentity { :>> providedId = "SCN-001"; :>> label = "Tampered therapy configuration scenario"; }
        doc /* An attacker with local access to the maintenance port alters lockout or dose parameters, aiming to bypass safety limits; may enable unsafe therapy delivery or bypass safeguards. */
        attribute :>> actorDescription = "unauthorized actor with local access to the maintenance port";
        attribute :>> defaultCategory = ThreatCategoryKind::tampering;
    }

    item unsafeDoseCyberHazard : CyberHazard {
        @MemoIdentity { :>> providedId = "CHZ-001"; :>> label = "Unsafe therapy configuration hazard"; }
        attribute :>> hazardType = HazardTypeKind::drugDeliveryError;
        attribute :>> foreseeable = true;
        attribute :>> securityImpact = "loss of configuration integrity";
        attribute :>> safetyImpact = "unsafe dose delivery";
        attribute :>> privacyImpact = "none";
        attribute :>> operationalImpact = "therapy interruption or unsafe continuation";
    }

    part configurationTamperingRisk : CyberRisk {
        @MemoIdentity { :>> providedId = "CRISK-001"; }
        attribute :>> driverKind = "cyber risk";
        attribute :>> probabilityEstimate = ProbabilityKind::occasional;
        attribute :>> severityEstimate = SeverityKind::catastrophic;
        attribute :>> riskLevel = CriticalityKind::high;
        attribute :>> acceptability = RiskAcceptabilityKind::unacceptable;
        attribute :>> exploitabilityEstimate = "moderate";
        attribute :>> detectability = DetectionKind::low;
        attribute :>> attackComplexity = "moderate with local access";
        attribute :>> patientSafetyContribution = "Potential overdose if therapy limits are changed.";
    }

    part strongServiceAuthentication : CyberMitigation {
        @MemoIdentity { :>> providedId = "CMIT-001"; :>> label = "Strong service authentication and audit"; }
        attribute :>> controlKind = RiskControlKind::protectiveMeasure;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
        attribute :>> verificationStatus = "planned";
        attribute :>> cyberControlKind = CyberControlKind::authentication;
        attribute :>> securityMechanism = "authenticate, authorize, audit";
        attribute :>> verificationExpectation = "verify only authenticated and integrity-protected configuration changes are accepted";
    }

    requirement reqAuthenticatedServiceAccess : SecurityRequirement {
        @MemoIdentity { :>> providedId = "SREQ-001"; :>> label = "Authenticated service access"; }
        doc /* The system shall require authenticated and authorized service access before any therapy configuration parameter can be modified. */
        attribute :>> sourceKind = RequirementSourceKind::risk;
        attribute :>> concernKind = ConcernKind::cybersecurity;
        attribute :>> status = ElementStatusKind::approved;
        attribute :>> acceptanceCriteria = "Unauthenticated or unauthorized attempts to modify therapy configuration are rejected and logged.";
        attribute :>> subjectDescription = "maintenance and configuration path";
        attribute :>> actorDescription = "service personnel";
        attribute :>> assumptionSummary = "cryptographic identity available";
        attribute :>> guaranteeSummary = "only authorized service access can change therapy configuration";
        attribute :>> securityObjective = "integrity";
        attribute :>> safetyClass = SafetyClassKind::C;
    }

    verification vcAuthenticatedServiceAccess : VerificationCase {
        @MemoIdentity { :>> providedId = "CVER-001"; :>> label = "Verify authenticated service access"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria = "Only authenticated and authorized service sessions may modify therapy configuration; all attempts are logged.";
        attribute :>> status = ElementStatusKind::approved;

        objective { verify reqAuthenticatedServiceAccess; }
    }

    // --8<-- [start:chain]
    connection : ThreatenedBy connect therapyConfigurationAsset to unauthorizedConfigChangeThreat;

    connection : ThreatenedBy connect patientEventLogAsset to eventLogTamperingThreat;

    connection : Exploits connect unauthorizedConfigChangeThreat to weakServiceAuthentication;

    connection : RealizedByScenario connect unauthorizedConfigChangeThreat to tamperedConfigurationScenario;
    // --8<-- [end:chain]

    connection : Mitigates connect strongServiceAuthentication to weakServiceAuthentication { attribute :>> mitigationKind = MitigationKind::vulnerability; }

    connection : DerivesCyberRequirement connect unauthorizedConfigChangeThreat to reqAuthenticatedServiceAccess;

    connection : DerivesCyberRequirement connect eventLogTamperingThreat to reqAuthenticatedServiceAccess;

    // A security risk feeds safety risk management at the hazard it can
    // cause (AAMI TIR57), not at another risk's estimate: tampered therapy
    // configuration is a route to over-infusion.
    connection : ImpactsSafety connect configurationTamperingRisk to overdoseHazard;

    connection : CrossesTrustBoundary connect maintenancePortBoundary to therapyConfigurationAsset;

    connection : ProducesEvidence connect vcAuthenticatedServiceAccess to evidenceLockout;
}
