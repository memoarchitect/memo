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

                part cyberAssessmentView : CybersecurityAssessmentView {
                    attribute id = "DOC-003";
                    attribute name = "GPCACybersecurityAssessmentView";
                    attribute title = "GPCA Cybersecurity Assessment View";
                    attribute shortDescription = "Cybersecurity risk-assessment-oriented document view for GPCA.";
                    attribute longDescription = "Captures GPCA cyber risks, mitigations, security requirements, verification, and safety/privacy traceability for cybersecurity assessment records.";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute marketScope = "generic";
                    attribute documentUsage = {"Cybersecurity Risk Assessment", "RMF", "QMSR"};
                    attribute sectionIdentifier = "CYB-RA";
                    part selectionQuery {
                        attribute id = "QRY-DOC-009";
                        attribute name = "cyberAssessmentViewQuery";
                        attribute includeElementKinds = {"CyberRisk", "CyberHazard", "CybersecurityAsset", "CyberMitigation", "SecurityRequirement", "SecurityClaim", "SBOMEntry", "SOUPComponent"};
                        attribute includeRelationshipKinds = {"ImpactsSafety", "MitigatesVulnerability", "DerivesCyberRequirement", "AssessedAgainst", "DependsOnSoup"};
                        attribute rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
                    }
                }
            }
        }
    }
}
