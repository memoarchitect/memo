package memo_methodology_core {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;
    private import memo_core_relationships::*;   // MemoRelationship

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_consistency_rules::*;

    part def MethodologyLibrary :> MemoPart {
        attribute version : String;
        attribute domain : String;
        attribute :>> description : String;
    }

    // A rule's disposition under one methodology or project binding.
    //
    // `targetRule` and `replacementRule` are typed references to the rule's own
    // `constraint def`, narrowed at the usage with `ref :>> targetRule : <Rule>`.
    // There is deliberately no `targetRuleId : String`: a qualified SysML
    // reference already identifies the rule, and a parallel string namespace
    // would be a MEMO-specific identifier where the language has one. The
    // stable rule ID survives on the rule itself, for audit records and
    // diagnostics — a different job from being the reference mechanism.
    part def RulePolicy :> MemoPart {
        ref targetRule : MemoConsistencyRule;
        // A replacement must be another native constraint. A methodology
        // cannot replace a predicate with a string expression stored here.
        ref replacementRule : MemoConsistencyRule[0..1];
        attribute disposition : RuleDispositionKind;
        attribute severityOverride : RuleSeverityKind[0..1];
        attribute rationaleText : String;
        attribute authority : String;
        attribute approvalReference : String[0..1];
        attribute approvedBy : String[0..1];
        attribute approvedOn : String[0..1];
    }

    part def MethodologyDefinition :> MemoPart {
        attribute version : String;
        attribute domain : String;
        attribute :>> description : String;
        // Exactly one base methodology at most. Multiple inheritance is not a
        // multiplicity the resolver has conflict semantics for, so the model
        // does not permit expressing it.
        ref baseMethodology : MethodologyDefinition[0..1];
        // Whether the inclusion lists below are the whole story. Under
        // `explicit`, an empty list selects nothing.
        attribute scopeMode : ScopeModeKind;
        // A methodology is an inclusion set. Layer entries normally name a
        // public MEMO layer namespace; module entries may name any qualified
        // package available to the project, including packages outside MEMO.
        attribute includedLayer : String[0..*];
        attribute includedModule : String[0..*];
        attribute includedStandard : String[0..*];
        attribute includedArtifactKind : String[0..*];
        attribute includedViewpoint : String[0..*];
        part rulePolicy : RulePolicy[0..*];
    }

    // Derived, never authored. The resolver projects this from a binding and
    // its methodology chain. If it is serialized for review it is generated
    // output that records its input hashes; it does not compete with the
    // authored methodology and binding, and ontology source declares no
    // instances of it.
    part def ResolvedMethodology :> MemoPart {
        attribute version : String;
        // The effective inclusion set after the project binding has added any
        // project- or supplier-specific modules.
        attribute includedLayer : String[0..*];
        attribute includedModule : String[0..*];
    }

    part def ProjectMethodBinding :> MemoPart {
        attribute projectName : String;
        ref selectedMethodology : MethodologyDefinition;
        // Additive: what the project adds on top of the selected methodology.
        // An empty list under `explicit` means no project additions.
        attribute scopeMode : ScopeModeKind;
        // Project bindings may add project or supplier modules to the selected
        // methodology without requiring those packages to live under memo::.
        attribute includedModule : String[0..*];
        // The submission regimes this project targets, declared once here.
        // Everything downstream that needs to know which standards apply —
        // `memo standards check`, the standards checklist, the Architect gap
        // badges — reads this, so the regime axis is a project fact stated in
        // SysML rather than a per-document array maintained in 44 places.
        // Empty means the project has not declared its regimes; a report that
        // needs them says so rather than assuming a default market.
        attribute regulatoryRegime : RegulatoryRegimeKind[0..*];
        part rulePolicy : RulePolicy[0..*];
    }

    part def DhfDocumentBinding :> MemoPart {
        attribute documentTitle : String;
        attribute groupLabel : String;
        attribute templateId : String;
        attribute viewKind : String;
        attribute regulatoryReference : String;
        attribute lifecycleStage : WorkflowStageKind;
        attribute required : Boolean;
    }

    part def Archetype :> MemoPart {
        attribute label : String;
        attribute :>> description : String;
        attribute category : String;
        attribute includedLayer : String;
        attribute includedStandard : String;
        attribute templateDir : String;
    }

    // ── Relations owned by this package ─────────────────────────────
    // Moved out of memo_core_relationships: their ends are typed against
    // types declared here, and core must not depend on a domain package.
}
