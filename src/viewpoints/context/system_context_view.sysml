package memo {
    package viewpoints {
        package context {
                package system_context_view {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;
                private import memo::viewpoints::context::*;

            part systemContextView : DiagramView {
                attribute id = "VIEW-CTX-001";
                attribute name = "SystemContextView";
                attribute title = "System Context View";
                attribute shortDescription = "Actors, use context, and system boundary.";
                attribute outputKind = {ViewOutputKind::diagram};
                attribute presentationKind = {PresentationKind::blockDiagram};
                attribute diagramType = "bdd";
                attribute autoPopulate = true;
                attribute queryDescription = "Include actors, use contexts, and trust boundaries at the system boundary.";
                part selectionQuery {
                    attribute id = "QRY-CTX-001";
                    attribute name = "SystemContextQuery";
                    attribute includeElementKinds = {"Actor", "UseContext", "TrustBoundary"};
                    attribute includeLayers = {"context"};
                    attribute rationaleText = "Auto-populate the system context view from the context layer.";
                }
                part viewpoint :> contextViewpoint;
            }
            }
        }
    }
}
