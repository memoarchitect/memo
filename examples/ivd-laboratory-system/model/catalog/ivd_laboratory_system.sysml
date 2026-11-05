// Focused example: in-vitro diagnostic laboratory analyzer. Specimen as
// material flow through fluidic components, a LOINC-coded measurement
// result, and an operational activity for running a panel.
package memo_examples_ivd_laboratory_system {
    private import memo::*;
    private import ScalarValues::*;


    part def IvdLaboratorySystem specializes memo_architecture_logical_structure::System {
        attribute :>> systemBoundaryDescription = "The IVD laboratory system: the system this example models, with the software and hardware that realize it.";
    }
    part analyzer : PhysicalAssembly {
        @MemoIdentity { :>> providedId = "IVD-DEV-001"; :>> label = "Chem analyzer"; }
        attribute :>> responsibility = "automate clinical chemistry measurements";
    }

    // Specimen path: material flow through fluidic hardware.
    part fluidSampleProbe : FluidicComponent {
        @MemoIdentity { :>> providedId = "IVD-HW-001"; :>> label = "Sample probe"; }
        attribute :>> patientContact = false;
        attribute :>> fluidPathRole = "aspirates specimen from primary tube";
        out port pSpecimenOut : PhysicalPort;
    }
    part fluidReactionCuvette : FluidicComponent {
        @MemoIdentity { :>> providedId = "IVD-HW-002"; :>> label = "Reaction cuvette"; }
        attribute :>> patientContact = false;
        attribute :>> fluidPathRole = "holds specimen-reagent reaction mix";
        in port pSpecimenIn : PhysicalPort;
    }
    part optPhotometer : OpticalComponent {
        @MemoIdentity { :>> providedId = "IVD-HW-003"; :>> label = "Photometer assembly"; }
        attribute :>> patientContact = false;
        attribute :>> opticalFunction = "absorbance measurement";
        attribute :>> wavelengthRange = "340-800 nm";
    }
    // The probe dispenses the aspirated specimen into the cuvette.
    flow exSpecimenFlow : LogicalTransfer from fluidSampleProbe.pSpecimenOut to fluidReactionCuvette.pSpecimenIn {
        @MemoIdentity { :>> providedId = "IVD-EX-001"; :>> label = "Specimen transfer"; }
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
        @MemoIdentity { :>> providedId = "IVD-ACT-001"; :>> label = "Run chemistry panel"; }
        attribute :>> criticality = CriticalityKind::high;
    }
    // Illustrative: authored for this example, not the record of a real evaluation.
    verification valAuthoredActRunPanel : ValidationCase {
        @MemoIdentity { :>> providedId = "ILS-VC-A01"; :>> label = "Verify run chemistry panel"; }
        attribute :>> validationMethod = ValidationMethodKind::summativeUsabilityTest;
        attribute :>> userParticipation = "representative users, simulated use conditions";
        attribute :>> acceptanceCriteria = "a representative user completes 'Run chemistry panel' without a use error, in a summative evaluation per IEC 62366-1";
    }
    connection : Validates connect actRunPanel to valAuthoredActRunPanel;
}
