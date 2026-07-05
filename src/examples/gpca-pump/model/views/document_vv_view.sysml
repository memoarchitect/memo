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

                part vvView : DocumentView {
                    attribute id = "DOC-006";
                    attribute name = "VerificationValidationView";
                    attribute title = "GPCA Verification and Validation View";
                    attribute shortDescription = "V&V plan and coverage for requirements and risk controls.";
                    attribute longDescription = "Aggregates verification cases, validation cases, test artifacts, and evidence with their coverage of requirements, risk controls, behavior properties, and timing constraints.";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute viewKind = DocumentViewKind::VV;
                    attribute generationRule = "Include all VerifiedBy, Validates, and ProducesEvidence chains with status";
                    attribute marketScope = "generic";
                    attribute documentUsage = {"VV", "DHF", "QMSR"};
                    attribute sectionIdentifier = "VV";
                    part selectionQuery {
                        attribute id = "QRY-DOC-006";
                        attribute name = "vvViewQuery";
                        attribute includeElementKinds = {"VerificationCase", "ValidationCase", "TestArtifact", "Evidence", "SystemRequirement", "SoftwareRequirement", "HardwareRequirement", "RiskControl"};
                        attribute includeRelationshipKinds = {"VerifiedBy", "Validates", "TestedByUsability", "ProducesEvidence", "IncludedIn"};
                        attribute rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
                    }
                }
            }
        }
    }
}
