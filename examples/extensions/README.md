# Extension examples

An extension is a regular SysML package selected by a MEMO methodology. MEMO
does not define a separate extension metaclass. `MethodologyDefinition` and
`ProjectMethodBinding` already accept packages through `includedModule`.

- `template/` is the starting structure for an extension.
- `clinical/` specializes `OperationalWorkflow` with clinical procedure data.

Extensions specialize or reference base types. They do not redefine
activities, workflows, architecture elements, relationships, or constraints
already expressed by the base ontology.

Extension packages remain outside `src/` and outside the `memo::` namespace.
Projects import an extension package directly and include it in their selected
methodology.
