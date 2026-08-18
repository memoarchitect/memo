package memo_examples_gpca_pump_viewpoints_usability_views_document_usability_view {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_usability_views_usability_engineering_view::*;
    private import memo_viewpoints_usability_usability_viewpoint::*;
    private import memo_core_enumerations::*;
    private import memo_examples_gpca_pump_gpca_verification::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view usabilityView : MemoUsabilityEngineeringView {
        expose memo_examples_gpca_pump_viewpoints_usability_views_document_usability_view::*;
        expose evidenceUsability;
        @MemoIdentity { :>> providedId = "DOC-008"; }
        attribute :>> name = "UsabilityEngineeringFileView";
        @MemoIdentity { :>> shortDescription = "IEC 62366-1 usability engineering file content for GPCA."; }
        attribute :>> description = "Aggregates intended use, use contexts, actors, foreseeable use errors, related risk chains, usability requirements, and the summative usability validation case.";
        attribute :>> version = "0.1";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> marketScope = "generic";
        ref :>> viewpointDefinition = usabilityViewpoint;
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-DOC-002"; }
            attribute :>> name = "usabilityViewQuery";
            attribute :>> includeElementKinds = ("UseError", "UseContext", "Actor", "ValidationCase", "OperativeScenario[scenarioKind=operative]", "IntendedUse", "ReasonablyForeseeableMisuse");
            attribute :>> includeRelationshipKinds = ("TestedByUsability", "RealizedByScenario", "InteractsWith");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
