package memo_monitoring_device_starter {
    private import memo_medical_device_library::*;

    part monitoringDevice : MedicalDevice;
    requirement monitoringRequirement : Requirement {
        attribute redefines statement = "Define the monitored physiological parameter";
    }
}
