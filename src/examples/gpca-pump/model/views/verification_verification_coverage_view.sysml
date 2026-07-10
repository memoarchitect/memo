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

                part gpcaVerificationCoverageView : DiagramView {
                    attribute id = "VIEW-VER-101";
                    attribute name = "GPCA_VerificationCoverageView";
                    attribute title = "GPCA Verification and Validation Coverage View";
                    attribute shortDescription = "Requirements and risk controls against verification cases, validation cases, and evidence.";
                    attribute outputKind = {ViewOutputKind::matrix};
                    attribute presentationKind = {PresentationKind::traceMatrix};
                    attribute viewKind = DiagramViewKind::grid;
                    attribute diagramType = "req";
                    attribute dataSourceDescription = "VerifiedBy, Validates, and ProducesEvidence links in the GPCA model";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include every requirement and risk control with its verification/validation status and produced evidence.";
                    attribute documentUsage = {"VV", "DHF", "QMSR"};
                    part selectionQuery {
                        attribute id = "QRY-VER-101";
                        attribute name = "GPCA_VerificationCoverageQuery";
                        attribute includeElementKinds = {"Requirement", "RiskControl", "VerificationCase", "ValidationCase", "TestArtifact", "Evidence"};
                        attribute includeRelationshipKinds = {"VerifiedBy", "Validates", "ProducesEvidence"};
                        attribute includeLayers = {"requirements", "risk", "assurance"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Coverage gaps surface as requirements or controls without linked cases or evidence.";
                    }
                    part viewpoint :> verificationViewpoint;
                }
            }
        }
    }
}
