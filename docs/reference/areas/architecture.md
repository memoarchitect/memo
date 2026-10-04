# Architecture

**Source:** `src/architecture/` · **Namespace:** `memo::architecture`

Architecture describes the device from its operating context to its deployed
realization. Each layer has its own page, which opens with the question the
layer answers. It then introduces the layer's elements, shows how they connect,
and lists the full inventory generated from the source:

| Layer | Source | Page |
| --- | --- | --- |
| Operational | `src/architecture/operational/` | [Operational layer](../../ontology/operational.md) |
| Functional | `src/architecture/functional/` | [Functional layer](../../ontology/functional.md) |
| Logical | `src/architecture/logical/` | [Logical layer](../../ontology/logical.md) |
| Implementation | `src/architecture/implementation/` | [Implementation layer](../../ontology/implementation.md) |
| Realization | `src/architecture/realization/` | [Realization layer](../../ontology/realization.md) |

`src/architecture/decisions/` holds `DesignDecision`, which records a choice
that affects elements in any layer. See [MEMO in a nutshell](../../ontology/index.md).

[Browse the generated architecture API](../../sysml-api/index.md#architecture).
