package memo_examples_sysml_diagram_samples_samples_package_view {
    private import memo::*;
    private import ScalarValues::*;


    // Three logical sub-packages: a presentation layer, a domain layer, and
    // an infrastructure layer.  Each package owns a few parts with ports so
    // the browser view has both depth and breadth to show.

    package presentation {
        part dashboardUI : LogicalComponent {
            @MemoIdentity { :>> label = "Dashboard UI"; }
            out port apiCall : DataPort { out item payload : MemoItem; }
        }
        part settingsUI : LogicalComponent {
            @MemoIdentity { :>> label = "Settings UI"; }
            out port configRequest : DataPort { out item payload : MemoItem; }
        }
    }

    package domain {
        part therapyEngine : LogicalComponent {
            @MemoIdentity { :>> label = "Therapy Engine"; }
            in port incomingRequest : DataPort { in item payload : MemoItem; }
            out port statusUpdate : DataPort { out item payload : MemoItem; }
        }
        part alarmManager : LogicalComponent {
            @MemoIdentity { :>> label = "Alarm Manager"; }
            in port trigger : DataPort { in item payload : MemoItem; }
        }
        part configService : LogicalComponent {
            @MemoIdentity { :>> label = "Configuration Service"; }
            in port configIn : DataPort { in item payload : MemoItem; }
        }
    }

    package infrastructure {
        part dataStore : LogicalComponent {
            @MemoIdentity { :>> label = "Data Store"; }
            in port writePort : DataPort { in item payload : MemoItem; }
            out port readPort : DataPort { out item payload : MemoItem; }
        }
        part networkAdapter : LogicalComponent {
            @MemoIdentity { :>> label = "Network Adapter"; }
            inout port netIO : DataPort { inout item payload : MemoItem; }
        }
    }
}
