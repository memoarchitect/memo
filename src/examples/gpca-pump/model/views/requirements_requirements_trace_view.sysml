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

                part gpcaRequirementsTraceView : DiagramView {
                    attribute id = "VIEW-REQ-101";
                    attribute name = "GPCA_RequirementsTraceabilityView";
                    attribute title = "GPCA Requirements Traceability View";
                    attribute shortDescription = "Needs to system/software/hardware requirements to satisfying components and verification.";
                    attribute outputKind = {ViewOutputKind::matrix};
                    attribute presentationKind = {PresentationKind::traceMatrix};
                    attribute viewKind = DiagramViewKind::grid;
                    attribute diagramType = "req";
                    attribute dataSourceDescription = "GPCA requirements with DerivesFrom, SatisfiedBy, and VerifiedBy links";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include all needs and requirements with derivation, satisfaction, and verification links.";
                    attribute documentUsage = {"Requirements Traceability Matrix", "DHF", "QMSR"};
                    part selectionQuery {
                        attribute id = "QRY-REQ-101";
                        attribute name = "GPCA_RequirementsTraceQuery";
                        attribute includeElementKinds = {"StakeholderNeed", "SystemRequirement", "SoftwareRequirement", "HardwareRequirement", "VerificationCase"};
                        attribute includeRelationshipKinds = {"DerivesFrom", "SatisfiedBy", "VerifiedBy"};
                        attribute includeLayers = {"requirements", "assurance"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Full derivation-to-verification traceability for design reviews.";
                    }
                    part viewpoint :> requirementsViewpoint;
                }
            }
        }
    }
}
