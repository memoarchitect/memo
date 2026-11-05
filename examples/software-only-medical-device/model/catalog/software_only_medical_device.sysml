// Focused example: software-only medical device (SaMD, IMDRF N10/N12).
// There is deliberately no device-specific product record or physical layer.
// Deployment targets
// off-the-shelf infrastructure the manufacturer does not control.
package memo_examples_software_only_medical_device {
    private import memo::*;
    private import ScalarValues::*;
    private import ModelingMetadata::*;

    // `serviceContract` was an optional attribute on SoftwareComponent, set
    // only when runtimeKind = service. It moved to `CloudService` in the cloud
    // extension, so the project that uses it includes the extension — which is
    // the mechanism working as designed rather than a cost of the move.
    private import memo_extension_cloud::*;

    part def SoftwareOnlyMedicalDeviceSystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The software-only medical device: the system this example models, with the software and hardware that realize it.";
    }
    part swScreeningApp : SoftwareSystem {
        @MemoIdentity { :>> providedId = "SMD-SW-001"; :>> label = "Screening application"; }
        attribute :>> safetyClass = SafetyClassKind::B;
    }
    part algGrading : Algorithm {
        @MemoIdentity { :>> providedId = "SMD-ALG-001"; :>> label = "Retinopathy grading model"; }
        attribute :>> algorithmKind = "convolutional neural network, locked (non-adaptive)";
        attribute :>> clinicalPerformanceClaim = "sensitivity >= 87%, specificity >= 90% vs. reference standard";
    }
    part soupInference : OTSSoftwareModule {
        @MemoIdentity { :>> providedId = "SMD-SOUP-001"; :>> label = "Inference runtime library"; }
        attribute :>> supplier = "third-party OSS";
        attribute :>> soupClassification = SOUPClassificationKind::classB;
        attribute :>> safetyClass = SafetyClassKind::B;
        attribute :>> version = "1.14.0";
        attribute :>> knownAnomalies = "Illustrative: the supplier's published anomaly list was reviewed; none leads to a hazardous situation in this use.";
    }
    part swGradingModule : SoftwareModule {
        @MemoIdentity { :>> providedId = "SMD-SW-002"; :>> label = "Grading module"; }
        attribute :>> responsibility = "Wraps the grading model behind the service API; owns input validation and result structuring.";
        attribute :>> safetyClass = SafetyClassKind::B;
    }
    dependency swGradingModule to soupInference;

    part svcGrading : CloudService {
        @MemoIdentity { :>> providedId = "SMD-RT-001"; :>> label = "Grading service"; }
        attribute :>> serviceContract = "REST /grade: image in, structured finding out";
        attribute :>> discoveryMechanism = "DNS name behind the cluster ingress";
        attribute :>> updatePolicy = "blue/green rollout";
        attribute :>> rollbackPolicy = "previous validated version retained hot";
    }
    #refinement dependency svcGrading to swGradingModule;

    part duContainerImage : SoftwareDeploymentUnit {
        @MemoIdentity { :>> providedId = "SMD-DU-001"; :>> label = "Screening service image"; }
        attribute :>> unitKind = "OCI container image";
        attribute :>> integrityProtection = "image signature + SBOM attestation";
    }
    part nodeCloud : ProcessingNode {
        @MemoIdentity { :>> providedId = "SMD-HW-001"; :>> label = "Cloud compute node"; }
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
        @MemoIdentity { :>> providedId = "SOMD-REQ-A01"; :>> label = "Grading module requirement"; }
        doc /* The software item GradingModule shall perform the function allocated to it in the software architecture. */
        attribute :>> status = ElementStatusKind::draft;
    }
    satisfy reqAuthoredSwGradingModule by swGradingModule;
    // Illustrative: authored for this example.
    requirement reqAuthoredSoupInference : Requirement {
        attribute :>> requirementType = RequirementTypeKind::system;
        @MemoIdentity { :>> providedId = "SOMD-REQ-A02"; :>> label = "Inference runtime library requirement"; }
        doc /* The software item InferenceRuntimeLibrary shall perform the function allocated to it in the software architecture. */
        attribute :>> status = ElementStatusKind::draft;
    }
    satisfy reqAuthoredSoupInference by soupInference;
    // Illustrative: authored for this example.
    requirement needAuthoredSafeOperation : Need {
        attribute :>> needKind = NeedKind::'stakeholder';
        @MemoIdentity { :>> providedId = "SOMD-NEED-A01"; :>> label = "Safe operation"; }
        doc /* The device shall operate safely and as intended. */
        attribute :>> priority = "high";
    }
    connection : DerivesFrom connect needAuthoredSafeOperation to reqAuthoredSwGradingModule;
    connection : DerivesFrom connect needAuthoredSafeOperation to reqAuthoredSoupInference;
}
