// Focused example: in-vitro diagnostic laboratory analyzer. Specimen as
// material flow through fluidic components, a LOINC-coded measurement
// result, and calibration as a required product-usage property.
package memo_examples_ivd_laboratory_system {
    private import ScalarValues::*;

    private import memo_core_enumerations::*;
    private import memo_core_terminology::*;
    private import memo_core_relationships::*;
    private import memo_medical_products_definitions::*;
    private import memo_medical_products_usage::*;
    private import memo_activities::*;
    private import memo_architecture_logical_structure::*;
    private import memo_architecture_hardware_structure::*;

    part analyzerDef : MedicalDeviceDefinition {
        attribute :>> id = "IVD-DEF-001"; attribute :>> name = "ChemAnalyzer_CA200";
        attribute :>> intendedPurpose = "Quantitative measurement of clinical chemistry analytes in serum and plasma.";
        attribute :>> technologyDomains = (
            TechnologyDomainKind::mechanical,
            TechnologyDomainKind::electrical,
            TechnologyDomainKind::electronic,
            TechnologyDomainKind::software,
            TechnologyDomainKind::fluidic,
            TechnologyDomainKind::optical);
        attribute :>> riskClassification = "IVDR Class C (example)";
    }
    part analyzer : MedicalDevice {
        attribute :>> deviceCategory = MedicalDeviceCategoryKind::equipment;
        attribute :>> id = "IVD-DEV-001"; attribute :>> name = "ChemAnalyzer";
        ref :>> definition = analyzerDef;
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

    // Operating the analyzer requires calibration (product-usage property).
    action actRunPanel : OperationalActivity {
        attribute :>> id = "IVD-ACT-001"; attribute :>> name = "RunChemistryPanel";
        attribute :>> criticality = CriticalityKind::high;
    }
    connection : UsesProduct connect using ::> actRunPanel to product ::> analyzer {
        attribute :>> productRole = ProductRoleKind::measurementInstrument;
        attribute :>> required = true;
        attribute :>> calibrationRequired = true;
        attribute :>> usageInstructions = "two-level QC must pass within the current calibration window";
    }
}
