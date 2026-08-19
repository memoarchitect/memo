// Clause-level conformance for the GPCA pump example.
//
// The standards library (src/artifacts/standards/) is MEMO content: it says
// which clauses exist. This file is PROJECT content: it says which of this
// project's elements claim them, and where the evidence is written down. That
// division is the two-mechanism rule in memo_artifacts_standards_traceability
// — @StandardReference is library provenance, ConformsTo is project
// traceability — and it is why the clause instances carry no project data and
// this file declares no clauses.
//
// It exists so the DHF standards-traceability, SAD conformance and HRS clause
// tables render real rows. A `select: relationships` query over ConformsTo is
// only as good as the edges a project authors, and an example with none cannot
// tell a working matrix apart from a broken one.
package memo_examples_gpca_pump_gpca_standards {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_core::*;
    private import memo_artifacts_standards_traceability::*;
    private import memo_artifacts_standards_iec_62304::*;
    private import memo_artifacts_standards_iec_60601_1::*;
    private import memo_artifacts_standards_iec_60601_1_2::*;
    private import memo_artifacts_standards_iso_14971::*;
    private import memo_examples_gpca_pump_gpca_requirements::*;
    private import memo_examples_gpca_pump_gpca_architecture::*;
    private import memo_examples_gpca_pump_gpca_physical::*;
    private import memo_examples_gpca_pump_gpca_risk::*;

    private import memo_core_common::MemoIdentity;
    // ── The controlled documents clause evidence lands in ────────────────
    // TracesToDocument targets ControlledArtifact, so the DHF documents are
    // modelled as the artifacts they are rather than as a second document type.

    part docSrs : MarkdownDocumentSource {
        @MemoIdentity { :>> providedId = "DOC-SRS"; }
        attribute :>> name = "SoftwareRequirementsSpecification";
        attribute :>> version = "1.0";
        attribute :>> artifactKind = ArtifactKind::requirementSpecification;
        attribute :>> owner = "Software Lead";
        attribute :>> approvalStatus = "approved";
        attribute :>> uri = "dhf/documents/srs.md";
        attribute :>> mediaType = "text/markdown";
        attribute :>> contentHash = "";
        attribute :>> generated = true;
    }
    part docSad : MarkdownDocumentSource {
        @MemoIdentity { :>> providedId = "DOC-SAD"; }
        attribute :>> name = "SoftwareArchitectureDescription";
        attribute :>> version = "1.0";
        attribute :>> artifactKind = ArtifactKind::architectureDescription;
        attribute :>> owner = "Systems Architect";
        attribute :>> approvalStatus = "approved";
        attribute :>> uri = "dhf/documents/sad.md";
        attribute :>> mediaType = "text/markdown";
        attribute :>> contentHash = "";
        attribute :>> generated = true;
    }
    part docHrs : MarkdownDocumentSource {
        @MemoIdentity { :>> providedId = "DOC-HRS"; }
        attribute :>> name = "HardwareRequirementsSpecification";
        attribute :>> version = "1.0";
        attribute :>> artifactKind = ArtifactKind::requirementSpecification;
        attribute :>> owner = "Hardware Lead";
        attribute :>> approvalStatus = "approved";
        attribute :>> uri = "dhf/documents/hrs.md";
        attribute :>> mediaType = "text/markdown";
        attribute :>> contentHash = "";
        attribute :>> generated = true;
    }
    part docRmf : MarkdownDocumentSource {
        @MemoIdentity { :>> providedId = "DOC-RMF"; }
        attribute :>> name = "RiskManagementFile";
        attribute :>> version = "1.0";
        attribute :>> artifactKind = ArtifactKind::riskRecord;
        attribute :>> owner = "Risk Manager";
        attribute :>> approvalStatus = "approved";
        attribute :>> uri = "dhf/documents/rmf.md";
        attribute :>> mediaType = "text/markdown";
        attribute :>> contentHash = "";
        attribute :>> generated = true;
    }

    // ── IEC 62304 — software lifecycle ───────────────────────────────────
    // §5.2.2 software requirements content: every software requirement.
    connection : ConformsTo connect conformingElement ::> reqOcclusion to clause ::> iec62304::iec62304Clause5::iec62304Clause5_2::iec62304Clause5_2_2;
    connection : ConformsTo connect conformingElement ::> reqDoorOpen to clause ::> iec62304::iec62304Clause5::iec62304Clause5_2::iec62304Clause5_2_2;
    connection : ConformsTo connect conformingElement ::> reqMaxHourlyDose to clause ::> iec62304::iec62304Clause5::iec62304Clause5_2::iec62304Clause5_2_2;
    connection : ConformsTo connect conformingElement ::> reqEventLogging to clause ::> iec62304::iec62304Clause5::iec62304Clause5_2::iec62304Clause5_2_2;
    connection : ConformsTo connect conformingElement ::> reqWatchdogSafeState to clause ::> iec62304::iec62304Clause5::iec62304Clause5_2::iec62304Clause5_2_2;
    connection : ConformsTo connect conformingElement ::> reqStuckButton to clause ::> iec62304::iec62304Clause5::iec62304Clause5_2::iec62304Clause5_2_2;
    connection : ConformsTo connect conformingElement ::> reqFlowCrossCheck to clause ::> iec62304::iec62304Clause5::iec62304Clause5_2::iec62304Clause5_2_2;

    // §5.2.3 risk control measures carried into software requirements.
    connection : ConformsTo connect conformingElement ::> reqWatchdogSafeState to clause ::> iec62304::iec62304Clause5::iec62304Clause5_2::iec62304Clause5_2_3;
    connection : ConformsTo connect conformingElement ::> reqFlowCrossCheck to clause ::> iec62304::iec62304Clause5::iec62304Clause5_2::iec62304Clause5_2_3;

    // §5.3 software architectural design: the software decomposition.
    connection : ConformsTo connect conformingElement ::> gpcaDevice.gpcaSoftware to clause ::> iec62304::iec62304Clause5::iec62304Clause5_3;
    connection : ConformsTo connect conformingElement ::> gpcaDevice.gpcaSoftware.tlm to clause ::> iec62304::iec62304Clause5::iec62304Clause5_3;
    connection : ConformsTo connect conformingElement ::> gpcaDevice.gpcaSoftware.infusionMgr to clause ::> iec62304::iec62304Clause5::iec62304Clause5_3;
    connection : ConformsTo connect conformingElement ::> gpcaDevice.gpcaSoftware.systemMonitor to clause ::> iec62304::iec62304Clause5::iec62304Clause5_3;
    connection : ConformsTo connect conformingElement ::> gpcaDevice.gpcaSoftware.config to clause ::> iec62304::iec62304Clause5::iec62304Clause5_3;

    // ── IEC 60601-1 — basic safety and essential performance ─────────────
    // §8 protection against electrical hazards.
    connection : ConformsTo connect conformingElement ::> reqBatteryBackup to clause ::> iec60601_1::iec60601_1Clause8;
    connection : ConformsTo connect conformingElement ::> powerSupply to clause ::> iec60601_1::iec60601_1Clause8;
    connection : ConformsTo connect conformingElement ::> batteryPack to clause ::> iec60601_1::iec60601_1Clause8;

    // §9 protection against mechanical hazards.
    connection : ConformsTo connect conformingElement ::> reqFreeFlowPrevention to clause ::> iec60601_1::iec60601_1Clause9;
    connection : ConformsTo connect conformingElement ::> antiFreeFlowValve to clause ::> iec60601_1::iec60601_1Clause9;
    connection : ConformsTo connect conformingElement ::> enclosure to clause ::> iec60601_1::iec60601_1Clause9;

    // §14 programmable electrical medical systems.
    connection : ConformsTo connect conformingElement ::> gpcaDevice.gpcaSoftware to clause ::> iec60601_1::iec60601_1Clause14;

    // ── IEC 60601-1-2 — electromagnetic compatibility ────────────────────
    connection : ConformsTo connect conformingElement ::> controllerBoard to clause ::> iec60601_1_2::iec60601_1_2Clause7;
    connection : ConformsTo connect conformingElement ::> controllerBoard to clause ::> iec60601_1_2::iec60601_1_2Clause8;
    connection : ConformsTo connect conformingElement ::> reqPost to clause ::> iec60601_1_2::iec60601_1_2Clause8;

    // ── ISO 14971 — risk management ──────────────────────────────────────
    // §7 risk control: the risk control measures themselves.
    connection : ConformsTo connect conformingElement ::> lockoutControl to clause ::> iso14971::iso14971Clause7;
    connection : ConformsTo connect conformingElement ::> occlusionAlarmControl to clause ::> iso14971::iso14971Clause7;
    connection : ConformsTo connect conformingElement ::> airDetectionControl to clause ::> iso14971::iso14971Clause7;
    connection : ConformsTo connect conformingElement ::> freeFlowValveControl to clause ::> iso14971::iso14971Clause7;
    connection : ConformsTo connect conformingElement ::> doorInterlockControl to clause ::> iso14971::iso14971Clause7;
    connection : ConformsTo connect conformingElement ::> watchdogControl to clause ::> iso14971::iso14971Clause7;
    connection : ConformsTo connect conformingElement ::> flowCrossCheckControl to clause ::> iso14971::iso14971Clause7;

    // ── Where the evidence for each claim is written down ────────────────
    // The section reference rides on the link, not on a duplicate section type.
    connection : TracesToDocument connect tracedElement ::> iec62304::iec62304Clause5::iec62304Clause5_2::iec62304Clause5_2_2 to artifact ::> docSrs {
        attribute :>> sectionReference = "3";
    }
    connection : TracesToDocument connect tracedElement ::> iec62304::iec62304Clause5::iec62304Clause5_2::iec62304Clause5_2_3 to artifact ::> docSrs {
        attribute :>> sectionReference = "3.2";
    }
    connection : TracesToDocument connect tracedElement ::> iec62304::iec62304Clause5::iec62304Clause5_3 to artifact ::> docSad {
        attribute :>> sectionReference = "4";
    }
    connection : TracesToDocument connect tracedElement ::> iec60601_1::iec60601_1Clause8 to artifact ::> docHrs {
        attribute :>> sectionReference = "4";
    }
    connection : TracesToDocument connect tracedElement ::> iec60601_1::iec60601_1Clause9 to artifact ::> docHrs {
        attribute :>> sectionReference = "6";
    }
    connection : TracesToDocument connect tracedElement ::> iec60601_1::iec60601_1Clause14 to artifact ::> docSad {
        attribute :>> sectionReference = "6.2";
    }
    connection : TracesToDocument connect tracedElement ::> iec60601_1_2::iec60601_1_2Clause7 to artifact ::> docHrs {
        attribute :>> sectionReference = "5";
    }
    connection : TracesToDocument connect tracedElement ::> iso14971::iso14971Clause7 to artifact ::> docRmf {
        attribute :>> sectionReference = "5";
    }
}
