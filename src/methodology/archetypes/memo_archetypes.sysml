package memo_methodology_archetypes {
    private import ScalarValues::*;

    private import memo_methodology_core::*;

    part minimal : Archetype {
        attribute :>> id = "ARCH-MINIMAL";
        attribute :>> name = "Minimal";
        attribute :>> label = "Minimal";
        attribute :>> description = "Core ontology only — requirements, hazards, basic architecture (~53 kinds)";
        attribute :>> category = "profile";
        attribute :>> includedLayer = "context; requirements; risk";
        attribute :>> includedStandard = "ISO 14971";
        attribute :>> templateDir = "";
    }

    part standardArchetype : Archetype {
        attribute :>> id = "ARCH-STANDARD";
        attribute :>> name = "Standard";
        attribute :>> label = "Standard";
        attribute :>> description = "Core + risk + software + DHF — covers most Class II devices (~120 kinds)";
        attribute :>> category = "profile";
        attribute :>> includedLayer = "context; requirements; functions; logical_structure; software_structure; risk; assurance";
        attribute :>> includedStandard = "ISO 14971; IEC 62304; 21 CFR 820";
        attribute :>> templateDir = "";
    }

    part full : Archetype {
        attribute :>> id = "ARCH-FULL";
        attribute :>> name = "Full";
        attribute :>> label = "Full";
        attribute :>> description = "All architecture layers, standards, and extensions (~200+ kinds)";
        attribute :>> category = "profile";
        attribute :>> includedLayer = "context; requirements; functions; logical_structure; interfaces; software_structure; hardware_structure; behavior; risk; arch_risk; assurance; cybersecurity; constraints";
        attribute :>> includedStandard = "ISO 14971; IEC 62304; 21 CFR 820; ISO 13485; IEC 62366; IEC 60601-1; IEC 82304-1; FDA Cybersecurity Guidance";
        attribute :>> templateDir = "";
    }

    part samd : Archetype {
        attribute :>> id = "ARCH-SAMD";
        attribute :>> name = "SaMD";
        attribute :>> label = "Software as Medical Device (SaMD)";
        attribute :>> description = "Clinical decision support, diagnostic algorithm, AI/ML tool, mobile medical app";
        attribute :>> category = "device-class";
        attribute :>> includedLayer = "context; requirements; functions; logical_structure; software_structure; risk; assurance; cybersecurity";
        attribute :>> includedStandard = "ISO 14971; IEC 62304; IEC 82304-1; FDA Cybersecurity Guidance";
        attribute :>> templateDir = "samd";
    }

    part connected : Archetype {
        attribute :>> id = "ARCH-CONNECTED";
        attribute :>> name = "Connected";
        attribute :>> label = "Connected / IoT Device";
        attribute :>> description = "Remote monitoring, wearable, smart device with cloud connectivity and cybersecurity requirements";
        attribute :>> category = "device-class";
        attribute :>> includedLayer = "context; requirements; functions; logical_structure; interfaces; software_structure; hardware_structure; risk; assurance; cybersecurity";
        attribute :>> includedStandard = "ISO 14971; IEC 62304; 21 CFR 820; FDA Cybersecurity Guidance";
        attribute :>> templateDir = "connected-device";
    }

    part monitoring : Archetype {
        attribute :>> id = "ARCH-MONITORING";
        attribute :>> name = "Monitoring";
        attribute :>> label = "Monitoring / Diagnostic Device";
        attribute :>> description = "Patient monitor, ECG, SpO2, vital signs, bedside diagnostic equipment";
        attribute :>> category = "device-class";
        attribute :>> includedLayer = "context; requirements; functions; logical_structure; interfaces; software_structure; hardware_structure; risk; assurance";
        attribute :>> includedStandard = "ISO 14971; IEC 62304; IEC 60601-1; 21 CFR 820";
        attribute :>> templateDir = "monitoring-device";
    }

    part infusion_pump : Archetype {
        attribute :>> id = "ARCH-INFUSION";
        attribute :>> name = "InfusionPump";
        attribute :>> label = "Infusion / Drug Delivery Device";
        attribute :>> description = "Infusion pump, syringe driver, implantable drug delivery, dosing device";
        attribute :>> category = "device-class";
        attribute :>> includedLayer = "context; requirements; functions; logical_structure; interfaces; software_structure; hardware_structure; behavior; risk; arch_risk; assurance; cybersecurity";
        attribute :>> includedStandard = "ISO 14971; IEC 62304; IEC 60601-1; 21 CFR 820; ISO 13485";
        attribute :>> templateDir = "infusion-pump";
    }

    part blank : Archetype {
        attribute :>> id = "ARCH-BLANK";
        attribute :>> name = "Blank";
        attribute :>> label = "Blank Project";
        attribute :>> description = "Start from scratch with a minimal SysML shell";
        attribute :>> category = "device-class";
        attribute :>> includedLayer = "";
        attribute :>> includedStandard = "";
        attribute :>> templateDir = "";
    }
}
