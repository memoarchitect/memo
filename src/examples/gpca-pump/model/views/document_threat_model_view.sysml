package memo {
    package examples {
        package gpca {
            package document_views {
                private import memo::viewpoints::definitions::*;
                private import memo::viewpoints::cybersecurity::*;
                private import memo::viewpoints::cybersecurity::threat_model_view::*;
                private import memo::viewpoints::cybersecurity::cybersecurity_assessment_view::*;
                private import memo::viewpoints::usability::usability_engineering_view::*;
                private import memo::core::enumerations::*;

                part threatModelView : CybersecurityThreatModelView {
                    attribute id = "DOC-002";
                    attribute name = "GPCACyberThreatModelView";
                    attribute title = "GPCA Cybersecurity Threat Model View";
                    attribute shortDescription = "Threat-model-oriented document view for GPCA.";
                    attribute longDescription = "Captures GPCA cyber assets, trust boundaries, threats, threat scenarios, vulnerabilities, and mitigations for secure product development records.";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute marketScope = "generic";
                    attribute documentUsage = {"Threat Model", "QMSR"};
                    attribute sectionIdentifier = "CYB-TM";
                    part selectionQuery {
                        attribute id = "QRY-DOC-008";
                        attribute name = "threatModelViewQuery";
                        attribute includeElementKinds = {"Threat", "ThreatScenario", "Vulnerability", "CybersecurityAsset", "TrustBoundary", "AttackSurface", "CyberMitigation", "SecurityRequirement"};
                        attribute includeRelationshipKinds = {"ThreatenedBy", "Exploits", "RealizedByScenario", "CrossesTrustBoundary", "MitigatesVulnerability", "DerivesCyberRequirement"};
                        attribute rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
                    }
                }
            }
        }
    }
}
