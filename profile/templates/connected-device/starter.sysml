package memo_connected_device_starter {
    private import memo_medical_device_library::*;

    part connectedDevice : MedicalDevice;
    requirement connectivityRequirement : Requirement {
        attribute redefines statement = "Define connectivity and cybersecurity boundaries";
    }
}
