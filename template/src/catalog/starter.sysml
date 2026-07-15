package memo_starter_catalog {
    import memo_medical_device_library::*;

    part starterSystem : System {
        attribute redefines name = "{{name}}";
    }

    requirement mainRequirement : Requirement {
        attribute redefines title = "Main system requirement";
        doc /* TODO: define the first system requirement. */
    }
}
