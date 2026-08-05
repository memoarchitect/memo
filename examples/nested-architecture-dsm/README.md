# Nested Architecture DSM

A small infusion-pump model whose only purpose is to exercise the two matrix
analyses — the Design Structure Matrix and the Traceability Matrix — with a
hierarchy deep enough that expanding and collapsing changes what you see.

## What is in it

| Axis material | Elements | Nesting |
| --- | --- | --- |
| Logical structure | 1 system, 5 subsystems, 12 components | 4 levels (`System → Subsystem → Subsystem → LogicalComponent`) |
| Functional architecture | 18 system functions | 3 levels, four capability trees |
| Requirements | 7 requirements | flat |

Nesting is declared with `Composes`, so both matrices build their trees from
the model rather than from a naming convention.

## What it is set up to show

- **Roll-up.** `SafetyMonitorSubsystem` sits one level deeper than its peers, so
  a collapsed `ControlSubsystem` row genuinely sums its descendants instead of
  standing in for a single child.
- **Feedback.** `DriveActuator` and `MeasureDeliveredVolume` exchange in both
  directions, so a partitioned DSM still shows one real feedback mark rather
  than an empty lower triangle.
- **Cross-tree dependency.** `EnforceDoseLimits → DriveActuator` and
  `SelectPowerSource → DriveActuator` cross capability trees, which is what a
  collapsed matrix rolls into a single number between two capabilities.
- **Asymmetric axes.** Functions on the rows and blocks on the columns, joined
  by `AllocatedTo` — including `MeterFluid → FluidPathSubsystem`, an allocation
  made at subsystem level rather than to one component.
- **A traceability gap.** `StatusVisibility` is satisfied by nothing, so
  coverage reads under 100% and there is an empty row to author a link into.

## Suggested run

```bash
memo-architect --example nested-architecture-dsm
```

In **DSM**: set rows and columns to `SystemFunction`, dependency to
`exchangesWith`, and switch ordering between *Name* and *Partition* — the
feedback count drops and one mark stays below the diagonal. Then set columns to
the logical kinds and dependency to `allocatedTo` for the allocation view.

In **Traceability**: rows `Requirement`, columns `SystemFunction`, trace via
`satisfiedBy`. Turn on **Edit links** and click the empty `StatusVisibility` row
to author the missing trace; it is written back to
`model/catalog/traces.sysml`.
