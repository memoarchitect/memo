package memo_infusion_pump_starter {
    import memo_medical_device_library::*;

    part infusionPumpSystem : System;
    requirement deliveryRequirement : Requirement {
        attribute redefines title = "Define safe therapy delivery behavior";
    }
}
