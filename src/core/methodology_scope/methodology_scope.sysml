// Methodology scope helpers.
//
// `MethodologyScope` and `MethodologyLayerSet` were removed when the semantic
// contract flipped. A methodology's effective selection is declared on
// `MethodologyDefinition` itself — `scopeMode` plus the `included*` lists — so
// that one element answers "what is in scope". A second scope part sitting
// beside the methodology meant two authorities for the same question, and the
// tools read the one the methodology definition did not declare.
package memo_core_methodology_scope {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_dimensions::*;

    part def ElementKindAlias specializes MemoPart {
        attribute methodTerm : String;
        attribute concreteKind : String;
        attribute concreteOntology : String;
    }
}
