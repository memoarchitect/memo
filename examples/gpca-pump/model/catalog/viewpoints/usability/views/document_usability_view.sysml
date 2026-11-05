package memo_examples_gpca_pump_viewpoints_usability_views_document_usability_view {
    private import memo::*;
    private import ScalarValues::*;

    private import memo_examples_gpca_pump_gpca_verification::*;

    view usabilityView : MemoUsabilityEngineeringView {
        expose memo_examples_gpca_pump_viewpoints_usability_views_document_usability_view::*;
        expose evidenceUsability;
        @MemoIdentity { :>> providedId = "DOC-008"; :>> label = "Usability engineering file view"; :>> shortDescription = "IEC 62366-1 usability engineering file content for GPCA."; }
        doc /* Aggregates intended use, use contexts, actors, foreseeable use errors, related risk chains, usability requirements, and the summative usability validation case. */
        attribute :>> version = "0.1.0";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> marketScope = "generic";
        ref :>> viewpointDefinition = usabilityViewpoint;
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-DOC-002"; :>> label = "Usability view query"; }
            attribute :>> includeElementKinds = ("UseError", "UseContext", "OperationalParticipant", "ValidationCase", "OperativeScenario", "IntendedUse", "ReasonablyForeseeableMisuse");
            attribute :>> includeRelationshipKinds = ("TestedByUsability", "RealizedByScenario", "connect");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
