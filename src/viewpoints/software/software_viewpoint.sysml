package memo_viewpoints_software_software_viewpoint {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;
    private import memo_viewpoints_stakeholders_concerns::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    viewpoint softwareViewpoint : MemoViewpoint {
        @MemoIdentity { :>> providedId = "VP-SW"; }
        attribute :>> name = "SoftwareViewpoint";
        @MemoIdentity { :>> shortDescription = "Shows software systems, components, SOUP, and software interfaces."; }
        attribute :>> description = "Default viewpoint derived from the software structure layer for IEC 62304 software architecture description — software item decomposition, SOUP inventory, and software-to-software interfaces, distinct from system-level logical decomposition.";
        attribute :>> purpose = "Describe the software architecture for IEC 62304 design documentation.";
        ref :>> stakeholders = (SoftwareArchitect);
        attribute :>> stage = WorkflowStageKind::architecture;
        attribute :>> abstractionLevel = "software";
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::blockDiagram);
        ref :>> framedConcerns = (SafetyConcern, ReliabilityConcern);
        attribute :>> explorerLane = "architecture";
        attribute :>> explorerOrder = 4;
        attribute :>> userExtensible = true;
    }
}
