# Model hardware, step by step

You know SysML v2: parts, ports, connections, flows. This series shows which
**MEMO** element to write at each step, and which relation joins it to the
next. Each lesson adds one idea to the same small model, a handheld **pulse
oximeter**: a main unit and the finger probe that plugs into it.

Every lesson has the same shape:

- **The idea** — one concept, in a few sentences.
- **Write it** — the lines to add.
- **What MEMO adds** — the MEMO element or relation, and why it is that one.
- **The model so far** — the whole file, which compiles as it stands.

You need one file, `pulse_oximeter.sysml`, in a project where MEMO is
installed ([Installing MEMO](../../how-to/install/index.md)). The quickest start
is `npx memo-architect init pulse-oximeter`, with the file in the new project's
`model/catalog/` folder; from lesson 7 on you will also run MEMO's validator
there.

## Lessons

| # | Lesson | You add |
|---|---|---|
| 0 | [Reading the notation](00-reading-the-notation.md) | what `:`, `:>>`, `::`, `@`, `.`, `[*]` and the rest mean |
| 1 | [One part](01-one-part.md) | a package, the MEMO import, a `HardwareAssembly` |
| 2 | [A port](02-a-port.md) | a `PhysicalPort` with a direction |
| 3 | [A nested port](03-a-nested-port.md) | a connector whose pins are ports of their own |
| 4 | [Parts inside parts](04-a-second-part.md) | nested parts, a second unit, patient contact |
| 5 | [Connect them](05-connect-them.md) | `interface … : PhysicalInterface`, and `bind` to reach inside |
| 6 | [What flows](06-what-flows.md) | `flow … : PhysicalTransfer`; flow versus bind |
| 7 | [Recap: the hardware](07-recap-hardware.md) | your `System`, `memo validate`, common mistakes |
| 8 | [Functions](08-functions.md) | `SystemFunction`, `ComponentFunction`, `allocate` |
| 9 | [Requirements on functions](09-requirements.md) | `User`, `Need`, `Requirement`, `DerivesFrom`, `satisfy` |
| 10 | [Risk on functions](10-risk.md) | the hazard chain, failure mode, risk control |
| 11 | [Interfaces as contracts](11-interfaces.md) | interface attributes, the cable, `ConnectionBinding` |
| 12 | [Verify it](12-verify.md) | `VerificationCase`, `verify`, `subject`, evidence |
| 13 | [Recap: the whole slice](13-recap.md) | the traceability picture and every element used |
