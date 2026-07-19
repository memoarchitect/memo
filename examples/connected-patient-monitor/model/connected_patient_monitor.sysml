// Focused example: connected, distributed device system. Bedside monitor →
// gateway → hospital system, with typed network interfaces, a trust boundary
// at the hospital network edge, and an ISO/IEEE 11073-coded measurement item.
package memo_examples_connected_patient_monitor {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_terminology::*;
    private import memo_core_relationships::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_interfaces::*;
    private import memo_architecture_cybersecurity::*;
    private import memo_medical_products_definitions::*;

    part monitorDef : MedicalDeviceDefinition {
        attribute :>> id = "CPM-DEF-001"; attribute :>> name = "BedsideMonitor_M300";
        attribute :>> technologyDomains = (
            TechnologyDomainKind::electrical,
            TechnologyDomainKind::electronic,
            TechnologyDomainKind::software);
    }

    part lcMonitor : LogicalComponent {
        attribute :>> id = "CPM-LC-001"; attribute :>> name = "BedsideMonitor";
        attribute :>> responsibility = "Acquire and display vitals; publish measurements.";
    }
    part lcGateway : LogicalComponent {
        attribute :>> id = "CPM-LC-002"; attribute :>> name = "WardGateway";
        attribute :>> responsibility = "Aggregate device data; bridge device LAN to hospital network.";
    }
    part lcCdrService : LogicalExternalSystem {
        attribute :>> id = "CPM-LC-003"; attribute :>> name = "ClinicalDataRepository";
        attribute :>> externalOwner = "hospital IT";
    }

    // Typed measurement item, coded against ISO/IEEE 11073-10101.
    item spo2Item : LogicalExchangeItem {
        attribute :>> id = "CPM-IT-001"; attribute :>> name = "SpO2Measurement";
        attribute :>> contentKind = FlowContentKind::measurement;
        attribute :>> unit = "%";
        attribute :>> timestampRequired = true;
        attribute :>> codes = mdc_spo2;
    }
    attribute mdc_spo2 : TerminologyCode {
        attribute :>> systemUri = "urn:iso:std:iso:11073:10101";
        attribute :>> code = "150456";
        attribute :>> display = "MDC_PULS_OXIM_SAT_O2";
    }

    part exSpo2ToGateway : LogicalExchange {
        attribute :>> id = "CPM-EX-001"; attribute :>> name = "SpO2ToGateway";
        attribute :>> contentKind = FlowContentKind::measurement;
        attribute :>> direction = DirectionKind::output;
        ref :>> exchangedItem = spo2Item;
    }
    connection : LogicalConnector connect sourceComponent ::> lcMonitor to targetComponent ::> lcGateway {
        attribute :>> contentKind = FlowContentKind::measurement;
        attribute :>> direction = DirectionKind::output;
    }
    connection : LogicalConnector connect sourceComponent ::> lcGateway to targetComponent ::> lcCdrService {
        attribute :>> contentKind = FlowContentKind::information;
        attribute :>> direction = DirectionKind::output;
    }

    // Network interface with cybersecurity properties; trust boundary at the
    // hospital network edge.
    part ifHl7Feed : EthernetInterface {
        attribute :>> id = "CPM-IF-001"; attribute :>> name = "GatewayToCdrFeed";
        attribute :>> protocol = "HL7 FHIR REST over TLS 1.3";
        attribute :>> securityCriticality = CriticalityKind::high;
        attribute :>> patientContactInterface = false;
    }
    item tbHospitalEdge : TrustBoundary {
        attribute :>> id = "CPM-TB-001"; attribute :>> name = "DeviceLanToHospitalNetwork";
    }
    connection : CrossesTrustBoundary connect boundary ::> tbHospitalEdge to crossingItem ::> ifHl7Feed {
        attribute :>> crossingKind = InterfaceKind::network;
    }
}
