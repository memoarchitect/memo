package memo_examples_gpca_pump_viewpoints_risk_views_risk_fmea_view {
    private import memo::*;
    private import ScalarValues::*;


    view gpcaFmeaView : MemoDiagramView {
        expose memo_examples_gpca_pump_viewpoints_risk_views_risk_fmea_view::*;
        attribute depth = 2;
        @MemoIdentity { :>> providedId = "VIEW-RISK-102"; :>> label = "GPCA_FmeaView"; :>> shortDescription = "Failure modes with causes, effects, detection, RPN, and the overdose fault tree."; }
        attribute :>> outputKind = (ViewOutputKind::table);
        attribute :>> presentationKind = (PresentationKind::riskTable);
        attribute :>> viewKind = DiagramViewKind::grid;
        attribute :>> diagramType = "fmea";
        attribute :>> dataSourceDescription = "GPCA FMEA worksheet, failure modes, fault tree events, gates, and cut sets";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "Include FMEA worksheet rows and the overdose fault tree structure.";
        part :>> selectionQuery {
            @MemoIdentity { :>> providedId = "QRY-RISK-102"; :>> label = "GPCA_FmeaQuery"; }
            attribute :>> includeElementKinds = ("FMEAWorksheet", "FailureMode", "FailureEffect", "FailureCause", "DetectionMethod", "FMEAAction", "FaultTree", "FaultTreeNode", "MinimalCutSet");
            attribute :>> includeLayers = ("analysis", "risk");
            attribute :>> includeConcerns = (ConcernKind::safety, ConcernKind::reliability);
            attribute :>> selectionExpression = "product == 'GPCA'";
            attribute :>> rationaleText = "Auto-populate the FMEA/FTA view from the analysis layer.";
        }
        ref :>> viewpointDefinition = riskViewpoint;
    }
}
