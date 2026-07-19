// Methodology scope helpers.
// Instances use repeated scalar attribute usages to enumerate set entries, for
// example: `attribute :>> includedArchLayer = "operational";`.
package memo_core_methodology_scope {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_dimensions::*;

    part def MethodologyLayerSet specializes TraceableElement {
        attribute setName : String;
        attribute layer : String;
    }

    part def MethodologyStandardSet specializes TraceableElement {
        attribute setName : String;
        attribute standardReference : String;
    }

    part def MethodologyArtifactSet specializes TraceableElement {
        attribute setName : String;
        attribute artifactKind : String;
    }

    part def MethodologyViewpointTypeSet specializes TraceableElement {
        attribute setName : String;
        attribute viewpointType : String;
    }

    part def MethodologyScope specializes TraceableElement {
        attribute scopeName : String;
        attribute includedArchLayer : String;
        attribute includedStandard : String;
        attribute includedArtifactKind : String;
        attribute includedViewpointType : String;
        attribute excludedKind : String;
    }

    part def ElementKindAlias specializes TraceableElement {
        attribute methodTerm : String;
        attribute concreteKind : String;
        attribute concreteOntology : String;
    }
}
