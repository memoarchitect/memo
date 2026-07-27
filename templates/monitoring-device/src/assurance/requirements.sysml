package monitoring_device_assurance {
    private import memo::*;

    requirement monitoringRequirement : Requirement {
        attribute redefines statement = "Define the monitored physiological parameter";
    }
}
