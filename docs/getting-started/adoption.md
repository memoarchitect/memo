# Adoption Guide

A team should not begin meMO adoption by modeling the entire product. That is the fastest way to fail. The right starting point is **one useful safety thread**.

## Start with a Thread, Not a Taxonomy

A taxonomy asks the team to classify everything. A safety thread asks the team to model one meaningful path through the system.

The first meMO model should answer a practical question:

> Can we connect one safety concern to the architecture, behavior, verification case, and evidence that support it?

## Choosing the First Product Slice

The first slice should be small, meaningful, and cross-disciplinary. Good candidates include:

- A safety-relevant alarm
- A therapy-control behavior
- A lockout or interlock
- A cybersecurity mitigation with safety impact
- A SOUP-dependent control path
- A configuration or update mechanism
- A user interaction that could create harm if misunderstood

Avoid starting with an entire product architecture, every requirement, or a full risk-management file migration.

## Modeling the Thread Step by Step

### Step 1 — Capture the driver

The driver may be an intended use concern, stakeholder need, hazard, cybersecurity threat, use error, or regulatory concern. Ask: *Why does this requirement exist? What concern caused it?*

### Step 2 — Create the requirement

Express the obligation. meMO distinguishes `SystemRequirement`, `SoftwareRequirement`, and `HardwareRequirement`. Ask: *Is this system-level or software-level? Is it safety-related? What is the source?*

### Step 3 — Connect requirement to architecture

A requirement should be satisfied by something. Use the `SatisfiedBy` relationship. Ask: *Which component satisfies this requirement? Is the responsibility clear?*

### Step 4 — Add interface and behavior

Many safety claims depend on interfaces and behavior. Identify logical interfaces, exchange items, behavior machines, modes, transitions, scenarios, and timing constraints. Ask: *What crosses the boundary? What state matters? What happens on fault or timeout?*

### Step 5 — Connect risk control

Connect the architecture and requirement to hazard and risk-control concepts. Ask: *Which hazard is being controlled? Is the control implemented in software, hardware, labeling, or procedure? Which architecture element implements it?*

### Step 6 — Add verification case and evidence

The thread is not complete until verification and evidence are connected. Ask: *What claim is being verified? What method is used? What are the acceptance criteria? What evidence is produced?*

### Step 7 — Create a view

Make the thread visible. A view may be an architecture view, safety view, verification view, or document-backed view. A model that nobody can read will not survive adoption.

## Adoption by Role

### For startups

Use the core ontology. Model intended use and one or two safety threads. Capture key architecture elements and interfaces. Connect hazards, risk controls, verification cases, and evidence placeholders. Generate lightweight architecture and risk views. Grow into DHF support as the product matures.

The value: early coherence before the process becomes heavy.

### For enterprise teams

Do not begin as a replacement program. meMO can begin as a **semantic bridge** across existing tools.

Select one change-impact problem. Model the architecture slice involved. Import or reference existing requirements and risks. Connect verification and evidence. Use meMO views to support review. Add rules gradually. Integrate with existing tools later.

The value: reducing fragmentation without replacing everything.

### For architects

Model architecture elements, interfaces, behavior, decisions, and relationships to requirements and risk controls. Focus on responsibilities, component boundaries, allocations, deployment, SOUP dependencies, and change impact.

### For safety engineers

Focus on hazards, sequences of events, hazardous situations, harms, risk controls, residual risk, and links to architecture and verification. The model should show which component implements a control — you should not have to guess.

### For verification and regulatory teams

Connect test cases and evidence to claims. Distinguish a verification procedure, the evidence it produces, and the claim it supports. Use document views and review surfaces to reduce ambiguity.

## Adoption Checklists

### First pilot

- [ ] Product slice selected
- [ ] One safety thread selected
- [ ] Core ontology imported
- [ ] Requirement modeled
- [ ] Architecture element modeled
- [ ] Interface or behavior modeled
- [ ] Hazard modeled
- [ ] Risk control modeled
- [ ] Verification case modeled
- [ ] Evidence placeholder modeled
- [ ] One view generated
- [ ] Review completed with architect, safety, and verification leads

### Startup

- [ ] Start with lightweight architecture/risk model
- [ ] Capture intended use and critical safety threads
- [ ] Model key architecture elements and interfaces
- [ ] Connect risk controls to requirements and verification
- [ ] Generate lightweight architecture and risk views
- [ ] Expand toward DHF support over time

### Enterprise

- [ ] Choose one change-impact problem
- [ ] Model the architecture slice
- [ ] Reference existing requirements and risks
- [ ] Connect verification and evidence
- [ ] Add rule checks gradually
- [ ] Define model ownership
- [ ] Integrate with ALM/PLM/QMS only after value is demonstrated

### Architecture review

- [ ] Architecture elements have responsibilities
- [ ] Interfaces have exchanged items and direction
- [ ] Safety-relevant components have safety class
- [ ] SOUP dependencies are identified
- [ ] Requirements are satisfied by architecture elements
- [ ] Risk controls are allocated to architecture or behavior
- [ ] Design decisions include rationale
- [ ] Impact paths are visible

### Safety review

- [ ] Hazards are identified
- [ ] Hazardous situations and harms are modeled
- [ ] Risk controls connect to requirements and architecture
- [ ] Verification cases exist for controls
- [ ] Evidence is connected
- [ ] Residual risk is represented

### Verification review

- [ ] Verification cases identify targets
- [ ] Verification method is explicit
- [ ] Acceptance criteria are captured
- [ ] Evidence artifacts are connected
- [ ] Evidence lifecycle state is known
- [ ] Release baseline impact is understood

## Expanding by Pattern

After the first successful safety thread, expand by pattern — not by mandate:

- Alarm pattern
- Interlock pattern
- SOUP dependency pattern
- Cybersecurity mitigation pattern
- Risk-control verification pattern
- Document-view pattern
- Design-decision pattern

Patterns make adoption scalable.

## Extension Rules

- **Add packages and profiles** — keep the released core ontology stable
- **Extend by specialization** — use `:>` to specialize ontology types, don't modify them
- **Keep your namespace** — put extensions in your own package, not in `memo::`
- **Version your extensions** — track them separately from the ontology version
