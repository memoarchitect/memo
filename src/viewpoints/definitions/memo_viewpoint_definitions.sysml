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
    private import memo_viewpoints_stakeholders_concerns::*;

    // Extends the native SysML viewpoint (Views::ViewpointCheck, a
    // RequirementCheck whose subject is a View) with MEMO's catalog
    // attributes. Identity comes from the `@MemoIdentity` metadata carrier
    // rather than a re-declared core: a viewpoint is native requirement-family,
    // not a MemoPart, and metadata crosses metaclasses where inheritance cannot.
    viewpoint def MemoViewpoint :> Views::ViewpointCheck {
        attribute name : String;
        attribute description : String;
        attribute status : ElementStatusKind;
        attribute lifecycleState : LifecycleStateKind;
        attribute realizationStage : RealizationStageKind[0..1];
        attribute crossCuttingConcerns : CrossCuttingConcernKind[0..*];
        attribute applicableStandards : ExternalReference[0..*];
        attribute codes : TerminologyCode[0..*];
        attribute purpose : String;
        /**
         * Who the viewpoint is written for, and what it frames for them.
         *
         * References, not enum literals. A stakeholder and a concern are
         * elements with ids — citable in a review, traceable from a
         * requirement, and extensible by a project without editing the
         * ontology, which `AudienceKind` and `ConcernKind` were not.
         */
        // Redefines the standard library's `RequirementCheck::stakeholders`,
        // which a viewpoint inherits through `ViewpointCheck`.
        ref :>> stakeholders : MemoStakeholder[0..*];
        attribute stage : WorkflowStageKind;
        attribute abstractionLevel : String;
        attribute outputKind : ViewOutputKind[*];
        attribute presentationKind : PresentationKind[*];
        ref framedConcerns : MemoConcern[*];
        // A viewpoint identifies stakeholders, the concerns it frames, and the
        // views that conform to it — ISO/IEC/IEEE 42010, and nothing further.
        // It used to also carry `includedLayers`, `allowedElementKinds`,
        // `allowedRelationshipKinds` and `filterExpression`: scoping rules over
        // its views. Nothing ever read them, and the filtering that did happen
        // came from a union the deriver accumulated out of the views
        // themselves. What a view shows is the view's to say, through its own
        // expose members and selectionQuery.
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

    // ─── Legends ────────────────────────────────────────────────────────
    //
    // A legend gives colour a meaning, and a view picks exactly one of them —
    // because two legends at once would put two meanings on the same channel
    // and neither could be read.
    //
    // Each legend is tied to ONE attribute or enumeration, which is what makes
    // it a legend rather than a palette: every entry is a value of that same
    // thing, so the key can be stated as "this attribute, these values, these
    // colours". Colour is otherwise a property of a diagram, defined nowhere,
    // reproducible in no other view and reviewable by nobody.
    // A swatch, not an "entry": `entry` is a SysML keyword (a state's entry
    // action), and the keyword-collision lint is right that a definition should
    // not reach for one that means something else. A swatch is what this is —
    // a colour with a label.
    part def MemoLegendSwatch specializes MemoPart {
        /** The value of the legend's attribute or enumeration this entry is for. */
        attribute value : String;
        /** Shown in the key. Defaults to the value when unstated. */
        attribute label : String;
        /** `#RRGGBB`. */
        attribute color : String;
    }

    part def MemoLegend specializes MemoPart {
        /** The attribute whose value each entry names — e.g. "realizationStage". */
        attribute attributeName : String;
        /**
         * An `enum def` whose values each entry names, as an alternative to
         * `attributeName`.
         */
        attribute enumerationName : String;
        /**
         * A value the model derives rather than stores — hierarchy depth, or
         * the element's kind. Use instead of `attributeName` when the thing
         * being coloured is not written on the element.
         */
        attribute derivedFrom : LegendSourceKind[0..1];
        /**
         * Which constructs are coloured. A legend may cover parts and the
         * connections between them, or only one of them. Empty means every
         * construct the legend has an entry for.
         */
        attribute appliesTo : LegendScopeKind[*];
        part swatches : MemoLegendSwatch[*];
    }

    view def MemoView :> Views::View {
        // Identity comes from the `@MemoIdentity` metadata carrier, which
        // annotates any metaclass — so a view stays native SysML without
        // re-declaring the identification core the other bases used to copy.
        attribute name : String;
        attribute description : String;
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
        /**
         * The one legend this view colours by. At most one: colour is a single
         * channel, and a second legend competing for it makes both unreadable.
         * Without one, an element keeps its layer colour.
         */
        ref legend : MemoLegend[0..1];

        // ── What the drawing SHOWS ────────────────────────────────────────
        //
        // These are the view's own statement about what it presents, so they
        // are declared here and not in the layout companion beside it. That
        // file records where boxes were dragged to; whether a drawing names
        // its ports at all is a decision about the view, survives a layout
        // reset, and belongs where the rest of the view's intent is written.
        //
        // Each is optional and the renderer keeps its default when a view says
        // nothing, so no existing view changes meaning by their arrival.
        attribute portDisplay : PortDisplayKind[0..1];
        attribute connectionDisplay : ConnectionDisplayKind[0..1];
        /** Name each port on the drawing. Off where the connector label
         *  already carries the same string, as on a ROS pub/sub view where the
         *  port and the topic share a name. */
        attribute showPortText : Boolean[0..1];
        attribute showConnectionText : Boolean[0..1];
        /** Animate direction along connectors. */
        attribute flowAnimation : Boolean[0..1];
        /** The renderer profile this view opts into, by id. */
        attribute rendererProfile : String[0..1];
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
