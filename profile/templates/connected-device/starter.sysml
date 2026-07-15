package memo_connected_device_starter {
    import memo_medical_device_library::*;

    part connectedDeviceSystem : System;
    requirement connectivityRequirement : Requirement {
        attribute redefines title = "Define connectivity and cybersecurity boundaries";
    }
}
