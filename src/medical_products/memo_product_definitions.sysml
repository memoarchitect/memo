// Medical product definitions and instances (§12, §16; ADR-0004). Follows the
// FHIR DeviceDefinition/Device split: catalog identity (manufacturer, model,
// UDI-DI, intended purpose, technology domains) belongs to the definition;
// production identity (serial, lot, UDI-PI, expiry, configuration, history)
// belongs to the instance. Instance identifiers on definitions violate the
// identity invariants (rules/lifecycle).
package memo_medical_products_definitions {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_terminology::*;
    private import memo_core_relationships::*;
    private import memo_medical_products_lifecycle::*;

    // Technology participation is a multivalued set — never one enum value
    // per technology combination (§13). Electromechanical / cyber-physical
    // classifications are derived from the set, not stored.
    enum def TechnologyDomainKind {
        enum mechanical;
        enum electrical;
        enum electronic;
        enum software;
        enum firmware;
        enum pneumatic;
        enum hydraulic;
        enum fluidic;
        enum optical;
        enum acoustic;
        enum thermal;
        enum chemical;
        enum biological;
    }

    // Catalog-level identity and intended purpose of a marketed product.
    part def MedicalDeviceDefinition specializes MemoPart {
        attribute manufacturer : String;
        attribute model : String;
        attribute catalogNumber : String;
        attribute intendedPurpose : String;
        attribute technologyDomains : TechnologyDomainKind[0..*];
        attribute udiDeviceIdentifier : String;
        attribute riskClassification : String;
        attribute reuse : ReuseLifecycle;
    }

    // The system-under-design or a referenced product, independent of any
    // particular manufactured unit.
    part def MedicalDevice specializes MemoPart {
        attribute deviceRole : String;
        ref definition : MedicalDeviceDefinition[0..1];
    }

    part def MedicalInstrument specializes MedicalDevice {
        attribute instrumentFunction : String;
    }
    part def MedicalEquipment specializes MedicalDevice {
        attribute installationRequirement : String;
    }
    part def MedicalDeviceAccessory specializes MedicalDevice {
        attribute parentDeviceReference : String;
    }
    part def MedicalConsumable specializes MedicalDevice {
        attribute consumptionMode : String;
    }
    part def MedicalSupply specializes MedicalDevice;
    part def Implant specializes MedicalDevice {
        attribute implantSite : String;
        attribute intendedImplantDuration : String;
    }

    // A manufactured unit of a definition (FHIR Device). The referenced
    // definition is mandatory (rules/lifecycle).
    part def MedicalDeviceInstance specializes MemoPart {
        attribute serialNumber : String;
        attribute lotNumber : String;
        attribute udiCarrier : UdiCarrier;
        attribute manufactureDate : String;
        attribute expirationDate : String;
        attribute softwareVersion : String;
        attribute configurationSummary : String;
        attribute location : String;
        attribute calibrationStatus : String;
        attribute maintenanceStatus : String;
        attribute reprocessingHistorySummary : String;
        ref definition : MedicalDeviceDefinition[1];
    }

    connection def InstanceOf :> MemoRelationship {
        end instance : MedicalDeviceInstance;
        end definition : MedicalDeviceDefinition;
    }
    // Links the modeled device to its physical/architecture realization.
    connection def RealizedByArchitecture :> MemoRelationship {
        end device : MedicalDevice;
        end architectureElement : ArchitectureElement;
    }
    connection def AccessoryOf :> MemoRelationship {
        end accessory : MedicalDeviceAccessory;
        end parentDevice : MedicalDevice;
    }
}
