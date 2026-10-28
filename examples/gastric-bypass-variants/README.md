# Roux-en-Y gastric bypass: three ways to do it

An illustrative operational model of one clinical goal done on three platforms: laparoscopic
instruments (current practice), a robot of ours, and a competitor's robot. It is a modelling
example with invented numbers, not a clinical protocol or a cost study.

- **Level 1** is the clinical baseline: one use case whose subject is the surgical team, one
  workflow, and steps that carry no number.
- **Level 2** is one use case, workflow and set of activities per platform. Each activity refines
  the level-1 step it carries out and carries the time, the success probability and the
  instruments that make it comparable.
- The platforms are `variant`s of one `variation`; the resources carry their cost rates, in the one
  currency the project declares.
- `bypassTradeStudy` is a native `TradeStudy` that scores each platform's workflow by the roll-ups
  of `memo_architecture_operational_rollups`.

`model/catalog/gastric_bypass_variants.sysml` holds the model.
