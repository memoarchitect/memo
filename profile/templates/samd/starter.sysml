package memo_samd_starter {
    import memo_medical_device_library::*;

    part samdSystem : System;
    requirement clinicalPurpose : Requirement {
        attribute redefines title = "Define the clinical purpose and intended user";
    }
}
