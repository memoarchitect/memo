// Consistency rule base types per Epic N.
// Bare imports are required by the current compatibility surface.
package memo_core_consistency_rules {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    // Common supertype of every executable MEMO rule. It carries no members of
    // its own: a rule's metadata is declared on the rule, and a shared member
    // here would be shadowed by every rule that sets it. Its job is to give
    // RulePolicy a type to reference, so a policy names a rule the way SysML
    // names anything else rather than through a parallel string-ID namespace.
    abstract constraint def MemoConsistencyRule;

    part def ConsistencyRule specializes MemoPart {
        attribute appliesTo : String;
        attribute predicate : RulePredicateKind;
        attribute strength : RuleStrengthKind;
        attribute severity : RuleSeverityKind;
        attribute rationaleText : String;
        attribute category : RuleCategoryKind;
    }

    part def RelationshipConsistencyRule specializes ConsistencyRule {
        attribute relationshipType : String;
        attribute minCount : String;
        attribute maxCount : String;
        attribute direction : String;
        attribute relatedKinds : String;
    }

    part def AttributeConsistencyRule specializes ConsistencyRule {
        attribute targetAttribute : String;
    }

    part def ConditionalConsistencyRule specializes RelationshipConsistencyRule {
        attribute conditionAttribute : String;
        attribute conditionOperator : String;
        attribute conditionValues : String;
    }

    part def CoverageConsistencyRule specializes ConsistencyRule {
        attribute standardReference : String;
        attribute clause : String;
        attribute coverageTarget : String;
    }
}
