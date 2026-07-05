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

                part gpcaThreatModelView : CybersecurityThreatModelView {
                    attribute id = "DOC-CYB-001";
                    attribute name = "GPCA_ThreatModelView";
                    attribute title = "GPCA Threat Model View";
                    attribute shortDescription = "Document-backed view for GPCA threat modeling.";
                    attribute longDescription = "Collects assets, trust boundaries, threats, scenarios, vulnerabilities, and mitigations for the GPCA threat model.";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute marketScope = "generic";
                    attribute dataSourceDescription = "GPCA cybersecurity layer and cross-layer trace links";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include all GPCA cyber assets, trust boundaries, threat scenarios, linked vulnerabilities, and mapped mitigations.";
                    attribute documentUsage = {"Threat Model", "QMSR"};
                    attribute sectionIdentifier = "CYB-TM";
                    part selectionQuery {
                        attribute id = "QRY-CYB-002";
                        attribute name = "GPCA_ThreatModelQuery";
                        attribute includeElementKinds = {"CybersecurityAsset", "Threat", "Vulnerability", "ThreatScenario", "CyberMitigation", "TrustBoundary"};
                        attribute includeLayers = {"cybersecurity"};
                        attribute includeConcerns = {ConcernKind::cybersecurity, ConcernKind::privacy};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Populate the GPCA threat model section from cyber assets, boundaries, and threat scenarios.";
                    }
                    part viewpoint :> cybersecurityViewpoint;
                }
            }
        }
    }
}
