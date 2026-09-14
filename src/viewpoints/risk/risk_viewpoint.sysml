package memo_viewpoints_risk_risk_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;
    private import memo_viewpoints_stakeholders_concerns::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    viewpoint riskViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-RISK"; }
        attribute :>> name = "RiskViewpoint";
        @MemoIdentity { :>> shortDescription = "Shows hazards, risks, controls, and assurance links."; }
        attribute :>> description = "Default viewpoint derived from the risk layer for ISO 14971-style reasoning across hazard, hazardous situation, harm, control, and verification evidence.";
        attribute :>> purpose = "Communicate safety risk chains and controls.";
        ref :>> stakeholders = (safetyEngineer);
        attribute :>> stage = WorkflowStageKind::risk;
        attribute :>> abstractionLevel = "analysis";
        attribute :>> outputKind = (ViewOutputKind::table);
        attribute :>> presentationKind = (PresentationKind::riskTable);
        ref :>> framedConcerns = (safetyConcern, regulatoryConcern);
        attribute :>> explorerLane = "assurance";
        attribute :>> explorerOrder = 2;
        attribute :>> userExtensible = true;
    }
}
