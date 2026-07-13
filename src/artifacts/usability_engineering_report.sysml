package memo {
    package artifacts {
        package usability_engineering_report {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def UsabilityEngineeringReport specializes ArtifactKindDef {
            attribute documentTitle = "Usability Engineering Report";
            attribute regulatoryRef = "IEC 62366-1:2015";
            attribute artifactKind = ArtifactKind::usabilityEngineeringReport;
        }
        }
    }
}
