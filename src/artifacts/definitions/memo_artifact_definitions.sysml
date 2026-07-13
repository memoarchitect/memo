package memo {
    package artifacts {
        package definitions {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;

            part def ArtifactKindDef specializes TraceableElement {
                attribute documentTitle : String;
                attribute regulatoryRef : String;
                attribute artifactKind : ArtifactKind;
            }
        }
    }
}
