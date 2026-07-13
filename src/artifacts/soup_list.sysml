package memo {
    package artifacts {
        package soup_list {
        private import memo::artifacts::definitions::*;
        private import memo::core::enumerations::*;

        part def SoupList specializes ArtifactKindDef {
            attribute documentTitle = "SOUP List (Software of Unknown Provenance)";
            attribute regulatoryRef = "IEC 62304:2006 §8.1.2";
            attribute artifactKind = ArtifactKind::soupList;
        }
        }
    }
}
