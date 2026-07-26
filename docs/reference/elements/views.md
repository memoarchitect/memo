# Views and methodology

Viewpoints frame stakeholder concerns; views conform to viewpoints; and the
methodology types describe how a team applies the ontology to a project.

Narrative treatment: [Views and Evidence](../../modeling/views-evidence.md).

**25 definitions** across 7 packages, extracted from the shipped SysML sources.

## Viewpoint and view definitions

`src/viewpoints/definitions/` — 8 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `MemoDiagramView` | view def | `MemoView` | `viewKind`, `diagramType`, `layoutHint`, `styleHint` |
| `MemoDocumentBackedView` | view def | `MemoView` | `version`, `generationRule`, `marketScope` |
| `MemoDocumentView` | view def | `MemoDocumentBackedView` | `viewKind` |
| `MemoView` | view def | `Views::View` | `outputKind`, `presentationKind`, `filterExpression`, `queryDescription`, `dataSourceDescription`, `autoPopulate` |
| `ViewInclusionRule` | part def | `MemoPart` | `includeElementKinds`, `includeRelationshipKinds`, `includeLayers`, `includeConcerns`, `selectionExpression`, `rationaleText` |
| `ViewRule` | part def | `MemoPart` | `elementTypeName`, `relationTypeName`, `strength`, `rationaleText` |
| `ViewSelectionQuery` | part def | `MemoPart` | `includeElementKinds`, `includeRelationshipKinds`, `includeLayers`, `includeConcerns`, `includeStatusTags`, `selectionExpression` … +1 |
| `Viewpoint` | part def | `DocumentedElement` | `purpose`, `audience`, `stage`, `abstractionLevel`, `outputKind`, `presentationKind` … +9 |

## Diagram intent catalog

`src/viewpoints/catalog/` — 1 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `DiagramIntentMapping` | part def | `MemoPart` | `legacyIntent`, `resolvesTo` |

## Clinical views

`src/viewpoints/clinical/` — 1 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `MemoClinicalEvidenceView` | view def | `MemoDocumentView` | — |

## Cybersecurity views

`src/viewpoints/cybersecurity/` — 2 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `MemoCybersecurityAssessmentView` | view def | `MemoDocumentView` | — |
| `MemoCybersecurityThreatModelView` | view def | `MemoDocumentView` | — |

## Usability views

`src/viewpoints/usability/` — 1 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `MemoUsabilityEngineeringView` | view def | `MemoDocumentView` | — |

## Methodology

`src/methodology/` — 11 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `Archetype` | part def | `MemoPart` | `label`, `description`, `category`, `includedLayer`, `includedStandard`, `templateDir` |
| `DhfDocumentBinding` | part def | `MemoPart` | `documentTitle`, `groupLabel`, `templateId`, `viewKind`, `regulatoryReference`, `lifecycleStage` … +1 |
| `ElementUsageRule` | part def | `ConsistencyRule` | `elementTypeName` |
| `MethodologyDefinition` | part def | `MemoPart` | `version`, `domain`, `description`, `baseMethodName` |
| `MethodologyLibrary` | part def | `MemoPart` | `version`, `domain`, `description` |
| `ModelingPattern` | part def | `MemoPart` | `intent`, `stage`, `strength` |
| `ProjectMethodBinding` | part def | `MemoPart` | `projectName` |
| `QualityGate` | part def | `MemoPart` | `gateStage`, `passCriteria` |
| `RelationUsageRule` | part def | `ConsistencyRule` | `relationTypeName` |
| `ResolvedMethodology` | part def | `MemoPart` | `version`, `safetyClassification`, `lifecycleStage`, `resolutionSummary` |
| `WorkflowStep` | part def | `MemoPart` | `stepOrder`, `stage`, `objectiveDescription`, `entryCriteria`, `exitCriteria` |

## Artifact definitions

`src/artifacts/definitions/` — 1 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `ArtifactKindDef` | part def | `MemoPart` | `documentTitle`, `regulatoryRef`, `artifactKind` |
