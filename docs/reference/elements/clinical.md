# Clinical and products

The vertical clinical domain and product identity. These elements may
reference both architecture and assurance elements, because a product or a
clinical procedure is a real-world thing that both axes talk about.

Narrative treatment:
[Medical Products and Identity](../../layers/medical-products.md).

19 definitions. Each entry gives the declaration, its position in the specialization hierarchy, its attributes and their types, and the relationships that accept it.

## Clinical procedures

`src/clinical_procedures/` — 7 definitions: [`AssembledFor`](#assembledfor), [`ClinicalProcedure`](#clinicalprocedure), [`ClinicalTechnique`](#clinicaltechnique), [`InstrumentSet`](#instrumentset), [`ProcedureVariant`](#procedurevariant), [`SetIncludesProduct`](#setincludesproduct), [`UsesTechnique`](#usestechnique)

### AssembledFor

```sysml
connection def AssembledFor :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/clinical_procedures/memo_clinical_procedures.sysml`](https://github.com/memoarchitect/memo/blob/main/src/clinical_procedures/memo_clinical_procedures.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `instrumentSet` | [`InstrumentSet`](#instrumentset) |
| `procedure` | [`ClinicalProcedure`](#clinicalprocedure) |

### ClinicalProcedure

```sysml
part def ClinicalProcedure :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Specialized by** | [`ProcedureVariant`](#procedurevariant) |
| **Defined in** | [`src/clinical_procedures/memo_clinical_procedures.sysml`](https://github.com/memoarchitect/memo/blob/main/src/clinical_procedures/memo_clinical_procedures.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `bodySite` | `String` |
| `clinicalObjective` | `String` |
| `anesthesiaRequirement` | `String` |
| `typicalDuration` | `String` |

**Accepted by** [`AssembledFor`](#assembledfor) (`procedure`), [`PartOfProcedure`](operational.md#partofprocedure) (`procedure`), [`UsesTechnique`](#usestechnique) (`procedure`)

### ClinicalTechnique

```sysml
part def ClinicalTechnique :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/clinical_procedures/memo_clinical_procedures.sysml`](https://github.com/memoarchitect/memo/blob/main/src/clinical_procedures/memo_clinical_procedures.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `skillPrerequisites` | `String` |
| `advantages` | `String` |
| `limitations` | `String` |

**Accepted by** [`UsesTechnique`](#usestechnique) (`technique`)

### InstrumentSet

```sysml
part def InstrumentSet :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/clinical_procedures/memo_clinical_procedures.sysml`](https://github.com/memoarchitect/memo/blob/main/src/clinical_procedures/memo_clinical_procedures.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `setPurpose` | `String` |
| `sterileAssembly` | `Boolean` |

**Accepted by** [`AssembledFor`](#assembledfor) (`instrumentSet`), [`SetIncludesProduct`](#setincludesproduct) (`instrumentSet`)

### ProcedureVariant

```sysml
part def ProcedureVariant :> ClinicalProcedure
```

| | |
| --- | --- |
| **Specializes** | [`ClinicalProcedure`](#clinicalprocedure) |
| **Defined in** | [`src/clinical_procedures/memo_clinical_procedures.sysml`](https://github.com/memoarchitect/memo/blob/main/src/clinical_procedures/memo_clinical_procedures.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `variationRationale` | `String` |

### SetIncludesProduct

```sysml
connection def SetIncludesProduct :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/clinical_procedures/memo_clinical_procedures.sysml`](https://github.com/memoarchitect/memo/blob/main/src/clinical_procedures/memo_clinical_procedures.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `instrumentSet` | [`InstrumentSet`](#instrumentset) |
| `product` | [`MemoPart`](core.md#memopart) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `quantity` | `Integer` |

### UsesTechnique

```sysml
connection def UsesTechnique :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/clinical_procedures/memo_clinical_procedures.sysml`](https://github.com/memoarchitect/memo/blob/main/src/clinical_procedures/memo_clinical_procedures.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `procedure` | [`ClinicalProcedure`](#clinicalprocedure) |
| `technique` | [`ClinicalTechnique`](#clinicaltechnique) |

## Medical products and identity

`src/medical_products/` — 12 definitions: [`AccessoryOf`](#accessoryof), [`InstanceOf`](#instanceof), [`MedicalDevice`](#medicaldevice), [`MedicalDeviceCategoryKind`](#medicaldevicecategorykind), [`MedicalDeviceDefinition`](#medicaldevicedefinition), [`MedicalDeviceInstance`](#medicaldeviceinstance), [`ProductRoleKind`](#productrolekind), [`ReuseLifecycle`](#reuselifecycle), [`ReuseModeKind`](#reusemodekind), [`SterilizationMethodKind`](#sterilizationmethodkind), [`TechnologyDomainKind`](#technologydomainkind), [`UsesProduct`](#usesproduct)

### AccessoryOf

```sysml
connection def AccessoryOf :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/medical_products/memo_product_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_definitions.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `accessory` | [`MedicalDevice`](#medicaldevice) |
| `parentDevice` | [`MedicalDevice`](#medicaldevice) |

### InstanceOf

```sysml
connection def InstanceOf :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/medical_products/memo_product_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_definitions.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `instance` | [`MedicalDeviceInstance`](#medicaldeviceinstance) |
| `definition` | [`MedicalDeviceDefinition`](#medicaldevicedefinition) |

### MedicalDevice

```sysml
part def MedicalDevice :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/medical_products/memo_product_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_definitions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `deviceRole` | `String` |
| `deviceCategory` | [`MedicalDeviceCategoryKind`](#medicaldevicecategorykind) |
| `instrumentFunction` | `String` |
| `installationRequirement` | `String` |
| `parentDeviceReference` | `String` |
| `consumptionMode` | `String` |
| `implantSite` | `String` |
| `intendedImplantDuration` | `String` |

**Accepted by** [`AccessoryOf`](#accessoryof) (`accessory`), [`AccessoryOf`](#accessoryof) (`parentDevice`), [`UsesProduct`](#usesproduct) (`product`)

### MedicalDeviceCategoryKind

```sysml
enum def MedicalDeviceCategoryKind
```

| | |
| --- | --- |
| **Defined in** | [`src/medical_products/memo_product_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_definitions.sysml) |

**Values**

`instrument`, `equipment`, `accessory`, `consumable`, `supply`, `implant`

### MedicalDeviceDefinition

```sysml
part def MedicalDeviceDefinition :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/medical_products/memo_product_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_definitions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `manufacturer` | `String` |
| `model` | `String` |
| `catalogNumber` | `String` |
| `intendedPurpose` | `String` |
| `technologyDomains` | [`TechnologyDomainKind`](#technologydomainkind) |
| `udiDeviceIdentifier` | `String` |
| `riskClassification` | `String` |
| `reuse` | [`ReuseLifecycle`](#reuselifecycle) |

**Accepted by** [`InstanceOf`](#instanceof) (`definition`)

### MedicalDeviceInstance

```sysml
part def MedicalDeviceInstance :> MemoPart
```

| | |
| --- | --- |
| **Specializes** | [`MemoPart`](core.md#memopart) |
| **Defined in** | [`src/medical_products/memo_product_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_definitions.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `serialNumber` | `String` |
| `lotNumber` | `String` |
| `udiCarrier` | [`UdiCarrier`](core.md#udicarrier) |
| `manufactureDate` | `String` |
| `expirationDate` | `String` |
| `softwareVersion` | `String` |
| `configurationSummary` | `String` |
| `location` | `String` |
| `calibrationStatus` | `String` |
| `maintenanceStatus` | `String` |
| `reprocessingHistorySummary` | `String` |

**Accepted by** [`InstanceOf`](#instanceof) (`instance`)

### ProductRoleKind

```sysml
enum def ProductRoleKind
```

| | |
| --- | --- |
| **Defined in** | [`src/medical_products/memo_product_usage.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_usage.sysml) |

**Values**

`primaryInstrument`, `assistingInstrument`, `measurementInstrument`, `visualizationInstrument`, `cuttingInstrument`, `graspingInstrument`, `closureInstrument`, `energyDeliveryInstrument`, `monitoringDevice`, `implant`, `accessory`, `consumable`, `protectiveEquipment`, `softwareTool`

### ReuseLifecycle

```sysml
attribute def ReuseLifecycle
```

| | |
| --- | --- |
| **Defined in** | [`src/medical_products/memo_product_lifecycle.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_lifecycle.sysml) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `reuseMode` | [`ReuseModeKind`](#reusemodekind) |
| `maximumReuseCount` | `Integer` |
| `reprocessingRequired` | `Boolean` |
| `cleaningRequired` | `Boolean` |
| `disinfectionRequired` | `Boolean` |
| `suppliedSterile` | `Boolean` |
| `sterilizable` | `Boolean` |
| `sterilizationMethod` | [`SterilizationMethodKind`](#sterilizationmethodkind) |
| `shelfLife` | `String` |
| `lotTraceabilityRequired` | `Boolean` |
| `udiApplicable` | `Boolean` |

### ReuseModeKind

```sysml
enum def ReuseModeKind
```

| | |
| --- | --- |
| **Defined in** | [`src/medical_products/memo_product_lifecycle.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_lifecycle.sysml) |

**Values**

`singleUse`, `reusable`, `limitedReuse`, `consumable`, `implantable`

### SterilizationMethodKind

```sysml
enum def SterilizationMethodKind
```

| | |
| --- | --- |
| **Defined in** | [`src/medical_products/memo_product_lifecycle.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_lifecycle.sysml) |

**Values**

`steamAutoclave`, `ethyleneOxide`, `gammaIrradiation`, `electronBeam`, `hydrogenPeroxidePlasma`, `dryHeat`, `notApplicable`

### TechnologyDomainKind

```sysml
enum def TechnologyDomainKind
```

| | |
| --- | --- |
| **Defined in** | [`src/medical_products/memo_product_definitions.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_definitions.sysml) |

**Values**

`mechanical`, `electrical`, `electronic`, `software`, `firmware`, `pneumatic`, `hydraulic`, `fluidic`, `optical`, `acoustic`, `thermal`, `chemical`, `biological`

### UsesProduct

```sysml
connection def UsesProduct :> MemoRelationship
```

| | |
| --- | --- |
| **Specializes** | [`MemoRelationship`](core.md#memorelationship) |
| **Defined in** | [`src/medical_products/memo_product_usage.sysml`](https://github.com/memoarchitect/memo/blob/main/src/medical_products/memo_product_usage.sysml) |

**Ends**

| End | Type |
| --- | --- |
| `using` | [`MemoAction`](core.md#memoaction) |
| `product` | [`MedicalDevice`](#medicaldevice) |

**Attributes**

| Attribute | Type |
| --- | --- |
| `productRole` | [`ProductRoleKind`](#productrolekind) |
| `required` | `Boolean` |
| `quantity` | `String` |
| `setupSummary` | `String` |
| `sterileRequired` | `Boolean` |
| `calibrationRequired` | `Boolean` |
| `permittedAlternative` | `String` |
| `usageInstructions` | `String` |
