// Focused example: in-vitro diagnostic laboratory analyzer. Specimen as
    private import memo_assurance_verification_validation::*;
// material flow through fluidic components, a LOINC-coded measurement
// result, and an operational activity for running a panel.
package memo_examples_ivd_laboratory_system {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_terminology::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_implementation_hardware_structure::*;
    private import memo_architecture_realization_physical::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part def IvdLaboratorySystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The IVD laboratory system: the system this example models, with the software and hardware that realize it.";
    }
    part analyzer : PhysicalAssembly {
        @MemoIdentity { :>> providedId = "IVD-DEV-001"; :>> label = "ChemAnalyzer"; }
        attribute :>> responsibility = "automate clinical chemistry measurements";
    }

    // Specimen path: material flow through fluidic hardware.
    part fluidSampleProbe : FluidicComponent {
        @MemoIdentity { :>> providedId = "IVD-HW-001"; :>> label = "SampleProbe"; }
        attribute :>> patientContact = false;
        attribute :>> fluidPathRole = "aspirates specimen from primary tube";
        out port pSpecimenOut : PhysicalPort;
    }
    part fluidReactionCuvette : FluidicComponent {
        @MemoIdentity { :>> providedId = "IVD-HW-002"; :>> label = "ReactionCuvette"; }
        attribute :>> patientContact = false;
        attribute :>> fluidPathRole = "holds specimen-reagent reaction mix";
        in port pSpecimenIn : PhysicalPort;
    }
    part optPhotometer : OpticalComponent {
        @MemoIdentity { :>> providedId = "IVD-HW-003"; :>> label = "PhotometerAssembly"; }
        attribute :>> patientContact = false;
        attribute :>> opticalFunction = "absorbance measurement";
        attribute :>> wavelengthRange = "340-800 nm";
    }
    // The probe dispenses the aspirated specimen into the cuvette.
    flow exSpecimenFlow : LogicalExchange from fluidSampleProbe.pSpecimenOut to fluidReactionCuvette.pSpecimenIn {
        @MemoIdentity { :>> providedId = "IVD-EX-001"; :>> label = "SpecimenTransfer"; }
        attribute :>> contentKind = FlowContentKind::material;
    }

    // Result item coded with LOINC.
    item glucoseResult : LogicalExchangeItem {
        @MemoIdentity { :>> providedId = "IVD-IT-001"; }
        attribute :>> contentKind = FlowContentKind::measurement;
        attribute :>> unit = "mg/dL";
        attribute :>> timestampRequired = true;
        attribute :>> codes = loincGlucose;
    }
    attribute loincGlucose : TerminologyCode {
        attribute :>> systemUri = "http://loinc.org";
        attribute :>> code = "2345-7";
        attribute :>> display = "Glucose [Mass/volume] in Serum or Plasma";
    }

    // Operating activity for the analyzer.
    action actRunPanel : OperativeAction {
        @MemoIdentity { :>> providedId = "IVD-ACT-001"; :>> label = "RunChemistryPanel"; }
        attribute :>> criticality = CriticalityKind::high;
    }
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredActRunPanel : ValidationCase {
        @MemoIdentity { :>> providedId = "ILS-VC-A01"; :>> label = "VerifyRunChemistryPanel"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'RunChemistryPanel' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect validationTarget ::> actRunPanel to validationCase ::> valAuthoredActRunPanel;
}
