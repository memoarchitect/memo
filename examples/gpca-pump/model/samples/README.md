# Diagram rendering samples

This folder backs MEMO Architect's **Samples** experience with small, disposable
SysML v2 inputs. Each file exists only to exercise one renderer; together they
do not describe a product or reference architecture.

## Action Flow samples

| File | Shows |
|------|-------|
| `action_flow_view.sysml` | Minimal renderer smoke test — dummy actions, typed item flows, successions, one composite. |
| `operational_behaviour_view.sysml` | **Operational** behaviour — swimlanes per clinical role (Physician/Nurse/Biomed Tech/Patient), a `fork`/`join` for concurrent prep, and a composite step (`Administer PCA Therapy`) with a drill-in sub-flow. |
| `functional_flow_view.sysml` | **Functional/component** behaviour — swimlanes per realising component, typed data/energy/material flows, a `fork`/`join` for concurrent occlusion monitoring, and a composite `Deliver Medication` valve sub-flow. |

`fork`/`join` are SysML v2 control nodes: a `fork` splits one control flow into
concurrent flows, a `join` synchronises them back; the branches are declared by
the surrounding `first … then …` successions that reference the node by name.

The first rendering milestone covers interconnection, tree, and action flow.
Run the supported example application from the repository root:

```sh
pnpm example:dev
```
