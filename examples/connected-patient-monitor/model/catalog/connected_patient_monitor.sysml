// Focused example: connected, distributed device system. Bedside monitor →
// gateway → hospital system, with typed network interfaces, a trust boundary
// at the hospital network edge, and an ISO/IEEE 11073-coded measurement item.
package memo_examples_connected_patient_monitor {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_terminology::*;
    private import memo_core_relationships::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_logical_interfaces::*;
    private import memo_assurance_cybersecurity::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part lcMonitor : LogicalComponent {
        @MemoIdentity { :>> providedId = "CPM-LC-001"; :>> label = "BedsideMonitor"; }
        attribute :>> responsibility = "Acquire and display vitals; publish measurements.";
        out port pSpo2Out : LogicalPort { out item spo2 :> spo2Item; }
    }
    part lcGateway : LogicalComponent {
        @MemoIdentity { :>> providedId = "CPM-LC-002"; :>> label = "WardGateway"; }
        attribute :>> responsibility = "Aggregate device data; bridge device LAN to hospital network.";
        in port pSpo2In : LogicalPort { in item spo2 :> spo2Item; }
        out port pHl7Out : LogicalPort;
    }
    part lcCdrService : LogicalComponent {
        @MemoIdentity { :>> providedId = "CPM-LC-003"; :>> label = "ClinicalDataRepository"; }
        attribute :>> externalOwner = "hospital IT";
        in port pHl7In : LogicalPort;
    }

    // Typed measurement item, coded against ISO/IEEE 11073-10101.
    item spo2Item : LogicalExchangeItem {
        @MemoIdentity { :>> providedId = "CPM-IT-001"; :>> label = "SpO2Measurement"; }
        attribute :>> contentKind = FlowContentKind::measurement;
        attribute :>> unit = "%";
        attribute :>> timestampRequired = true;
        attribute :>> codes = mdcSpo2;
    }
    attribute mdcSpo2 : TerminologyCode {
        attribute :>> systemUri = "urn:iso:std:iso:11073:10101";
        attribute :>> code = "150456";
        attribute :>> display = "MDC_PULS_OXIM_SAT_O2";
    }

    // The measurement crosses from the monitor's out port to the gateway's in
    // port; the item feature on each port is what it carries.
    flow exSpo2ToGateway : LogicalExchange from lcMonitor.pSpo2Out.spo2 to lcGateway.pSpo2In.spo2 {
        @MemoIdentity { :>> providedId = "CPM-EX-001"; :>> label = "SpO2ToGateway"; }
        attribute :>> contentKind = FlowContentKind::measurement;
    }
    connection : LogicalConnector connect sourceComponent ::> lcMonitor to targetComponent ::> lcGateway {
        attribute :>> contentKind = FlowContentKind::measurement;
        attribute :>> direction = DirectionKind::output;
    }
    connection : LogicalConnector connect sourceComponent ::> lcGateway to targetComponent ::> lcCdrService {
        attribute :>> contentKind = FlowContentKind::information;
        attribute :>> direction = DirectionKind::output;
    }

    // Network interface with cybersecurity properties: it connects the
    // gateway's HL7 port to the repository's across the trust boundary at the
    // hospital network edge.
    interface ifHl7Feed : SoftwareInterface connect lcGateway.pHl7Out to lcCdrService.pHl7In {
        @MemoIdentity { :>> providedId = "CPM-IF-001"; :>> label = "GatewayToCdrFeed"; }
        attribute :>> protocol = "HL7 FHIR REST over TLS 1.3";
        attribute :>> securityCriticality = CriticalityKind::high;
        attribute :>> patientContactInterface = false;
    }
    part tbHospitalEdge : TrustBoundary {
        @MemoIdentity { :>> providedId = "CPM-TB-001"; :>> label = "DeviceLanToHospitalNetwork"; }
    }
    connection : CrossesTrustBoundary connect boundary ::> tbHospitalEdge to crossingItem ::> ifHl7Feed {
        attribute :>> crossingKind = InterfaceKind::network;
    }
}
