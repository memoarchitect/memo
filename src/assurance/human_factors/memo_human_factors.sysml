// Human-factors assurance (IEC 62366-1; FDA HF guidance 2016). UseError
// relocated here from the former memo_architecture_context; hazard-related
// use scenarios and formative/summative evaluations complete the usability
// engineering chain: user → task → use error → hazard → risk control →
// usability validation.
package memo_assurance_human_factors {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_activities::*;
    private import memo_architecture_operational_scenarios::*;

    part def UseError specializes MemoPart {
        attribute errorCategory : UseErrorCategoryKind;
        attribute taskReference : String;
        attribute severity : SeverityKind;
        attribute rootCauseType : String;
    }

    connection def CommitsUseError :> MemoRelationship {
        end task : UserTask :>> source;
        end useError : UseError :>> target;
    }
    abstract connection commitsUseErrorLinks : CommitsUseError[*];
    metadata def <commitsUseError> CommitsUseErrorMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = commitsUseErrorLinks meta SysML::Usage;
    }
    connection def EvaluatesTask :> MemoRelationship {
        end evaluation : MemoEvidence :>> source;
        end task : UserTask :>> target;
    }
    abstract connection evaluatesTaskLinks : EvaluatesTask[*];
    metadata def <evaluatesTask> EvaluatesTaskMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = evaluatesTaskLinks meta SysML::Usage;
    }

    // ── Relations owned by this package ─────────────────────────────
    // Moved out of memo_core_relationships: their ends are typed against
    // types declared here, and core must not depend on a domain package.
    connection def TestedByUsability :> MemoRelationship {
        end uiElementOrTask : MemoPart :>> source;
        end usabilityTest : MemoEvidence :>> target;
    }
    abstract connection testedByUsabilityLinks : TestedByUsability[*];
    metadata def <testedByUsability> TestedByUsabilityMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = testedByUsabilityLinks meta SysML::Usage;
    }
}
