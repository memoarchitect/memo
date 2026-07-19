package memo_starter_catalog {
    private import memo_medical_device_library::*;

    part starterDevice : MedicalDevice {
        attribute redefines name = "{{name}}";
    }

    requirement mainRequirement : Requirement {
        attribute redefines statement = "TODO: state the first system requirement.";
        doc /* TODO: define the first system requirement. */
    }
}
