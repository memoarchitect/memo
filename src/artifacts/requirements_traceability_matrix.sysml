package memo_artifacts_requirements_traceability_matrix {
    private import ScalarValues::*;

            private import memo_artifacts_definitions::*;
            private import memo_core_enumerations::*;

            part def RequirementsTraceabilityMatrix specializes ArtifactKindDef {
    attribute :>> documentTitle = "Requirements Traceability Matrix";
    attribute :>> regulatoryRef = "IEC 62304:2006 §5.1.1";
    attribute :>> artifactKind = ArtifactKind::traceMatrix;
            }
}
