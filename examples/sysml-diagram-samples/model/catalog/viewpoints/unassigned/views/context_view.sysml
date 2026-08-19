// System context sample (general view kind, `context` diagram type). The system
// under consideration is one block; every other element is an external actor,
// neighbouring system, or use context it interacts with across its boundary.
package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_context_view {
    private import ScalarValues::*;

    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_context_use_context::*;
    private import memo_architecture_operational_structure::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_context_context_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    // The operational system of interest is intentionally represented as one
    // black box. Context diagrams show its environment and interfaces, not its
    // internal decomposition.
    part infusionSystem : OperationalEntity {
        attribute :>> name = "Infusion Pump System";
        attribute :>> entityKind = OperationalEntityKind::device;
        attribute :>> responsibility = "System of interest for this context view.";
    }
    part clinician : User { attribute :>> name = "Clinician"; }
    part patient : User { attribute :>> name = "Patient"; }
    part biomedTech : User { attribute :>> name = "Biomedical Technician"; }
    part pharmacySystem : OperationalEntity {
        attribute :>> name = "Pharmacy Information System";
        attribute :>> entityKind = OperationalEntityKind::externalSystem;
    }
    part homeContext : UseContext { attribute :>> name = "Home Care Environment"; }

    connection connect clinician to infusionSystem;
    connection connect patient to infusionSystem;
    connection connect biomedTech to infusionSystem;
    flow from infusionSystem to pharmacySystem;
    connection : AppliesInContext connect useContext ::> homeContext to subjectElement ::> infusionSystem;

    view sampleContextView : MemoDiagramView {
        expose infusionSystem::**;
        expose clinician;
        expose patient;
        expose biomedTech;
        expose pharmacySystem;
        expose homeContext;
        attribute depth = 1;
        @MemoIdentity { :>> shortDescription = "Operational system context: one black-box system boundary, its external people, peer systems, operating environment, and named boundary-crossing interactions."; }
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "context";
        ref :>> viewpointDefinition = contextViewpoint;
        part :>> selectionQuery {
            attribute :>> includeRelationshipKinds = ("connect", "flow", "AppliesInContext");
        }
    }
}
