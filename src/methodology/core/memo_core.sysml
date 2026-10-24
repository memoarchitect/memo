package memo_methodology_core {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;
    private import memo_core_relationships::*;   // MemoRelationship

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_consistency_rules::*;
    private import memo_artifacts_standards_traceability::RegulatoryStandard;
    private import memo_viewpoints_definitions::MemoViewpoint;
    private import memo_viewpoints_stakeholders_concerns::MemoStakeholder;

    part def MethodologyLibrary :> MemoPart {
        attribute version : String;
        attribute domain : String;
    }

    // A rule's disposition under one methodology or model binding.
    //
    // `targetRule` and `replacementRule` are typed references to the rule's own
    // `constraint def`, narrowed at the usage with `ref :>> targetRule : <Rule>`.
    // There is deliberately no `targetRuleId : String`: a qualified SysML
    // reference already identifies the rule, and a parallel string namespace
    // would be a MEMO-specific identifier where the language has one. The
    // stable rule ID survives on the rule itself, for audit records and
    // diagnostics — a different job from being the reference mechanism.
    //
    // A policy selects what it governs in ONE of three ways. A rule (`targetRule`),
    // as above; every rule that enforces a clause of a standard
    // (`targetStandard`, written `ref :>> targetStandard = <standard>;`); or every
    // rule whose subject kind sits in a layer (`targetCategory`, a layer
    // namespace by name, `"memo_assurance_safety_risk"`: a value cannot
    // reference a package, so this one stays a string). A selection of several rules is
    // still one decision with one rationale and one approval, so the tailoring
    // record reports it once, with the rules it reached; a rule added later that
    // the selection matches is covered by it. An invariant in the selection keeps
    // running, as it does for a policy naming it.
    part def RulePolicy :> MemoPart {
        ref targetRule : MemoConsistencyRule[0..1];
        ref targetStandard : RegulatoryStandard[0..1];
        attribute targetCategory : String[0..1];
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
        // Exactly one base methodology at most. Multiple inheritance is not a
        // multiplicity the resolver has conflict semantics for, so the model
        // does not permit expressing it.
        ref baseMethodology : MethodologyDefinition[0..1];
        // Whether the selection below is the whole story. Under `explicit`,
        // what is not selected is out of scope; under `allAvailable`, every
        // package the project resolved is in scope and the methodology selects
        // nothing itself.
        attribute scopeMode : ScopeModeKind;
        // The packages a methodology selects are not listed here. They are
        // what the package declaring the methodology PUBLICLY imports:
        //
        //     public import memo_architecture_logical::*;   // a layer
        //     public import memo_assurance_safety_risk::*;  // one package
        //     public import memo_extension_ros::*;          // an extension
        //
        // A public import is how SysML says a package passes another's members
        // on to whoever imports it, so the selection is the import, followed
        // transitively through public imports; a private import is the
        // package's own business and selects nothing. A layer and an extension
        // each have one package that publicly imports all of theirs. Because
        // the package is the selection, a package declares one methodology.
        // A project adds to the selection the same way, from its entrypoint
        // package. A misspelled package is an import the compiler rejects.
        //
        // The standards, artifact kinds and viewpoints a methodology selects
        // are TYPED: a standard is a RegulatoryStandard, an artifact kind is an
        // ArtifactKind literal, a viewpoint is a MemoViewpoint. They were
        // strings ("ISO 14155", "RiskManagementPlan", "VP-CTX"), and three
        // standards and an artifact kind in the GPCA methodology named nothing
        // the ontology declares: a string that matches nothing selects nothing,
        // and nothing said so. Now the compiler does.
        ref includedStandard : RegulatoryStandard[0..*];
        attribute includedArtifactKind : ArtifactKind[0..*];
        ref includedViewpoint : MemoViewpoint[0..*];
        part rulePolicy : RulePolicy[0..*];
    }

    // Which viewpoints a role works with (plan O12). A viewpoint names the stakeholders it is written for,
    // and that is what a role sees by default; a methodology may say otherwise for a role, and then THIS is
    // what the role sees, an override and not an addition. A method that names a base starts from its
    // role views, and a later one for the same stakeholder replaces the earlier.
    //
    //   part rvSafety : RoleView { ref :>> forStakeholder = safetyEngineer; ref :>> shownViewpoint = (vpRiskChain, vpEvidenceTraceability); }
    part def RoleView :> MemoPart {
        // `stakeholder` and `viewpoint` are SysML keywords, so neither names a feature.
        ref forStakeholder : MemoStakeholder;
        ref shownViewpoint : MemoViewpoint[0..*];
    }

    // Derived, never authored. The resolver projects this from a binding and
    // its methodology chain. If it is serialized for review it is generated
    // output that records its input hashes; it does not compete with the
    // authored methodology and binding, and ontology source declares no
    // instances of it.
    part def ResolvedMethodology :> MemoPart {
        attribute version : String;
    }

    // What a model is bound to: its name, the methodology it is governed by,
    // and the rule policies it adds. "Model" is what Architect opens, one
    // repository and one compile; "project" means a change set in an iteration.
    part def ModelMethodBinding :> MemoPart {
        attribute modelName : String;
        ref selectedMethodology : MethodologyDefinition;
        // `allAvailable` widens the model to every package it resolved,
        // whatever the methodology selects; anything else leaves the
        // methodology's mode in force. A model ADDS packages to the
        // selection by importing them publicly in the package that declares
        // this binding (`public import memo_extension_ros::*;`), the same way
        // a methodology selects them. There is no list to keep beside it.
        attribute scopeMode : ScopeModeKind;
        // The approvals this model targets are `RegulatedDevice` parts (one jurisdiction each), not a setting here:
        // `memo standards check`, the standards checklist and the Architect gap badges read their jurisdictions.
        part rulePolicy : RulePolicy[0..*];
    }

    // DEPRECATED in 0.14.0, deleted in 0.15.0: the former spelling of
    // ModelMethodBinding, kept so a model written with it still binds. MEMO
    // reads `projectName` when `modelName` is absent and warns on either.
    part def ProjectMethodBinding :> ModelMethodBinding {
        attribute projectName : String;
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
        attribute category : String;
        attribute includedLayer : String;
        attribute includedStandard : String;
        attribute templateDir : String;
    }

    // ── Relations owned by this package ─────────────────────────────
    // Moved out of memo_core_relationships: their ends are typed against
    // types declared here, and core must not depend on a domain package.
}
