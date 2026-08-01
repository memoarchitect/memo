# UI screen regions

A focused MEMO example for marking up a screenshot so that every functional
area of the interface is traceable to a function, a specification, and a risk
control — using the part tree MEMO already has, not a parallel one.

- `model/ui_screen_regions.sysml` is the public parent package.
- `model/catalog/` holds the canonical model elements.
- `model/viewpoints/` holds the geometry view and a trace graph of that catalog.

## What it demonstrates

One infusion-pump screen, modelled as an **ordinary part tree**. A screen is a
`UIElement` that contains `UIElement`s; each carries `bounds` (x, y, width,
height). There is no separate "region" type: one tree carries both the geometry
and the design record.

Because the elements carrying geometry are the same elements carrying the
design record, every trace MEMO already supported applies unchanged:

```
elRateValue                     a part, with bounds, inside elRatePanel
  -ElementTriggersAction->  uiaEditRate
     -ActionInvokesFunction->  fnSetInfusionRate     FUNCTION
  <-SatisfiedBy-  reqRateEntry                       SPEC
  <-ErrorAtElement-  ueMisreadRate                   RISK (use error)
  <-ControlImplementedBy-  rcRateConfirm             RISK (control)
```

Layout adds four numbers and two invariants over them — nothing else.

## Containment vs navigation

These are different, and conflating them is the trap this example is built to
show:

| Element | Relation | Meaning |
| --- | --- | --- |
| `elRateValue` inside `elRatePanel` | `Composes` | laid out **within** the parent's box |
| `elSettingsRow` → `elSettingsScreen` | `NavigatesTo` | activation **replaces** the view |

`elSettingsScreen` is a sibling root with its own capture and its own
coordinate frame. It is not a child of anything, so no geometric rule relates
it to the main screen.

## The dropdown, and why `disclosureKind` exists

`elDrugMenu` is why geometry alone is not enough. Open, it extends past the
bottom of the rate panel (`y + height` = 1.35 > 1.0) **and** overlaps
`elRateValue` outright. For an `inline` element both would be layout defects;
for a dropdown both are correct. The four numbers cannot tell those cases apart,
so `disclosureKind = overlay` states the intent — and a renderer reads it to know
not to clip.

Layout correctness is **not** asserted as a consistency rule. Geometric
invariants (child within parent, inline siblings disjoint) cannot be written as
KerML constraint bodies — the evaluator has no Real literal, and it binds one
implicit subject per quantifier, so pairwise sibling comparison is impossible by
construction. Rather than declare rules no engine can evaluate, layout is checked
where it is drawn.

`elStatusBar` is the negative case that IS checked: it is chrome, and it passes
**CR-MED-110** only because it is declared `formKind = decoration`. An element
left unclassified fails. Declaring chrome as chrome is a modelling act, not an
omission.

## Bounds

`RegionBounds` are normalized to the **parent element**, each value in 0..1.
`elRateValue` occupies the lower 65 % of the rate panel, not 65 % of the screen,
so a renderer accumulates transforms down the `Composes` tree. Two things
follow: an element survives re-capture at a different resolution, and a child's
box is stated against its parent, which is exactly what the containment tree
already asserts. Absolute pixels stay recoverable from the capture's
`pixelWidth` / `pixelHeight`.

## Commentary

`ModelComment` elements carry review conversation — author, timestamp,
disposition — attached with `CommentsOn` and threaded with `Composes`.
They are kept separate from `description` on purpose: `description` is what an
element *is*, a comment is what someone *said about it*, and only the former
belongs in a generated DHF section.

## Validation

The example is written to pass the four UI layout rules:

| Rule | Severity | What it enforces |
| --- | --- | --- |
| CR-MED-110 | error | Every non-`decoration` element has a design record (requirement or action) |
| CR-MED-111 | warning | Interactive elements trigger an action that invokes a function |
| CR-MED-112 | warning | Automatically detected bounds are confirmed by a reviewer |
| CR-MED-113 | error | Screen captures identify their build and hash their bytes |

See the caveat in `memo-ui-region-spec.md` §5 about rule evaluation generally —
no ontology rule body currently evaluates.

## Where the images live

Screenshots live in the project repo beside the model, in a folder named for the
layout view that renders them:

```
model/
  assets/
    mainScreenLayout/main-screen-2.4.1.png
    settingsScreenLayout/settings-screen-2.4.1.png
```

`imageUri` is relative to the model root. One layout view per captured screen,
and the view's name is its folder — so it is always obvious which images belong
to which layout.

The image files themselves are **not committed**; this example ships as model
content only, and the `imageHash` values are illustrative. Drop your own
screenshots at those paths to see the geometry view render.
