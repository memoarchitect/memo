package memo {
    package artifacts {
        package requirements_traceability_matrix {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def RequirementsTraceabilityMatrix specializes ArtifactKindDef {
            attribute documentTitle = "Requirements Traceability Matrix";
            attribute regulatoryRef = "IEC 62304:2006 §5.1.1";
            attribute artifactKind = ArtifactKind::traceMatrix;
        }
        }
    }
}
