// Optional C4 viewpoint mapping (§22). C4 is NOT a foundational ontology:
// each C4 level is a correspondence onto existing MEMO viewpoints and
// element kinds. Nothing in memo/src depends on this package.
package memo_examples_c4_mapping {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    part def C4LevelMapping specializes MemoPart {
        attribute c4Level : String;
        attribute memoViewpoint : String;
        attribute memoElementKinds : String;
        attribute viewKind : DiagramViewKind;
    }

    part mapContext : C4LevelMapping {
        attribute :>> c4Level = "System Context";
        attribute :>> memoViewpoint = "SystemContextViewpoint";
        attribute :>> memoElementKinds = "MedicalDevice, Actor, ExternalSystemActor, LogicalExternalSystem";
        attribute :>> viewKind = DiagramViewKind::general;
    }
    part mapContainer : C4LevelMapping {
        attribute :>> c4Level = "Container";
        attribute :>> memoViewpoint = "RuntimeComponentViewpoint";
        attribute :>> memoElementKinds = "RuntimeComponent, Service, Container, DataStore, MessageBroker, ProcessingNode";
        attribute :>> viewKind = DiagramViewKind::interconnection;
    }
    part mapComponent : C4LevelMapping {
        attribute :>> c4Level = "Component";
        attribute :>> memoViewpoint = "SoftwareModuleViewpoint";
        attribute :>> memoElementKinds = "SoftwareComponent, SoftwareItem, SoftwareModule, SOUPComponent";
        attribute :>> viewKind = DiagramViewKind::general;
    }
    part mapCode : C4LevelMapping {
        attribute :>> c4Level = "Code";
        attribute :>> memoViewpoint = "(out of MEMO scope — source repositories)";
        attribute :>> memoElementKinds = "SoftwareUnit";
        attribute :>> viewKind = DiagramViewKind::general;
    }
}
