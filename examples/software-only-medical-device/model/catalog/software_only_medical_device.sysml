// Focused example: software-only medical device (SaMD, IMDRF N10/N12).
    private import memo_assurance_requirements_needs::*;
    private import memo_core_dimensions::*;
    private import memo_assurance_requirements::*;
// There is deliberately no device-specific product record or physical layer.
// Deployment targets
// off-the-shelf infrastructure the manufacturer does not control.
package memo_examples_software_only_medical_device {
    private import ScalarValues::*;
    private import ModelingMetadata::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_implementation_software_structure::*;
    private import memo_architecture_implementation_software_runtime::*;
    private import memo_architecture_realization_deployment::*;
    private import memo_architecture_realization_physical::*;
    // `serviceContract` was an optional attribute on SoftwareComponent, set
    // only when runtimeKind = service. It moved to `CloudService` in the cloud
    // extension, so the project that uses it includes the extension — which is
    // the mechanism working as designed rather than a cost of the move.
    private import memo_extension_cloud::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part def SoftwareOnlyMedicalDeviceSystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The software-only medical device: the system this example models, with the software and hardware that realize it.";
    }
    part swScreeningApp : SoftwareSystem {
        @MemoIdentity { :>> providedId = "SMD-SW-001"; :>> label = "ScreeningApplication"; }
        attribute :>> safetyClass = SafetyClassKind::B;
        attribute :>> version = "1.4.0";
    }
    part algGrading : Algorithm {
        @MemoIdentity { :>> providedId = "SMD-ALG-001"; :>> label = "RetinopathyGradingModel"; }
        attribute :>> algorithmKind = "convolutional neural network, locked (non-adaptive)";
        attribute :>> clinicalPerformanceClaim = "sensitivity >= 87%, specificity >= 90% vs. reference standard";
    }
    part soupInference : OTSSoftwareModule {
        @MemoIdentity { :>> providedId = "SMD-SOUP-001"; :>> label = "InferenceRuntimeLibrary"; }
        attribute :>> supplier = "third-party OSS";
        attribute :>> soupClassification = SOUPClassificationKind::classB;
        attribute :>> safetyClass = SafetyClassKind::B;
        attribute :>> version = "1.14.0";
        attribute :>> knownAnomalies = "Illustrative: the supplier's published anomaly list was reviewed; none leads to a hazardous situation in this use.";
    }
    part swGradingModule : SoftwareModule {
        @MemoIdentity { :>> providedId = "SMD-SW-002"; :>> label = "GradingModule"; }
        attribute :>> responsibility = "Wraps the grading model behind the service API; owns input validation and result structuring.";
        attribute :>> safetyClass = SafetyClassKind::B;
    }
    dependency swGradingModule to soupInference;

    part svcGrading : CloudService {
        @MemoIdentity { :>> providedId = "SMD-RT-001"; :>> label = "GradingService"; }
        attribute :>> serviceContract = "REST /grade: image in, structured finding out";
        attribute :>> discoveryMechanism = "DNS name behind the cluster ingress";
        attribute :>> updatePolicy = "blue/green rollout";
        attribute :>> rollbackPolicy = "previous validated version retained hot";
    }
    #refinement dependency svcGrading to swGradingModule;

    part duContainerImage : SoftwareDeploymentUnit {
        @MemoIdentity { :>> providedId = "SMD-DU-001"; :>> label = "ScreeningServiceImage"; }
        attribute :>> unitKind = "OCI container image";
        attribute :>> integrityProtection = "image signature + SBOM attestation";
    }
    part nodeCloud : ProcessingNode {
        @MemoIdentity { :>> providedId = "SMD-HW-001"; :>> label = "CloudComputeNode"; }
        attribute :>> nodeKind = ProcessingNodeKind::cloudServer;
        attribute :>> supportsContainerization = true;
        attribute :>> realTimeCapable = false;
    }
    allocation duContainerImageDeployment : DeploysTo allocate duContainerImage to nodeCloud {
        attribute :>> deploymentKind = DeploymentKind::containerized;
    }
    allocation : HostedBy allocate svcGrading to nodeCloud;
    // Illustrative: authored for this example.
    requirement reqAuthoredSwGradingModule : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "SOMD-REQ-A01"; :>> label = "GradingModule requirement"; }
        attribute :>> statement = "The software item GradingModule shall perform the function allocated to it in the software architecture.";
        attribute :>> status = ElementStatusKind::draft;
    }
    satisfy reqAuthoredSwGradingModule by swGradingModule;
    // Illustrative: authored for this example.
    requirement reqAuthoredSoupInference : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "SOMD-REQ-A02"; :>> label = "InferenceRuntimeLibrary requirement"; }
        attribute :>> statement = "The software item InferenceRuntimeLibrary shall perform the function allocated to it in the software architecture.";
        attribute :>> status = ElementStatusKind::draft;
    }
    satisfy reqAuthoredSoupInference by soupInference;
    // Illustrative: authored for this example.
    requirement needAuthoredSafeOperation : Need {
        attribute :>> needKind = NeedKind::'stakeholder';
        @MemoIdentity { :>> providedId = "SOMD-NEED-A01"; :>> label = "SafeOperation"; }
        attribute :>> statement = "The device shall operate safely and as intended.";
        attribute :>> priority = "high";
    }
    connection : DerivesFrom connect sourceDriver ::> needAuthoredSafeOperation to targetRequirement ::> reqAuthoredSwGradingModule;
    connection : DerivesFrom connect sourceDriver ::> needAuthoredSafeOperation to targetRequirement ::> reqAuthoredSoupInference;
}
