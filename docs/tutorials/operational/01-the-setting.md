# Lesson 1 · The setting

[Series overview](index.md) · Next: [The goal](02-the-goal.md)

## The idea

Before any step, say where the work happens and who it belongs to. A spot check
of oxygen saturation is done by a ward's nursing team, at the bedside, in a
general ward. Neither is part of the device: they are the world it enters.

MEMO has a definition for each. The team that owns the work is an
`OperationalEntity`; the care setting is a `UseContext`. Start a new file for
them, so the operational model stays apart from the hardware.

## Write it

Create `model/catalog/pulse_oximeter_use.sysml`:

```sysml
package pulse_oximeter_use {
    private import memo::*;
    private import pulse_oximeter::*;

    part wardTeam : OperationalEntity {
        @MemoIdentity { :>> providedId = "OE-1"; :>> label = "Ward nursing team"; }
    }
    part generalWard : UseContext {
        @MemoIdentity { :>> providedId = "CTX-1"; :>> label = "General ward"; }
        attribute :>> careSetting = "general hospital ward";
        attribute :>> environment = "bedside, normal ward lighting";
        attribute :>> connectedUse = false;
    }
}
```

## Line by line

Each line or small group from the code above: its notation, what it says, and why it is written that way. Symbols are collected in [Reading the notation](../hardware/00-reading-the-notation.md).

```sysml
package pulse_oximeter_use {
```

- **Notation.** A second package, in its own file.
- **What it says.** A namespace for the operational model.
- **Why.** The operational model describes the work, not the device, and is reviewed by different people (clinical and usability, not hardware). Its own package keeps the two apart and lets each grow on its own.

```sysml
private import memo::*;
```

- **Notation.** As in the hardware file.
- **What it says.** MEMO's definitions are usable by short name.

```sysml
private import pulse_oximeter::*;
```

- **Notation.** Imports every name in your hardware package.
- **What it says.** The clinician, the need and the system definition from the hardware series can be used here.
- **Why.** The operational model refers to the same clinician and the same need. Importing them, rather than declaring them again, keeps one element for one thing.

```sysml
part wardTeam : OperationalEntity {
```

- **Notation.** A part usage, as in the hardware series.
- **What it says.** There is an operational entity, the ward nursing team.
- **Why.** The level-1 use case in lesson 2 needs a subject that is not the device: the care team whose work it is. `OperationalEntity` is MEMO's definition for an organisation, team or setting that takes part in the work.

```sysml
@MemoIdentity { :>> providedId = "OE-1"; :>> label = "Ward nursing team"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in; `:>> providedId = "…";` gives a value to an attribute the metadata already declares.
- **What it says.** Its engineering id and the name people read.

```sysml
}
```

- **Notation.** Closes the entity.

```sysml
part generalWard : UseContext {
```

- **Notation.** A part usage.
- **What it says.** There is a context of use, the general ward.
- **Why.** IEC 62366-1 asks for the context of use as part of the use specification: the same task is harder in an ambulance than on a ward. `UseContext` holds it as an element, so scenarios and workflows can point at it instead of repeating a sentence.

```sysml
@MemoIdentity { :>> providedId = "CTX-1"; :>> label = "General ward"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in; `:>> providedId = "…";` gives a value to an attribute the metadata already declares.
- **What it says.** Its engineering id and the name people read.

```sysml
attribute :>> careSetting = "general hospital ward";
```

- **Notation.** A text value.
- **What it says.** The care setting.

```sysml
attribute :>> environment = "bedside, normal ward lighting";
```

- **Notation.** A text value.
- **What it says.** The physical environment, in words.
- **Why.** Lighting and noise change how well a user reads a display. When several contexts share one environment, model it as a `UseEnvironment` of its own instead.

```sysml
attribute :>> connectedUse = false;
```

- **Notation.** A Boolean value.
- **What it says.** The oximeter is used without a network connection.
- **Why.** Connected use brings cybersecurity into scope, so the answer is stated rather than assumed.

```sysml
}
}
```

- **Notation.** Close `generalWard`, then the package.

## Tell the project about the file

Add the new package to the project's entrypoint, `model/methodology/project.sysml`,
beside the import of `pulse_oximeter`:

```sysml
    private import pulse_oximeter_use::*;
```

As in [hardware lesson 7](../hardware/07-recap-hardware.md#validate-it): a package
the entrypoint does not import is only partly checked by `memo validate`.

## Validate it

`npx memo validate .` reports nothing new. The one warning left from the hardware
series (the second verification case has no evidence yet) stays until that test
is run.

## The operational file so far

```sysml
package pulse_oximeter_use {
    private import memo::*;
    private import pulse_oximeter::*;

    part wardTeam : OperationalEntity {
        @MemoIdentity { :>> providedId = "OE-1"; :>> label = "Ward nursing team"; }
    }
    part generalWard : UseContext {
        @MemoIdentity { :>> providedId = "CTX-1"; :>> label = "General ward"; }
        attribute :>> careSetting = "general hospital ward";
        attribute :>> environment = "bedside, normal ward lighting";
        attribute :>> connectedUse = false;
    }
}
```

Next: [Lesson 2 · The goal](02-the-goal.md)
