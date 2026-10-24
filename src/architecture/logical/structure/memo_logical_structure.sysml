// Logical architecture (§10). Technology-independent structure: what parts of
// the solution exist and how they interact, before committing to software,
// electronics, or mechanics. Redundancy is expressed by typed channel roles
// plus independence constraints — never by duplicating identically named
// components.
package memo_architecture_logical_structure {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_logical_interfaces::Interface;

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
    // (LogicalChannel / LogicalDataStore / LogicalControlElement /
    // LogicalUserInterface / LogicalExternalSystem); now one attribute, because
    // those all share the same relationships and differed only by a couple of
    // descriptive attributes.
    //
    // System / Subsystem / SystemOfSystems are types below, not values here:
    // each admits a different set of children, and a value on an attribute
    // cannot carry containment legality.
    enum def ComponentRoleKind {
        enum channel;
        enum dataStore;
        enum controlElement;
        enum userInterface;
        enum externalSystem;
        enum generic;
    }

    // The discipline a logical block is realized in. Orthogonal to
    // `componentRole`: a subsystem may be software, a system may be hardware,
    // and a block whose realization is not yet decided stays `logical`.
    //
    // This does NOT relocate the element. The block remains logical-layer —
    // MEMO encodes layer by owning package, and this one is
    // memo_architecture_logical_structure. `systemType` records what the block
    // WILL BE realized in, which is a logical-architecture decision made
    // before any software or hardware element exists. Once those elements do
    // exist, AllocatedTo carries the actual allocation and this attribute
    // stays as the stated intent.
    enum def SystemTypeKind {
        enum logical;
        enum software;
        enum hardware;
    }

    // Who builds a system or system of systems: this organisation, or others.
    // Distinct from `componentRole`, which says what a logical component DOES
    // (an `externalSystem` is a role in a context). This says whose it is to
    // build, which decides what the project is responsible for delivering and
    // verifying versus what it only interfaces with.
    enum def SystemOriginKind {
        /** Built by this organisation: the project delivers and verifies it. */
        enum internal;
        /** Built by others: the project interfaces with it and relies on what its maker states. */
        enum external;
    }

    // ─── System hierarchy ────────────────────────────────────────
    // Three types rather than three role values, because they differ in what
    // they may CONTAIN — and containment legality cannot live on an attribute.
    //
    // The allowed children are declared as typed part features, which is how
    // SysML v2 already states "what may be contained". No new relationship is
    // introduced: `Composes` remains the single containment relation for
    // instances, exactly as everywhere else in MEMO. The features below say
    // which types are admissible; Composes records the actual links.

    part def SystemOfSystems specializes LogicalComponent {
        // Constituent systems are independently operated and independently
        // managed, collaborating for a capability none delivers alone
        // (ISO/IEC/IEEE 21841). A connected pump talking to a hospital
        // infusion-management server is one; a pump and its own pole-mounted
        // battery are not — which is why ownership is recorded here and is the
        // attribute that distinguishes an SoS from a merely large system.
        attribute systemBoundaryDescription : String;
        // A short code the system's part numbers are written under (for example GPCA). A label: nothing checks a part number against it.
        attribute systemPrefix : String[0..1];
        attribute origin : SystemOriginKind[0..1];
        attribute constituentOwnership : String;
        // A constituent may itself coordinate systems-of-systems, or it may be
        // an independently operated system. Subsystems and components remain
        // inside one of those constituent systems.
        part constituentSystemOfSystems : SystemOfSystems[0..*];
        part constituentSystem : System[0..*];
    }

    part def System specializes LogicalComponent {
        attribute systemBoundaryDescription : String;
        attribute origin : SystemOriginKind[0..1];
        part system : System[0..*];
        part subsystem : Subsystem[0..*];
        part component : LogicalComponent[0..*];
    }

    part def Subsystem specializes LogicalComponent {
        attribute systemBoundaryDescription : String;
        part subsystem : Subsystem[0..*];
        part component : LogicalComponent[0..*];
    }

    // One logical component. `componentRole` selects what it is, `systemType`
    // what it is realized in; the role-specific attributes below are all
    // optional so a component carries only the ones its role needs. A channel
    // claiming independence must still be linked by IndependentOf with its
    // basis stated.
    part def LogicalComponent specializes MemoPart {
        attribute componentRole : ComponentRoleKind;
        attribute systemType : SystemTypeKind[0..1];
        attribute responsibility : String;
        attribute decompositionLevel : String;
        attribute safetyPartition : String;
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
    port def LogicalPort specializes MemoPort;
    interface def LogicalInterface specializes Interface {
        attribute contentKind : FlowContentKind;
        end providerPort : LogicalPort;
        end consumerPort : ~LogicalPort;
    }
    item def LogicalExchangeItem specializes MemoItem {
        attribute contentKind : FlowContentKind;
    }

    // A typed logical connection between two components' ports.
    connection def LogicalConnector :> MemoRelationship {
        attribute contentKind : FlowContentKind;
        attribute direction : DirectionKind;
        end sourceComponent : LogicalComponent :>> source;
        end targetComponent : LogicalComponent :>> target;
    }
    abstract connection logicalConnectorLinks : LogicalConnector[*];
    metadata def <logicalConnector> LogicalConnectorMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = logicalConnectorLinks meta SysML::Usage;
    }
    // A transfer between two ports, carrying what a reader needs to know about
    // the transfer itself. Authored as a typed named flow between the item
    // features the two ports declare, the way `FunctionalExchange` is between
    // function parameters:
    //
    //     part lcMonitor { out port pSpo2Out : LogicalPort { out item spo2 :> spo2Item; } }
    //     flow exSpo2ToGateway : LogicalExchange
    //         from lcMonitor.pSpo2Out.spo2 to lcGateway.pSpo2In.spo2 {
    //         attribute :>> contentKind = FlowContentKind::measurement;
    //     }
    //
    // It was a `part def` holding `sourcePort`, `targetPort` and
    // `exchangedItem` refs. No example set either port, so no exchange said
    // what it connected. The flow's ends are those ports now,
    // and its payload the item feature on them. `direction` is not carried
    // over: the ports say `in` and `out`, and a second writable direction is
    // the duplicate §8 of the architecture plan forbids.
    //
    // The ends are not restricted to `LogicalPort`. Two of the three examples
    // move a specimen or a force between hardware parts, and a flow def that
    // named `LogicalPort` ends would have refused them. `payload` is not
    // declared either: `of <type>` on a usage of a flow def that declares a
    // feature is not distinguishable (namespace distinguishability) from the
    // library's own `payload`, so the payload lives on the ports.
    abstract flow def LogicalExchange {
        attribute contentKind : FlowContentKind;
        attribute latencyRequirement : String;
    }

    // States and modes of the logical solution (kept distinct from UI state
    // and from physical device configuration).

    part def LogicalBehavior specializes MemoPart {
        attribute behaviorSummary : String;
        attribute executionSemantics : String;
    }

    // Isolation, fault containment, and trust boundaries (§10).
    part def IsolationBoundary specializes MemoPart {
        attribute boundaryKind : String;
        attribute isolationMechanism : String;
    }
    part def FaultContainmentRegion specializes MemoPart {
        attribute containmentRationale : String;
    }

    // Claimed independence between channels (common-cause defense).
    connection def IndependentOf :> MemoRelationship {
        attribute independenceBasis : String;
        end channel : LogicalComponent :>> source;
        end otherChannel : LogicalComponent :>> target;
    }
    abstract connection independentOfLinks : IndependentOf[*];
    metadata def <independentOf> IndependentOfMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = independentOfLinks meta SysML::Usage;
    }
    // `MonitorsChannel` is native `dependency` (R10-S6): write
    // `dependency <monitorChannel> to <monitoredComponent>;` instead.

}
