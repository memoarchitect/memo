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

                part gpcaCybersecurityView : DiagramView {
                    attribute id = "VIEW-CYB-001";
                    attribute name = "GPCA_CybersecurityView";
                    attribute title = "GPCA Cybersecurity View";
                    attribute shortDescription = "Shows GPCA assets, trust boundaries, threats, vulnerabilities, and mitigations.";
                    attribute longDescription = "Product-specific cybersecurity view intended for secure product development and cross-reference into cybersecurity risk documentation.";
                    attribute outputKind = {ViewOutputKind::diagram};
                    attribute presentationKind = {PresentationKind::custom};
                    attribute viewKind = DiagramViewKind::general;
                    attribute diagramType = "threat-model";
                    attribute dataSourceDescription = "GPCA cyber assets, threat scenarios, and trace links";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include cyber assets, trust boundaries, threats, vulnerabilities, cyber hazards, cyber risks, mitigations, security requirements, and verification.";
                    attribute documentUsage = {"Threat Model", "Cybersecurity Risk Assessment", "QMSR"};
                    part selectionQuery {
                        attribute id = "QRY-CYB-001";
                        attribute name = "GPCA_CybersecurityQuery";
                        attribute includeElementKinds = {"CybersecurityAsset", "Threat", "Vulnerability", "CyberHazard", "CyberRisk", "CyberMitigation", "SecurityRequirement", "TrustBoundary", "ThreatScenario"};
                        attribute includeLayers = {"cybersecurity", "risk", "assurance"};
                        attribute includeConcerns = {ConcernKind::cybersecurity, ConcernKind::privacy, ConcernKind::safety};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Auto-populate the GPCA cybersecurity view from the cyber layer and cross-layer trace model.";
                    }
                    part viewpoint :> cybersecurityViewpoint;
                }
            }
        }
    }
}
