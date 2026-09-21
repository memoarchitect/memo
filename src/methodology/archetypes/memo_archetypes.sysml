package memo_methodology_archetypes {
    private import ScalarValues::*;

    private import memo_methodology_core::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part minimal : Archetype {
        @MemoIdentity { :>> providedId = "ARCH-MINIMAL"; }
        attribute :>> label = "Minimal";
        doc /* Core ontology only — requirements, hazards, basic architecture (~53 kinds) */
        attribute :>> category = "profile";
        attribute :>> includedLayer = "context; requirements; risk";
        attribute :>> includedStandard = "ISO 14971";
        attribute :>> templateDir = "";
    }

    part standardArchetype : Archetype {
        @MemoIdentity { :>> providedId = "ARCH-STANDARD"; }
        attribute :>> label = "Standard";
        doc /* Core + risk + software + DHF — covers most Class II devices (~120 kinds) */
        attribute :>> category = "profile";
        attribute :>> includedLayer = "context; requirements; functions; logical_structure; software_structure; risk; assurance";
        attribute :>> includedStandard = "ISO 14971; IEC 62304; 21 CFR 820";
        attribute :>> templateDir = "";
    }

    part full : Archetype {
        @MemoIdentity { :>> providedId = "ARCH-FULL"; }
        attribute :>> label = "Full";
        doc /* All architecture layers, standards, and extensions (~200+ kinds) */
        attribute :>> category = "profile";
        attribute :>> includedLayer = "context; requirements; functions; logical_structure; interfaces; software_structure; hardware_structure; behavior; risk; arch_risk; assurance; cybersecurity; constraints";
        attribute :>> includedStandard = "ISO 14971; IEC 62304; 21 CFR 820; ISO 13485; IEC 62366; IEC 60601-1; IEC 82304-1; FDA Cybersecurity Guidance";
        attribute :>> templateDir = "";
    }

    part samd : Archetype {
        @MemoIdentity { :>> providedId = "ARCH-SAMD"; }
        attribute :>> label = "Software as Medical Device (SaMD)";
        doc /* Clinical decision support, diagnostic algorithm, AI/ML tool, mobile medical app */
        attribute :>> category = "device-class";
        attribute :>> includedLayer = "context; requirements; functions; logical_structure; software_structure; risk; assurance; cybersecurity";
        attribute :>> includedStandard = "ISO 14971; IEC 62304; IEC 82304-1; FDA Cybersecurity Guidance";
        attribute :>> templateDir = "samd";
    }

    part connected : Archetype {
        @MemoIdentity { :>> providedId = "ARCH-CONNECTED"; }
        attribute :>> label = "Connected / IoT Device";
        doc /* Remote monitoring, wearable, smart device with cloud connectivity and cybersecurity requirements */
        attribute :>> category = "device-class";
        attribute :>> includedLayer = "context; requirements; functions; logical_structure; interfaces; software_structure; hardware_structure; risk; assurance; cybersecurity";
        attribute :>> includedStandard = "ISO 14971; IEC 62304; 21 CFR 820; FDA Cybersecurity Guidance";
        attribute :>> templateDir = "connected-device";
    }

    part monitoring : Archetype {
        @MemoIdentity { :>> providedId = "ARCH-MONITORING"; }
        attribute :>> label = "Monitoring / Diagnostic Device";
        doc /* Patient monitor, ECG, SpO2, vital signs, bedside diagnostic equipment */
        attribute :>> category = "device-class";
        attribute :>> includedLayer = "context; requirements; functions; logical_structure; interfaces; software_structure; hardware_structure; risk; assurance";
        attribute :>> includedStandard = "ISO 14971; IEC 62304; IEC 60601-1; 21 CFR 820";
        attribute :>> templateDir = "monitoring-device";
    }

    part infusion_pump : Archetype {
        @MemoIdentity { :>> providedId = "ARCH-INFUSION"; }
        attribute :>> label = "Infusion / Drug Delivery Device";
        doc /* Infusion pump, syringe driver, implantable drug delivery, dosing device */
        attribute :>> category = "device-class";
        attribute :>> includedLayer = "context; requirements; functions; logical_structure; interfaces; software_structure; hardware_structure; behavior; risk; arch_risk; assurance; cybersecurity";
        attribute :>> includedStandard = "ISO 14971; IEC 62304; IEC 60601-1; 21 CFR 820; ISO 13485";
        attribute :>> templateDir = "infusion-pump";
    }

    part blank : Archetype {
        @MemoIdentity { :>> providedId = "ARCH-BLANK"; }
        attribute :>> label = "Blank Project";
        doc /* Start from scratch with a minimal SysML shell */
        attribute :>> category = "device-class";
        attribute :>> includedLayer = "";
        attribute :>> includedStandard = "";
        attribute :>> templateDir = "";
    }
}
