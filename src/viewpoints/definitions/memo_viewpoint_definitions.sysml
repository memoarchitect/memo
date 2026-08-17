// MEMO's ISO/IEC/IEEE 42010 view apparatus, built on native SysML v2 — which
// already models the whole stack: a View conforms to a Viewpoint, a Viewpoint
// frames Concerns, Concerns are held by Stakeholders. MemoView extends the
// native Views::View. Concerns are the native `concern def`; stakeholders are
// native stakeholder memberships (any Part in the stakeholder role); MEMO adds
// only the medical-device attributes on top, never a parallel type.
package memo_viewpoints_definitions {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_dimensions::*;
    private import memo_core_terminology::*;
    private import memo_core_relationships::*;

    // Extends the native SysML viewpoint (Views::ViewpointCheck, a
    // RequirementCheck whose subject is a View) with MEMO's catalog
    // attributes. The MEMO identity core is re-declared here because a
    // viewpoint is native requirement-family, not a MemoPart — the same
    // per-metaclass pattern MemoView and the other bases use.
    viewpoint def MemoViewpoint :> Views::ViewpointCheck {
        attribute id : String;
        attribute uuid : String;
        attribute name : String;
        attribute shortDescription : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
        attribute status : ElementStatusKind;
        attribute lifecycleState : LifecycleStateKind;
        attribute realizationStage : RealizationStageKind[0..1];
        attribute crossCuttingConcerns : CrossCuttingConcernKind[0..*];
        attribute concerns : ConcernKind[0..*];
        attribute applicableStandards : ExternalReference[0..*];
        attribute codes : TerminologyCode[0..*];
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

    view def MemoView :> Views::View {
        // MEMO identity core, re-declared here rather than inherited: a view is
        // native SysML and must stay one, so it does not mix in the MemoPart
        // part hierarchy — same per-metaclass pattern the other MEMO bases use.
        attribute id : String;
        attribute uuid : String;
        attribute name : String;
        attribute shortDescription : String;
        attribute description : String;
        attribute rationale : String;
        attribute sourceReference : String;
        attribute status : ElementStatusKind;
        attribute lifecycleState : LifecycleStateKind;
        attribute realizationStage : RealizationStageKind[0..1];
        attribute crossCuttingConcerns : CrossCuttingConcernKind[0..*];
        attribute concerns : ConcernKind[0..*];
        attribute applicableStandards : ExternalReference[0..*];
        attribute codes : TerminologyCode[0..*];
        attribute outputKind : ViewOutputKind[*];
        attribute presentationKind : PresentationKind[*];
        attribute filterExpression : String;
        attribute queryDescription : String;
        attribute dataSourceDescription : String;
        attribute autoPopulate : Boolean;
        // ISO 42010 conformance is many-to-many: every view has one or more
        // viewpoints, and a viewpoint may be realized by many reusable views.
        ref viewpointDefinition : MemoViewpoint[1..*];
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
