// Focused example: software-only medical device (SaMD, IMDRF N10/N12).
// technologyDomains = {software}; there is deliberately NO hardware or
// physical layer — irrelevant layers are never mandatory. Deployment targets
// off-the-shelf infrastructure the manufacturer does not control.
package memo_examples_software_only_medical_device {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_medical_products_definitions::*;
    private import memo_architecture_software_structure::*;
    private import memo_architecture_software_runtime::*;
    private import memo_architecture_deployment::*;
    private import memo_architecture_physical::*;

    part samdDef : MedicalDeviceDefinition {
        attribute :>> id = "SMD-DEF-001"; attribute :>> name = "RetinaScreen_AI";
        attribute :>> intendedPurpose = "Screening for referable diabetic retinopathy from fundus images.";
        attribute :>> technologyDomains = TechnologyDomainKind::software;
        attribute :>> riskClassification = "IMDRF SaMD category III; FDA Class II (example)";
    }

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
    part soupInference : SOUPComponent {
        attribute :>> id = "SMD-SOUP-001"; attribute :>> name = "InferenceRuntimeLibrary";
        attribute :>> soupVendor = "third-party OSS";
        attribute :>> classification = SOUPClassificationKind::classB;
    }
    part swGradingModule : SoftwareModule {
        attribute :>> id = "SMD-SW-002"; attribute :>> name = "GradingModule";
        attribute :>> responsibility = "Wraps the grading model behind the service API; owns input validation and result structuring.";
        attribute :>> safetyClass = SafetyClassKind::B;
    }
    connection : ModuleUses connect usingModule ::> swGradingModule to usedModule ::> soupInference;

    part svcGrading : Service {
        attribute :>> id = "SMD-RT-001"; attribute :>> name = "GradingService";
        attribute :>> serviceContract = "REST /grade: image in, structured finding out";
        attribute :>> updatePolicy = "blue/green rollout";
        attribute :>> rollbackPolicy = "previous validated version retained hot";
    }
    connection : Realizes connect realizing ::> svcGrading to realized ::> swGradingModule;

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
    connection : DeploysTo connect deploymentUnit ::> duContainerImage to node ::> nodeCloud {
        attribute :>> deploymentKind = DeploymentKind::containerized;
    }
    connection : HostedBy connect hostAssembly ::> nodeCloud to processingNode ::> svcGrading;
    connection : Realizes connect realized ::> samdDevice to realizing ::> swScreeningApp;
    part samdDevice : MedicalDevice {
        attribute :>> id = "SMD-DEV-001"; attribute :>> name = "RetinaScreenDevice";
        ref :>> definition = samdDef;
    }
}
