// Semantic-metadata definitions (SysML v2 `metadata def`) — the standard, portable
// mechanism for extending the MEMO ontology with domain semantics. Downstream models
// extend MEMO by importing the ontology library and either specializing its kinds or
// applying these metadata defs with `@Name` — never by adding new grammar.
package memo_core_semantics {
    private import ScalarValues::*;
    private import memo_core_terminology::ExternalReference;

    // Tags an element with the regulatory standard it derives from
    // (e.g. ISO 14971, IEC 62304, ISO/IEC/IEEE 42010).
    metadata def StandardReference {
        attribute standardReference : String;
        attribute clause : String;
    }

    // An element imported from another system (a requirements tool, a PLM, a
    // quality system, a test-result export). It annotates an element of ANY
    // metaclass, because imported records span them: a requirement def is not a
    // MemoPart. The source id is `externalReference.identifier`, NOT MemoIdentity's
    // `providedId`: `providedId` is the id an external system knows an
    // authored element by, whereas this records the external record an
    // element was made from, with its revision.
    //
    //   @ExternalSource {
    //       :>> externalReference { :>> sourceSystem = "..."; :>> identifier = "..."; :>> revision = "B"; }
    //       :>> sourceMastered = true;
    //   }
    //
    // `sourceMastered` is true when the source system owns the element, so a
    // re-import overwrites it and a MEMO edit would be lost. `sourceWithdrawn`
    // is set by a re-import when the record is gone from the source: the
    // element is kept, so the links to it still compile and can be reviewed.
    metadata def ExternalSource {
        attribute externalReference : ExternalReference[0..1];
        attribute sourceMastered : Boolean[0..1];
        attribute sourceWithdrawn : Boolean[0..1];
    }

    // What an import wrote a package from, on the package itself. A source's
    // records live in one package that the import owns and regenerates, so this
    // is the record of where it came from and when it was last imported. A
    // metadata usage is a package member (PackageBodyElement, SysML-textual-bnf.kebnf:124 →
    // PackageMember :133 → DefinitionElement :184 → AnnotatingElement :74 → MetadataFeature).
    metadata def ImportSource {
        attribute sourceSystem : String;
        attribute importFormat : String;
        attribute importFile : String[0..1];
        attribute importedAt : String;
    }

    // The revision of an imported element a MEMO-authored link was made against.
    // A link is suspect when that revision is no longer the element's current
    // `externalReference.revision`, or when the element is withdrawn. The status
    // is derived, never stored; reviewing the link rewrites this baseline to the
    // current revision. Only MEMO-authored links carry it: a link imported
    // from the source is mastered there and is re-imported instead.
    //
    // Both are written in a body, because a prefix `#Name` cannot carry a value
    // (PrefixMetadataUsage, SysML-textual-bnf.kebnf:1667). The nested
    // `externalReference { … }` is MetadataBodyUsage (kebnf:1694), and the baseline sits in
    // the link's own body: a `satisfy`'s RequirementBody (kebnf:1408), a
    // connection's or a `dependency`'s DefinitionBody (kebnf:238).
    //
    // `sourceIdentifier` names the imported element the revision belongs to. A
    // link between two imported elements needs it: one revision cannot be
    // compared with two ends, so without it the link could never be cleared by
    // review. Absent, every imported end is compared.
    metadata def TraceBaseline {
        attribute sourceRevision : String;
        attribute sourceIdentifier : String[0..1];
    }

    // Marks an element as the rationale/provenance carrier for a decision.
    metadata def Provenance {
        attribute source : String;
        attribute rationale : String;
    }
}
