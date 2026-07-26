# Clinical and products

The vertical clinical domain and product identity. These elements may
reference both architecture and assurance elements, because a product or a
clinical procedure is a real-world thing that both axes talk about.

Narrative treatment:
[Medical Products and Identity](../../layers/medical-products.md).

**19 definitions** across 2 packages, extracted from the shipped SysML sources.

## Clinical procedures

`src/clinical_procedures/` — 7 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `AssembledFor` | connection def | `MemoRelationship` | — |
| `ClinicalProcedure` | part def | `MemoPart` | `bodySite`, `clinicalObjective`, `anesthesiaRequirement`, `typicalDuration` |
| `ClinicalTechnique` | part def | `MemoPart` | `skillPrerequisites`, `advantages`, `limitations` |
| `InstrumentSet` | part def | `MemoPart` | `setPurpose`, `sterileAssembly` |
| `ProcedureVariant` | part def | `ClinicalProcedure` | `variationRationale` |
| `SetIncludesProduct` | connection def | `MemoRelationship` | `quantity` |
| `UsesTechnique` | connection def | `MemoRelationship` | — |

## Medical products and identity

`src/medical_products/` — 12 definitions

| Definition | Kind | Specializes | Attributes |
| --- | --- | --- | --- |
| `AccessoryOf` | connection def | `MemoRelationship` | — |
| `InstanceOf` | connection def | `MemoRelationship` | — |
| `MedicalDevice` | part def | `MemoPart` | `deviceRole`, `deviceCategory`, `instrumentFunction`, `installationRequirement`, `parentDeviceReference`, `consumptionMode` … +2 |
| `MedicalDeviceCategoryKind` | enum def | — | — |
| `MedicalDeviceDefinition` | part def | `MemoPart` | `manufacturer`, `model`, `catalogNumber`, `intendedPurpose`, `technologyDomains`, `udiDeviceIdentifier` … +2 |
| `MedicalDeviceInstance` | part def | `MemoPart` | `serialNumber`, `lotNumber`, `udiCarrier`, `manufactureDate`, `expirationDate`, `softwareVersion` … +5 |
| `ProductRoleKind` | enum def | — | — |
| `ReuseLifecycle` | attribute def | — | `reuseMode`, `maximumReuseCount`, `reprocessingRequired`, `cleaningRequired`, `disinfectionRequired`, `suppliedSterile` … +5 |
| `ReuseModeKind` | enum def | — | — |
| `SterilizationMethodKind` | enum def | — | — |
| `TechnologyDomainKind` | enum def | — | — |
| `UsesProduct` | connection def | `MemoRelationship` | `productRole`, `required`, `quantity`, `setupSummary`, `sterileRequired`, `calibrationRequired` … +2 |
