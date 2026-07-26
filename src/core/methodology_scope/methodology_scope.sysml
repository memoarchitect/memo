// Methodology scope helpers.
// Instances use repeated scalar attribute usages to enumerate set entries, for
// example: `attribute :>> includedArchLayer = "operational";`.
package memo_core_methodology_scope {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_dimensions::*;

    part def MethodologyLayerSet specializes MemoPart {
        attribute setName : String;
        attribute layer : String;
    }

    part def MethodologyScope specializes MemoPart {
        attribute scopeName : String;
        attribute includedArchLayer : String[0..*];
        // Qualified package names may resolve to MEMO, project, supplier, or
        // other externally provided ontology modules.
        attribute includedModule : String[0..*];
    }

    part def ElementKindAlias specializes MemoPart {
        attribute methodTerm : String;
        attribute concreteKind : String;
        attribute concreteOntology : String;
    }
}
