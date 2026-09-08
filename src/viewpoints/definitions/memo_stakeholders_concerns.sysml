// Stakeholders and concerns, as elements.
//
// ISO/IEC/IEEE 42010 gives a viewpoint three jobs: name the stakeholders,
// frame their concerns, and be what a view conforms to. MEMO used to do the
// first two with enumerations — `AudienceKind` and `ConcernKind` — which meant
// a stakeholder was a literal from a closed list of eleven and a concern was a
// literal from nine. You could tag a viewpoint with one; you could not declare
// a concern, give it an id, say who holds it, trace a requirement to it, or
// add one without editing the ontology.
//
// They are elements now. SysML v2 already models both — `ConcernDefinition`
// and `StakeholderMembership` are in the metamodel, and MEMO's grammar has
// carried `concern def`, `concern`, `frame` and `stakeholder` all along — so
// nothing new is invented here. Each carries `@MemoIdentity`, which is what
// makes it citable in a review the way every other MEMO element is.
//
// The literals they replace are kept verbatim as names, so a project reading
// `AudienceKind::safetyEngineer` finds `SafetyEngineer` and nothing is lost in
// the move.
package memo_viewpoints_stakeholders_concerns {
    private import ScalarValues::*;
    private import memo_core_common::*;

    // ─── Concerns ────────────────────────────────────────────────────────
    //
    // A concern is an interest in the system held by one or more stakeholders.
    // `concern def` is the native SysML construct for it; a viewpoint frames
    // the concerns it addresses.
    abstract concern def MemoConcern;

    concern def SafetyConcern :> MemoConcern {
        @MemoIdentity { :>> providedId = "CNC-1"; }
        attribute name = "Safety";
        attribute description = "Freedom from unacceptable risk of harm to the patient, the operator or a bystander.";
    }
    concern def UsabilityConcern :> MemoConcern {
        @MemoIdentity { :>> providedId = "CNC-2"; }
        attribute name = "Usability";
        attribute description = "Whether the intended user can operate the device correctly under use conditions.";
    }
    concern def CybersecurityConcern :> MemoConcern {
        @MemoIdentity { :>> providedId = "CNC-3"; }
        attribute name = "Cybersecurity";
        attribute description = "Resistance to compromise of the device, its data, or the network it participates in.";
    }
    concern def PerformanceConcern :> MemoConcern {
        @MemoIdentity { :>> providedId = "CNC-4"; }
        attribute name = "Performance";
        attribute description = "Timing, throughput and capacity against what the clinical procedure demands.";
    }
    concern def InteroperabilityConcern :> MemoConcern {
        @MemoIdentity { :>> providedId = "CNC-5"; }
        attribute name = "Interoperability";
        attribute description = "Correct exchange with the equipment and systems the device is used alongside.";
    }
    concern def ReliabilityConcern :> MemoConcern {
        @MemoIdentity { :>> providedId = "CNC-6"; }
        attribute name = "Reliability";
        attribute description = "Continuity of correct service, and behaviour on failure.";
    }
    concern def PrivacyConcern :> MemoConcern {
        @MemoIdentity { :>> providedId = "CNC-7"; }
        attribute name = "Privacy";
        attribute description = "Protection of patient and operator data through its lifecycle.";
    }
    concern def RegulatoryConcern :> MemoConcern {
        @MemoIdentity { :>> providedId = "CNC-8"; }
        attribute name = "Regulatory";
        attribute description = "Evidence a submission requires, and conformance to the standards claimed.";
    }
    concern def ClinicalConcern :> MemoConcern {
        @MemoIdentity { :>> providedId = "CNC-9"; }
        attribute name = "Clinical";
        attribute description = "Whether the device serves the clinical procedure and its intended use.";
    }

    // ─── Quality attributes ──────────────────────────────────────────────
    //
    // A concern is what a stakeholder cares about; a quality attribute is the
    // measurable property of the system through which that care is answered.
    // The SEI's separation (Bass, Clements & Kazman): "performance" as a
    // concern is a worry, and only becomes designable once it is stated as a
    // property with a stimulus, a response and a measure.
    //
    // `addressesConcerns` is the mapping, and it is many-to-many on purpose.
    // Availability answers safety AND clinical continuity; security answers
    // cybersecurity AND privacy. A quality attribute that addresses no concern
    // is one nobody asked for, and a concern with no quality attribute behind
    // it is a worry the architecture has not yet answered — both are findings
    // this mapping makes visible.
    abstract part def MemoQualityAttribute :> MemoPart {
        ref addressesConcerns : MemoConcern[*];
        /** How the property is measured — the response measure of a quality
         *  attribute scenario, stated once for the attribute. */
        attribute measure : String;
    }

    part def Availability :> MemoQualityAttribute {
        @MemoIdentity { :>> providedId = "QA-1"; }
        attribute :>> name = "Availability";
        ref :>> addressesConcerns = (SafetyConcern, ReliabilityConcern, ClinicalConcern);
        attribute :>> measure = "Proportion of scheduled procedure time the function is delivered, and time to recover after a fault.";
    }
    part def Performance :> MemoQualityAttribute {
        @MemoIdentity { :>> providedId = "QA-2"; }
        attribute :>> name = "Performance";
        ref :>> addressesConcerns = (PerformanceConcern, ClinicalConcern);
        attribute :>> measure = "Latency and throughput under the arrival pattern the procedure produces.";
    }
    part def Security :> MemoQualityAttribute {
        @MemoIdentity { :>> providedId = "QA-3"; }
        attribute :>> name = "Security";
        ref :>> addressesConcerns = (CybersecurityConcern, PrivacyConcern, SafetyConcern);
        attribute :>> measure = "Resistance to a stated threat, and time to detect and recover from a compromise.";
    }
    part def Modifiability :> MemoQualityAttribute {
        @MemoIdentity { :>> providedId = "QA-4"; }
        attribute :>> name = "Modifiability";
        ref :>> addressesConcerns = (RegulatoryConcern);
        attribute :>> measure = "Cost and blast radius of a stated change, including the re-verification it forces.";
    }
    part def Testability :> MemoQualityAttribute {
        @MemoIdentity { :>> providedId = "QA-5"; }
        attribute :>> name = "Testability";
        ref :>> addressesConcerns = (RegulatoryConcern, SafetyConcern);
        attribute :>> measure = "Probability that a fault present is revealed by the next test, and the effort to observe it.";
    }
    part def Usability :> MemoQualityAttribute {
        @MemoIdentity { :>> providedId = "QA-6"; }
        attribute :>> name = "Usability";
        ref :>> addressesConcerns = (UsabilityConcern, SafetyConcern, ClinicalConcern);
        attribute :>> measure = "Task success and use-error rate for the intended user under use conditions (IEC 62366-1).";
    }
    part def Interoperability :> MemoQualityAttribute {
        @MemoIdentity { :>> providedId = "QA-7"; }
        attribute :>> name = "Interoperability";
        ref :>> addressesConcerns = (InteroperabilityConcern, ClinicalConcern);
        attribute :>> measure = "Proportion of exchanges with a named partner system that are correctly understood.";
    }

    // ─── Stakeholders ────────────────────────────────────────────────────
    //
    // A stakeholder holds concerns. These are the engineering and regulatory
    // roles a viewpoint is written FOR; the clinical actors who operate the
    // device are OperationalParticipants and are a different population.
    abstract part def MemoStakeholder :> MemoPart;

    part def SystemArchitect :> MemoStakeholder {
        @MemoIdentity { :>> providedId = "STK-1"; }
        attribute :>> name = "System Architect";
    }
    part def SoftwareArchitect :> MemoStakeholder {
        @MemoIdentity { :>> providedId = "STK-2"; }
        attribute :>> name = "Software Architect";
    }
    part def HardwareEngineer :> MemoStakeholder {
        @MemoIdentity { :>> providedId = "STK-3"; }
        attribute :>> name = "Hardware Engineer";
    }
    part def SafetyEngineer :> MemoStakeholder {
        @MemoIdentity { :>> providedId = "STK-4"; }
        attribute :>> name = "Safety Engineer";
    }
    part def VerificationEngineer :> MemoStakeholder {
        @MemoIdentity { :>> providedId = "STK-5"; }
        attribute :>> name = "Verification Engineer";
    }
    part def RegulatoryEngineer :> MemoStakeholder {
        @MemoIdentity { :>> providedId = "STK-6"; }
        attribute :>> name = "Regulatory Engineer";
    }
    part def ProjectLead :> MemoStakeholder {
        @MemoIdentity { :>> providedId = "STK-7"; }
        attribute :>> name = "Project Lead";
    }
    part def SecurityEngineer :> MemoStakeholder {
        @MemoIdentity { :>> providedId = "STK-8"; }
        attribute :>> name = "Security Engineer";
    }
    part def PrivacyEngineer :> MemoStakeholder {
        @MemoIdentity { :>> providedId = "STK-9"; }
        attribute :>> name = "Privacy Engineer";
    }
    part def ClinicalEngineer :> MemoStakeholder {
        @MemoIdentity { :>> providedId = "STK-10"; }
        attribute :>> name = "Clinical Engineer";
    }
    part def UsabilityEngineer :> MemoStakeholder {
        @MemoIdentity { :>> providedId = "STK-11"; }
        attribute :>> name = "Usability Engineer";
    }
}
