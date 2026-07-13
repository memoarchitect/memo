package memo {
    package viewpoints {
        package verification {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;

            part verificationViewpoint : Viewpoint {
                attribute id = "VP-VER";
                attribute name = "VerificationViewpoint";
                attribute title = "Verification & Validation Viewpoint";
                attribute shortDescription = "Shows verification cases, validation cases, and the evidence they produce, traced to requirements.";
                attribute longDescription = "Default viewpoint derived from the requirements and assurance layers for V&V coverage — which requirements are verified/validated, by which case, and what evidence was produced, supporting ISO 13485 §7.3.6/§7.3.7 and IEC 62304 §5.7/§5.8.";
                attribute purpose = "Communicate verification and validation coverage against requirements.";
                attribute audience = {AudienceKind::verificationEngineer};
                attribute stage = WorkflowStageKind::verification;
                attribute abstractionLevel = "verification";
                attribute outputKind = {ViewOutputKind::matrix};
                attribute presentationKind = {PresentationKind::traceMatrix};
                attribute concern = {ConcernKind::safety, ConcernKind::regulatory};
                attribute includedLayers = {"requirements", "assurance"};
                attribute allowedElementKinds = {"Requirement", "VerificationCase", "ValidationCase", "Evidence", "TestArtifact"};
                attribute methodologyReference = {"default-layer-viewpoint"};
                attribute userExtensible = true;
            }
        }
    }
}
