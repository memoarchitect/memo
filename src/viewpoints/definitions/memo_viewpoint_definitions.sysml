package memo_viewpoints_definitions {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;

    part def Viewpoint specializes DocumentedElement {
        attribute purpose : String;
        attribute audience : AudienceKind[*];
        attribute stage : WorkflowStageKind;
        attribute abstractionLevel : String;
        attribute outputKind : ViewOutputKind[*];
        attribute presentationKind : PresentationKind[*];
        attribute concernKinds : ConcernKind[*];
        attribute includedLayers : String[*];
        attribute allowedElementKinds : String[*];
        attribute allowedRelationshipKinds : String[*];
        attribute filterExpression : String;
        attribute extendsViewpointIds : String[*];
        attribute userExtensible : Boolean;
        // Optional navigation grouping interpreted by Memo Architect.
        attribute group : String;
        // Explorer placement follows the MEMO V-model: Architecture is read
        // top-to-bottom; Assurance is read left-to-right.
        attribute explorerLane : String;
        attribute explorerOrder : Integer;
        // default diagram kind for a catalog viewpoint (optional)
        attribute defaultViewKind : DiagramViewKind[0..1];
    }

    part def ViewRule specializes MemoPart {
        attribute elementTypeName : String;
        attribute relationTypeName : String;
        attribute strength : RuleStrengthKind;
        attribute rationaleText : String;
    }

    part def ViewSelectionQuery specializes MemoPart {
        attribute includeElementKinds : String[*];
        attribute includeElementIds : String[*];
        attribute includeRelationshipKinds : String[*];
        attribute includeLayers : String[*];
        attribute includeConcerns : ConcernKind[*];
        attribute includeStatusTags : String[*];
        attribute selectionExpression : String;
        attribute rationaleText : String;
    }

    view def MemoView :> Views::View, DocumentedElement {
        attribute outputKind : ViewOutputKind[*];
        attribute presentationKind : PresentationKind[*];
        attribute filterExpression : String;
        attribute queryDescription : String;
        attribute dataSourceDescription : String;
        attribute autoPopulate : Boolean;
        // ISO 42010 conformance is many-to-many: every view has one or more
        // viewpoints, and a viewpoint may be realized by many reusable views.
        part viewpointDefinition : Viewpoint[1..*];
        // Optional grouping within each viewpoint, interpreted by Architect.
        attribute group : String;
        ref subjectElement : MemoPart[*];
        ref exposesElement : MemoPart[*];
        ref exposesRelationship : MemoRelationship[*];
        part selectionQuery : ViewSelectionQuery[*];
    }

    view def MemoDiagramView :> MemoView {
        attribute viewKind : DiagramViewKind;
        attribute diagramType : String;
        attribute layoutHint : String;
        attribute styleHint : String;
    }

    view def MemoDocumentBackedView :> MemoView {
        attribute version : String;
        attribute generationRule : String;
        attribute marketScope : String;
    }

    view def MemoDocumentView :> MemoDocumentBackedView {
        attribute viewKind : DocumentViewKind;
    }

    part def ViewInclusionRule specializes MemoPart {
        attribute includeElementKinds : String[*];
        attribute includeElementIds : String[*];
        attribute includeRelationshipKinds : String[*];
        attribute includeLayers : String[*];
        attribute includeConcerns : ConcernKind[*];
        attribute selectionExpression : String;
        attribute rationaleText : String;
    }
}
