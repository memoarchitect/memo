// GPCA prototype methodology.
//
// Converted from subtraction to explicit selection at the native semantic flip.
// Before, this methodology said "the default, minus cybersecurity and SOUP" by
// listing `excludedKind` entries on a separate `MethodologyScope` part. ADR-1-15
// requires a methodology to declare its own final effective lists, so the
// selection is now stated positively here and the scope part is gone.
//
// Two differences from the pre-flip behaviour are deliberate and recorded:
//
//  1. Cybersecurity is excluded by *not* importing `memo_assurance_cybersecurity`
//     and by two explicit RulePolicy entries disabling the cybersecurity closure
//     rules. Before, `excludedKind` named eleven cybersecurity kinds; naming the
//     discipline once is the same selection stated at the level the methodology
//     metamodel supports.
//  2. `SoftwareModule[moduleKind=soup]` cannot be expressed as an inclusion.
//     Explicit selection works over kinds, not over instance attribute values,
//     so a per-instance filter has no positive form. The GPCA model declares no
//     SOUP module, so the effective element set is unchanged; the intent is
//     recorded in this methodology's description and belongs to a project rule
//     if it ever needs enforcing.
//
// The authored `gpcaMethodResolved : ResolvedMethodology` is gone. A resolved
// methodology is derived from the binding and the methodology chain; authoring
// one by hand created a second answer that no resolver produced.
package memo_examples_gpca_pump_methodology_gpca_profiles {
    private import ScalarValues::*;

    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    // ── The selection ────────────────────────────────────────────────────
    //
    // What this methodology selects is what this package publicly imports.
    // The five architecture layers, each through the package that publicly
    // imports the whole layer:
    public import memo_architecture_operational::*;
    public import memo_architecture_functional::*;
    public import memo_architecture_logical::*;
    public import memo_architecture_implementation::*;
    public import memo_architecture_realization::*;

    // Explicit means explicit. A methodology that names its assurance
    // disciplines and stops there selects no rules at all, because rules
    // live in their own packages. Before the flip an empty list read as
    // "everything", which hid exactly this: the selection said nothing and
    // the tools behaved as though it said everything. Cybersecurity is the
    // discipline not imported.
    public import memo_core_common::*;
    public import memo_core_enumerations::*;
    public import memo_core_relationships::*;
    public import memo_core_annotations::*;
    public import memo_core_consistency_rules::*;
    public import memo_assurance_requirements::*;
    public import memo_assurance_requirements_needs::*;
    public import memo_assurance_safety_risk::*;
    public import memo_assurance_human_factors::*;
    public import memo_assurance_verification_validation::*;
    public import memo_rules_closure::*;
    public import memo_rules_crosslayer::*;
    public import memo_rules_quantitative::*;
    public import memo_rules_ontology::*;

    private import memo_artifacts_standards_iso_14971::iso14971;
    private import memo_artifacts_standards_iec_62304::iec62304;
    private import memo_artifacts_standards_cfr_21_820::cfr21Part820;
    private import memo_artifacts_standards_iso_13485::iso13485;
    private import memo_viewpoints_context_context_viewpoint::contextViewpoint;
    private import memo_viewpoints_logical_logical_viewpoint::logicalArchitectureViewpoint;
    private import memo_viewpoints_risk_risk_viewpoint::riskViewpoint;

    private import memo_core_common::MemoIdentity;
    part gpcaMethodDefinition : MethodologyDefinition {
        @MemoIdentity { :>> providedId = "METH-GPCA-001"; :>> label = "GPCAPrototypeMethodology"; }
        attribute :>> version = "0.6.5";
        attribute :>> domain = "medical device modeling";
        doc /* GPCA infusion pump methodology for the non-networked prototype variant. Explicitly selects the five architecture layers and four of the five assurance disciplines; cybersecurity is out of scope because the prototype has no network interface. The prototype uses no SOUP. */
        ref :>> baseMethodology = mdDefaultDefinition;
        attribute :>> scopeMode = ScopeModeKind::explicit;

        // Typed. The standards GPCA also names, ISO 14155, IEC 62366 and
        // IEC 60601-1, have no RegulatoryStandard in the ontology yet, and the
        // artifact kind "RiskManagementPlan" is no ArtifactKind literal; as
        // strings they selected nothing and nothing said so.
        ref :>> includedStandard = (
            iso14971,
            iec62304,
            cfr21Part820,
            iso13485
        );

        ref :>> includedViewpoint = (
            contextViewpoint,
            logicalArchitectureViewpoint,
            riskViewpoint
        );

        part disableThreatMitigation : RulePolicy :> rulePolicy {
            ref :>> targetRule : ThreatMitigationRule;
            attribute :>> disposition = RuleDispositionKind::disabled;
            attribute :>> rationaleText = "CR-MED-040 requires every threat to carry a mitigation. The prototype has no network or removable-media interface, so no threat is in scope and the rule can only report on elements this variant does not model.";
            attribute :>> authority = "GPCA Systems Engineering Lead";
            attribute :>> approvalReference = "GPCA-DHF-CR-0007";
        }

        part disableAssetThreatLink : RulePolicy :> rulePolicy {
            ref :>> targetRule : AssetThreatLinkRule;
            attribute :>> disposition = RuleDispositionKind::disabled;
            attribute :>> rationaleText = "CR-MED-041 requires every cybersecurity asset to trace to a threat. Cybersecurity is not a selected discipline for this variant, so the rule has no subjects and its absence is recorded here rather than left implicit.";
            attribute :>> authority = "GPCA Systems Engineering Lead";
            attribute :>> approvalReference = "GPCA-DHF-CR-0007";
        }
    }
}
