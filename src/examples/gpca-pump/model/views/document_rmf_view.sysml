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

                part rmfView : DocumentView {
                    attribute id = "DOC-001";
                    attribute name = "RiskManagementFileView";
                    attribute title = "GPCA Risk Management File View";
                    attribute shortDescription = "Document-backed risk view for GPCA.";
                    attribute longDescription = "Aggregates the risk chain, controls, verification, residual risk, and cybersecurity links needed for the GPCA risk management file.";
                    attribute version = "0.2";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute viewKind = DocumentViewKind::RMF;
                    attribute generationRule = "Include risk chain, controls, verification, residual risk, and cybersecurity traceability";
                    attribute marketScope = "generic";
                    attribute documentUsage = {"RMF", "QMSR"};
                    attribute sectionIdentifier = "RMF";
                    part selectionQuery {
                        attribute id = "QRY-DOC-001";
                        attribute name = "rmfViewQuery";
                        attribute includeElementKinds = {"Hazard", "HazardCause", "HazardousSituation", "Harm", "SequenceOfEvents", "Risk", "RiskBeforeMitigation", "RiskAfterMitigation", "RiskControl", "OverallResidualRiskEvaluation", "VerificationCase", "Evidence"};
                        attribute includeRelationshipKinds = {"ContributesToHazard", "LeadsToHazard", "CausedBy", "MitigatesHazard", "MitigatedByControl", "TracesRisk", "AssessedAgainst", "VerifiedBy", "ProducesEvidence", "IncludedIn"};
                        attribute rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
                    }
                }
            }
        }
    }
}
