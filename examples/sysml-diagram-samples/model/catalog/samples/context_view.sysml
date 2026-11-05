package memo_examples_sysml_diagram_samples_samples_context_view {
    private import memo::*;
    // System context sample (general view kind, `context` diagram type). The system
    // under consideration is one block; every other element is an external actor,
    // neighbouring system, or use context it interacts with across its boundary.
    private import ScalarValues::*;


    // The operational system of interest is intentionally represented as one
    // black box. Context diagrams show its environment and interfaces, not its
    // internal decomposition.
    part infusionSystem : OperationalEntity {
        @MemoIdentity { :>> label = "Infusion Pump System"; }
        attribute :>> entityKind = OperationalEntityKind::device;
        attribute :>> responsibility = "System of interest for this context view.";
        out port pPharmacyOut : MemoPort;
    }
    part clinician : User { }
    part patient : User { }
    part biomedTech : User {@MemoIdentity { :>> label = "Biomedical Technician"; } }
    part pharmacySystem : OperationalEntity {
        @MemoIdentity { :>> label = "Pharmacy Information System"; }
        attribute :>> entityKind = OperationalEntityKind::externalSystem;
        in port pInfusionIn : MemoPort;
    }
    part homeContext : UseContext {@MemoIdentity { :>> label = "Home Care Environment"; } }

    connection connect clinician to infusionSystem;
    connection connect patient to infusionSystem;
    connection connect biomedTech to infusionSystem;
    // A flow end names a feature of its participant (`part.feature`): the black
    // boxes exchange across their boundary, at these ports.
    flow infusionSystemToPharmacySystem from infusionSystem.pPharmacyOut to pharmacySystem.pInfusionIn;
    connection : AppliesInContext connect homeContext to infusionSystem;
}
