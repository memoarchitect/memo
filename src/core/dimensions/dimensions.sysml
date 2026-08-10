// Lifecycle and cross-cutting classification dimensions.
//
// Axis ownership (horizontal architecture layer vs. vertical assurance
// discipline) is NOT a tag here — it is encoded by package membership: every
// element is defined in exactly one axis package (memo_architecture_* xor
// memo_assurance_*), enforced by CR-ONT-045. The remaining dimensions below
// (realization stage, cross-cutting concern, element status) are genuinely
// orthogonal to the axis and to each other, and stay as metadata.
package memo_core_dimensions {
    private import ScalarValues::*;

    // Realization stages of one element identity across the product
    // lifecycle (proposal through retirement). Orthogonal to the axis:
    // a single identity progresses through stages without changing its owner.
    enum def RealizationStageKind {
        // Put forward but not yet specified — a candidate under consideration,
        // so a design alternative can be modelled and traced without implying
        // it has been accepted into the specification.
        enum proposed;
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
    // This is the ONE status vocabulary in MEMO: every element carries
    // `status : ElementStatusKind`, whatever its metaclass. The former
    // per-family variants (RequirementStatusKind, LinkStatusKind,
    // MemoNeed::needStatus) are gone — three overlapping status dropdowns on
    // one element was cognitive load, not precision.
    //
    // The V&V states the requirement variant carried (implemented, verified,
    // validated) are deliberately NOT here: they are facts about links, not
    // editorial states. An element is implemented when a Realizes link exists,
    // verified when VerifiedBy does, validated when Validates does. Duplicating
    // them as an attribute lets the attribute disagree with the graph.
    enum def ElementStatusKind {
        enum proposed;
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
