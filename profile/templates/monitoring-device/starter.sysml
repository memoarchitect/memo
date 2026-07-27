package memo_monitoring_device_starter {
    private import memo::*;

    part monitoringDevice : PhysicalAssembly;
    requirement monitoringRequirement : Requirement {
        attribute redefines statement = "Define the monitored physiological parameter";
    }
}
