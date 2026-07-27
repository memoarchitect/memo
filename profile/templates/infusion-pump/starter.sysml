package memo_infusion_pump_starter {
    private import memo::*;

    part infusionPump : PhysicalAssembly;
    requirement deliveryRequirement : Requirement {
        attribute redefines statement = "Define safe therapy delivery behavior";
    }
}
