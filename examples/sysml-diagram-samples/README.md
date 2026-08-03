# Standard SysML v2 diagram samples

An openable MEMO Architect project whose only purpose is to render **one small,
self-contained diagram per standard SysML v2 view kind**. Together the views do
not describe a product or reference architecture — each exists only to exercise
one renderer.

Open it read-only in the Architect UI:

```sh
memo-architect --example standard-sysml-diagrams
```

Each view is a `MemoDiagramView` declared in `model/samples/`, exposing its own
dummy elements. The Architect explorer groups each authored view by the layer
of its model content.

`reference/sysml-v2-activity-example.sysml` is the authoritative SysML v2
activity-diagram acceptance fixture. It is kept outside `model/` until the
bundled parser supports its decision, merge, accept/send, termination, and
guard syntax; this keeps the currently runnable sample project parse-clean.

| View | Diagram type | View kind | Renders |
| --- | --- | --- | --- |
| `tree_view.sysml` | `bdd` | general | Block Definition Diagram — a decomposition hierarchy. |
| `interconnection_view.sysml` | `ibd` | interconnection | Internal Block Diagram — nested parts, boundary ports, typed connectors. |
| `action_flow_view.sysml` | `afd` | actionflow | Activity / action flow — actions, item flows, successions. |
| `functional_flow_view.sysml` | `ffd` | actionflow | Functional flow — swimlanes per realising component, typed data/energy flows. |
| `operational_behaviour_view.sysml` | `ofd` | actionflow | Operational flow — clinical-role swimlanes, concurrent preparation, and a composite therapy step. |
| `context_view.sysml` | `context` | general | Operational system context — a black-box system of interest inside an explicit boundary, with actors, peer systems, environment, and typed interactions outside it. |
| `requirements_view.sysml` | `req` | general | Requirements — stakeholder needs deriving into system requirements. |
| `use_case_view.sysml` | `ucd` | general | Use case — relationship-driven actors, include/extend links, and model-owned `usecase:level` / `edge` presentation hints. |
| `state_transition_view.sysml` | `stm` | statetransition | State machine — pump operating modes and their triggered transitions. |

SysML v2 standardizes the model semantics; a diagram is a presentation of those
semantics. The Architect renderer selects the template from each view's
`viewKind`, so the same model can be re-presented in any compatible kind.
