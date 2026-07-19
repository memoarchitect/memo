// Lifecycle and cross-cutting classification dimensions.
//
// Axis ownership (horizontal architecture layer vs. vertical assurance
// discipline) is NOT a tag here — it is encoded by package membership: every
// element is defined in exactly one axis package (memo_architecture_* xor
// memo_assurance_*), enforced by CR-ONT-045. This reverses ADR-0001, which
// carried perspective/discipline as free multivalued tags and thereby let one
// element claim both axes at once. The remaining dimensions below (realization
// stage, cross-cutting concern, element status) are genuinely orthogonal to the
// axis and to each other, and stay as metadata.
package memo_core_dimensions {
    private import ScalarValues::*;

    // Realization stages of one element identity across the product
    // lifecycle (specification through retirement). Orthogonal to the axis:
    // a single identity progresses through stages without changing its owner.
    enum def RealizationStageKind {
        enum specified;
        enum designed;
        enum built;
        enum configured;
        enum assembled;
        enum deployed;
        enum operated;
        enum retired;
    }

    // Cross-cutting concerns orthogonal to the axis.
    enum def CrossCuttingConcernKind {
        enum evidence;
        enum traceability;
        enum configurationManagement;
        enum changeControl;
        enum regulatoryCompliance;
        enum clinicalPerformance;
    }

    // Editorial status of the model element itself (distinct from the
    // lifecycle of the thing the element describes).
    enum def ElementStatusKind {
        enum draft;
        enum inReview;
        enum approved;
        enum released;
        enum deprecated;
        enum retired;
    }

    // Metadata carriers for tagging non-part constructs (actions, ports,
    // interfaces, items, views) with the orthogonal dimensions. Part-based
    // elements carry these directly as attributes of MemoPart. Axis ownership
    // is never tagged here — it is the construct's owning package.
    metadata def RealizationClassification {
        attribute stage : RealizationStageKind[0..1];
    }

    metadata def CrossCuttingClassification {
        attribute crossCutting : CrossCuttingConcernKind[0..*];
    }
}
