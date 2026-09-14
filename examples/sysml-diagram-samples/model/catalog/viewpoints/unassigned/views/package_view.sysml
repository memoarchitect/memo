package memo_examples_sysml_diagram_samples_viewpoints_unassigned_views_package_view {
    private import memo_examples_sysml_diagram_samples_viewpoints_unassigned::*;
    private import ScalarValues::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_core_relationships::*;
    private import memo_viewpoints_definitions::*;
    private import memo_viewpoints_logical_logical_viewpoint::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;

    // Three logical sub-packages: a presentation layer, a domain layer, and
    // an infrastructure layer.  Each package owns a few parts with ports so
    // the browser view has both depth and breadth to show.

    package presentation {
        part dashboardUI : LogicalComponent {
            attribute :>> name = "Dashboard UI";
            out port apiCall : DataPort { out item payload : MemoItem; }
        }
        part settingsUI : LogicalComponent {
            attribute :>> name = "Settings UI";
            out port configRequest : DataPort { out item payload : MemoItem; }
        }
    }

    package domain {
        part therapyEngine : LogicalComponent {
            attribute :>> name = "Therapy Engine";
            in port incomingRequest : DataPort { in item payload : MemoItem; }
            out port statusUpdate : DataPort { out item payload : MemoItem; }
        }
        part alarmManager : LogicalComponent {
            attribute :>> name = "Alarm Manager";
            in port trigger : DataPort { in item payload : MemoItem; }
        }
        part configService : LogicalComponent {
            attribute :>> name = "Configuration Service";
            in port configIn : DataPort { in item payload : MemoItem; }
        }
    }

    package infrastructure {
        part dataStore : LogicalComponent {
            attribute :>> name = "Data Store";
            in port writePort : DataPort { in item payload : MemoItem; }
            out port readPort : DataPort { out item payload : MemoItem; }
        }
        part networkAdapter : LogicalComponent {
            attribute :>> name = "Network Adapter";
            inout port netIO : DataPort { inout item payload : MemoItem; }
        }
    }
}
