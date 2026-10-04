# Requirements

!!! question "The question this discipline answers"
    **What must be true, and why?**

Requirements connect the problem to the solution. A **need** says what someone
expects, in their own language. A **requirement** is an obligation the solution
must meet, and it exists because something drove it: a need, a hazard, a
threat, or an existing component's limits. MEMO records that driver as a typed
relationship, so every requirement can answer "why does this exist?" and every
need can answer "what did we do about it?".

Requirements run across the architecture layers. A requirement can be about the
whole system, the software, the hardware, or the instructions for use, and it is
satisfied by elements in any layer.

**Namespace:** `memo::assurance::requirements` · **Source:** `src/assurance/requirements/`

## Key elements

**Needs.** A `Need` is a problem-space expectation stated in stakeholder
language. Its `needKind` classifies it as a design input in ISO 13485 and
IEC 62366-1 terms: stakeholder, user, clinical user, patient user, business,
service, regulatory, operational, or design control. A user need says whose
need it is with `HeldBy`. The user's characteristics live on the `User`, not
restated on the need.

**Requirements.** A `Requirement` is a solution-space obligation. It records:

- `requirementType`: what it is about, which is the system, the software, the
  hardware, or the instructions for use (EU MDR Annex I §23.4, ISO 20417).
- `sourceKind` and `concernKind`: where it came from and which concern it serves.
- `statement`, with an authoring `notation` such as EARS, an `obligation`
  (shall, should, will), and the parsed condition and response clauses, so
  tools can check the pattern.
- `safetyClass` for a software requirement (IEC 62304).
- `acceptanceCriteria`, which a verification case checks.

**Drivers and supporting definitions.** A `RiskDriver` is a requirement driver
that comes from risk: `Risk` and `Threat` both specialise it, which is what lets
a hazard or a threat be the source a requirement derives from. A
`SystemConstant` is a named constant from a source requirements document, such
as a tolerance, that requirement statements refer to. A `NotificationSpec` is
one row of an alarm and notification table: a named notification, its
priority, and the actions the system must take.

## How it connects

- **Needs motivate use cases** (`Motivates`) and are held by participants
  (`HeldBy`). See [Operational](operational.md).
- **Requirements derive from their drivers** (`DerivesFrom`): from needs, from
  operational activities, from risks and threats, from components. The driver
  end accepts any element, because drivers are of many kinds.
- **Requirements are satisfied by design elements** with native `satisfy`: a
  function, a hardware component, a software module, or a UI element. See the layer
  pages from [Functional](functional.md) to [Implementation](implementation.md).
- **Requirements are checked** by verification cases, and the evidence they
  produce. See [Verification and validation](verification-validation.md).
- **A security requirement is derived from a threat or a risk**
  (`DerivesCyberRequirement`, in Core). `SecurityRequirement` itself is defined
  in [Cybersecurity](cybersecurity.md).

## In the running example

The temperature alarm carries no requirements, so this example comes from the
GPCA infusion pump. Here is a need, a hardware requirement, the needs it
derives from, and requirements satisfied by software.

```sysml
--8<-- "examples/gpca-pump/model/catalog/gpca_requirements.sysml:need"
```

```sysml
--8<-- "examples/gpca-pump/model/catalog/gpca_requirements.sysml:requirement"
```

```sysml
--8<-- "examples/gpca-pump/model/catalog/gpca_trace.sysml:derives"
```

```sysml
--8<-- "examples/gpca-pump/model/catalog/gpca_architecture.sysml:satisfy"
```

## The full inventory

Generated from `src/assurance/requirements/`.

--8<-- "docs/ontology/_generated/requirements.md"

## Go deeper

- The GPCA infusion pump: [requirements and architecture](../layers/requirements-architecture.md).
- [The requirements API](../sysml-api/index.md#assurance).
