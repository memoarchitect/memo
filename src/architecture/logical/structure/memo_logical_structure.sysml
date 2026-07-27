// Logical architecture (§10). Technology-independent structure: what parts of
// the solution exist and how they interact, before committing to software,
// electronics, or mechanics. Redundancy is expressed by typed channel roles
// plus independence constraints — never by duplicating identically named
// components.
package memo_architecture_logical_structure {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;

    // What a logical connection carries: information and control, but also
    // energy, material, fluid, and mechanical force (§10).
    enum def FlowContentKind {
        enum information;
        enum command;
        enum status;
        enum measurement;
        enum alarm;
        enum configuration;
        enum energy;
        enum material;
        enum fluid;
        enum mechanicalForce;
    }

    enum def ChannelRoleKind {
        enum primary;
        enum secondary;
        enum redundant;
        enum diverse;
        enum monitor;
        enum watchdog;
        enum interlock;
        enum independentProtection;
    }

    // The role a logical component plays. Was a subclass branch
    // (LogicalSystem / LogicalSubsystem / LogicalChannel / LogicalDataStore /
    // LogicalControlElement / LogicalUserInterface / LogicalExternalSystem);
    // now one attribute, because all of them share the same relationships and
    // differed only by a couple of descriptive attributes.
    enum def ComponentRoleKind {
        enum system;
        enum subsystem;
        enum channel;
        enum dataStore;
        enum controlElement;
        enum userInterface;
        enum externalSystem;
        enum generic;
    }

    // One logical component. `componentRole` selects what it is; the role-
    // specific attributes below are all optional so a component carries only
    // the ones its role needs. A channel claiming independence must still be
    // linked by IndependentOf with its basis stated.
    part def LogicalComponent specializes ArchitectureElement {
        attribute componentRole : ComponentRoleKind;
        attribute responsibility : String;
        attribute decompositionLevel : String;
        attribute safetyPartition : String;
        // system / subsystem
        attribute systemBoundaryDescription : String;
        // channel (safety role + diversity)
        attribute channelRole : ChannelRoleKind[0..1];
        attribute diversityBasis : String;
        // data store
        attribute persistenceRequirement : String;
        attribute integrityRequirement : String;
        // control element
        attribute controlLaw : String;
        attribute controlledVariable : String;
        // user interface
        attribute interactionSummary : String;
        // external system
        attribute externalOwner : String;
    }

    // Boundary features and contracts.
    port def LogicalPort specializes MemoPort {
        attribute contentKind : FlowContentKind;
    }
    interface def LogicalInterface specializes MemoInterface {
        attribute contentKind : FlowContentKind;
        attribute interactionPattern : String;
        end providerPort : LogicalPort;
        end consumerPort : ~LogicalPort;
    }
    item def LogicalExchangeItem specializes MemoExchangeItem {
        attribute contentKind : FlowContentKind;
    }

    // A typed logical connection between two components' ports.
    connection def LogicalConnector :> MemoRelationship {
        attribute contentKind : FlowContentKind;
        attribute direction : DirectionKind;
        end sourceComponent : LogicalComponent;
        end targetComponent : LogicalComponent;
    }
    // A transfer of a typed item across a connector.
    part def LogicalExchange specializes ArchitectureElement {
        attribute contentKind : FlowContentKind;
        attribute direction : DirectionKind;
        attribute latencyRequirement : String;
        ref exchangedItem : LogicalExchangeItem[0..1];
        ref sourcePort : LogicalPort[0..1];
        ref targetPort : LogicalPort[0..1];
    }

    // States and modes of the logical solution (kept distinct from UI state
    // and from physical device configuration).
    part def LogicalState specializes ArchitectureElement {
        attribute stateInvariant : String;
    }
    part def LogicalMode specializes ArchitectureElement {
        attribute modePurpose : String;
        attribute entryCondition : String;
        attribute exitCondition : String;
    }
    part def LogicalBehavior specializes ArchitectureElement {
        attribute behaviorSummary : String;
        attribute executionSemantics : String;
    }

    // Isolation, fault containment, and trust boundaries (§10).
    part def IsolationBoundary specializes ArchitectureElement {
        attribute boundaryKind : String;
        attribute isolationMechanism : String;
    }
    part def FaultContainmentRegion specializes ArchitectureElement {
        attribute containmentRationale : String;
    }

    // Claimed independence between channels (common-cause defense).
    connection def IndependentOf :> MemoRelationship {
        attribute independenceBasis : String;
        end channel : LogicalComponent;
        end otherChannel : LogicalComponent;
    }
    connection def MonitorsChannel :> MemoRelationship {
        end monitorChannel : LogicalComponent;
        end monitoredComponent : LogicalComponent;
    }
    connection def ExhibitsMode :> MemoRelationship {
        end component : LogicalComponent;
        end mode : LogicalMode;
    }
}
