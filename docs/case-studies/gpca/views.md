# GPCA — Views

A **view** in ISO/IEC/IEEE 42010 expresses the architecture from the
perspective of one viewpoint, addressing that viewpoint's concerns. GPCA has
26 views: 17 diagram views governed by a viewpoint, and 9 document views that
assemble regulatory deliverables.

## Diagram views

Each row names the viewpoint it conforms to and the SysML v2 view kind it
renders as.

| View | Viewpoint | View kind |
|---|---|---|
| GPCA System Context View | Context | `general` |
| GPCA Use Case View | Operational | `general` |
| GPCA Scenario Sequence View | Operational | `sequence` |
| GPCA Function Allocation View | Functional | `grid` |
| GPCA Function Browser | Functional | `browser` |
| GPCA Logical Architecture View | Logical architecture | `general` |
| GPCA System Decomposition View | Logical architecture | `general` |
| GPCA Device Interconnect View | Logical architecture | `interconnection` |
| GPCA Top-Level Mode State View | Logical architecture | `statetransition` |
| GPCA Infusion Delivery Action Flow | Logical architecture | `actionflow` |
| GPCA Software Architecture View | Software | `interconnection` |
| GPCA Physical Architecture and BOM View | Physical | `grid` |
| GPCA Requirements Traceability View | Requirements | `grid` |
| GPCA Risk Mitigation Chain View | Risk | `general` |
| GPCA FMEA and Fault Tree View | Risk | `grid` |
| GPCA Cybersecurity View | Cybersecurity | `general` |
| GPCA V&V Coverage View | Verification | `grid` |

### Distribution by view kind

| View kind | Count |
|---|---|
| `general` | 6 |
| `grid` | 5 |
| `interconnection` | 2 |
| `statetransition` | 1 |
| `sequence` | 1 |
| `browser` | 1 |
| `actionflow` | 1 |

That `general` and `grid` dominate is not an accident. Most regulatory review
questions are *"show me the relationships"* or *"show me the matrix"*. The
behavioural kinds are fewer but carry the hardest content.

## Document views

Nine views produce documents rather than diagrams. They carry no `viewKind` —
their output is a structured document assembled from the model.

| Document view | Deliverable |
|---|---|
| Architecture Description | Architecture Description, DHF |
| Software Design Description | SDD, QMSR |
| Risk Management File | RMF, QMSR |
| Hazard Analysis Report | Hazard Analysis Report, RMF |
| Cybersecurity Threat Model | Threat Model, QMSR |
| Cybersecurity Assessment | Cybersecurity Risk Assessment, RMF, QMSR |
| Usability Engineering File | Usability Engineering File, DHF |
| Verification and Validation | VV, DHF, QMSR |
| Design History File Index | DHF |

## Anatomy of a view

Views are declarative. `VIEW-BHV-001`, the mode-state view, in full shape:

```sysml
view gpcaModeStateView : MemoDiagramView {
    attribute :>> id = "VIEW-BHV-001";
    attribute :>> title = "GPCA Top-Level Mode State View";
    attribute :>> viewKind = DiagramViewKind::statetransition;
    attribute :>> diagramType = "stm";
    attribute :>> autoPopulate = true;
    attribute :>> documentUsage = ("SDD", "RMF");
    part :>> selectionQuery {
        attribute :>> includeElementKinds =
            ("StateMachine", "ModeState", "Transition",
             "BehaviorProperty", "TimingConstraint");
        attribute :>> includeLayers = ("behavior");
        attribute :>> selectionExpression = "product == 'GPCA'";
    }
    part :>> viewpointDefinition = logicalArchitectureViewpoint;
}
```

Three things make this a 42010 view rather than a drawing:

1. `viewpointDefinition` names the viewpoint it conforms to.
2. `selectionQuery` states *how* content is selected, so the view is
   reproducible and auditable — nobody hand-picked the boxes.
3. `documentUsage` records which regulatory documents consume it.

## Depth is a view decision

The mode-state view exposes four levels of nesting (OFF/ON → IDLE/THERAPY →
PAUSED/ACTIVE → BASAL/SQUARE_BOLUS/PATIENT_BOLUS). The `depth = 2` attribute
sets what the view offers by default; how much a reviewer actually unfolds is
a reading decision made in the renderer, not a change to the model.

MEMO Architect supports both moves on this view — folding a composite state in
place, and drilling into one so it becomes its own diagram. Neither alters the
model; both change only what is on screen. The same two moves work on the
action-flow view for composite actions.

Continue to [Correspondences](correspondences.md).
