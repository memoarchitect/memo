// Methodology scope helpers.
//
// A methodology's effective selection is declared on `MethodologyDefinition`
// itself — `scopeMode` plus the `included*` lists — so that one element answers
// "what is in scope".
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
