// Every view of the diagram gallery, in one package.
//
// Each sample's model content lives in its own file and package, next to
// this one, and is imported below. The views are gathered here so the
// explorer lists them together under each diagram-type viewpoint: a SysML
// root package is declared once, in one file, so a shared `diagram_samples`
// package cannot be split across the sample files themselves.
package diagram_samples {
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned::*;
    private import ScalarValues::*;
    private import memo_core_relationships::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_architecture_functional_functions::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_functional_functional_viewpoint::*;
    private import memo_core_enumerations::*;
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_architecture_operational_context_actors::*;
    private import memo_architecture_operational_use_cases::*;
    private import memo_architecture_operational_structure::*;
    private import memo_viewpoints_operational_operational_viewpoint::*;
    private import memo_architecture_operational_context_use_context::*;
    private import memo_viewpoints_context_context_viewpoint::*;
    private import memo_assurance_safety_risk_analysis::*;
    private import memo_viewpoints_logical_logical_viewpoint::*;
    private import memo_architecture_operational_activities::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_requirements::*;
    private import memo_viewpoints_requirements_requirements_viewpoint::*;
    private import activity_example::*;
    private import memo_architecture_functional_behavior::*;
    private import memo_architecture_implementation_hardware_structure::*;
    private import memo_architecture_realization_physical::*;
    private import memo_viewpoints_physical_physical_viewpoint::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_action_flow_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_browser_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_context_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_functional_flow_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_grid_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_interconnection_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_operational_behaviour_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_package_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_requirements_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_sequence_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_standard_activity_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_state_transition_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_tree_view::*;
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_use_case_view::*;

    // ─── action flow view ────────────────────────────────────────────────

    // Child action-flow view — the process composite action's own steps. Its
    // subject is `sampleActionFlow.process`, so the parent action-flow shows a
    // "navigate to view" button on the Process node.
    view processStepsDetail : MemoDiagramView {
        expose sampleActionFlow::process::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Internal steps of the Process action — step A through C."; }
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "afd";
        ref :>> viewpointDefinition = actionFlowViewpoint;
    }

    view therapySessionFlow : MemoDiagramView {
        expose sampleActionFlow::**;
        expose laneA;
        expose laneB;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Dummy actions, typed item flows, successions, and a composite action for renderer development."; }
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "afd";
        ref :>> viewpointDefinition = actionFlowViewpoint;
    }

    // ─── browser view ────────────────────────────────────────────────────

    view operationalBrowserTree : MemoDiagramView {
        expose controlSystem::**;
        expose systemOperator;
        expose maintenanceEngineer;
        expose remoteMonitor;
        expose startSystem::**;
        expose runDiagnostics::**;
        expose monitorStatus::**;
        @MemoIdentity { :>> shortDescription = "Browser membership tree showing operational entities, actors, and use cases — demonstrates the browser view kind with mixed element types."; }
        attribute :>> viewKind = DiagramViewKind::browser;
        attribute :>> diagramType = "brw";
        ref :>> viewpointDefinition = browserViewpoint;
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("OperationalEntity", "User", "UseCase");
            attribute :>> includeRelationshipKinds = ("Composes", "ParticipatesIn");
        }
    }

    // ─── context view ────────────────────────────────────────────────────

    view systemContextDiagram : MemoDiagramView {
        expose infusionSystem::**;
        expose clinician;
        expose patient;
        expose biomedTech;
        expose pharmacySystem;
        expose homeContext;
        attribute depth = 1;
        @MemoIdentity { :>> shortDescription = "Operational system context: one black-box system boundary, its external people, peer systems, operating environment, and named boundary-crossing interactions."; }
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "context";
        ref :>> viewpointDefinition = contextDiagramViewpoint;
        part :>> selectionQuery {
            attribute :>> includeRelationshipKinds = ("connect", "flow", "AppliesInContext");
        }
    }

    // ─── functional flow view ────────────────────────────────────────────

    view medicationDeliveryFlow : MemoDiagramView {
        expose fxDeliveryFlow::**;
        expose fxPumpSystem::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Component behaviour: functions in swimlanes per realising component, typed data/energy/material flows, a fork/join for concurrent occlusion monitoring, and a composite 'Deliver Medication' valve sub-flow (double-click to drill in)."; }
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ffd";
        ref :>> viewpointDefinition = actionFlowViewpoint;
    }

    // ─── grid view ───────────────────────────────────────────────────────

    view failureModeGrid : MemoDiagramView {
        expose fmMotorRunaway::**;
        expose fmAirSensorSilent::**;
        expose fmOcclusionDrift::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Three FailureMode rows rendered as an FMEA worksheet table — one section, columns auto-derived from the attributes the rows carry."; }
        attribute :>> viewKind = DiagramViewKind::grid;
        attribute :>> diagramType = "fmea";
        ref :>> viewpointDefinition = gridViewpoint;
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("FailureMode");
        }
    }

    // ─── interconnection view ────────────────────────────────────────────

    // Child IBD view — the heater assembly's own internal wiring. Its subject
    // is `heaterAssembly`, so the parent IBD shows a "navigate to view" button
    // on the Thermal Control Assembly part.
    view heaterAssemblyIBD : MemoDiagramView {
        expose coffeeMachine::heaterAssembly::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Internal wiring of the Thermal Control Assembly — heating element and its status output."; }
        attribute :>> viewKind = DiagramViewKind::interconnection;
        attribute :>> diagramType = "ibd";
        attribute :>> rendererProfile = "ibd";
        ref :>> viewpointDefinition = ibdViewpoint;
        part :>> selectionQuery {
            attribute :>> includeRelationshipKinds = ("Composes", "flow", "bind");
        }
    }

    view heatingElementIBD : MemoDiagramView {
        expose coffeeMachine::heaterAssembly::heatingElement::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Third-level IBD — resistive coil and temperature sensor inside the heating element."; }
        attribute :>> viewKind = DiagramViewKind::interconnection;
        attribute :>> diagramType = "ibd";
        attribute :>> rendererProfile = "ibd";
        ref :>> viewpointDefinition = ibdViewpoint;
        part :>> selectionQuery {
            attribute :>> includeRelationshipKinds = ("Composes", "flow", "bind");
        }
    }

    view beverageMachineIBD : MemoDiagramView {
        expose coffeeMachine::**;
        expose waterSupply::**;
        expose cup::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Balanced internal architecture with readable boundary ports, nested service diagnostics, and external water and beverage interfaces."; }
        attribute :>> viewKind = DiagramViewKind::interconnection;
        attribute :>> diagramType = "ibd";
        // The dedicated IBD renderer (Base -> Ibd class hierarchy): square
        // wall ports, orange-in/green-out, solid grabbable nested-connector
        // housings, orthogonal crossing-bridge routing, monochrome shading.
        attribute :>> rendererProfile = "ibd";
        ref :>> viewpointDefinition = ibdViewpoint;
        part :>> selectionQuery {
            attribute :>> includeRelationshipKinds = ("Composes", "flow", "bind");
        }
    }

    // ─── operational behaviour view ──────────────────────────────────────

    view clinicalSetupActivity : MemoDiagramView {
        expose opSetupFlow::**;
        expose opCareSystem::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Operational activity across clinical roles with concurrent preparation and a composite therapy step."; }
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "ofd";
        ref :>> viewpointDefinition = actionFlowViewpoint;
    }

    // ─── package view ────────────────────────────────────────────────────

    view threeLayerPackages : MemoDiagramView {
        expose presentation::**;
        expose domain::**;
        expose infrastructure::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Three-layer package overview — presentation, domain, infrastructure — rendered as a browser membership tree."; }
        attribute :>> viewKind = DiagramViewKind::browser;
        attribute :>> diagramType = "pkg";
        ref :>> viewpointDefinition = browserViewpoint;
        part :>> selectionQuery {
            attribute :>> includeRelationshipKinds = ("Composes");
        }
    }

    // ─── requirements view ───────────────────────────────────────────────

    view needsToRequirements : MemoDiagramView {
        expose needSafeTherapy::**;
        expose needTimelyAlarms::**;
        expose reqDoseLimit;
        expose reqOcclusionAlarm;
        expose reqAlarmLoudness;
        attribute depth = 1;
        @MemoIdentity { :>> shortDescription = "Stakeholder needs deriving into system requirements, wired by DerivesFrom trace edges."; }
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "req";
        ref :>> viewpointDefinition = requirementsDiagramViewpoint;
        part :>> selectionQuery {
            attribute :>> includeRelationshipKinds = ("DerivesFrom");
        }
    }

    // ─── sequence view ───────────────────────────────────────────────────

    view startInfusionSequence : MemoDiagramView {
        expose startInfusion::**;
        expose clinician::**;
        expose pumpController::**;
        expose pumpMechanism::**;
        expose monitorLoop::**;
        expose errorHandling::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Start-infusion sequence with combined fragments — loop for sensor monitoring and alt for error handling."; }
        attribute :>> viewKind = DiagramViewKind::sequence;
        attribute :>> diagramType = "seq";
        ref :>> viewpointDefinition = sequenceViewpoint;
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("FunctionalFlowStep", "User", "LogicalComponent", "Part");
        }
    }

    // ─── standard activity view ──────────────────────────────────────────

    view orderFulfillmentActivity : MemoDiagramView {
        expose FulfillOrder::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Order fulfilment — accept, validate, decide, fork into parallel shipment and invoice, join, notify, send receipt, and terminate."; }
        attribute :>> viewKind = DiagramViewKind::actionflow;
        attribute :>> diagramType = "afd";
        ref :>> viewpointDefinition = actionFlowViewpoint;
    }

    // ─── state transition view ───────────────────────────────────────────

    view pumpModeStateMachine : MemoDiagramView {
        expose pumpModes::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "A pump-mode state machine — Idle, Infusing, Paused, Alarm — where Infusing is a composite state nesting Priming, Delivering and Holding."; }
        attribute :>> viewKind = DiagramViewKind::statetransition;
        attribute :>> diagramType = "stm";
        ref :>> viewpointDefinition = stateMachineViewpoint;
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("StateMachine", "MemoState");
        }
    }

    view infusingSubStates : MemoDiagramView {
        expose pumpModes::infusing::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Sub-states of the Infusing composite state — Priming, Delivering, and Holding with their internal transitions."; }
        attribute :>> viewKind = DiagramViewKind::statetransition;
        attribute :>> diagramType = "stm";
        ref :>> viewpointDefinition = stateMachineViewpoint;
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("MemoState");
        }
    }

    // ─── tree view ───────────────────────────────────────────────────────

    view blockDecomposition : MemoDiagramView {
        expose rootA::**;
        attribute depth = 2;
        @MemoIdentity { :>> shortDescription = "Block decomposition tree — hardware assemblies with varied branch depths."; }
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "bdd";
        ref :>> viewpointDefinition = treeViewpoint;
        attribute :>> layoutHint = "tree";
        attribute :>> styleHint = "expanded:rootA,rootB,branchA1,branchB1";
        part :>> selectionQuery {
            attribute :>> includeRelationshipKinds = ("Composes");
        }
    }

    // ─── use case view ───────────────────────────────────────────────────

    view deviceUseCases : MemoDiagramView {
        expose patient;
        expose clinician;
        expose serviceTechnician;
        expose nursingStaff;
        expose reviewStatus;
        expose configureTherapy;
        expose maintainDevice;
        expose documentTreatment;
        expose validateTherapySettings;
        @MemoIdentity { :>> shortDescription = "Actors outside a device boundary with include, extend, generalization, hierarchy-level, and orthogonal-routing presentation."; }
        attribute :>> viewKind = DiagramViewKind::general;
        attribute :>> diagramType = "ucd";
        ref :>> viewpointDefinition = useCaseViewpoint;
        part :>> selectionQuery {
            attribute :>> includeElementKinds = ("User", "UseCase");
            attribute :>> includeRelationshipKinds = ("ParticipatesIn", "IncludesStep", "Extends", "Specialization");
        }
        attribute :>> layoutHint = "usecase:level=all;edge=rounded";
    }
}
