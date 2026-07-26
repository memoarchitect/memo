# Safety evidence drifts as the design changes

Medical devices became software-intensive systems. Their safety case is spread
across documents that are traced but not always meaningful, and it loses
alignment as the design evolves.

## Complexity accumulates faster than the evidence

A modern device is rarely one enclosure with one function. It is connected,
configurable, and software-defined, and each of those properties adds coupling
that the safety argument has to account for:

| Where complexity lives | What it means for the argument |
| --- | --- |
| Clinical context | Users, procedures, and environments vary; the hazard depends on which one you are in |
| Connected services | Cloud, updates, telemetry, and fleet data change the device after release |
| Software behavior | Modes, configuration, alarms, and UI decide what the device actually does |
| Hardware and interfaces | Assumptions live in the interface, not in the block diagram |

The consequence is that safety depends on **behavior**, not on requirement
text alone. A requirement can be met by an implementation that is still unsafe
in a mode nobody wrote down.

## Why change is the failure point

Nothing on this list is a problem while the design is stable. Each one becomes
a problem the moment something changes:

- Risk controls cross teams — software, systems, clinical, and V&V — so a
  change to one is not visible to the others.
- Assumptions recorded in an interface are not restated in the requirement
  that depends on them.
- Evidence must follow change, or it silently goes stale. A test report is
  still a valid document after the design it tested has moved on; nothing about
  the document says otherwise.

That last point is the one that matters. Stale evidence does not announce
itself. It looks exactly like current evidence.

## What would have to be true instead

For the argument to survive change, three things have to hold:

1. Each real thing is recorded **once**, so there is no second copy to forget.
2. Each link states **what it claims**, so a change can be followed to the
   claims that depend on it.
3. The result is **computable**, so following those links is a check a tool
   runs, not a review meeting.

MEMO exists to make those three things true of an ordinary engineering model.

[Next: the artifacts are linked, but the links lack meaning →](links-without-meaning.md)
