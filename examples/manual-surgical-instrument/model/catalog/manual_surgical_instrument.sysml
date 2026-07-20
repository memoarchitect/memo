// Focused example: a passive, reusable, reprocessable manual instrument
// (needle holder). Demonstrates the definition/instance split, technology
// domains (mechanical only), reuse lifecycle, patient-contact declaration,
// and role-typed product usage in a task — with NO functional, logical, or
// software layers: irrelevant layers are never mandatory.
package memo_examples_manual_surgical_instrument {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_terminology::*;
    private import memo_activities::*;
    private import memo_architecture_hardware_structure::*;
    private import memo_medical_products_lifecycle::*;
    private import memo_medical_products_definitions::*;
    private import memo_medical_products_usage::*;

    // ── Catalog definition ──────────────────────────────────────
    part needleHolderDef : MedicalDeviceDefinition {
        attribute :>> id = "MSI-DEF-001";
        attribute :>> name = "MayoHegarNeedleHolder_15cm";
        attribute :>> manufacturer = "Example Surgical GmbH";
        attribute :>> model = "MH-15";
        attribute :>> catalogNumber = "ES-MH-15-TC";
        attribute :>> intendedPurpose = "Grasping and guiding suture needles during wound closure.";
        attribute :>> technologyDomains = TechnologyDomainKind::mechanical;
        attribute :>> udiDeviceIdentifier = "(01)04012345000061";
        attribute :>> riskClassification = "EU MDR Class I reusable surgical instrument (Ir)";
        attribute :>> reuse = reuseProfile;
        attribute :>> codes = gmdnCode;
    }
    attribute reuseProfile : ReuseLifecycle {
        attribute :>> reuseMode = ReuseModeKind::reusable;
        attribute :>> maximumReuseCount = 500;
        attribute :>> reprocessingRequired = true;
        attribute :>> cleaningRequired = true;
        attribute :>> disinfectionRequired = true;
        attribute :>> suppliedSterile = false;
        attribute :>> sterilizable = true;
        attribute :>> sterilizationMethod = SterilizationMethodKind::steamAutoclave;
        attribute :>> lotTraceabilityRequired = true;
        attribute :>> udiApplicable = true;
    }
    attribute gmdnCode : TerminologyCode {
        attribute :>> systemUri = "urn:gmdn";
        attribute :>> code = "35674";
        attribute :>> display = "Needle holder, surgical";
    }

    // ── Modeled product and physical structure ──────────────────
    part needleHolder : MedicalInstrument {
        attribute :>> id = "MSI-DEV-001";
        attribute :>> name = "NeedleHolder";
        attribute :>> instrumentFunction = "needle grasping and driving";
        ref :>> definition = needleHolderDef;
    }
    part jawAssembly : MechanicalPart {
        attribute :>> id = "MSI-PART-001";
        attribute :>> name = "TungstenCarbideJaws";
        attribute :>> mechanicalFunction = "serrated needle grip";
        attribute :>> patientContact = true;
        attribute :>> contactNature = "intact tissue / surgical site, indirect";
        attribute :>> contactDuration = "limited (<24 h)";
    }
    part ratchetLock : MechanicalPart {
        attribute :>> id = "MSI-PART-002";
        attribute :>> name = "RatchetLock";
        attribute :>> mechanicalFunction = "maintains jaw clamping force without continuous grip";
        attribute :>> patientContact = false;
    }
    connection : Realizes connect realized ::> needleHolder to realizing ::> jawAssembly;
    connection : Realizes connect realized ::> needleHolder to realizing ::> ratchetLock;

    // ── Manufactured instance (identity separate from definition) ──
    part needleHolderUnit42 : MedicalDeviceInstance {
        attribute :>> id = "MSI-INST-042";
        attribute :>> name = "NeedleHolder_SN042";
        attribute :>> serialNumber = "SN-000042";
        attribute :>> lotNumber = "LOT-2025-11";
        attribute :>> manufactureDate = "2025-11-14";
        attribute :>> reprocessingHistorySummary = "37 autoclave cycles; last inspection passed";
        ref :>> definition = needleHolderDef;
    }
    connection : InstanceOf connect instance ::> needleHolderUnit42 to definition ::> needleHolderDef;

    // ── Role-typed usage in a task (§15): the product is referenced,
    //     never duplicated as an "operational tool". ────────────────
    action taskPlaceSutures : UserTask {
        attribute :>> id = "MSI-TASK-001";
        attribute :>> name = "PlaceSutures";
        attribute :>> taskGoal = "place interrupted sutures";
    }
    connection : UsesProduct connect using ::> taskPlaceSutures to product ::> needleHolder {
        attribute :>> productRole = ProductRoleKind::primaryInstrument;
        attribute :>> required = true;
        attribute :>> quantity = "1";
        attribute :>> sterileRequired = true;
        attribute :>> calibrationRequired = false;
    }
}
