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

                part sddView : DocumentView {
                    attribute id = "DOC-004";
                    attribute name = "SoftwareDesignDescriptionView";
                    attribute title = "GPCA Software Design Description View";
                    attribute shortDescription = "IEC 62304 software design description for the GPCA software system.";
                    attribute longDescription = "Aggregates the software system, its six components with safety classes and scheduling attributes, mode machine and transitions, interfaces, and function allocations for the SDD.";
                    attribute version = "0.1";
                    attribute lifecycleState = LifecycleStateKind::development;
                    attribute viewKind = DocumentViewKind::SDD;
                    attribute generationRule = "Include software structure, behavior machine with transitions, software interfaces, allocations, and timing constraints";
                    attribute marketScope = "generic";
                    attribute documentUsage = {"SDD", "QMSR"};
                    attribute sectionIdentifier = "SDD";
                    part selectionQuery {
                        attribute id = "QRY-DOC-004";
                        attribute name = "sddViewQuery";
                        attribute includeElementKinds = {"SoftwareSystem", "SoftwareComponent", "ModeState", "Transition", "SoftwareInterface", "LogicalFunction", "TimingConstraint", "SOUPComponent"};
                        attribute includeRelationshipKinds = {"Composes", "AllocatedTo", "BindsToInterface", "RealizesInterface", "DependsOnSoup", "Changes"};
                        attribute rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
                    }
                }
            }
        }
    }
}
