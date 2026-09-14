---
title: Internal Block Diagram
viewpoint: VP-DEMO-IBD
---
# Internal Block Diagram

A worked example of a **viewpoint dashboard**: the same page MEMO Architect
generates for every viewpoint, with the placeholders filled in. Compare it with
any other viewpoint's Dashboard entry, which still shows the generated prompts.

> **Purpose** — Lets a design reviewer confirm, from the logical structure
> alone, that water can only reach the cup through the heater, and that every
> heater fault is observable from outside the machine.

## Stakeholders and concerns

| Stakeholder | Concern | How the views below address it |
| --- | --- | --- |
| Design reviewer | **Safety** — no path delivers unheated or overheated water | The machine view shows the single water path: tank → heater → brew group |
| Service engineer | **Reliability** — faults can be diagnosed without disassembly | The heater views show heater status bound out to the service interface |
| Firmware lead | **Performance** — the control loop is closed inside one assembly | The heater assembly view keeps the thermostat and element loop internal |

These rows are commentary. To make them part of the model, set `stakeholders`
and `framedConcerns` on `ibdViewpoint` in the viewpoint package.

## Views

The model currently has {{model.views}} views; three conform to this viewpoint.

### Beverage machine

{{diagram:beverageMachineIBD height=560}}

**Commentary** — Mains water enters on `mainsWaterIn` and is *bound*, not
flowed, to the reservoir: a delegation through the boundary is not a transfer.
The only route to `beverageOut` passes the Thermal Control Assembly. The service
interface nests a `diagnostics` port, which is where a fault becomes visible.

### Heater assembly

{{diagram:heaterAssemblyIBD}}

**Commentary** — The thermostat and the heating element form a closed loop:
power command out, heater status back in. Nothing outside the assembly drives
the element directly, which is the property the firmware lead relies on.

### Heating element

{{diagram:heatingElementIBD}}

**Commentary** — The coil and the temperature sensor are the element's only
parts. The sensor reads heat, not water temperature — an assumption worth
confirming before this structure is reused for a safety argument.

## Open questions

- Should the reservoir have a level sensor port, so an empty tank can inhibit heating? *Owner: design reviewer.*

## Decisions and rationale

- Heater status is exposed through the service interface rather than a dedicated port, so the machine boundary stays at three external ports.
