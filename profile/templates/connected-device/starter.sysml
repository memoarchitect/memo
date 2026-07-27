package memo_connected_device_starter {
    private import memo::*;

    part connectedDevice : PhysicalAssembly;
    requirement connectivityRequirement : Requirement {
        attribute redefines statement = "Define connectivity and cybersecurity boundaries";
    }
}
