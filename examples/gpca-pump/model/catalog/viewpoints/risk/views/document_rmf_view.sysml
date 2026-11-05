package memo_examples_gpca_pump_viewpoints_risk_views_document_rmf_view {
    private import memo::*;
    private import ScalarValues::*;

    private import memo_examples_gpca_pump_gpca_verification::*;

    view rmfView : MemoDocumentView {
        expose memo_examples_gpca_pump_viewpoints_risk_views_document_rmf_view::*;
        expose evidenceLockout;
        @MemoIdentity { :>> providedId = "DOC-001"; :>> label = "Risk management file view"; :>> shortDescription = "Document-backed risk view for GPCA."; }
        doc /* Aggregates the risk chain, controls, verification, residual risk, and cybersecurity links needed for the GPCA risk management file. */
        attribute :>> version = "0.2.0";
        attribute :>> lifecycleState = LifecycleStateKind::development;
        attribute :>> viewKind = DocumentViewKind::RMF;
        attribute :>> generationRule = "Include risk chain, controls, verification, residual risk, and cybersecurity traceability";
        attribute :>> marketScope = "generic";
        ref :>> viewpointDefinition = riskViewpoint;
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-DOC-001"; :>> label = "RMF view query"; }
            attribute :>> includeElementKinds = ("IntendedUse", "ReasonablyForeseeableMisuse", "SafetyRelatedCharacteristic", "Hazard", "HazardCause", "SequenceOfEvents", "HazardousSituation", "Harm", "Risk", "RiskControlMeasure", "ResidualRisk", "Benefit", "OverallResidualRiskEvaluation", "VerificationCase", "MemoEvidence");
            attribute :>> includeRelationshipKinds = ("Causes", "Mitigates", "TracesRisk", "EstimatedFor", "ReducedBy", "EvaluatedIn", "AssessedAgainst", "VerifiedBy", "ProducesEvidence");
            attribute :>> rationaleText = "Declares what this document-backed view renders; the web renderer is presentation-only.";
        }
    }
}
