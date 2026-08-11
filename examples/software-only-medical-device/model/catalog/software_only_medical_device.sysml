// Focused example: software-only medical device (SaMD, IMDRF N10/N12).
// There is deliberately no device-specific product record or physical layer.
// Deployment targets
// off-the-shelf infrastructure the manufacturer does not control.
package memo_examples_software_only_medical_device {
    private import ScalarValues::*;

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

    part swScreeningApp : SoftwareSystem {
        attribute :>> id = "SMD-SW-001"; attribute :>> name = "ScreeningApplication";
        attribute :>> safetyClass = SafetyClassKind::B;
        attribute :>> version = "1.4.0";
    }
    part algGrading : Algorithm {
        attribute :>> id = "SMD-ALG-001"; attribute :>> name = "RetinopathyGradingModel";
        attribute :>> algorithmKind = "convolutional neural network, locked (non-adaptive)";
        attribute :>> clinicalPerformanceClaim = "sensitivity >= 87%, specificity >= 90% vs. reference standard";
    }
    part soupInference : SoftwareModule {
        attribute :>> moduleKind = ModuleKind::soup;
        attribute :>> id = "SMD-SOUP-001"; attribute :>> name = "InferenceRuntimeLibrary";
        attribute :>> soupVendor = "third-party OSS";
        attribute :>> soupClassification = SOUPClassificationKind::classB;
    }
    part swGradingModule : SoftwareModule {
        attribute :>> id = "SMD-SW-002"; attribute :>> name = "GradingModule";
        attribute :>> responsibility = "Wraps the grading model behind the service API; owns input validation and result structuring.";
        attribute :>> safetyClass = SafetyClassKind::B;
    }
    connection : ModuleUses connect usingModule ::> swGradingModule to usedModule ::> soupInference;

    part svcGrading : CloudService {
        attribute :>> id = "SMD-RT-001"; attribute :>> name = "GradingService";
        attribute :>> serviceContract = "REST /grade: image in, structured finding out";
        attribute :>> discoveryMechanism = "DNS name behind the cluster ingress";
        attribute :>> updatePolicy = "blue/green rollout";
        attribute :>> rollbackPolicy = "previous validated version retained hot";
    }
    #refinement dependency svcGrading to swGradingModule;

    part duContainerImage : DeploymentUnit {
        attribute :>> id = "SMD-DU-001"; attribute :>> name = "ScreeningServiceImage";
        attribute :>> unitKind = "OCI container image";
        attribute :>> integrityProtection = "image signature + SBOM attestation";
    }
    part nodeCloud : ProcessingNode {
        attribute :>> id = "SMD-HW-001"; attribute :>> name = "CloudComputeNode";
        attribute :>> nodeKind = ProcessingNodeKind::cloudServer;
        attribute :>> supportsContainerization = true;
        attribute :>> realTimeCapable = false;
    }
    allocation duContainerImageDeployment : DeploysTo allocate duContainerImage to nodeCloud {
        attribute :>> deploymentKind = DeploymentKind::containerized;
    }
    connection : HostedBy connect hostAssembly ::> nodeCloud to processingNode ::> svcGrading;
}
