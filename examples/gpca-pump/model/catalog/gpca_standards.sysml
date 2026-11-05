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
    private import memo::*;
    private import ScalarValues::*;

    private import memo_examples_gpca_pump_gpca_requirements::*;
    private import memo_examples_gpca_pump_gpca_architecture::*;
    private import memo_examples_gpca_pump_gpca_physical::*;
    private import memo_examples_gpca_pump_gpca_risk::*;

    // ── The controlled documents clause evidence lands in ────────────────
    // TracesToDocument targets ControlledArtifact, so the DHF documents are
    // modelled as the artifacts they are rather than as a second document type.

    part docSrs : MarkdownDocumentSource {
        @MemoIdentity { :>> providedId = "DOC-SRS"; :>> label = "Software requirements specification"; }
        attribute :>> version = "1.0.0";
        attribute :>> artifactKind = ArtifactKind::requirementSpecification;
        attribute :>> owner = "Software Lead";
        attribute :>> approvalStatus = "approved";
        attribute :>> uri = "dhf/documents/srs.md";
        attribute :>> mediaType = "text/markdown";
        attribute :>> contentHash = "";
        attribute :>> generated = true;
    }
    part docSad : MarkdownDocumentSource {
        @MemoIdentity { :>> providedId = "DOC-SAD"; :>> label = "Software architecture description"; }
        attribute :>> version = "1.0.0";
        attribute :>> artifactKind = ArtifactKind::architectureDescription;
        attribute :>> owner = "Systems Architect";
        attribute :>> approvalStatus = "approved";
        attribute :>> uri = "dhf/documents/sad.md";
        attribute :>> mediaType = "text/markdown";
        attribute :>> contentHash = "";
        attribute :>> generated = true;
    }
    part docHrs : MarkdownDocumentSource {
        @MemoIdentity { :>> providedId = "DOC-HRS"; :>> label = "Hardware requirements specification"; }
        attribute :>> version = "1.0.0";
        attribute :>> artifactKind = ArtifactKind::requirementSpecification;
        attribute :>> owner = "Hardware Lead";
        attribute :>> approvalStatus = "approved";
        attribute :>> uri = "dhf/documents/hrs.md";
        attribute :>> mediaType = "text/markdown";
        attribute :>> contentHash = "";
        attribute :>> generated = true;
    }
    part docRmf : MarkdownDocumentSource {
        @MemoIdentity { :>> providedId = "DOC-RMF"; :>> label = "Risk management file"; }
        attribute :>> version = "1.0.0";
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
    connection : ConformsTo connect reqOcclusion to iec62304.iec62304Clause5.iec62304Clause5_2.iec62304Clause5_2_2;
    connection : ConformsTo connect reqDoorOpen to iec62304.iec62304Clause5.iec62304Clause5_2.iec62304Clause5_2_2;
    connection : ConformsTo connect reqMaxHourlyDose to iec62304.iec62304Clause5.iec62304Clause5_2.iec62304Clause5_2_2;
    connection : ConformsTo connect reqEventLogging to iec62304.iec62304Clause5.iec62304Clause5_2.iec62304Clause5_2_2;
    connection : ConformsTo connect reqWatchdogSafeState to iec62304.iec62304Clause5.iec62304Clause5_2.iec62304Clause5_2_2;
    connection : ConformsTo connect reqStuckButton to iec62304.iec62304Clause5.iec62304Clause5_2.iec62304Clause5_2_2;
    connection : ConformsTo connect reqFlowCrossCheck to iec62304.iec62304Clause5.iec62304Clause5_2.iec62304Clause5_2_2;

    // §5.2.3 risk control measures carried into software requirements.
    connection : ConformsTo connect reqWatchdogSafeState to iec62304.iec62304Clause5.iec62304Clause5_2.iec62304Clause5_2_3;
    connection : ConformsTo connect reqFlowCrossCheck to iec62304.iec62304Clause5.iec62304Clause5_2.iec62304Clause5_2_3;

    // §5.3 software architectural design: the software decomposition.
    connection : ConformsTo connect gpcaSoftware to iec62304.iec62304Clause5.iec62304Clause5_3;
    connection : ConformsTo connect gpcaSoftware.tlm to iec62304.iec62304Clause5.iec62304Clause5_3;
    connection : ConformsTo connect gpcaSoftware.infusionMgr to iec62304.iec62304Clause5.iec62304Clause5_3;
    connection : ConformsTo connect gpcaSoftware.systemMonitor to iec62304.iec62304Clause5.iec62304Clause5_3;
    connection : ConformsTo connect gpcaSoftware.config to iec62304.iec62304Clause5.iec62304Clause5_3;

    // ── IEC 60601-1 — basic safety and essential performance ─────────────
    // §8 protection against electrical hazards.
    connection : ConformsTo connect reqBatteryBackup to iec60601_1.iec60601_1Clause8;
    connection : ConformsTo connect powerSupply to iec60601_1.iec60601_1Clause8;
    connection : ConformsTo connect batteryPack to iec60601_1.iec60601_1Clause8;

    // §9 protection against mechanical hazards.
    connection : ConformsTo connect reqFreeFlowPrevention to iec60601_1.iec60601_1Clause9;
    connection : ConformsTo connect antiFreeFlowValve to iec60601_1.iec60601_1Clause9;
    connection : ConformsTo connect enclosure to iec60601_1.iec60601_1Clause9;

    // §14 programmable electrical medical systems.
    connection : ConformsTo connect gpcaSoftware to iec60601_1.iec60601_1Clause14;

    // ── IEC 60601-1-2 — electromagnetic compatibility ────────────────────
    connection : ConformsTo connect controllerBoard to iec60601_1_2.iec60601_1_2Clause7;
    connection : ConformsTo connect controllerBoard to iec60601_1_2.iec60601_1_2Clause8;
    connection : ConformsTo connect reqPost to iec60601_1_2.iec60601_1_2Clause8;

    // ── ISO 14971 — risk management ──────────────────────────────────────
    // §7 risk control: the risk control measures themselves.
    connection : ConformsTo connect lockoutControl to iso14971.iso14971Clause7;
    connection : ConformsTo connect occlusionAlarmControl to iso14971.iso14971Clause7;
    connection : ConformsTo connect airDetectionControl to iso14971.iso14971Clause7;
    connection : ConformsTo connect freeFlowValveControl to iso14971.iso14971Clause7;
    connection : ConformsTo connect doorInterlockControl to iso14971.iso14971Clause7;
    connection : ConformsTo connect watchdogControl to iso14971.iso14971Clause7;
    connection : ConformsTo connect flowCrossCheckControl to iso14971.iso14971Clause7;

    // ── Where the evidence for each claim is written down ────────────────
    // The section reference rides on the link, not on a duplicate section type.
    connection : TracesToDocument connect iec62304.iec62304Clause5.iec62304Clause5_2.iec62304Clause5_2_2 to docSrs {
        attribute :>> sectionReference = "3";
    }
    connection : TracesToDocument connect iec62304.iec62304Clause5.iec62304Clause5_2.iec62304Clause5_2_3 to docSrs {
        attribute :>> sectionReference = "3.2";
    }
    connection : TracesToDocument connect iec62304.iec62304Clause5.iec62304Clause5_3 to docSad {
        attribute :>> sectionReference = "4";
    }
    connection : TracesToDocument connect iec60601_1.iec60601_1Clause8 to docHrs {
        attribute :>> sectionReference = "4";
    }
    connection : TracesToDocument connect iec60601_1.iec60601_1Clause9 to docHrs {
        attribute :>> sectionReference = "6";
    }
    connection : TracesToDocument connect iec60601_1.iec60601_1Clause14 to docSad {
        attribute :>> sectionReference = "6.2";
    }
    connection : TracesToDocument connect iec60601_1_2.iec60601_1_2Clause7 to docHrs {
        attribute :>> sectionReference = "5";
    }
    connection : TracesToDocument connect iso14971.iso14971Clause7 to docRmf {
        attribute :>> sectionReference = "5";
    }
}
