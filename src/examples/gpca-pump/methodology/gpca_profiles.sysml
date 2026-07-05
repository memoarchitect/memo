package memo {
    package examples {
        package gpca {
            package methodology_profiles {
                private import memo::methodology::core::*;
                private import memo::methodology::profiles::*;
                private import memo::core::enumerations::*;

                part gpcaMethodDefinition : MethodologyDefinition {
                    attribute id = "METH-GPCA-001";
                    attribute name = "GPCAPrototypeMethodology";
                    attribute version = "1.0";
                    attribute domain = "medical device modeling";
                    attribute description = "GPCA infusion pump methodology — subtraction-based tailoring for non-networked prototype. Excludes cybersecurity layer and SOUPComponent.";
                    attribute baseMethodName = "MedicalDeviceLightDefault";
                }

                part gpcaMethodResolved : ResolvedMethodology {
                    attribute id = "RMETH-GPCA-001";
                    attribute name = "GPCAPrototypeResolved";
                    attribute version = "1.0";
                    attribute safetyClassification = SafetyClassKind::C;
                    attribute lifecycleStage = LifecycleStateKind::development;
                    attribute resolutionSummary = "GPCA infusion pump — IEC 62304 Class C at development stage. Default scope minus cybersecurity and SOUP, as the prototype is non-networked.";
                }
            }
        }
    }
}
