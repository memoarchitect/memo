// System context sample (general view kind, `context` diagram type). The system
// under consideration is one block; every other element is an external actor,
// neighbouring system, or use context it interacts with across its boundary.
package memo_examples_sysml_diagram_samples_model_samples_context_view {
    private import ScalarValues::*;

    private import memo_context_actors::*;
    private import memo_context_use_context::*;
    private import memo_medical_products_definitions::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    part infusionSystem : MedicalDevice { attribute :>> name = "Infusion Pump System"; }
    part clinician : User { attribute :>> name = "Clinician"; }
    part patient : User { attribute :>> name = "Patient"; }
    part biomedTech : User { attribute :>> name = "Biomedical Technician"; }
    part pharmacySystem : MedicalDevice { attribute :>> name = "Pharmacy Information System"; }
    part homeContext : UseContext { attribute :>> name = "Home Care Environment"; }

    connection : InteractsWith connect contextParticipant ::> clinician to target ::> infusionSystem;
    connection : InteractsWith connect contextParticipant ::> patient to target ::> infusionSystem;
    connection : InteractsWith connect contextParticipant ::> biomedTech to target ::> infusionSystem;
    connection : ExchangesWith connect source ::> infusionSystem to target ::> pharmacySystem;
    connection : AppliesInContext connect useContext ::> homeContext to subjectElement ::> infusionSystem;

    view sampleContextView : MemoDiagramView {
        expose infusionSystem::**;
        attribute depth = 1;
        attribute :>> title = "Sample · System Context";
        attribute :>> shortDescription = "The system as a single block surrounded by the external actors, neighbouring systems, and use context it exchanges with across its boundary.";
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "context";
        part :>> selectionQuery {
            attribute :>> includeRelationshipKinds = ("InteractsWith", "ExchangesWith", "AppliesInContext");
        }
    }

    connection : IncludedIn connect sourceElement ::> infusionSystem to targetView ::> sampleContextView;
    connection : IncludedIn connect sourceElement ::> clinician to targetView ::> sampleContextView;
    connection : IncludedIn connect sourceElement ::> patient to targetView ::> sampleContextView;
    connection : IncludedIn connect sourceElement ::> biomedTech to targetView ::> sampleContextView;
    connection : IncludedIn connect sourceElement ::> pharmacySystem to targetView ::> sampleContextView;
    connection : IncludedIn connect sourceElement ::> homeContext to targetView ::> sampleContextView;
}
