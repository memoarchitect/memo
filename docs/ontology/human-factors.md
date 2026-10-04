# Human factors

!!! question "The question this discipline answers"
    **Where can use go wrong?**

Human factors follows IEC 62366-1 and the FDA's human factors guidance. A user
performs tasks. Some tasks are critical, and while performing one a user can
commit a use error. A use error can lead to a hazard. A risk control addresses
the hazard, and usability validation shows, with representative users, that the
design works.

Most of that chain belongs to other parts of MEMO: the user and the task are
operational, the hazard and the control are safety, and the validation case is
verification and validation. Human factors owns the use error, and the
relationships that tie the usability argument together.

**Namespace:** `memo::assurance::human_factors` · **Source:** `src/assurance/human_factors/`

## Key elements

**Use errors.** A `UseError` records a use error in the sense of IEC 62366-1.
Its `errorCategory` classifies it as a perception, cognition, action, or
memory and recall error. It also
records its severity and the type of its root cause.

**What it builds on.** The rest of the chain uses elements from elsewhere:

- `User` and `OperativeAction` for the user and the task (see
  [Operational](operational.md));
- `Hazard` and `RiskControlMeasure` for the risk (see
  [Safety and risk](safety-risk.md));
- `ValidationCase` and `MemoEvidence` for summative evaluation (see
  [Verification and validation](verification-validation.md));
- `UIElement` for where the error happens (see [Implementation](implementation.md)).

## How it connects

- **A task is where an error is committed.** `CommitsUseError` links an operative
  action to a use error.
- **An error happens at an element.** `ErrorAtElement` links a use error to the
  design element it occurs at, such as a UI element. It is declared in the UI
  package.
- **An error can lead to a hazard.** `Causes`, with
  `causeKind = useErrorLeadsToHazard`.
- **Usability evidence evaluates a task.** `EvaluatesTask` links evidence to the
  task it evaluates.
- **A UI element or task is tested for usability.** `TestedByUsability` links it
  to the usability test, which is a validation case, not the evidence it
  produces. `ProducesEvidence` links the two.
- **A task is validated.** `Validates` links a task to the validation case that
  checks it.

## In the running example

The use error is silencing the alarm without assessing it, a memory and recall
error with serious severity. It is committed during the acknowledgement task, and
it leads to the hazard of an undetected deviation.

```sysml
--8<-- "examples/temperature-alarm/model/catalog/temperature_alarm.sysml:human-factors"
```

## The full inventory

Generated from `src/assurance/human_factors/`.

--8<-- "docs/ontology/_generated/human-factors.md"

## Go deeper

- The GPCA infusion pump: [risk, cybersecurity, and assurance](../layers/risk-assurance.md).
- [The human factors API](../sysml-api/index.md#assurance).
