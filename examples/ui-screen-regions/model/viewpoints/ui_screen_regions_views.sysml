package memo_examples_ui_screen_regions_viewpoints {
    private import memo_examples_ui_screen_regions::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_ui_layout_ui_layout_viewpoint::*;
    private import memo_viewpoints_ui_layout_screen_layout_view::*;
    private import memo_viewpoints_requirements_requirements_viewpoint::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;
    private import memo_viewpoints_risk_risk_viewpoint::*;
    private import memo_core_enumerations::*;

    // The geometry view: the capture as backdrop, elements drawn at their
    // authored bounds. Images for a layout view live in
    // `model/assets/<viewName>/`, so this view's backdrop is under
    // `model/assets/mainScreenLayout/`.
    //
    // `viewKind` is bound by MemoScreenLayoutView and inherited here; SysIDE
    // rejects redeclaring a bound feature value. No `diagramType` is set —
    // geometry has no legacy intent to map from.
    view mainScreenLayout : MemoScreenLayoutView {
        expose memo_examples_ui_screen_regions::*;
        attribute :>> id = "UIE-001";
        attribute :>> title = "Main Infusion Screen — Region Layout";
        part :>> viewpointDefinition = uiLayoutViewpoint;
    }

    // The settings screen reached by NavigatesTo, rendered on its own capture.
    // One layout view per captured screen, and the view's name is the folder
    // its images live in — `model/assets/settingsScreenLayout/`.
    view settingsScreenLayout : MemoScreenLayoutView {
        expose memo_examples_ui_screen_regions::*;
        attribute :>> id = "UIE-008";
        attribute :>> title = "Infusion Settings Screen — Region Layout";
        part :>> viewpointDefinition = uiLayoutViewpoint;
    }

    // The same content as a graph, for reviewers who want to read the trace
    // chain rather than look at the screen.
    view uiRegionTrace : MemoDiagramView {
        expose memo_examples_ui_screen_regions::*;
        attribute :>> id = "UIV-001";
        attribute depth = 3;
        attribute :>> title = "UI Region Traceability";
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
        part :>> viewpointDefinition = uiLayoutViewpoint;
    }

    view uiRequirementsTrace : MemoDiagramView {
        expose memo_examples_ui_screen_regions::*;
        attribute depth = 3;
        attribute :>> id = "REQ-101";
        attribute :>> title = "UI Requirements Traceability";
        attribute :>> shortDescription = "Clinical need through UI requirements to satisfying regions and functions.";
        attribute :>> viewKind = DiagramViewKind::grid;
        attribute :>> diagramType = "req";
        attribute :>> autoPopulate = true;
        part :>> selectionQuery {
            attribute :>> id = "QRY-101";
            attribute :>> name = "UIRequirementsTraceQuery";
            attribute :>> includeElementKinds = ("Need", "Requirement", "UIElement", "SystemFunction", "VerificationCase");
            attribute :>> includeRelationshipKinds = ("DerivesFrom", "SatisfiedBy", "VerifiedBy");
            attribute :>> includeLayers = ("requirements", "implementation", "functions", "assurance");
            attribute :>> rationaleText = "Show the example's requirement derivation and satisfaction chain.";
        }
        part :>> viewpointDefinition = requirementsViewpoint;
    }

    view uiFunctionalTree : MemoDiagramView {
        expose memo_examples_ui_screen_regions::*;
        attribute depth = 3;
        attribute :>> id = "FUN-101";
        attribute :>> title = "Infusion UI Functional Tree";
        attribute :>> shortDescription = "Display-management functions, invoked actions, and UI allocation.";
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
        attribute :>> autoPopulate = true;
        part :>> selectionQuery {
            attribute :>> id = "QRY-102";
            attribute :>> name = "UIFunctionalTreeQuery";
            attribute :>> includeElementKinds = ("SystemFunction", "UIAction", "UIElement", "UserInterface");
            attribute :>> includeRelationshipKinds = ("Composes", "ElementTriggersAction", "ActionInvokesFunction", "AllocatedTo");
            attribute :>> includeLayers = ("functions", "implementation");
            attribute :>> rationaleText = "Show function decomposition from interaction to allocated user interface.";
        }
        part :>> viewpointDefinition = functionalViewpoint;
    }

    view uiRiskChain : MemoDiagramView {
        expose memo_examples_ui_screen_regions::*;
        attribute depth = 3;
        attribute :>> id = "RSK-101";
        attribute :>> title = "UI Risk and Control Chains";
        attribute :>> shortDescription = "Use errors through UI hazards to implemented controls and requirements.";
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "risk";
        attribute :>> autoPopulate = true;
        part :>> selectionQuery {
            attribute :>> id = "QRY-103";
            attribute :>> name = "UIRiskChainQuery";
            attribute :>> includeElementKinds = ("UseError", "Hazard", "RiskControlMeasure", "Requirement", "UIElement", "SystemFunction", "VerificationCase");
            attribute :>> includeRelationshipKinds = ("ErrorAtElement", "Causes", "Mitigates", "ControlImplementedBy", "DerivesFrom", "VerifiedBy");
            attribute :>> includeLayers = ("human_factors", "risk", "requirements", "implementation", "functions", "assurance");
            attribute :>> rationaleText = "Show both misread-rate and wrong-drug UI risk-control chains.";
        }
        part :>> viewpointDefinition = riskViewpoint;
    }
}
