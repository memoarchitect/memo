package memo {
    package viewpoints {
        package definitions {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;
            private import memo::core::relationships::*;

            part def Viewpoint specializes DocumentedElement {
                attribute purpose : String;
                attribute audience : AudienceKind[*];
                attribute stage : WorkflowStageKind;
                attribute abstractionLevel : String;
                attribute outputKind : ViewOutputKind[*];
                attribute presentationKind : PresentationKind[*];
                attribute concern : ConcernKind[*];
                attribute includedLayers : String[*];
                attribute allowedElementKinds : String[*];
                attribute allowedRelationshipKinds : String[*];
                attribute filterExpression : String;
                attribute methodologyReference : String[*];
                attribute extendsViewpointIds : String[*];
                attribute userExtensible : Boolean;
            }

            part def ViewRule specializes TraceableElement {
                attribute elementTypeName : String;
                attribute relationTypeName : String;
                attribute strength : RuleStrengthKind;
                attribute rationaleText : String;
            }

            part def ViewSelectionQuery specializes TraceableElement {
                attribute includeElementKinds : String[*];
                attribute includeRelationshipKinds : String[*];
                attribute includeLayers : String[*];
                attribute includeConcerns : ConcernKind[*];
                attribute includeStatusTags : String[*];
                attribute selectionExpression : String;
                attribute rationaleText : String;
            }

            part def View specializes DocumentedElement {
                attribute outputKind : ViewOutputKind[*];
                attribute presentationKind : PresentationKind[*];
                attribute filterExpression : String;
                attribute queryDescription : String;
                attribute dataSourceDescription : String;
                attribute autoPopulate : Boolean;
                part viewpoint : Viewpoint;
                ref subject : TraceableElement[*];
                ref exposesElement : TraceableElement[*];
                ref exposesRelationship : SemanticLink[*];
                part selectionQuery : ViewSelectionQuery[*];
            }

            part def DiagramView specializes View {
                attribute viewKind : DiagramViewKind;
                attribute diagramType : String;
                attribute layoutHint : String;
                attribute styleHint : String;
            }

            part def DocumentBackedView specializes View {
                attribute version : String;
                attribute lifecycleState : LifecycleStateKind;
                attribute generationRule : String;
                attribute marketScope : String;
            }

            part def DocumentView specializes DocumentBackedView {
                attribute viewKind : DocumentViewKind;
            }

            part def ViewInclusionRule specializes TraceableElement {
                attribute includeElementKinds : String[*];
                attribute includeRelationshipKinds : String[*];
                attribute includeLayers : String[*];
                attribute includeConcerns : ConcernKind[*];
                attribute selectionExpression : String;
                attribute rationaleText : String;
            }
        }
    }
}
