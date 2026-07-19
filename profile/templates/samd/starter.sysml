package memo_samd_starter {
    private import memo_medical_device_library::*;

    part samdDevice : MedicalDevice;
    requirement clinicalPurpose : Requirement {
        attribute redefines statement = "Define the clinical purpose and intended user";
    }
}
