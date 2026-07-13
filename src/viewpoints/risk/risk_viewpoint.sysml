package memo {
    package viewpoints {
        package risk {
            private import memo::viewpoints::definitions::*;
            private import memo::core::enumerations::*;

            part riskViewpoint : Viewpoint {
                attribute id = "VP-RISK";
                attribute name = "RiskViewpoint";
                attribute title = "Risk and Control Viewpoint";
                attribute shortDescription = "Shows hazards, risks, controls, and assurance links.";
                attribute longDescription = "Default viewpoint derived from the risk layer for ISO 14971-style reasoning across hazard, hazardous situation, harm, control, and verification evidence.";
                attribute purpose = "Communicate safety risk chains and controls.";
                attribute audience = {AudienceKind::safetyEngineer};
                attribute stage = WorkflowStageKind::risk;
                attribute abstractionLevel = "analysis";
                attribute outputKind = {ViewOutputKind::table};
                attribute presentationKind = {PresentationKind::riskTable};
                attribute concern = {ConcernKind::safety, ConcernKind::regulatory};
                attribute includedLayers = {"risk", "assurance"};
                attribute allowedElementKinds = {"Hazard", "HazardousSituation", "Harm", "Risk", "RiskControl", "VerificationCase"};
                attribute methodologyReference = {"iso14971-default"};
                attribute userExtensible = true;
            }
        }
    }
}
