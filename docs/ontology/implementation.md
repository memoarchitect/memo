# Implementation layer

!!! question "The question this layer answers"
    **What is it built from?**

The implementation layer is where technology commitments live, and the only place they live. The logical layer said what blocks exist; this layer says what each one is made of: **software**, **hardware**, or the **user interface** that people touch. Each element here realises something in the logical design.

**Namespace:** `memo::architecture::implementation` · **Source:** `src/architecture/implementation/`

[![The implementation layer: software, hardware and user interface, with the third-party software they depend on](../assets/ontology/implementation.svg){ .memo-presentation-graphic }](../assets/ontology/implementation.svg){ title="Open full size" }

The colours say which part of MEMO an element belongs to: **blue** is
architecture, **red** is assurance. A solid line is one of MEMO's own
relationships, a dashed line is native SysML, a diamond is containment, and a
dotted line is a reference. [How to read the figures](index.md#how-to-read-the-figures)

## How to read this page

Each step below introduces a few elements, then shows them in SysML and explains
every line: its **notation**, **what it says**, and **why** it is written that
way. The example is the pulse oximeter of the [Logical](logical.md) page, now
built: firmware for its processing channel, a finger probe for its sensing
channel, a touchscreen for its display, and a third-party kernel the firmware
runs on. The implementation is a second file beside the Logical page's finished
model, which it imports, because each element here realises a block there. Each
step's code adds to the previous one, and every stage compiles and passes
`memo validate`. The symbols are collected in
[Reading the notation](../tutorials/hardware/00-reading-the-notation.md).

## Building it up
### What this page starts from

Before any software or hardware, the file imports the logical model and states
the requirement chain the implementation answers. Its parts belong to other
pages: users and needs to [Requirements](requirements.md) and
[Human factors](human-factors.md), and the same chain is built step by step in
[Requirements](../tutorials/hardware/09-requirements.md). They are here because
the implementation rules ask that every software requirement comes from a system
requirement, and the chain only passes `memo validate` when it is rooted in a
need someone holds.

#### Write it

The package, its imports, and the requirement chain. Everything in the steps below goes before the closing brace:

```sysml
package layer_implementation {
    private import memo::*;
    private import layer_logical::*;
    private import ModelingMetadata::*;

    part clinician : User {
        @MemoIdentity { :>> label = "Ward clinician"; }
    }
    requirement needReading : Need {
        @MemoIdentity { :>> label = "Oxygen reading"; }
        attribute :>> needKind = NeedKind::clinicalUser;
        doc /* A clinician needs to see the patient's oxygen saturation. */
    }
    requirement reqSpo2Reading : Requirement {
        @MemoIdentity { :>> label = "SpO2 reading"; }
        attribute :>> requirementType = RequirementTypeKind::system;
        doc /* The oximeter shall show an SpO2 reading, updated once per second. */
    }
    connection : HeldBy connect needReading to clinician;
    connection : DerivesFrom connect needReading to reqSpo2Reading;
    satisfy reqSpo2Reading by oximeter;
}
```

#### Line by line

```sysml
package layer_implementation {
```

- **Notation.** `package` opens a namespace; everything up to its `}` belongs to it.
- **What it says.** A package for the implementation model.

```sysml
private import memo::*;
```

- **Notation.** `import memo::*` makes every MEMO name usable here; `private` keeps them inside this package.
- **What it says.** MEMO's definitions can be written by short name.

```sysml
private import layer_logical::*;
```

- **Notation.** The same import, of the Logical page's package.
- **What it says.** The oximeter, its measurement subsystem, its channels and its display can be named here.
- **Why.** The implementation realises the logical design. It is written in its own package, which refers to the logical one, rather than inside it: the logical model stays free of technology, so another implementation of the same design can refine it too.

```sysml
private import ModelingMetadata::*;
```

- **Notation.** `ModelingMetadata` is a SysML standard library package.
- **What it says.** Its metadata can be used here, among it `#refinement`, which step 1 uses.
- **Why.** The `#refinement` keyword is not built into the language: it names the `Refinement` metadata that package declares, so the package must be visible.

```sysml
part clinician : User {
```

- **Notation.** `part` declares a usage; `:` reads "defined by".
- **What it says.** There is a ward clinician who uses the device.

```sysml
@MemoIdentity { :>> label = "Ward clinician"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
}
```

- **Notation.** Closes the user.

```sysml
requirement needReading : Need {
```

- **Notation.** `requirement` declares a requirement usage, defined by MEMO's `Need`.
- **What it says.** A stakeholder need.
- **Why.** A need is the root of a derivation chain: it says what someone needs, not what the device shall do.

```sysml
@MemoIdentity { :>> label = "Oxygen reading"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> needKind = NeedKind::clinicalUser;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value. `NeedKind::clinicalUser` is an enumeration value.
- **What it says.** A clinical user holds it.

```sysml
doc /* A clinician needs to see the patient's oxygen saturation. */
```

- **Notation.** `doc /* … */` is SysML's own documentation comment.
- **What it says.** The text of the need.
- **Why.** A requirement's text is its `doc`; MEMO adds no text attribute.

```sysml
}
```

- **Notation.** Closes the need.

```sysml
requirement reqSpo2Reading : Requirement {
```

- **Notation.** A requirement usage defined by MEMO's `Requirement`.
- **What it says.** A system requirement.

```sysml
@MemoIdentity { :>> label = "SpO2 reading"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> requirementType = RequirementTypeKind::system;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** It is a system requirement, not a software or hardware one.
- **Why.** The type decides which rules apply. A software requirement must derive from a system requirement (CR-MED-011); a system requirement is where that chain starts.

```sysml
doc /* The oximeter shall show an SpO2 reading, updated once per second. */
```

- **Notation.** As above.
- **What it says.** The text of the requirement.

```sysml
}
```

- **Notation.** Closes the requirement.

```sysml
connection : HeldBy connect needReading to clinician;
```

- **Notation.** `connection : HeldBy` declares an unnamed connection defined by MEMO's `HeldBy`; `connect a to b` gives its two ends.
- **What it says.** The clinician holds the need.
- **Why.** A user need that names no user leaves the usability engineering file's input to prose (CR-MED-024, IEC 62366-1 5.1).

```sysml
connection : DerivesFrom connect needReading to reqSpo2Reading;
```

- **Notation.** As above, with `DerivesFrom`; the source comes first.
- **What it says.** The system requirement comes from the need.
- **Why.** A requirement others derive from must itself be justified, and a need is the legitimate root (CR-ONT-080).

```sysml
satisfy reqSpo2Reading by oximeter;
```

- **Notation.** `satisfy R by x` is SysML's own satisfy relationship.
- **What it says.** The oximeter, the logical system, meets the system requirement.
- **Why.** The system as a whole answers a system requirement. The software requirements below say which part of the implementation does what.

```sysml
}
```

- **Notation.** Closes the package.

### Step 1 · Software

[![Step 1: a LogicalComponent RealizedBy a SoftwareModule inside a SoftwareSystem, with its SoftwareComponent, unit and Requirement](../assets/ontology/implementation-step1.svg){ .memo-presentation-graphic }](../assets/ontology/implementation-step1.svg){ title="Open full size" }

IEC 62304 calls any identifiable part of a program a *software item*. MEMO's
base for that concept is `SoftwareElement`, named so because SysML reserves
*item* for things that flow, which is what `DataItem` is. Software is described
in two views. The **module view** (IEC 62304 5.3 to 5.4) has `SoftwareSystem` at
the top and `SoftwareModule`s as the code units with design responsibility; a
module's `moduleKind` says whether it is a software item, a unit, a library and
so on. The **runtime view** has the `SoftwareComponent`, with its timing,
scheduling, health monitoring and fault containment; its `runtimeKind` says what
kind: a process, thread, task, service, container, partition, data store, or
message broker. Neither is placed inside a logical block: a logical component is
allocated to what realizes it (`RealizedBy`), and a runtime component refines
the module it executes (`#refinement`).

`Algorithm`, `DataModel` and `ConfigurationArtifact` describe what a module
holds, but today one cannot sit inside a module: they are not software elements, and a software element contains only software
(CR-ONT-077). The examples declare them beside the modules, with no relation
between the two.

#### Write it

Inside the package, after the requirement chain:

```sysml
requirement reqComputeSpo2 : Requirement {
    @MemoIdentity { :>> label = "Compute SpO2"; }
    attribute :>> requirementType = RequirementTypeKind::software;
    doc /* The firmware shall compute SpO2 from the red and infrared signal
         * once per second. */
}

part firmware : SoftwareSystem {
    @MemoIdentity { :>> label = "Oximeter firmware"; }
    attribute :>> safetyClass = SafetyClassKind::B;
    attribute :>> operatingSystem = "Real-time kernel";

    part spo2Item : SoftwareModule {
        @MemoIdentity { :>> label = "SpO2 computation"; }
        attribute :>> moduleKind = ModuleKind::'item';
        attribute :>> safetyClass = SafetyClassKind::B;
        attribute :>> responsibility = "Compute SpO2 from the photodiode signal";

        part ratioUnit : SoftwareModule {
            @MemoIdentity { :>> label = "Ratio-of-ratios"; }
            attribute :>> moduleKind = ModuleKind::unit;
            attribute :>> safetyClass = SafetyClassKind::B;
            attribute :>> responsibility = "Turn the red and infrared amplitudes into a saturation value";
            attribute :>> implementationLanguage = "C";
        }
    }

    part measurementTask : SoftwareComponent {
        @MemoIdentity { :>> label = "Measurement task"; }
        attribute :>> runtimeKind = RuntimeKind::task;
        attribute :>> periodMs = 20 [milli*s];
        attribute :>> deadlineMs = 20 [milli*s];
        attribute :>> wcetMs = 4 [milli*s];
        attribute :>> schedulingPolicy = SchedulingPolicyKind::fixedPriorityPreemptive;
    }
}
allocation : RealizedBy allocate oximeter.measurement.processing to firmware.spo2Item;
#refinement dependency firmware::measurementTask to firmware::spo2Item;
connection : DerivesFrom connect reqSpo2Reading to reqComputeSpo2;
satisfy reqComputeSpo2 by firmware.spo2Item;
satisfy reqComputeSpo2 by firmware.spo2Item.ratioUnit;
```

#### Line by line

```sysml
requirement reqComputeSpo2 : Requirement {
```

- **Notation.** A requirement usage, as above.
- **What it says.** A software requirement.

```sysml
@MemoIdentity { :>> label = "Compute SpO2"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> requirementType = RequirementTypeKind::software;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** It is a software requirement.
- **Why.** IEC 62304 5.2 asks for software requirements of their own, derived from the system ones; the type is what CR-MED-011 checks.

```sysml
doc /* The firmware shall compute SpO2 from the red and infrared signal
* once per second. */
```

- **Notation.** A `doc` comment may span lines; the leading `*` is layout.
- **What it says.** The text of the requirement.

```sysml
}
```

- **Notation.** Closes the requirement.

```sysml
part firmware : SoftwareSystem {
```

- **Notation.** A part usage defined by MEMO's `SoftwareSystem`.
- **What it says.** The oximeter's firmware, the top of its software.
- **Why.** IEC 62304 decomposes from the software system down, so the system is the root that every module and runtime component of the product sits in.

```sysml
@MemoIdentity { :>> label = "Oximeter firmware"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> safetyClass = SafetyClassKind::B;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value. The values are `none`, `A`, `B` and `C`.
- **What it says.** This example takes the firmware as IEC 62304 class B.
- **Why.** The class (IEC 62304 4.3) follows from the harm a software failure could contribute to, and decides how much of the standard's process applies to the item.

```sysml
attribute :>> operatingSystem = "Real-time kernel";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** What the firmware runs on.
- **Why.** Step 4 models the kernel itself as third-party software; this attribute only names it for a reader.

```sysml
part spo2Item : SoftwareModule {
```

- **Notation.** A part usage inside the firmware's body, defined by `SoftwareModule`.
- **What it says.** The firmware has a module that computes SpO2.
- **Why.** A module is a unit of code with design responsibility. Writing it inside the firmware makes it part of the firmware: software contains software (CR-ONT-077).

```sysml
@MemoIdentity { :>> label = "SpO2 computation"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> moduleKind = ModuleKind::'item';
```

- **Notation.** `'item'` is quoted because `item` is a SysML keyword; a quoted name is the same name written so the parser does not read it as the keyword.
- **What it says.** The module is a software item: it is broken down further.
- **Why.** IEC 62304 distinguishes an item, which is subdivided, from a unit, which is not. The kind is what CR-MED-018 reads.

```sysml
attribute :>> safetyClass = SafetyClassKind::B;
```

- **Notation.** As above.
- **What it says.** This module is class B too.
- **Why.** Every module states its own class (CR-MED-020): a module can be segregated into a lower class than its system.

```sysml
attribute :>> responsibility = "Compute SpO2 from the photodiode signal";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** What the module is for.

```sysml
part ratioUnit : SoftwareModule {
```

- **Notation.** A part usage inside the module.
- **What it says.** The module contains one unit.
- **Why.** A class B or C item is subdivided into software units (CR-MED-018, IEC 62304 5.4).

```sysml
@MemoIdentity { :>> label = "Ratio-of-ratios"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> moduleKind = ModuleKind::unit;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** It is a unit: not broken down further.

```sysml
attribute :>> safetyClass = SafetyClassKind::B;
```

- **Notation.** As above.
- **What it says.** The unit is class B.

```sysml
attribute :>> responsibility = "Turn the red and infrared amplitudes into a saturation value";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** What the unit does.

```sysml
attribute :>> implementationLanguage = "C";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value. It is optional and set only where it applies.
- **What it says.** The unit is written in C.

```sysml
}
```

- **Notation.** Closes the unit.

```sysml
}
```

- **Notation.** Closes the module.

```sysml
part measurementTask : SoftwareComponent {
```

- **Notation.** A part usage defined by `SoftwareComponent`, also inside the firmware.
- **What it says.** The firmware runs a measurement task.
- **Why.** The module view says how the code is divided; the runtime view says what executes, when and how often. One module can run in several tasks and one task can run several modules, so they are separate elements.

```sysml
@MemoIdentity { :>> label = "Measurement task"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> runtimeKind = RuntimeKind::task;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** It is a task in the kernel.

```sysml
attribute :>> periodMs = 20 [milli*s];
attribute :>> deadlineMs = 20 [milli*s];
attribute :>> wcetMs = 4 [milli*s];
```

- **Notation.** A number with a unit in brackets is a quantity value; `milli*s` is milliseconds, written with the SI prefix.
- **What it says.** The task runs every 20 ms, must finish within 20 ms, and takes at most 4 ms.
- **Why.** These are quantities, not strings, so a rule can compare them: a worst-case execution time over the deadline is reported (QT-004).

```sysml
attribute :>> schedulingPolicy = SchedulingPolicyKind::fixedPriorityPreemptive;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** The kernel schedules it by fixed priority with preemption.

```sysml
}
```

- **Notation.** Closes the task.

```sysml
}
```

- **Notation.** Closes the firmware.

```sysml
allocation : RealizedBy allocate oximeter.measurement.processing to firmware.spo2Item;
```

- **Notation.** `allocation : RealizedBy` declares an unnamed SysML allocation defined by MEMO's `RealizedBy`; `allocate a to b` gives its ends, the logical component first.
- **What it says.** The logical processing channel is realized by the SpO2 module.
- **Why.** A software module placed inside a logical component would mix the two hierarchies, and the rules reject it (CR-ONT-078, CR-ONT-077). The ontology joins the two structures with this allocation instead, the way SysML joins structures across domains; its ends are typed, so a reversed one is reported.

```sysml
#refinement dependency firmware::measurementTask to firmware::spo2Item;
```

- **Notation.** `dependency a to b` is SysML's dependency, from client to supplier; `#refinement` marks it as a refinement. Its ends are qualified names, written with `::`, while `allocate`, `satisfy` and `connect` take feature chains written with `.` (SysML textual BNF, `DependencyDeclaration` and `SatisfactionReferenceExpression`).
- **What it says.** The task realises the module.
- **Why.** This is a realization inside the software, not of a logical block, so it is the general `#refinement`. Every runtime component traces to the module-view element it executes (CR-ONT-011).

```sysml
connection : DerivesFrom connect reqSpo2Reading to reqComputeSpo2;
```

- **Notation.** As above.
- **What it says.** The software requirement comes from the system requirement.
- **Why.** Software requirements derive from system requirements (CR-MED-011, IEC 62304 5.2).

```sysml
satisfy reqComputeSpo2 by firmware.spo2Item;
satisfy reqComputeSpo2 by firmware.spo2Item.ratioUnit;
```

- **Notation.** `firmware.spo2Item` is a feature chain: the `spo2Item` of `firmware`.
- **What it says.** The module and its unit both meet the requirement.
- **Why.** Each software item is linked to its requirements (CR-MED-021, a warning). The rule applies to every module, so the unit needs its own link.

### Step 2 · Hardware

[![Step 2: a LogicalComponent RealizedBy a HardwareAssembly holding an OpticalComponent, a Sensor and a HardwareComponent](../assets/ontology/implementation-step2.svg){ .memo-presentation-graphic }](../assets/ontology/implementation-step2.svg){ title="Open full size" }

`PhysicalElement` is the root of a physical taxonomy: `PhysicalAssembly` and
`PhysicalSubassembly`, `HardwareAssembly`, `PhysicalComponent` and
`HardwareComponent`. Below them are electrical and electronic parts
(`PowerSupply`, `Battery`, `Cable`, `NetworkMedium`), fluidic and pneumatic
parts, mechanical parts and enclosures, optical, acoustic and thermal
components, and the `Sensor`s and `Actuator`s that meet the physical world.
Choose the most specific one that fits: each adds the attributes its kind of
part is assessed on. An assembly carries unit-level properties (IP rating,
protection class, MTBF); a component carries item-level ones (material and
patient contact). The [hardware series](../tutorials/hardware/index.md) builds
the same probe with its ports, cable and connector.

#### Write it

After the firmware's links:

```sysml
part probe : HardwareAssembly {
    @MemoIdentity { :>> label = "Finger probe"; }
    attribute :>> responsibility = "Shine light through the finger and measure what comes out";
    attribute :>> ipRating = "IP22";

    part emitter : OpticalComponent {
        @MemoIdentity { :>> label = "LED pair"; }
        attribute :>> opticalFunction = "Emit red and infrared light";
        attribute :>> wavelengthRange = "660 nm and 940 nm";
        attribute :>> patientContact = false;
    }
    part photodiode : Sensor {
        @MemoIdentity { :>> label = "Photodiode"; }
        attribute :>> measurand = "Light transmitted through the finger";
        attribute :>> rangeSummary = "600 nm to 1000 nm";
        attribute :>> patientContact = false;
    }
    part fingerPad : HardwareComponent {
        @MemoIdentity { :>> label = "Finger pad"; }
        attribute :>> materialSummary = "Medical-grade silicone";
        attribute :>> patientContact = true;
        attribute :>> contactNature = "Intact skin";
        attribute :>> contactDuration = "Limited, under 24 hours";
    }
}
allocation : RealizedBy allocate oximeter.measurement.sensing to probe;
```

#### Line by line

```sysml
part probe : HardwareAssembly {
```

- **Notation.** A part usage defined by MEMO's `HardwareAssembly`.
- **What it says.** The finger probe, an assembly of parts.
- **Why.** An assembly is a unit that is built, tested and rated as a whole, so it carries unit-level properties such as its IP rating ([why `HardwareAssembly`](../tutorials/hardware/01-one-part.md#why-hardwareassembly)).

```sysml
@MemoIdentity { :>> label = "Finger probe"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> responsibility = "Shine light through the finger and measure what comes out";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** What the probe is for.

```sysml
attribute :>> ipRating = "IP22";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** Its ingress protection rating.
- **Why.** IEC 60529 rates the enclosed unit, so the rating sits on the assembly, not on the parts inside it.

```sysml
part emitter : OpticalComponent {
```

- **Notation.** A part usage inside the probe, defined by `OpticalComponent`.
- **What it says.** The probe contains an LED pair.
- **Why.** An assembly contains only physical things (CR-ONT-079). `OpticalComponent` adds what an optical part is specified by: its function and wavelengths.

```sysml
@MemoIdentity { :>> label = "LED pair"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> opticalFunction = "Emit red and infrared light";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** What it does with light.

```sysml
attribute :>> wavelengthRange = "660 nm and 940 nm";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** The two wavelengths it emits.
- **Why.** Pulse oximetry compares absorption at a red and an infrared wavelength, so the wavelengths are part of the design.

```sysml
attribute :>> patientContact = false;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** The LEDs do not touch the patient.
- **Why.** The patient-contact rule (CR-ONT-032) counts a component that does not state its contact as failing, so every physical component says yes or no.

```sysml
}
```

- **Notation.** Closes the LED pair.

```sysml
part photodiode : Sensor {
```

- **Notation.** A part usage defined by `Sensor`.
- **What it says.** The probe contains a photodiode.
- **Why.** A `Sensor` adds what verification of a sensor needs: what it measures, over what range, and how accurately.

```sysml
@MemoIdentity { :>> label = "Photodiode"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> measurand = "Light transmitted through the finger";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** What it measures.

```sysml
attribute :>> rangeSummary = "600 nm to 1000 nm";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** The wavelengths it responds to.

```sysml
attribute :>> patientContact = false;
```

- **Notation.** As above.
- **What it says.** It does not touch the patient either.

```sysml
}
```

- **Notation.** Closes the photodiode.

```sysml
part fingerPad : HardwareComponent {
```

- **Notation.** A part usage defined by `HardwareComponent`.
- **What it says.** The probe contains the pad the finger rests on.
- **Why.** Nothing more specific fits a moulded pad, so it takes the general component definition, which still carries material and patient contact.

```sysml
@MemoIdentity { :>> label = "Finger pad"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> materialSummary = "Medical-grade silicone";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** What it is made of.
- **Why.** Biocompatibility is assessed on the material of what touches the patient.

```sysml
attribute :>> patientContact = true;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** The pad touches the patient.

```sysml
attribute :>> contactNature = "Intact skin";
attribute :>> contactDuration = "Limited, under 24 hours";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** What it touches, and for how long.
- **Why.** ISO 10993-1 categorises a contacting part by the nature and duration of contact, and those categories decide the biological evaluation. A component in contact must state both (CR-ONT-032).

```sysml
}
```

- **Notation.** Closes the pad.

```sysml
}
```

- **Notation.** Closes the probe.

```sysml
allocation : RealizedBy allocate oximeter.measurement.sensing to probe;
```

- **Notation.** As in step 1.
- **What it says.** The logical sensing channel is realized by the probe.
- **Why.** The sensing channel was marked `systemType = hardware` on the Logical page; this is the hardware that keeps the promise.

### Step 3 · User interface

[![Step 3: a LogicalComponent RealizedBy a UserInterface; a button UIElement triggers a UIAction that performs a SystemFunction](../assets/ontology/implementation-step3.svg){ .memo-presentation-graphic }](../assets/ontology/implementation-step3.svg){ title="Open full size" }

A `UserInterface` is what the user operates, and a `UIElement` is one element of
it, such as a screen, a banner or a button. There is one element definition:
whether it is a screen that holds others, a control, or a readout is its
`formKind`, so a screen's contents are an ordinary part tree. A `UIElement` is a
software element. A control the user physically touches, a knob or a push
button, is an `OperatorInterfaceElement` instead, a physical component that
carries material and patient contact. A `UIAction` is an operative action,
because pressing a button has a trigger, a precondition, a criticality and a
potential harm, just as turning a knob does. A UI element triggers a UI action
(`ElementTriggersAction`), and the action `perform`s a function. `UIState` and
`UIEvent` describe the interface's behaviour; an `InteractionFlow` is a reusable
dialogue structure, and one path through it is an `OperativeScenario` of kind
`ui`. `ScreenCapture` and `RegionBounds` tie the model to real screen layouts
(`CapturesScreen`).

#### Write it

A software requirement for the display, after the first one:

```sysml
requirement reqShowReading : Requirement {
    @MemoIdentity { :>> label = "Show the reading"; }
    attribute :>> requirementType = RequirementTypeKind::software;
    doc /* The display shall show the latest SpO2 reading in percent. */
}
```

After the probe:

```sysml
part frontPanel : UserInterface {
    @MemoIdentity { :>> label = "Front panel"; }
    attribute :>> modality = "Visual, touch";
    attribute :>> uiTechnology = "Colour touchscreen";

    part readingScreen : UIElement {
        @MemoIdentity { :>> label = "Reading screen"; }
        attribute :>> formKind = UIElementFormKind::screen;

        part spo2Readout : UIElement {
            @MemoIdentity { :>> label = "SpO2 readout"; }
            attribute :>> formKind = UIElementFormKind::textMessage;
            attribute :>> unitsDisplayed = "%";
            attribute :>> updateRate = "Once per second";
        }
        part spotCheckButton : UIElement {
            @MemoIdentity { :>> label = "Spot-check button"; }
            attribute :>> formKind = UIElementFormKind::button;
            attribute :>> labelText = "Spot check";
        }
    }
}
allocation : RealizedBy allocate oximeter.display to frontPanel;
connection : DerivesFrom connect reqSpo2Reading to reqShowReading;
satisfy reqShowReading by frontPanel.readingScreen;
satisfy reqShowReading by frontPanel.readingScreen.spo2Readout;

action fnMeasureSpO2 : SystemFunction {
    @MemoIdentity { :>> label = "Measure oxygen saturation"; }
}
action startSpotCheck : UIAction {
    @MemoIdentity { :>> label = "Start a spot check"; }
    attribute :>> intent = InteractionIntentKind::userInput;
    attribute :>> feedbackProvided = "The readout shows a spinner until the reading settles";
    perform fnMeasureSpO2;
}
connection : ElementTriggersAction connect frontPanel.readingScreen.spotCheckButton to startSpotCheck;
allocate fnMeasureSpO2 to firmware.measurementTask;
```

#### Line by line

```sysml
requirement reqShowReading : Requirement {
```

- **Notation.** As in step 1.
- **What it says.** A second software requirement.

```sysml
@MemoIdentity { :>> label = "Show the reading"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> requirementType = RequirementTypeKind::software;
```

- **Notation.** As in step 1.
- **What it says.** It is a software requirement.

```sysml
doc /* The display shall show the latest SpO2 reading in percent. */
```

- **Notation.** As above.
- **What it says.** The text of the requirement.

```sysml
}
```

- **Notation.** Closes the requirement.

```sysml
part frontPanel : UserInterface {
```

- **Notation.** A part usage defined by MEMO's `UserInterface`.
- **What it says.** The oximeter has a front panel the clinician operates.

```sysml
@MemoIdentity { :>> label = "Front panel"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> modality = "Visual, touch";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** The user reads it and touches it.

```sysml
attribute :>> uiTechnology = "Colour touchscreen";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** It is a touchscreen.
- **Why.** The technology decides which element definition the controls take: rendered on a screen, they are software and `UIElement`; a moulded push button would be an `OperatorInterfaceElement`.

```sysml
part readingScreen : UIElement {
```

- **Notation.** A part usage inside the panel, defined by `UIElement`.
- **What it says.** The panel shows a reading screen.

```sysml
@MemoIdentity { :>> label = "Reading screen"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> formKind = UIElementFormKind::screen;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** This element is a screen.
- **Why.** A screen is not a different kind of thing from a button: it is an element that holds others. Making the form a value rather than a definition keeps the whole interface one part tree, which requirements, use errors and risk controls can all point into.

```sysml
part spo2Readout : UIElement {
```

- **Notation.** A part usage inside the screen.
- **What it says.** The screen holds the SpO2 readout.
- **Why.** Nesting is containment, so the screen's layout is the tree as written.

```sysml
@MemoIdentity { :>> label = "SpO2 readout"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> formKind = UIElementFormKind::textMessage;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** It presents text: the number.

```sysml
attribute :>> unitsDisplayed = "%";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** It shows the reading in percent.
- **Why.** The displayed unit is a use-error risk of its own, so it is stated where it is shown.

```sysml
attribute :>> updateRate = "Once per second";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** How often it refreshes.

```sysml
}
```

- **Notation.** Closes the readout.

```sysml
part spotCheckButton : UIElement {
```

- **Notation.** A part usage inside the screen.
- **What it says.** The screen holds a button.

```sysml
@MemoIdentity { :>> label = "Spot-check button"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> formKind = UIElementFormKind::button;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** It is a button the user presses.
- **Why.** A control (button, selector, slider, field) should trigger an action, or the model does not say what it is for (CR-MED-111).

```sysml
attribute :>> labelText = "Spot check";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** The text on the button.

```sysml
}
```

- **Notation.** Closes the button.

```sysml
}
```

- **Notation.** Closes the screen.

```sysml
}
```

- **Notation.** Closes the panel.

```sysml
allocation : RealizedBy allocate oximeter.display to frontPanel;
```

- **Notation.** As in step 1.
- **What it says.** The logical display is realized by the front panel.

```sysml
connection : DerivesFrom connect reqSpo2Reading to reqShowReading;
```

- **Notation.** As in step 1.
- **What it says.** The display requirement comes from the system requirement.

```sysml
satisfy reqShowReading by frontPanel.readingScreen;
satisfy reqShowReading by frontPanel.readingScreen.spo2Readout;
```

- **Notation.** As in step 1.
- **What it says.** The screen and the readout meet the display requirement.
- **Why.** Every UI element other than decoration needs a design record: a requirement it satisfies or an action it triggers (CR-MED-110). The readout triggers nothing, so it satisfies a requirement.

```sysml
action fnMeasureSpO2 : SystemFunction {
```

- **Notation.** `action` declares an action usage, defined by MEMO's `SystemFunction`.
- **What it says.** The function of measuring oxygen saturation.
- **Why.** In a full model this is the [Functional](functional.md) page's function. It is declared here only so the UI action below has a function to perform.

```sysml
@MemoIdentity { :>> label = "Measure oxygen saturation"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
}
```

- **Notation.** Closes the function.

```sysml
action startSpotCheck : UIAction {
```

- **Notation.** An action usage defined by `UIAction`.
- **What it says.** Starting a spot check is something the user does at the interface.
- **Why.** A UI action is an operative action, so it carries what any user action is assessed on, and a use error can be committed by it.

```sysml
@MemoIdentity { :>> label = "Start a spot check"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> intent = InteractionIntentKind::userInput;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** The user is giving the device an input.

```sysml
attribute :>> feedbackProvided = "The readout shows a spinner until the reading settles";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** What the user sees in return.
- **Why.** Feedback is how the user knows the action took effect; a missing one is a classic use-error cause.

```sysml
perform fnMeasureSpO2;
```

- **Notation.** `perform` is SysML's own: the action carries out the named action.
- **What it says.** Pressing the button runs the measurement.
- **Why.** This is how a UI action reaches a function. No MEMO relation is needed.

```sysml
}
```

- **Notation.** Closes the UI action.

```sysml
connection : ElementTriggersAction connect frontPanel.readingScreen.spotCheckButton to startSpotCheck;
```

- **Notation.** As in step 1, with `ElementTriggersAction`; an end can be a feature chain into the screen.
- **What it says.** The button triggers the action.
- **Why.** This is the button's design record (CR-MED-110, CR-MED-111).

```sysml
allocate fnMeasureSpO2 to firmware.measurementTask;
```

- **Notation.** `allocate a to b` is SysML's own allocation.
- **What it says.** The measurement task carries out the function.
- **Why.** Functions are allocated to the implementation elements that execute them (CR-MED-022, a warning).

### Step 4 · Third-party software

[![Step 4: a SoftwareModule DependsOnSoup an OTSSoftwareModule, listed by an SBOMEntry in the SoftwareBillOfMaterials](../assets/ontology/implementation-step4.svg){ .memo-presentation-graphic }](../assets/ontology/implementation-step4.svg){ title="Open full size" }

A SOUP item (IEC 62304's software of unknown provenance) is a
`SOUPSoftwareModule`: software the manufacturer did not develop under its own
process, or legacy code without development records. An `OTSSoftwareModule` is
the off-the-shelf kind and adds what a bought or downloaded package is
identified by: its license, package URL and checksum. Any element can depend on
a SOUP element (`DependsOnSoup`). An `SBOMEntry` records one component in the
software bill of materials, a `SoftwareBillOfMaterials`. The SBOM is a record of
what shipped, kept apart from the design module it lists.

#### Write it

A requirement on the kernel, after the others:

```sysml
requirement reqRtosScheduling : Requirement {
    @MemoIdentity { :>> label = "Kernel scheduling"; }
    attribute :>> requirementType = RequirementTypeKind::software;
    doc /* The kernel shall run the measurement task every 20 ms with
         * fixed-priority preemption. */
}
```

Inside the firmware, after the measurement task:

```sysml
part rtosKernel : OTSSoftwareModule {
    @MemoIdentity { :>> label = "Real-time kernel"; }
    attribute :>> moduleKind = ModuleKind::'library';
    attribute :>> safetyClass = SafetyClassKind::B;
    attribute :>> supplier = "Kernel supplier";
    attribute :>> version = "10.6.2";
    attribute :>> knownAnomalies = "The supplier's published anomaly list was reviewed; none affects the scheduling this firmware uses";
    attribute :>> soupClassification = SOUPClassificationKind::classB;
    attribute :>> licenseExpression = "MIT";
    attribute :>> packageUrl = "pkg:generic/rtos-kernel@10.6.2";
    attribute :>> checksum = "sha256:3f2a9c";
}
```

After the front panel's links:

```sysml
connection : DependsOnSoup connect firmware.spo2Item to firmware.rtosKernel;
connection : DerivesFrom connect reqSpo2Reading to reqRtosScheduling;
satisfy reqRtosScheduling by firmware.rtosKernel;

part sbom : SoftwareBillOfMaterials {
    @MemoIdentity { :>> label = "Firmware SBOM"; }
    attribute :>> sbomFormat = SbomFormatKind::spdx;
    attribute :>> specVersion = "2.3";

    part rtosEntry : SBOMEntry {
        attribute :>> componentName = "rtos-kernel";
        attribute :>> version = "10.6.2";
        attribute :>> supplier = "Kernel supplier";
        attribute :>> packageUrl = "pkg:generic/rtos-kernel@10.6.2";
        ref :>> inventoriedElement = firmware.rtosKernel;
    }
}
```

#### Line by line

```sysml
requirement reqRtosScheduling : Requirement {
```

- **Notation.** As in step 1.
- **What it says.** A requirement on the kernel.
- **Why.** IEC 62304 5.3.3 asks for the functional and performance requirements the software needs from a SOUP item; CR-MED-017 checks that one is linked.

```sysml
@MemoIdentity { :>> label = "Kernel scheduling"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> requirementType = RequirementTypeKind::software;
```

- **Notation.** As in step 1.
- **What it says.** It is a software requirement.

```sysml
doc /* The kernel shall run the measurement task every 20 ms with
* fixed-priority preemption. */
```

- **Notation.** As in step 1.
- **What it says.** The text of the requirement.

```sysml
}
```

- **Notation.** Closes the requirement.

```sysml
part rtosKernel : OTSSoftwareModule {
```

- **Notation.** A part usage inside the firmware, defined by `OTSSoftwareModule`.
- **What it says.** The firmware includes a bought-in real-time kernel.
- **Why.** It ships inside the firmware, so it is written there: software contains software. Being a SOUP type rather than a module with a flag is what brings the SOUP rules to it.

```sysml
@MemoIdentity { :>> label = "Real-time kernel"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> moduleKind = ModuleKind::'library';
```

- **Notation.** Quoted because `library` is a SysML keyword, as `'item'` was.
- **What it says.** It is a library.

```sysml
attribute :>> safetyClass = SafetyClassKind::B;
```

- **Notation.** As in step 1.
- **What it says.** It is class B, like the code that uses it.
- **Why.** A SOUP module is a software module, so it needs a class too (CR-MED-020).

```sysml
attribute :>> supplier = "Kernel supplier";
attribute :>> version = "10.6.2";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** Who supplies it and which version is used.
- **Why.** A SOUP item is identified by its supplier and version (CR-MED-016, IEC 62304 8.1.2).

```sysml
attribute :>> knownAnomalies = "The supplier's published anomaly list was reviewed; none affects the scheduling this firmware uses";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** The outcome of reviewing its known bugs.
- **Why.** The published anomaly list of a SOUP item is evaluated for the device (CR-MED-015, IEC 62304 7.1.3).

```sysml
attribute :>> soupClassification = SOUPClassificationKind::classB;
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** Its class as a SOUP item.

```sysml
attribute :>> licenseExpression = "MIT";
attribute :>> packageUrl = "pkg:generic/rtos-kernel@10.6.2";
attribute :>> checksum = "sha256:3f2a9c";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value. The checksum is shortened here.
- **What it says.** Its license, its package identifier and the hash of what was received.
- **Why.** These identify the package as acquired, which is what makes it off-the-shelf rather than legacy code: that is why they sit on `OTSSoftwareModule` and not on every SOUP item.

```sysml
}
```

- **Notation.** Closes the kernel.

```sysml
connection : DependsOnSoup connect firmware.spo2Item to firmware.rtosKernel;
```

- **Notation.** As in step 1, with `DependsOnSoup`.
- **What it says.** The SpO2 module depends on the kernel.
- **Why.** Which design elements rely on a SOUP item is what tells an anomaly review which parts of the device a kernel bug could reach.

```sysml
connection : DerivesFrom connect reqSpo2Reading to reqRtosScheduling;
```

- **Notation.** As in step 1.
- **What it says.** The kernel requirement comes from the system requirement.

```sysml
satisfy reqRtosScheduling by firmware.rtosKernel;
```

- **Notation.** As in step 1.
- **What it says.** The kernel meets it.

```sysml
part sbom : SoftwareBillOfMaterials {
```

- **Notation.** A part usage defined by `SoftwareBillOfMaterials`, at package level.
- **What it says.** The firmware has a software bill of materials.
- **Why.** The SBOM is a document of what shipped, not a part of the software, so it is not written inside the firmware.

```sysml
@MemoIdentity { :>> label = "Firmware SBOM"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element it sits in; `:>> label = "…";` gives a value to an attribute the metadata declares.
- **What it says.** Its display name.

```sysml
attribute :>> sbomFormat = SbomFormatKind::spdx;
attribute :>> specVersion = "2.3";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** It is an SPDX 2.3 document.

```sysml
part rtosEntry : SBOMEntry {
```

- **Notation.** A part usage inside the SBOM.
- **What it says.** The SBOM has an entry for the kernel.

```sysml
attribute :>> componentName = "rtos-kernel";
attribute :>> version = "10.6.2";
attribute :>> supplier = "Kernel supplier";
attribute :>> packageUrl = "pkg:generic/rtos-kernel@10.6.2";
```

- **Notation.** `attribute :>>` redefines an attribute the type declares and gives it a value.
- **What it says.** What the entry records about the kernel as shipped.

```sysml
ref :>> inventoriedElement = firmware.rtosKernel;
```

- **Notation.** `ref :>>` redefines a reference the type declares; `= firmware.rtosKernel` binds it to that element.
- **What it says.** The entry is the kernel module's.
- **Why.** The entry points at the design element, so a vulnerability recorded against the entry can be traced to the code that uses it.

```sysml
}
```

- **Notation.** Closes the entry.

```sysml
}
```

- **Notation.** Closes the SBOM.

## Where it leads

- **Up to [Logical](logical.md):** a logical component is allocated to the implementation element that realizes it, `allocation : RealizedBy allocate <logical> to <implementation>`.
- **Up to [Functional](functional.md) and [Operational](operational.md):** a `UIAction` `perform`s a function, an interaction flow serves a use case (`FlowServesUseCase`), and the interface supports operational tasks with a native `dependency`.
- **Down to [Realization](realization.md):** modules build into deployment units (`BuildsInto`), runtime components bind to memory (`MemoryBinding`), and exchanges bind to a network medium (`ConnectionBinding`).
- **Across to assurance:** a risk control is implemented by an implementation element (`ControlImplementedBy`), and a use error happens at an element (`ErrorAtElement`) ([Safety and risk](safety-risk.md), [Human factors](human-factors.md)).

## Rules that check this layer

Each was triggered deliberately on a model like this one, under both supported
compilers, to confirm `memo validate` reports it:

| Mistake | Reported by |
|---|---|
| a software module with no safety class | CR-MED-020 |
| a class B or C software item with no unit inside it | CR-MED-018 (warning) |
| a software module that satisfies no requirement | CR-MED-021 (warning) |
| a software requirement derived from nothing | CR-MED-011 |
| a runtime component that refines no module | CR-ONT-011 (warning) |
| a logical component linked to its realization with `#refinement` instead of `RealizedBy` | CR-ONT-105 |
| a worst-case execution time over the deadline | QT-004 (warning) |
| anything not software inside a software element, an `Algorithm` included | CR-ONT-077, once for every software element above it |
| anything not physical inside a hardware part | CR-ONT-079 |
| a physical component that does not state its patient contact, or states contact without its nature and duration | CR-ONT-032 |
| a UI element with no requirement and no action | CR-MED-110 |
| a button, selector, slider or field that triggers no action | CR-MED-111 (warning), with CR-MED-110 |
| a SOUP item with no supplier or version | CR-MED-016 (warning) |
| a SOUP item with no anomaly review | CR-MED-015 (warning) |
| a SOUP item that satisfies no requirement | CR-MED-017 (warning), with CR-MED-021 |

<details markdown="1">
<summary><strong>The whole example</strong> (all four stages; compiles and validates beside the
<a href="../logical/#rules-that-check-this-layer">Logical page's whole example</a>)</summary>

```sysml
package layer_implementation {
    private import memo::*;
    private import layer_logical::*;
    private import ModelingMetadata::*;

    part clinician : User {
        @MemoIdentity { :>> label = "Ward clinician"; }
    }
    requirement needReading : Need {
        @MemoIdentity { :>> label = "Oxygen reading"; }
        attribute :>> needKind = NeedKind::clinicalUser;
        doc /* A clinician needs to see the patient's oxygen saturation. */
    }
    requirement reqSpo2Reading : Requirement {
        @MemoIdentity { :>> label = "SpO2 reading"; }
        attribute :>> requirementType = RequirementTypeKind::system;
        doc /* The oximeter shall show an SpO2 reading, updated once per second. */
    }
    connection : HeldBy connect needReading to clinician;
    connection : DerivesFrom connect needReading to reqSpo2Reading;
    satisfy reqSpo2Reading by oximeter;

    requirement reqComputeSpo2 : Requirement {
        @MemoIdentity { :>> label = "Compute SpO2"; }
        attribute :>> requirementType = RequirementTypeKind::software;
        doc /* The firmware shall compute SpO2 from the red and infrared signal
             * once per second. */
    }
    requirement reqShowReading : Requirement {
        @MemoIdentity { :>> label = "Show the reading"; }
        attribute :>> requirementType = RequirementTypeKind::software;
        doc /* The display shall show the latest SpO2 reading in percent. */
    }
    requirement reqRtosScheduling : Requirement {
        @MemoIdentity { :>> label = "Kernel scheduling"; }
        attribute :>> requirementType = RequirementTypeKind::software;
        doc /* The kernel shall run the measurement task every 20 ms with
             * fixed-priority preemption. */
    }

    part firmware : SoftwareSystem {
        @MemoIdentity { :>> label = "Oximeter firmware"; }
        attribute :>> safetyClass = SafetyClassKind::B;
        attribute :>> operatingSystem = "Real-time kernel";

        part spo2Item : SoftwareModule {
            @MemoIdentity { :>> label = "SpO2 computation"; }
            attribute :>> moduleKind = ModuleKind::'item';
            attribute :>> safetyClass = SafetyClassKind::B;
            attribute :>> responsibility = "Compute SpO2 from the photodiode signal";

            part ratioUnit : SoftwareModule {
                @MemoIdentity { :>> label = "Ratio-of-ratios"; }
                attribute :>> moduleKind = ModuleKind::unit;
                attribute :>> safetyClass = SafetyClassKind::B;
                attribute :>> responsibility = "Turn the red and infrared amplitudes into a saturation value";
                attribute :>> implementationLanguage = "C";
            }
        }

        part measurementTask : SoftwareComponent {
            @MemoIdentity { :>> label = "Measurement task"; }
            attribute :>> runtimeKind = RuntimeKind::task;
            attribute :>> periodMs = 20 [milli*s];
            attribute :>> deadlineMs = 20 [milli*s];
            attribute :>> wcetMs = 4 [milli*s];
            attribute :>> schedulingPolicy = SchedulingPolicyKind::fixedPriorityPreemptive;
        }

        part rtosKernel : OTSSoftwareModule {
            @MemoIdentity { :>> label = "Real-time kernel"; }
            attribute :>> moduleKind = ModuleKind::'library';
            attribute :>> safetyClass = SafetyClassKind::B;
            attribute :>> supplier = "Kernel supplier";
            attribute :>> version = "10.6.2";
            attribute :>> knownAnomalies = "The supplier's published anomaly list was reviewed; none affects the scheduling this firmware uses";
            attribute :>> soupClassification = SOUPClassificationKind::classB;
            attribute :>> licenseExpression = "MIT";
            attribute :>> packageUrl = "pkg:generic/rtos-kernel@10.6.2";
            attribute :>> checksum = "sha256:3f2a9c";
        }
    }
    allocation : RealizedBy allocate oximeter.measurement.processing to firmware.spo2Item;
    #refinement dependency firmware::measurementTask to firmware::spo2Item;
    connection : DerivesFrom connect reqSpo2Reading to reqComputeSpo2;
    satisfy reqComputeSpo2 by firmware.spo2Item;
    satisfy reqComputeSpo2 by firmware.spo2Item.ratioUnit;
    connection : DependsOnSoup connect firmware.spo2Item to firmware.rtosKernel;
    connection : DerivesFrom connect reqSpo2Reading to reqRtosScheduling;
    satisfy reqRtosScheduling by firmware.rtosKernel;

    part sbom : SoftwareBillOfMaterials {
        @MemoIdentity { :>> label = "Firmware SBOM"; }
        attribute :>> sbomFormat = SbomFormatKind::spdx;
        attribute :>> specVersion = "2.3";

        part rtosEntry : SBOMEntry {
            attribute :>> componentName = "rtos-kernel";
            attribute :>> version = "10.6.2";
            attribute :>> supplier = "Kernel supplier";
            attribute :>> packageUrl = "pkg:generic/rtos-kernel@10.6.2";
            ref :>> inventoriedElement = firmware.rtosKernel;
        }
    }

    part probe : HardwareAssembly {
        @MemoIdentity { :>> label = "Finger probe"; }
        attribute :>> responsibility = "Shine light through the finger and measure what comes out";
        attribute :>> ipRating = "IP22";

        part emitter : OpticalComponent {
            @MemoIdentity { :>> label = "LED pair"; }
            attribute :>> opticalFunction = "Emit red and infrared light";
            attribute :>> wavelengthRange = "660 nm and 940 nm";
            attribute :>> patientContact = false;
        }
        part photodiode : Sensor {
            @MemoIdentity { :>> label = "Photodiode"; }
            attribute :>> measurand = "Light transmitted through the finger";
            attribute :>> rangeSummary = "600 nm to 1000 nm";
            attribute :>> patientContact = false;
        }
        part fingerPad : HardwareComponent {
            @MemoIdentity { :>> label = "Finger pad"; }
            attribute :>> materialSummary = "Medical-grade silicone";
            attribute :>> patientContact = true;
            attribute :>> contactNature = "Intact skin";
            attribute :>> contactDuration = "Limited, under 24 hours";
        }
    }
    allocation : RealizedBy allocate oximeter.measurement.sensing to probe;

    part frontPanel : UserInterface {
        @MemoIdentity { :>> label = "Front panel"; }
        attribute :>> modality = "Visual, touch";
        attribute :>> uiTechnology = "Colour touchscreen";

        part readingScreen : UIElement {
            @MemoIdentity { :>> label = "Reading screen"; }
            attribute :>> formKind = UIElementFormKind::screen;

            part spo2Readout : UIElement {
                @MemoIdentity { :>> label = "SpO2 readout"; }
                attribute :>> formKind = UIElementFormKind::textMessage;
                attribute :>> unitsDisplayed = "%";
                attribute :>> updateRate = "Once per second";
            }
            part spotCheckButton : UIElement {
                @MemoIdentity { :>> label = "Spot-check button"; }
                attribute :>> formKind = UIElementFormKind::button;
                attribute :>> labelText = "Spot check";
            }
        }
    }
    allocation : RealizedBy allocate oximeter.display to frontPanel;
    connection : DerivesFrom connect reqSpo2Reading to reqShowReading;
    satisfy reqShowReading by frontPanel.readingScreen;
    satisfy reqShowReading by frontPanel.readingScreen.spo2Readout;

    action fnMeasureSpO2 : SystemFunction {
        @MemoIdentity { :>> label = "Measure oxygen saturation"; }
    }
    action startSpotCheck : UIAction {
        @MemoIdentity { :>> label = "Start a spot check"; }
        attribute :>> intent = InteractionIntentKind::userInput;
        attribute :>> feedbackProvided = "The readout shows a spinner until the reading settles";
        perform fnMeasureSpO2;
    }
    connection : ElementTriggersAction connect frontPanel.readingScreen.spotCheckButton to startSpotCheck;
    allocate fnMeasureSpO2 to firmware.measurementTask;
}
```

</details>

## In the running example

The bedside display carries the alarm banner. The banner triggers the
acknowledge action, which performs the detection function. A native dependency
records that the display supports the nurse's acknowledgement task.

```sysml
--8<-- "examples/temperature-alarm/model/catalog/temperature_alarm.sysml:implementation"
```

<details markdown="1">
<summary><strong>Every element and relationship in this layer</strong> (generated from <code>src/architecture/implementation/</code>)</summary>

--8<-- "docs/ontology/_generated/implementation.md"

</details>

<details markdown="1">
<summary><strong>The detail behind the steps</strong>: every attribute and kind the layer defines</summary>

### Every element in detail

**Software.** IEC 62304 calls any identifiable part of a program a *software
item*, and it decomposes software item by item. MEMO's base for that concept is
`SoftwareElement`. It is named so because SysML reserves *item* for things that
flow, which is what MEMO's `DataItem` is: software data or content that is
stored or exchanged. Software is described in two views:

- **The module view** (IEC 62304 5.3 to 5.4): `SoftwareSystem` is the top, and
  `SoftwareModule`s are the code units with design responsibility. `Algorithm`,
  `DataModel` and `ConfigurationArtifact` describe what a module holds, but they
  are not software elements, so they are declared beside the modules. An
  `SBOMEntry` records a component in the software bill of materials.
- **The runtime view**: a `SoftwareComponent` is a runtime component, with its
  concurrency, scheduling, health monitoring and fault containment. Its
  `runtimeKind` says what kind: a process, thread, task, service, container,
  partition, data store, or message broker.

**Hardware.** `PhysicalElement` is the root of a physical taxonomy:
`PhysicalAssembly` and `PhysicalSubassembly`, `HardwareAssembly`,
`PhysicalComponent` and `HardwareComponent`. Below them are electrical and
electronic parts (`PowerSupply`, `Battery`, `Cable`, `NetworkMedium`), fluidic
and pneumatic parts, mechanical parts and enclosures, optical, acoustic and
thermal components, and the `Sensor`s and `Actuator`s that meet the physical
world.

**User interface.** A `UserInterface` is what the user operates. A `UIElement`
is one element of it, such as a banner or a button. A `UIElement` is a software
element. A `UIAction` is an operative action, because clicking a button has a
trigger, a precondition, a criticality and a potential harm, just as turning a
knob does. `UIState` and `UIEvent` describe the interface's behaviour. An
`InteractionFlow` is a reusable dialogue structure through the interface; one
path through it is an `OperativeScenario` of kind `ui`. `ScreenCapture` and
`RegionBounds` tie the model to real screen layouts.

## How it connects

**Within the layer.** A UI element triggers a UI action
(`ElementTriggersAction`). A screen capture shows a UI element
(`CapturesScreen`). A SOUP item (IEC 62304's software of unknown provenance)
is a `SOUPSoftwareModule`; an `OTSSoftwareModule` is the off-the-shelf kind of
SOUP and adds the license, package URL and checksum. Any element can depend on a
SOUP software element (`DependsOnSoup`).

**To other layers and disciplines:**

- **It realises the logical design.** A logical component is allocated to the
  implementation element that realizes it (`RealizedBy`, the logical component
  first). See [Logical](logical.md).
- **UI actions carry out functions**: a `UIAction` `perform`s a function. See
  [Functional](functional.md).
- **Interaction serves use**: an interaction flow serves a use case
  (`FlowServesUseCase`), and the interface supports operational tasks with a
  native `dependency`. See [Operational](operational.md).
- **It is where controls are built.** A risk control is implemented by an
  implementation element (`ControlImplementedBy`), and a use error happens at
  an element (`ErrorAtElement`). See [Safety and risk](safety-risk.md) and
  [Human factors](human-factors.md).
- **It is deployed in the realization layer.** Modules build into deployment
  units (`BuildsInto`), runtime components bind to memory (`MemoryBinding`),
  and exchanges bind to a network medium (`ConnectionBinding`). See
  [Realization](realization.md).

</details>

## Go deeper

- The GPCA infusion pump: [requirements and architecture](../layers/requirements-architecture.md).
- [The implementation API](../sysml-api/index.md#architecture).
