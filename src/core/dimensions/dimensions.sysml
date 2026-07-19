// Orthogonal classification dimensions (ADR-0001). An element participates in
// several independent dimensions at once — architecture perspective, realization
// stage, engineering discipline, cross-cutting concern — without being duplicated.
// Dimensions are typed enums carried as multivalued attributes on the Memo base
// definitions (memo_core_common) and as metadata defs for constructs whose
// metaclass cannot specialize a part-based carrier.
package memo_core_dimensions {
    private import ScalarValues::*;

    // Horizontal architecture perspectives (Arcadia-informed; implementation
    // covers software, hardware, and physical realization together).
    enum def ArchitecturePerspectiveKind {
        enum operational;
        enum functional;
        enum logical;
        enum implementation;
    }

    // Vertical realization stages of one element identity across the product
    // lifecycle (specification through retirement).
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

    // Engineering disciplines that can claim an element without owning it.
    enum def EngineeringDisciplineKind {
        enum requirements;
        enum safety;
        enum cybersecurity;
        enum humanFactors;
        enum 'verification';
        enum 'validation';
    }

    // Cross-cutting concerns orthogonal to perspective and discipline.
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
    // interfaces, items, views) with the same dimensions. Part-based elements
    // carry the dimensions directly as attributes of MemoPart.
    metadata def ArchitectureClassification {
        attribute perspective : ArchitecturePerspectiveKind[0..*];
        attribute stage : RealizationStageKind[0..1];
    }

    metadata def AssuranceClassification {
        attribute disciplines : EngineeringDisciplineKind[0..*];
        attribute crossCutting : CrossCuttingConcernKind[0..*];
    }
}
