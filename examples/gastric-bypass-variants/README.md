# Roux-en-Y gastric bypass: three ways to do it

An illustrative operational model of one clinical goal done on three platforms: laparoscopic
instruments (current practice), a robot of ours, and a competitor's robot. It is a modelling
example with invented numbers, not a clinical protocol or a cost study.

- **Clinical workflow (level 1)** uses each clinical action once, in order, and carries no number.
- **System workflow (level 2)**, one per platform, uses the same action definitions again as usages.
  Time, success probability and instruments are set on the platform's own usage. An action is
  defined once and never copied for the platform that does it; who does it is a `perform` from the
  platform part.
- **Functional workflow (level 3)** is a functional flow of our robot's functions, which a level-2
  usage performs.
- Every occurrence of an action is a usage, so how often a step is repeated is the number of its usages.
- The platforms are `variant`s of one `variation`; the resources carry their cost rates, in the one
  currency the project declares.
- `bypassTradeStudy` is a native `TradeStudy` that scores each platform's workflow by the roll-ups
  of `memo_architecture_operational_rollups`.

`model/catalog/gastric_bypass_variants.sysml` holds the model; `model/catalog/viewpoints/` its flow views.
