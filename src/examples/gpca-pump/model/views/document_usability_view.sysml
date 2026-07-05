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

                part usabilityView : UsabilityEngineeringView {
                    attribute id = "DOC-008";
                    attribute name = "UsabilityEngineeringFileView";
                    attribute title = "GPCA Usability Engineering File View";
                    attribute shortDescription = "IEC 62366-1 usability engineering file content for GPCA.";
                    attribute longDescription = "Aggregates intended use, use contexts, actors, foreseeable use errors, related risk chains, usability requirements, and the summative usability validation case.";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute marketScope = "generic";
                    attribute documentUsage = {"Usability Engineering File", "DHF"};
                    attribute sectionIdentifier = "UEF";
                    part selectionQuery {
                        attribute id = "QRY-DOC-002";
                        attribute name = "usabilityViewQuery";
                        attribute includeElementKinds = {"UseError", "UseContext", "Actor", "ValidationCase", "OperationalScenario", "IntendedUse"};
                        attribute includeRelationshipKinds = {"TestedByUsability", "RealizedByScenario", "InteractsWith", "IncludedIn"};
                        attribute rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
                    }
                }
            }
        }
    }
}
