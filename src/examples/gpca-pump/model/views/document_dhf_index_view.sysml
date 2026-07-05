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

                part dhfIndexView : DocumentView {
                    attribute id = "DOC-007";
                    attribute name = "DesignHistoryFileIndexView";
                    attribute title = "GPCA Design History File Index View";
                    attribute shortDescription = "Index of design inputs, outputs, reviews, and V&V records for the DHF.";
                    attribute longDescription = "Collects the document-backed views (requirements, architecture, SDD, RMF, VV, usability, cybersecurity) into the design history file index required by 21 CFR 820.30(j).";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute viewKind = DocumentViewKind::DHF;
                    attribute generationRule = "Index every document-backed view with version and lifecycle state";
                    attribute marketScope = "generic";
                    attribute documentUsage = {"DHF"};
                    attribute sectionIdentifier = "DHF";
                    part selectionQuery {
                        attribute id = "QRY-DOC-007";
                        attribute name = "dhfIndexViewQuery";
                        attribute includeElementKinds = {"DocumentView", "DiagramView", "UsabilityEngineeringView", "CybersecurityThreatModelView", "CybersecurityAssessmentView", "Evidence", "Citation"};
                        attribute includeRelationshipKinds = {"IncludedIn", "ProducesEvidence"};
                        attribute rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
                    }
                }
            }
        }
    }
}
