# Lesson 0 · Reading the notation

[Series overview](index.md) · Next: [One part](01-one-part.md)

Every symbol used in this series, once, with what it means and why SysML v2
writes it that way. Each lesson explains the notation again where it first
appears; come back here when a symbol looks unfamiliar.

## Two kinds of declaration

SysML v2 separates a **definition** (`part def`, `port def`, `action def`, …),
which is a type that describes a kind of thing, from a **usage** (`part`, `port`,
`action`, …), which is one actual thing in your design described by a
definition. The same keyword with and without `def` gives the pair.

MEMO is mostly a library of **definitions**: `HardwareAssembly`, `PhysicalPort`,
`SystemFunction`, `Hazard`. Your model is mostly **usages** typed by them. That
is why almost every line you write has the shape `keyword name : MemoDefinition`.

The keyword stays SysML's own. MEMO adds no new kinds of element: a `HardwareAssembly` is a
`part def`, and the element you write is a `part`. Every MEMO definition sits on a base for its
kind (`MemoPart`, `MemoAction`, `MemoPort`, …) that holds attributes such as `status`, but you
define your elements by the specific definition, not by the base, because the specific one is
what the rules read. Evidence and states are the two exceptions: lesson 12's
`part evSpO2AccuracyReport : MemoEvidence` uses its base directly, because the library has
nothing more specific for it. The diagrams follow SysML: «part» over
`oximeter : HardwareAssembly`, the kind in guillemets and the definition after the colon. The
table of bases is in
[How MEMO builds on SysML](../../ontology/index.md#how-memo-builds-on-sysml).

## Symbols

| Notation | Read it as | Example | Why it is there |
|---|---|---|---|
| `{ … }` | "the body of" | `part oximeter : HardwareAssembly { … }` | everything inside belongs to the element: its ports, its parts, its attributes. Ownership in SysML v2 is nesting. |
| `;` | "end of declaration" | `in port signalIn : PhysicalPort;` | an element with nothing inside ends with `;` instead of an empty body |
| `:` | "defined by" | `part oximeter : HardwareAssembly` | the usage gets every feature the definition declares. You can also write the words: `part oximeter defined by HardwareAssembly`. |
| `specializes` or `:>` | "is a kind of" | `part def PulseOximeterSystem specializes System` | used between definitions: the new definition inherits everything and adds to it |
| `:>>` | "redefines" | `attribute :>> connectorType = "USB-C";` | gives a value to an attribute the type **already declares**. The spelled-out form is `attribute redefines connectorType = "USB-C";`. The name must be one the part's type declares; a misspelt name is a compile error because nothing by that name exists to redefine. |
| `=` | "has the value" / "is the same as" | `:>> label = "Pulse oximeter"`, `bind a = b` | in an attribute, the value; in `bind`, the two sides are one feature |
| `::` | "member of" | `NeedKind::clinicalUser`, `Base::Anything` | a qualified name: the part after `::` is found inside the namespace before it |
| `::*` | "every member of" | `import memo::*` | imports all names in the namespace at once |
| `.` | "the feature of" | `oximeter.probeSocket.ledDrive` | a path into a nested element: the `ledDrive` pins of the `probeSocket` port of the `oximeter` part |
| `@Name { … }` | "annotated with" | `@MemoIdentity { … }` | attaches metadata to the element whose body it sits in. Metadata describes the element without becoming part of the design. |
| `doc /* … */` | "documented as" | `doc /* The handheld unit … */` | the element's description. A leading `*` on later lines is layout only. |
| `"…"` | a string | `"USB-C"` | a text value |
| `true`, `false` | a Boolean | `patientContact = false` | a yes/no value |
| `[*]` | "any number of" | `Base::Anything[*]` | a multiplicity: how many values the feature may hold |
| `( a, b )` | "the list" | `= (rcSignalQualityCheck, fnMeasureSpO2.fnCheckSignalQuality)` | several values given at once |
| `in`, `out`, `inout` | direction | `out port ledDrive` | which way things cross a port, seen from the part that owns it |
| `:>` on a usage | "subsets", "is one occurrence of" | `action sense :> fnMeasureSpO2.fnSenseLight;` | the step is the function at one position in a route, and inherits its parameters |
| `ref` | "refers to" | `ref :>> useContext = generalWard;` | points at an element owned elsewhere instead of owning it |
| `10 [s]` | a quantity | `expectedDuration = 10 [s]` | a number with its unit; the unit goes in square brackets |
| `#name` | "marked as" | `#refinement dependency a to b;` | applies a metadata keyword to the element that follows |

## Statements used in the series

| Statement | Says |
|---|---|
| `private import X::*;` | use the names in `X` here, without passing them on to whoever imports this package |
| `bind a = b;` | `a` and `b` are the same feature |
| `interface n : T connect a to b` | a connection between two ports, with a contract of type `T` |
| `flow n : T from a to b` | something moves from `a` (an `out`) to `b` (an `in`) |
| `connection : T connect a to b;` | a relation of type `T` from `a` to `b`; no name is needed when nothing refers to it |
| `first a then b;` | `b` starts after `a` ends |
| `allocate a to b;` | `b` carries out responsibility `a` |
| `allocation : T allocate a to b;` | the same, with a type that says what kind of allocation |
| `satisfy r by x;` | `x` meets requirement `r` |
| `objective { verify r; }` | inside a verification case: the requirement it verifies |
| `subject s : T = (…);` | inside a verification case: what is under test |
| `use case u : T { … }` | a goal pursued with a subject, by actors |
| `subject :>> supportingSystem = x;` | inside a use case: what the goal is pursued with |
| `actor a = x;` | inside a use case: who takes part |
| `action def D specializes OperativeAction { … }` | a step, defined once, used in several scenarios |
| `perform x;` | the owner carries out action `x` |
| `perform action n references x;` | the same, with its own name `n`, needed when one owner performs two actions with the same name |
| `in item p : T;`, `out item p : T;` | inside an action: an input or output parameter of item type `T` |
| `dependency a to b;` | `a` depends on `b`; `#refinement` in front says it refines it |

## Names

| Kind of name | Style | Example |
|---|---|---|
| definitions | PascalCase | `PulseOximeterSystem` |
| usages | lowerCamelCase | `oximeter`, `probeSocket` |
| enumeration values | `EnumName::member` | `SeverityKind::serious` |

MEMO accepts an enumeration value only in its qualified form. A bare `serious`
is an error, because the same member name can exist in two enumerations.

Next: [Lesson 1 · One part](01-one-part.md)
