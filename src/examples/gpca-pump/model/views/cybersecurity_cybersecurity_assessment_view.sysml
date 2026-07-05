package memo {
    package examples {
        package gpca {
            package views {
                private import memo::viewpoints::definitions::*;
                private import memo::viewpoints::context::*;
                private import memo::viewpoints::operational::*;
                private import memo::viewpoints::functional::*;
                private import memo::viewpoints::logical::*;
                private import memo::viewpoints::software::*;
                private import memo::viewpoints::physical::*;
                private import memo::viewpoints::requirements::*;
                private import memo::viewpoints::risk::*;
                private import memo::viewpoints::verification::*;
                private import memo::viewpoints::cybersecurity::*;
                private import memo::viewpoints::cybersecurity::threat_model_view::*;
                private import memo::viewpoints::cybersecurity::cybersecurity_assessment_view::*;
                private import memo::core::enumerations::*;

                part gpcaCybersecurityAssessmentView : CybersecurityAssessmentView {
                    attribute id = "DOC-CYB-002";
                    attribute name = "GPCA_CybersecurityAssessmentView";
                    attribute title = "GPCA Cybersecurity Assessment View";
                    attribute shortDescription = "Document-backed view for GPCA cybersecurity risk assessment.";
                    attribute longDescription = "Collects cyber risks, safety/privacy impacts, mitigations, security requirements, verification, and residual assessment for GPCA.";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute marketScope = "generic";
                    attribute dataSourceDescription = "GPCA cybersecurity and safety risk model elements with assurance evidence";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include GPCA cyber risks, safety links, mitigations, derived security requirements, and verification evidence.";
                    attribute documentUsage = {"Cybersecurity Risk Assessment", "RMF", "QMSR"};
                    attribute sectionIdentifier = "CYB-RA";
                    part selectionQuery {
                        attribute id = "QRY-CYB-003";
                        attribute name = "GPCA_CyberAssessmentQuery";
                        attribute includeElementKinds = {"CyberRisk", "CyberHazard", "CyberMitigation", "SecurityRequirement", "VerificationCase", "Evidence"};
                        attribute includeLayers = {"cybersecurity", "risk", "assurance"};
                        attribute includeConcerns = {ConcernKind::cybersecurity, ConcernKind::safety};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Populate the GPCA cybersecurity assessment from risks, mitigations, derived requirements, and evidence.";
                    }
                    part viewpoint :> cybersecurityViewpoint;
                }
            }
        }
    }
}
