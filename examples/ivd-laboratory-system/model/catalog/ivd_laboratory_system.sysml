// Focused example: in-vitro diagnostic laboratory analyzer. Specimen as
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

    part analyzer : PhysicalAssembly {
        attribute :>> id = "IVD-DEV-001"; attribute :>> name = "ChemAnalyzer";
        attribute :>> responsibility = "automate clinical chemistry measurements";
    }

    // Specimen path: material flow through fluidic hardware.
    part fluidSampleProbe : FluidicComponent {
        attribute :>> id = "IVD-HW-001"; attribute :>> name = "SampleProbe";
        attribute :>> fluidPathRole = "aspirates specimen from primary tube";
    }
    part fluidReactionCuvette : FluidicComponent {
        attribute :>> id = "IVD-HW-002"; attribute :>> name = "ReactionCuvette";
        attribute :>> fluidPathRole = "holds specimen-reagent reaction mix";
    }
    part optPhotometer : OpticalComponent {
        attribute :>> id = "IVD-HW-003"; attribute :>> name = "PhotometerAssembly";
        attribute :>> opticalFunction = "absorbance measurement";
        attribute :>> wavelengthRange = "340-800 nm";
    }
    part exSpecimenFlow : LogicalExchange {
        attribute :>> id = "IVD-EX-001"; attribute :>> name = "SpecimenTransfer";
        attribute :>> contentKind = FlowContentKind::material;
        attribute :>> direction = DirectionKind::output;
    }

    // Result item coded with LOINC.
    item glucoseResult : LogicalExchangeItem {
        attribute :>> id = "IVD-IT-001"; attribute :>> name = "GlucoseResult";
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
        attribute :>> id = "IVD-ACT-001"; attribute :>> name = "RunChemistryPanel";
        attribute :>> criticality = CriticalityKind::high;
    }
}
