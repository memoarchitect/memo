// User interface and interaction (§18). A small semantic hierarchy: concrete
// widget forms (button, knob, chart …) are enum classifications, not classes.
// UI state is distinct from system state (memo_architecture_functional_behavior) and
// from device modes (memo_architecture_logical_structure::LogicalMode).
// UI is an implementation concern (rendered UI is software; physical controls
// are hardware), so it lives in the implementation layer, not operational.
package memo_architecture_implementation_ui {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_assurance_safety_risk::*;   // RiskControlMeasure
    private import memo_core_relationships::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_scenarios::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_architecture_functional_functions::*;
    private import memo_architecture_implementation_software_structure::*;
    private import memo_architecture_implementation_hardware_common::*;
    private import memo_assurance_human_factors::*;

    // Every concrete UI form, holding and held alike. A screen is not a
    // different KIND of thing from a button — it is a UIElement that happens to
    // contain others, exactly as an assembly is a part that contains parts.
    // The forms below are classifications, not classes, so one tree carries the
    // whole interface.
    enum def UIElementFormKind {
        // ── forms that hold other elements ──
        enum screen;
        enum dialog;
        enum panel;
        enum menu;
        enum tab;
        enum drawer;
        enum wizardStep;
        // ── controls the user acts on ──
        // Rendered controls only. A knob, toggle, lamp, or buzzer the user
        // touches is not software: it is an OperatorInterfaceElement below.
        enum button;
        enum field;
        enum selector;
        enum slider;
        // ── forms that present information ──
        enum table;
        enum chart;
        enum icon;
        enum textMessage;
        // ── chrome ──
        // Non-functional: a rule, a background, a brand mark. Declared, never
        // merely implied — CR-MED-110 exempts `decoration` from needing a
        // design record, so an element left unclassified fails rather than
        // slipping through as scenery.
        enum decoration;
    }

    // ─── Screen geometry ─────────────────────────────────────────
    // Position and size of a UIElement inside its PARENT element, each value
    // normalized to 0..1 of the parent's box — not pixels. Two consequences
    // are wanted: an element survives a re-capture at a different resolution
    // or device scale, and a child's box is stated against its parent, which
    // is exactly what the containment tree already asserts. Absolute pixels
    // stay recoverable from the ScreenCapture's pixelWidth / pixelHeight.
    attribute def RegionBounds {
        attribute x : Real;
        attribute y : Real;
        attribute width : Real;
        attribute height : Real;
    }

    // How an element appears relative to its parent and siblings. It records
    // design intent a bare rectangle cannot: an element whose box escapes its
    // parent and covers its siblings is a defect if it is `inline` and correct
    // if it is `overlay`, and the geometry alone does not say which. A
    // renderer reads it to decide what to clip and what to draw on top; a
    // reviewer reads it to know whether an overlap is intended.
    enum def UIDisclosureKind {
        enum inline;       // laid out inside the parent, sharing space with siblings
        enum overlay;      // dropdown, popover, modal — drawn OVER parent and siblings
        enum transient;    // tooltip, toast — appears over everything, then withdraws
        enum scrolled;     // inside the parent, but beyond its viewport until scrolled
        enum conditional;  // rendered only while a stated condition holds
    }

    // How the element's bounds were obtained. Automatic boundary detection
    // PROPOSES; a reviewer DISPOSES. In a regulated review the reader must be
    // able to see which boxes a human confirmed and which the tool guessed, so
    // that provenance is model content and not a workbench-only flag.
    enum def BoundsDetectionKind {
        enum manual;
        enum automatic;
        enum automaticConfirmed;
        enum imported;
    }

    // The interaction intents a step or action can carry (§18).
    enum def InteractionIntentKind {
        enum userInput;
        enum feedback;
        enum navigation;
        enum confirmation;
        enum inputValidation;
        enum errorMessage;
        enum alarmAnnunciation;
        enum acknowledgement;
        enum cancellation;
        enum timeout;
        enum lockout;
        enum correction;
        enum recovery;
    }

    part def UserInterface specializes ArchitectureElement {
        attribute modality : String;
        attribute uiTechnology : String;
    }

    // What a rendered control and a physical one genuinely share: a label, an
    // accessibility story, and — when they annunciate — an alarm character.
    // The base exists so that the §18 traceability relations can type against
    // "something the user interacts with" rather than against software
    // specifically. Without it a use error on a knob would be unmodellable,
    // because ErrorAtElement would only accept a UIElement.
    abstract part def InteractionElement specializes ArchitectureElement {
        attribute labelText : String;
        attribute accessibilitySummary : String;
        // alarm annunciation (optional; IEC 60601-1-8)
        attribute alarmPriority : NotificationPriorityKind[0..1];
        attribute annunciationModality : String;
        attribute silenceable : Boolean;
    }


    // One UIElement — the single UI part type. The widget form — holding
    // (screen/panel/dialog), acting (button/knob/slider), presenting
    // (field/table/chart), physical (knob/switch/indicatorLamp/haptic), or
    // decorative — is the `formKind` enum, not a subclass.
    // Input/output/navigation/alarm/display/physical-control descriptors are
    // optional attributes; a physical control's mechanical realization is a
    // hardware part linked by ControlImplementedBy.
    //
    // Composition is the ordinary `Composes` relation, so a screen's element
    // tree is an ordinary part tree: CR-ONT-001 already forbids cycles in it,
    // impact analysis already walks it, and requirements, functions, use
    // errors, and risk controls already trace to it. Screen layout adds four
    // numbers to that tree — it does not add a tree.
    //
    // A UIElement IS a structural SOFTWARE ITEM (IEC 62304 §3.25) and
    // specializes SoftwareElement, inheriting safetyClass and complexity, so the
    // interface is classified and decomposed like the software it is.
    //
    // It specializes SoftwareElement and NOT SoftwareModule: the module view is
    // CODE, and a screen is not a source module. Runtime processes are
    // SoftwareComponent, code is SoftwareModule, and the UI is a third view of
    // the same software — a sibling of those, not a kind of either.
    part def UIElement specializes SoftwareElement, InteractionElement {
        attribute formKind : UIElementFormKind;
        // ── screen layout (optional; set for elements that are laid out) ──
        // Bounds are relative to the parent element in the Composes tree; a
        // root screen's bounds are the full frame.
        attribute bounds : RegionBounds[0..1];
        attribute disclosureKind : UIDisclosureKind[0..1];
        // The condition under which the element renders; meaningful when
        // disclosureKind is `conditional`.
        attribute visibilityCondition : String;
        // Boundary colour as a CSS colour token. Presentation, but modelled: a
        // review print, an exported figure, and the workbench must agree on
        // which box is which, and a colour assigned only in a tool session does
        // not survive the export.
        attribute boundaryColor : String;
        // Capture-relative fill transparency for region review overlays. A
        // modelled value keeps interactive review and exported figures aligned.
        attribute boundaryOpacity : Real[0..1];
        attribute detectionMethod : BoundsDetectionKind[0..1];
        attribute detectionConfidence : Real[0..1];
        attribute confirmedBy : String;
        attribute confirmedAt : String;
        // ── role of a holding form (optional) ──
        attribute navigationRole : String;
        // input descriptors (optional)
        attribute inputConstraints : String;
        attribute defaultValue : String;
        // output / display descriptors (optional)
        attribute updateRate : String;
        attribute unitsDisplayed : String;
        attribute informationContent : String;
    }

    // ─── Physical operator interface ─────────────────────────────
    // The hardware the user actually touches and reads. IEC 60601-1 marks
    // "controls and instruments" and defines OPERATOR; this is that surface,
    // covering both directions — what the operator actuates and what the
    // device shows back — because a front panel is one interface, not two.
    //
    // It is a PhysicalComponent, so it inherits part number, material, and the
    // ISO 10993-1 patient-contact characterization that a touched surface
    // needs and that software can never have. That inheritance is the reason
    // these forms had to leave UIElement: as UIElementFormKind members they
    // were software items with no way to state any of it.
    enum def OperatorInterfaceFormKind {
        // ── actuated by the operator ──
        enum knob;
        enum dial;
        enum pushButton;
        enum toggleSwitch;
        enum rockerSwitch;
        enum lever;
        enum physicalSlider;
        enum keypad;
        enum footPedal;
        enum touchSurface;
        // ── presented to the operator ──
        enum indicatorLamp;
        enum gauge;
        enum audibleIndicator;
        enum hapticIndicator;
        enum printedMarking;
    }

    part def OperatorInterfaceElement specializes PhysicalComponent, InteractionElement {
        attribute formKind : OperatorInterfaceFormKind;
        // actuation (optional; set for actuated forms)
        attribute actuationForce : String;
        attribute actuationTravel : String;
        attribute guardedAgainstInadvertentActuation : Boolean;
        attribute tactileFeedback : String;
        // presentation (optional; set for presented forms)
        attribute legendText : String;
        attribute luminanceOrVolume : String;
    }

    // ─── Captured evidence ───────────────────────────────────────
    // One image of one screen. MemoEvidence, not ArchitectureElement: it
    // records what a specific build actually displayed at a specific time,
    // which is the provenance a design review or a usability engineering file
    // needs before it can rely on the picture. The screen it depicts is an
    // ordinary UIElement with formKind = screen.
    part def ScreenCapture specializes MemoEvidence {
        attribute imageUri : String;
        // Content hash of the image bytes. The screenshot is the evidence, so
        // it must be tamper-evident: a DHF reference to a mutable file is not
        // a reference to anything.
        attribute imageHash : String;
        attribute pixelWidth : Integer;
        attribute pixelHeight : Integer;
        attribute captureDate : String;
        // Which build produced this rendering. A screenshot without a build is
        // undated design intent, not evidence of the device.
        attribute capturedBuild : String;
        // Device, viewport, locale, theme, user role — everything that changes
        // what the screen shows without changing the software.
        attribute captureContext : String;
    }

    // UI state is presentation state — distinct from system/device state.
    part def UIState specializes ArchitectureElement {
        attribute displayedInformation : String;
        attribute availableActions : String;
    }
    part def UIEvent specializes ArchitectureElement {
        attribute eventSource : String;
        attribute intent : InteractionIntentKind;
    }

    action def UIAction specializes MemoAction {
        attribute intent : InteractionIntentKind;
        attribute feedbackProvided : String;
        attribute confirmationRequired : Boolean;
    }

    // A reusable dialogue structure through the UI; a selected path through
    // it is a MemoScenario with scenarioKind `ui`.
    action def InteractionFlow specializes MemoAction {
        attribute entryPoint : String;
        attribute exitPoint : String;
    }

    connection def DataBinding :> MemoRelationship {
        attribute bindingExpression : String;
        attribute refreshPolicy : String;
        end boundElement : InteractionElement :>> source;
        end dataSource : MemoItem :>> target;
    }
    abstract connection dataBindingLinks : DataBinding[*];
    metadata def <dataBinding> DataBindingMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = dataBindingLinks meta SysML::Usage;
    }
    connection def PresentsState :> MemoRelationship {
        end userInterface : UserInterface :>> source;
        end uiState : UIState :>> target;
    }
    abstract connection presentsStateLinks : PresentsState[*];
    metadata def <presentsState> PresentsStateMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = presentsStateLinks meta SysML::Usage;
    }

    // ── Screen layout relations ──────────────────────────────────
    // Which modelled screen an image is a rendering of.
    connection def CapturesScreen :> MemoRelationship {
        end capture : ScreenCapture :>> source;
        end screen : UIElement :>> target;
    }
    abstract connection capturesScreenLinks : CapturesScreen[*];
    metadata def <capturesScreen> CapturesScreenMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = capturesScreenLinks meta SysML::Usage;
    }

    // Activating this element opens another screen. This is NAVIGATION, not
    // containment — the opened screen is not laid out inside the element, so
    // it is not a Composes child and the geometric rules do not relate them.
    // Conflating the two was the mistake that made "clicking takes you to a
    // child view" look like spatial nesting; it is a separate frame reached
    // from here, and only this relation says so.
    connection def NavigatesTo :> MemoRelationship {
        attribute triggerGesture : String;
        end sourceElement : UIElement :>> source;
        end targetScreen : UIElement :>> target;
    }
    abstract connection navigatesToLinks : NavigatesTo[*];
    metadata def <navigatesTo> NavigatesToMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = navigatesToLinks meta SysML::Usage;
    }

    // ── §18 traceability ─────────────────────────────────────────
    connection def ElementTriggersAction :> MemoRelationship {
        end element : InteractionElement :>> source;
        end triggeredAction : UIAction :>> target;
    }
    abstract connection elementTriggersActionLinks : ElementTriggersAction[*];
    metadata def <elementTriggersAction> ElementTriggersActionMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = elementTriggersActionLinks meta SysML::Usage;
    }
    connection def ActionInvokesFunction :> MemoRelationship {
        end uiAction : UIAction :>> source;
        end systemFunction : MemoFunction :>> target;
    }
    abstract connection actionInvokesFunctionLinks : ActionInvokesFunction[*];
    metadata def <actionInvokesFunction> ActionInvokesFunctionMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = actionInvokesFunctionLinks meta SysML::Usage;
    }
    connection def FlowServesUseCase :> MemoRelationship {
        end interactionFlow : InteractionFlow :>> source;
        end useCase : UseCase :>> target;
    }
    abstract connection flowServesUseCaseLinks : FlowServesUseCase[*];
    metadata def <flowServesUseCase> FlowServesUseCaseMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = flowServesUseCaseLinks meta SysML::Usage;
    }
    // A UI scenario realizes a functional scenario one layer up: each is a
    // MemoScenario selected by scenarioKind rather than a separate definition.
    connection def ErrorAtElement :> MemoRelationship {
        end useError : UseError :>> source;
        end element : InteractionElement :>> target;
    }
    abstract connection errorAtElementLinks : ErrorAtElement[*];
    metadata def <errorAtElement> ErrorAtElementMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = errorAtElementLinks meta SysML::Usage;
    }
    // A risk control implemented by a UI element or by task design
    // (confirmation dialog, lockout, guarded control).
    connection def ControlImplementedBy :> MemoRelationship {
        end riskControl : RiskControlMeasure :>> source;
        end implementingElement : ArchitectureElement :>> target;
    }
    abstract connection controlImplementedByLinks : ControlImplementedBy[*];
    metadata def <controlImplementedBy> ControlImplementedByMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = controlImplementedByLinks meta SysML::Usage;
    }
}
