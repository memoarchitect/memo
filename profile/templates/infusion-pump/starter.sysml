package memo_infusion_pump_starter {
    private import memo_medical_device_library::*;

    part infusionPump : MedicalDevice;
    requirement deliveryRequirement : Requirement {
        attribute redefines statement = "Define safe therapy delivery behavior";
    }
}
