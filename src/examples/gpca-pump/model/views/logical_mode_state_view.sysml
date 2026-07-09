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

                part gpcaModeStateView : DiagramView {
                    attribute id = "VIEW-BHV-001";
                    attribute name = "GPCA_ModeStateView";
                    attribute title = "GPCA Top-Level Mode State View";
                    attribute shortDescription = "The CriSys Fig 4.1 mode hierarchy (OFF, ON, IDLE, THERAPY, PAUSED, ACTIVE, BASAL, SQUARE_BOLUS, PATIENT_BOLUS) and all guarded transitions.";
                    attribute longDescription = "Hierarchical state diagram per CriSys §4.1 Fig 4.1: OFF and ON at top level, IDLE and THERAPY under ON, PAUSED (KVO delivery) and ACTIVE under THERAPY, and BASAL / SQUARE_BOLUS (auto-scheduled) / PATIENT_BOLUS under ACTIVE — with the REQ 4-47 transitions, Inhibited_* macro guards, and same-step-critical markings.";
                    attribute outputKind = {ViewOutputKind::diagram};
                    attribute presentationKind = {PresentationKind::stateDiagram};
                    attribute viewKind = DiagramViewKind::statetransition;
                    attribute diagramType = "stm";
                    attribute dataSourceDescription = "GPCA behavior machine, mode states, and transitions";
                    attribute autoPopulate = true;
                    attribute queryDescription = "Include the mode machine, the Fig 4.1 mode tree (Composes edges), transitions, and safety properties.";
                    attribute documentUsage = {"SDD", "RMF"};
                    part selectionQuery {
                        attribute id = "QRY-BHV-101";
                        attribute name = "GPCA_ModeStateQuery";
                        attribute includeElementKinds = {"BehaviorMachine", "ModeState", "Transition", "BehaviorProperty", "TimingConstraint"};
                        attribute includeLayers = {"behavior"};
                        attribute selectionExpression = "product == 'GPCA'";
                        attribute rationaleText = "Auto-populate the mode state view from the behavior layer.";
                    }
                    part viewpoint :> logicalArchitectureViewpoint;
                }
            }
        }
    }
}
