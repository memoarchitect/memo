# Safety and risk

!!! question "The question this discipline answers"
    **What could cause harm, and what keeps the risk acceptable?**

Safety and risk follows ISO 14971. A **hazard** is a potential source of harm. A
**sequence of events** turns it into a **hazardous situation**, which can lead
to **harm**. Each **risk** is estimated and evaluated, reduced by **risk
controls**, and what remains is the **residual risk**, judged once more against
the device's benefit.

MEMO models that chain as elements and relationships rather than as rows in a
spreadsheet. The payoff is that a risk control is tied to the design element
that implements it. When that element changes, the control's evidence is
visibly at stake.

**Namespace:** `memo::assurance::safety_risk` · **Source:** `src/assurance/safety_risk/`

## Key elements

**The ISO 14971 chain.** `Hazard`, `HazardCause`, `SequenceOfEvents`,
`HazardousSituation` and `Harm` are the chain's risk items. A
`ReasonablyForeseeableMisuse` records misuse the manufacturer must consider. A
`SafetyRelatedCharacteristic` records a characteristic of the device that can
affect safety.

**Risk and its evaluation.** A `Risk` is estimated for a risk item and assessed
against a `RiskMatrix`. A `ResidualRisk` is what remains after control. An
`OverallResidualRiskEvaluation` weighs all residual risk, together with the
device's `Benefit`.

**Controls.** A `RiskControlMeasure` reduces a risk. Its `controlKind` says what
kind of control it is: inherent safe design, a protective measure, information
for safety, an alarm, an interlock, monitoring, or a plausibility check. Its
`implementationKind` says how it is built: in hardware design, in software
design, in labelling, in training, or as a procedural control.

**Analysis techniques.**

- *FMEA*: `FMEAWorksheet`, `FailureMode`, `FailureEffect`, `FailureCause`,
  `DetectionMethod` and `FMEAAction`.
- *Fault tree analysis*: `FaultTree`, `FaultTreeNode` and `MinimalCutSet`.
- *HAZOP*: `HAZOPStudy`, `HAZOPNode` and `HAZOPDeviation`.

**After release.** `PostMarketSurveillance` feeds field information back into
the design.

## How it connects

**The chain itself.** Risk items trace to each other along the sequence of
events (`TracesRisk`). A hazardous situation leads to a harm (`LeadsToHarm`),
carrying the conditional probability that it does. A risk is estimated for a
risk item (`EstimatedFor`) and assessed against a matrix (`AssessedAgainst`). A
residual risk is reduced by controls (`ReducedBy`) and evaluated in the overall
evaluation (`EvaluatedIn`).

**Causes and controls:**

- `Causes` links a cause to its effect. Its `causeKind` says what kind of
  causation it is, for example a failure that causes an effect, or a use error
  that leads to a hazard.
- `Mitigates` links a control to the risk item it reduces. Its `mitigationKind`
  is `hazard` or `vulnerability`.
- `ControlImplementedBy` links a control to the design element that implements
  it, in any architecture layer.

**Analysis.** An element has failure modes (`HasFailureMode`). A failure mode is
detected by a detection method (`DetectedBy`). Fault-tree nodes feed gates and
produce events (`InputToGate`, `ProducesEvent`), and a minimal cut set contains
events (`ContainsEvent`). A HAZOP deviation identifies a hazard
(`IdentifiesHazard`).

**To other layers and disciplines:**

- **Operational**: a risk item is related to the operative scenario it occurs in
  (`HazardRelatedScenario`). See [Operational](operational.md).
- **Human factors**: a use error causes a hazard (`Causes`). See
  [Human factors](human-factors.md).
- **Cybersecurity**: a security element can impact safety (`ImpactsSafety`), and
  a cyber risk is a `Risk`. See [Cybersecurity](cybersecurity.md).
- **Requirements**: a risk is a requirement driver, so a safety requirement can
  derive from it (`DerivesFrom`). See [Requirements](requirements.md).
- **Post-market**: surveillance feeds back to a design element (`FeedsBackTo`).

## In the running example

A nurse who silences the alarm without assessing it commits a use error. That
use error leads to the hazard of an undetected deviation. Re-announcing the alarm
after silence is the control, and the alarm banner implements it.

```sysml
--8<-- "examples/temperature-alarm/model/catalog/temperature_alarm.sysml:safety-risk"
```

## The full inventory

Generated from `src/assurance/safety_risk/`.

--8<-- "docs/ontology/_generated/safety-risk.md"

## Go deeper

- The GPCA infusion pump: [risk, cybersecurity, and assurance](../layers/risk-assurance.md).
- [The safety and risk API](../sysml-api/index.md#assurance).
