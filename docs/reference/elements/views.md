# Views and methodology

Viewpoints frame stakeholder concerns; views conform to viewpoints; and the
methodology types describe how a team applies the ontology to a project.

Narrative treatment: [Views and Evidence](../../modeling/views-evidence.md).

24 definitions. Each entry gives the declaration, its position in the specialization hierarchy, its attributes and their types, and the relationships that accept it.

## Viewpoint and view definitions

`src/viewpoints/definitions/` — 8 definitions: [`MemoDiagramView`](#memodiagramview), [`MemoDocumentBackedView`](#memodocumentbackedview), [`MemoDocumentView`](#memodocumentview), [`MemoView`](#memoview), [`ViewInclusionRule`](#viewinclusionrule), [`ViewRule`](#viewrule), [`ViewSelectionQuery`](#viewselectionquery), [`Viewpoint`](#viewpoint)

### MemoDiagramView

```sysml
view def MemoDiagramView :> MemoView
```

| | |
| --- | --- |
| **Specializes** | [`MemoView`](#memoview) |
| **Defined in** | [`src/viewpoints/definitions/memo_viewpoint_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/viewpoints/definitions/memo_viewpoint_definitions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `viewKind` | [`DiagramViewKind`](core.md#diagramviewkind) |
| `diagramType` | `String` |
| `layoutHint` | `String` |
| `styleHint` | `String` |

### MemoDocumentBackedView

```sysml
view def MemoDocumentBackedView :> MemoView
```

| | |
| --- | --- |
| **Specializes** | [`MemoView`](#memoview) |
| **Specialized by** | [`MemoDocumentView`](#memodocumentview) |
| **Defined in** | [`src/viewpoints/definitions/memo_viewpoint_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/viewpoints/definitions/memo_viewpoint_definitions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `version` | `String` |
| `generationRule` | `String` |
| `marketScope` | `String` |

### MemoDocumentView

```sysml
view def MemoDocumentView :> MemoDocumentBackedView
```

| | |
| --- | --- |
| **Specializes** | [`MemoDocumentBackedView`](#memodocumentbackedview) |
| **Specialized by** | [`MemoClinicalEvidenceView`](#memoclinicalevidenceview), [`MemoCybersecurityAssessmentView`](#memocybersecurityassessmentview), [`MemoCybersecurityThreatModelView`](#memocybersecuritythreatmodelview), [`MemoUsabilityEngineeringView`](#memousabilityengineeringview) |
| **Defined in** | [`src/viewpoints/definitions/memo_viewpoint_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/viewpoints/definitions/memo_viewpoint_definitions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `viewKind` | [`DocumentViewKind`](core.md#documentviewkind) |

### MemoView

```sysml
view def MemoView :> Views::View
```

| | |
| --- | --- |
| **Specializes** | `Views::View` |
| **Specialized by** | [`MemoDiagramView`](#memodiagramview), [`MemoDocumentBackedView`](#memodocumentbackedview) |
| **Defined in** | [`src/viewpoints/definitions/memo_viewpoint_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/viewpoints/definitions/memo_viewpoint_definitions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `outputKind` | [`ViewOutputKind`](core.md#viewoutputkind) |
| `presentationKind` | [`PresentationKind`](core.md#presentationkind) |
| `filterExpression` | `String` |
| `queryDescription` | `String` |
| `dataSourceDescription` | `String` |
| `autoPopulate` | `Boolean` |

### ViewInclusionRule

```sysml
part def ViewInclusionRule :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/viewpoints/definitions/memo_viewpoint_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/viewpoints/definitions/memo_viewpoint_definitions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `includeElementKinds` | `String` |
| `includeRelationshipKinds` | `String` |
| `includeLayers` | `String` |
| `includeConcerns` | [`ConcernKind`](core.md#concernkind) |
| `selectionExpression` | `String` |
| `rationaleText` | `String` |

### ViewRule

```sysml
part def ViewRule :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/viewpoints/definitions/memo_viewpoint_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/viewpoints/definitions/memo_viewpoint_definitions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `elementTypeName` | `String` |
| `relationTypeName` | `String` |
| `strength` | [`RuleStrengthKind`](core.md#rulestrengthkind) |
| `rationaleText` | `String` |

### ViewSelectionQuery

```sysml
part def ViewSelectionQuery :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/viewpoints/definitions/memo_viewpoint_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/viewpoints/definitions/memo_viewpoint_definitions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `includeElementKinds` | `String` |
| `includeRelationshipKinds` | `String` |
| `includeLayers` | `String` |
| `includeConcerns` | [`ConcernKind`](core.md#concernkind) |
| `includeStatusTags` | `String` |
| `selectionExpression` | `String` |
| `rationaleText` | `String` |

### Viewpoint

```sysml
part def Viewpoint :> DocumentedElement
```

| | |
| --- | --- |
| **Specializes** | [`DocumentedElement`](core.md#documentedelement) |
| **Defined in** | [`src/viewpoints/definitions/memo_viewpoint_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/viewpoints/definitions/memo_viewpoint_definitions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `purpose` | `String` |
| `audience` | [`AudienceKind`](core.md#audiencekind) |
| `stage` | [`WorkflowStageKind`](core.md#workflowstagekind) |
| `abstractionLevel` | `String` |
| `outputKind` | [`ViewOutputKind`](core.md#viewoutputkind) |
| `presentationKind` | [`PresentationKind`](core.md#presentationkind) |
| `concernKinds` | [`ConcernKind`](core.md#concernkind) |
| `includedLayers` | `String` |
| `allowedElementKinds` | `String` |
| `allowedRelationshipKinds` | `String` |
| `filterExpression` | `String` |
| `extendsViewpointIds` | `String` |
| `userExtensible` | `Boolean` |
| `defaultViewKind` | [`DiagramViewKind`](core.md#diagramviewkind) |

## Diagram intent catalog

`src/viewpoints/catalog/` — 1 definitions: [`DiagramIntentMapping`](#diagramintentmapping)

### DiagramIntentMapping

```sysml
part def DiagramIntentMapping :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/viewpoints/catalog/memo_viewpoint_catalog.sysml`](https://github.com/memoarchitect/memo/blob/main/src/viewpoints/catalog/memo_viewpoint_catalog.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `legacyIntent` | `String` |
| `resolvesTo` | [`DiagramViewKind`](core.md#diagramviewkind) |

## Clinical views

`src/viewpoints/clinical/` — 1 definitions: [`MemoClinicalEvidenceView`](#memoclinicalevidenceview)

### MemoClinicalEvidenceView

```sysml
view def MemoClinicalEvidenceView :> MemoDocumentView
```

| | |
| --- | --- |
| **Specializes** | [`MemoDocumentView`](#memodocumentview) |
| **Defined in** | [`src/viewpoints/clinical/clinical_evidence_view.sysml`](https://github.com/memoarchitect/memo/blob/main/src/viewpoints/clinical/clinical_evidence_view.sysml) |

## Cybersecurity views

`src/viewpoints/cybersecurity/` — 2 definitions: [`MemoCybersecurityAssessmentView`](#memocybersecurityassessmentview), [`MemoCybersecurityThreatModelView`](#memocybersecuritythreatmodelview)

### MemoCybersecurityAssessmentView

```sysml
view def MemoCybersecurityAssessmentView :> MemoDocumentView
```

| | |
| --- | --- |
| **Specializes** | [`MemoDocumentView`](#memodocumentview) |
| **Defined in** | [`src/viewpoints/cybersecurity/cybersecurity_assessment_view.sysml`](https://github.com/memoarchitect/memo/blob/main/src/viewpoints/cybersecurity/cybersecurity_assessment_view.sysml) |

### MemoCybersecurityThreatModelView

```sysml
view def MemoCybersecurityThreatModelView :> MemoDocumentView
```

| | |
| --- | --- |
| **Specializes** | [`MemoDocumentView`](#memodocumentview) |
| **Defined in** | [`src/viewpoints/cybersecurity/threat_model_view.sysml`](https://github.com/memoarchitect/memo/blob/main/src/viewpoints/cybersecurity/threat_model_view.sysml) |

## Usability views

`src/viewpoints/usability/` — 1 definitions: [`MemoUsabilityEngineeringView`](#memousabilityengineeringview)

### MemoUsabilityEngineeringView

```sysml
view def MemoUsabilityEngineeringView :> MemoDocumentView
```

| | |
| --- | --- |
| **Specializes** | [`MemoDocumentView`](#memodocumentview) |
| **Defined in** | [`src/viewpoints/usability/usability_engineering_view.sysml`](https://github.com/memoarchitect/memo/blob/main/src/viewpoints/usability/usability_engineering_view.sysml) |

## Methodology

`src/methodology/` — 10 definitions: [`Archetype`](#archetype), [`DhfDocumentBinding`](#dhfdocumentbinding), [`ElementUsageRule`](#elementusagerule), [`MethodologyDefinition`](#methodologydefinition), [`MethodologyLibrary`](#methodologylibrary), [`ModelingPattern`](#modelingpattern), [`ProjectMethodBinding`](#projectmethodbinding), [`QualityGate`](#qualitygate), [`RelationUsageRule`](#relationusagerule), [`ResolvedMethodology`](#resolvedmethodology)

### Archetype

```sysml
part def Archetype :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/methodology/memo_core.sysml`](https://github.com/memoarchitect/memo/blob/main/src/methodology/memo_core.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `label` | `String` |
| `description` | `String` |
| `category` | `String` |
| `includedLayer` | `String` |
| `includedStandard` | `String` |
| `templateDir` | `String` |

### DhfDocumentBinding

```sysml
part def DhfDocumentBinding :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/methodology/memo_core.sysml`](https://github.com/memoarchitect/memo/blob/main/src/methodology/memo_core.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `documentTitle` | `String` |
| `groupLabel` | `String` |
| `templateId` | `String` |
| `viewKind` | `String` |
| `regulatoryReference` | `String` |
| `lifecycleStage` | [`WorkflowStageKind`](core.md#workflowstagekind) |
| `required` | `Boolean` |

### ElementUsageRule

```sysml
part def ElementUsageRule :> ConsistencyRule
```

| | |
| --- | --- |
| **Specializes** | [`ConsistencyRule`](core.md#consistencyrule) |
| **Defined in** | [`src/methodology/memo_rules.sysml`](https://github.com/memoarchitect/memo/blob/main/src/methodology/memo_rules.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `elementTypeName` | `String` |

### MethodologyDefinition

```sysml
part def MethodologyDefinition :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/methodology/memo_core.sysml`](https://github.com/memoarchitect/memo/blob/main/src/methodology/memo_core.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `version` | `String` |
| `domain` | `String` |
| `description` | `String` |
| `baseMethodName` | `String` |
| `includedLayer` | `String` |
| `includedModule` | `String` |

### MethodologyLibrary

```sysml
part def MethodologyLibrary :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/methodology/memo_core.sysml`](https://github.com/memoarchitect/memo/blob/main/src/methodology/memo_core.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `version` | `String` |
| `domain` | `String` |
| `description` | `String` |

### ModelingPattern

```sysml
part def ModelingPattern :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/methodology/memo_patterns.sysml`](https://github.com/memoarchitect/memo/blob/main/src/methodology/memo_patterns.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `intent` | `String` |
| `stage` | [`WorkflowStageKind`](core.md#workflowstagekind) |
| `strength` | [`RuleStrengthKind`](core.md#rulestrengthkind) |

### ProjectMethodBinding

```sysml
part def ProjectMethodBinding :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/methodology/memo_core.sysml`](https://github.com/memoarchitect/memo/blob/main/src/methodology/memo_core.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `projectName` | `String` |
| `methodologyName` | `String` |
| `includedModule` | `String` |

### QualityGate

```sysml
part def QualityGate :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/methodology/memo_gates.sysml`](https://github.com/memoarchitect/memo/blob/main/src/methodology/memo_gates.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `gateStage` | [`WorkflowStageKind`](core.md#workflowstagekind) |
| `passCriteria` | `String` |

### RelationUsageRule

```sysml
part def RelationUsageRule :> ConsistencyRule
```

| | |
| --- | --- |
| **Specializes** | [`ConsistencyRule`](core.md#consistencyrule) |
| **Defined in** | [`src/methodology/memo_rules.sysml`](https://github.com/memoarchitect/memo/blob/main/src/methodology/memo_rules.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `relationTypeName` | `String` |

### ResolvedMethodology

```sysml
part def ResolvedMethodology :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/methodology/memo_core.sysml`](https://github.com/memoarchitect/memo/blob/main/src/methodology/memo_core.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `version` | `String` |
| `includedLayer` | `String` |
| `includedModule` | `String` |

## Artifact definitions

`src/artifacts/definitions/` — 1 definitions: [`ArtifactKindDef`](#artifactkinddef)

### ArtifactKindDef

```sysml
part def ArtifactKindDef :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/artifacts/definitions/memo_artifact_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/artifacts/definitions/memo_artifact_definitions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `documentTitle` | `String` |
| `regulatoryRef` | `String` |
| `artifactKind` | [`ArtifactKind`](core.md#artifactkind) |
