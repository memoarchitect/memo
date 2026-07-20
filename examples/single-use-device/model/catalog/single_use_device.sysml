// Focused example: single-use sterile device (safety syringe). The reuse
// lifecycle forbids reprocessing (CR-ONT-030); identity is lot-based, and
// expiration belongs to the consumable instance, never the definition.
package memo_examples_single_use_device {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_terminology::*;
    private import memo_medical_products_lifecycle::*;
    private import memo_medical_products_definitions::*;
    private import memo_activities::*;
    private import memo_medical_products_usage::*;

    part syringeDef : MedicalDeviceDefinition {
        attribute :>> id = "SUD-DEF-001"; attribute :>> name = "SafetySyringe_5ml";
        attribute :>> manufacturer = "Example Disposables Ltd";
        attribute :>> model = "SS-5";
        attribute :>> catalogNumber = "ED-SS5-100";
        attribute :>> intendedPurpose = "Single-use injection with sharps-injury protection.";
        attribute :>> technologyDomains = TechnologyDomainKind::mechanical;
        attribute :>> udiDeviceIdentifier = "(01)04012345000122";
        attribute :>> reuse = syringeReuse;
    }
    attribute syringeReuse : ReuseLifecycle {
        attribute :>> reuseMode = ReuseModeKind::singleUse;
        attribute :>> maximumReuseCount = 1;
        attribute :>> reprocessingRequired = false;
        attribute :>> cleaningRequired = false;
        attribute :>> disinfectionRequired = false;
        attribute :>> suppliedSterile = true;
        attribute :>> sterilizable = false;
        attribute :>> sterilizationMethod = SterilizationMethodKind::notApplicable;
        attribute :>> shelfLife = "36 months";
        attribute :>> lotTraceabilityRequired = true;
        attribute :>> udiApplicable = true;
    }

    part syringe : MedicalConsumable {
        attribute :>> id = "SUD-DEV-001"; attribute :>> name = "SafetySyringe";
        attribute :>> consumptionMode = "consumed on first use; sharps disposal";
        ref :>> definition = syringeDef;
    }

    // Consumable instance: lot identity, expiry on the instance.
    part syringeLotUnit : MedicalDeviceInstance {
        attribute :>> id = "SUD-INST-001"; attribute :>> name = "SafetySyringe_LOT2026C";
        attribute :>> lotNumber = "LOT-2026-C-0451";
        attribute :>> manufactureDate = "2026-03-02";
        attribute :>> expirationDate = "2029-03-02";
        ref :>> definition = syringeDef;
    }
    connection : InstanceOf connect instance ::> syringeLotUnit to definition ::> syringeDef;

    action taskInject : UserTask {
        attribute :>> id = "SUD-TASK-001"; attribute :>> name = "AdministerInjection";
        attribute :>> taskGoal = "administer prescribed dose subcutaneously";
    }
    connection : UsesProduct connect using ::> taskInject to product ::> syringe {
        attribute :>> productRole = ProductRoleKind::consumable;
        attribute :>> required = true;
        attribute :>> quantity = "1";
        attribute :>> sterileRequired = true;
        attribute :>> calibrationRequired = false;
    }
}
