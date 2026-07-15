package memo_monitoring_device_starter {
    import memo_medical_device_library::*;

    part monitoringDeviceSystem : System;
    requirement monitoringRequirement : Requirement {
        attribute redefines title = "Define the monitored physiological parameter";
    }
}
