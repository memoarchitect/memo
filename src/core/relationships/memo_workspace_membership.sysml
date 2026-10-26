// Which workspace a relation's far end belongs to.
//
// A workspace (the system of systems, or one system) is not declared; it is
// the closure of what is linked to the system (plans/memo-model-product-project-structure.md,
// T2). That closure needs one fact per relation: when one end is in a workspace,
// does the relation draw the other end in? This file states it, for every
// relation the registry holds and for the edges the builder synthesizes from
// SysML keywords (`flow`, `interface`, `succession`, `bind`, `variant`).
//
// It is a table, not an attribute on each relation def, because the relations
// the closure needs most are SysML keywords with no def to annotate (`allocate`,
// `satisfy`, `verify`, `subject`, nesting). One mechanism for all of them.
//
//   sourceFollowsTarget  the source is in whichever workspace the target is in
//                        (a function is in the workspace of the component it is
//                        allocated to)
//   targetFollowsSource  the target is in whichever workspace the source is in
//                        (a verification case follows the requirement it verifies)
//   neither              the relation joins elements without placing either
//
// Every row is a decision and says why. A test requires a row for every
// relation, so adding a relation forces the decision. The rule of thumb: the
// dependent end follows the anchor end (a function follows the component it is
// allocated to, a comment follows the element it annotates). `neither` is for
// peers, for shared catalogue entries, and for the elements that sit above the
// systems: a clinical use case that includes three system use cases, or a chain
// that performs functions of three systems, belongs to the system of systems and
// must not be pulled into each system it touches (`includesStep`, `performs`,
// `interface`, `flow`).
package memo_core_relationships_workspace_membership {
    private import ScalarValues::*;
    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    part def WorkspaceMembershipEntry specializes MemoPart {
        doc /* One relation and the direction it places elements in a workspace. */
        attribute relation : String;
        attribute direction : WorkspaceMembershipKind;
    }

    // An ADR follows the decision it records.
    part membershipDecisionRecordedInADR : WorkspaceMembershipEntry { attribute :>> relation = "decisionRecordedInADR"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A design decision follows the element it affects.
    part membershipDecides : WorkspaceMembershipEntry { attribute :>> relation = "decides"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A SOUP item follows the component that depends on it.
    part membershipDependsOnSoup : WorkspaceMembershipEntry { attribute :>> relation = "dependsOnSoup"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A screen capture follows its screen.
    part membershipCapturesScreen : WorkspaceMembershipEntry { attribute :>> relation = "capturesScreen"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A UI action follows the element that triggers it.
    part membershipElementTriggersAction : WorkspaceMembershipEntry { attribute :>> relation = "elementTriggersAction"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // An interaction flow follows the use case it serves.
    part membershipFlowServesUseCase : WorkspaceMembershipEntry { attribute :>> relation = "flowServesUseCase"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A use error follows the element it occurs at.
    part membershipErrorAtElement : WorkspaceMembershipEntry { attribute :>> relation = "errorAtElement"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A risk control follows the element that implements it.
    part membershipControlImplementedBy : WorkspaceMembershipEntry { attribute :>> relation = "controlImplementedBy"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Neither: a connector joins peer components.
    part membershipLogicalConnector : WorkspaceMembershipEntry { attribute :>> relation = "logicalConnector"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: independence is a claim about two channels, not a placement.
    part membershipIndependentOf : WorkspaceMembershipEntry { attribute :>> relation = "independentOf"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A difficulty assessment follows its task.
    part membershipAssessesDifficulty : WorkspaceMembershipEntry { attribute :>> relation = "assessesDifficulty"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Neither: a governing rule or standard applies to many elements and is placed by none.
    part membershipGoverns : WorkspaceMembershipEntry { attribute :>> relation = "governs"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A context participant follows the system of interest.
    part membershipInteractsInContext : WorkspaceMembershipEntry { attribute :>> relation = "interactsInContext"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A use context follows its subject element.
    part membershipAppliesInContext : WorkspaceMembershipEntry { attribute :>> relation = "appliesInContext"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Neither: an environment is shared by the contexts situated in it.
    part membershipSituatedIn : WorkspaceMembershipEntry { attribute :>> relation = "situatedIn"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: an intended use and its capability are operational, not any system.
    part membershipRequiresCapability : WorkspaceMembershipEntry { attribute :>> relation = "requiresCapability"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A capability follows the use case it enables.
    part membershipEnablesUseCase : WorkspaceMembershipEntry { attribute :>> relation = "enablesUseCase"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A need follows the use case it motivates.
    part membershipMotivates : WorkspaceMembershipEntry { attribute :>> relation = "motivates"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A workflow follows the use case it realizes.
    part membershipRealizesUseCase : WorkspaceMembershipEntry { attribute :>> relation = "realizesUseCase"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Neither: a transformation joins two actions.
    part membershipTransforms : WorkspaceMembershipEntry { attribute :>> relation = "transforms"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A module follows the deployment unit it is built into.
    part membershipBuildsInto : WorkspaceMembershipEntry { attribute :>> relation = "buildsInto"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // The hardware or software follows the logical component it realizes: the logical component is
    // what a System contains, and what implements it belongs to the same System (logical and
    // implementation are separate structures joined by this allocation, never nested).
    part membershipRealizedBy : WorkspaceMembershipEntry { attribute :>> relation = "realizedBy"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A deployment unit follows the node it runs on.
    part membershipDeploysTo : WorkspaceMembershipEntry { attribute :>> relation = "deploysTo"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A runtime environment follows the node that provides it.
    part membershipProvidesEnvironment : WorkspaceMembershipEntry { attribute :>> relation = "providesEnvironment"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A memory device follows the component bound to it.
    part membershipMemoryBinding : WorkspaceMembershipEntry { attribute :>> relation = "memoryBinding"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A physical medium follows the exchange bound to it.
    part membershipConnectionBinding : WorkspaceMembershipEntry { attribute :>> relation = "connectionBinding"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A flow specification follows the end-to-end flow it belongs to.
    part membershipFlowComprisesSpec : WorkspaceMembershipEntry { attribute :>> relation = "flowComprisesSpec"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // Neither: an end-to-end flow crosses deployment units; it is not part of any one.
    part membershipFlowTraversesBinding : WorkspaceMembershipEntry { attribute :>> relation = "flowTraversesBinding"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A change request follows the element it changes.
    part membershipChanges : WorkspaceMembershipEntry { attribute :>> relation = "changes"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Neither: a clause belongs to the standards library, not to any workspace.
    part membershipConformsTo : WorkspaceMembershipEntry { attribute :>> relation = "conformsTo"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A controlled document follows the elements that trace to it.
    part membershipTracesToDocument : WorkspaceMembershipEntry { attribute :>> relation = "tracesToDocument"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A threat follows the asset it threatens.
    part membershipThreatenedBy : WorkspaceMembershipEntry { attribute :>> relation = "threatenedBy"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A vulnerability follows the threat that exploits it.
    part membershipExploits : WorkspaceMembershipEntry { attribute :>> relation = "exploits"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // An attack scenario follows the threat it realizes.
    part membershipRealizedByScenario : WorkspaceMembershipEntry { attribute :>> relation = "realizedByScenario"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // Neither: a cyber element and a safety item are each placed on their own.
    part membershipImpactsSafety : WorkspaceMembershipEntry { attribute :>> relation = "impactsSafety"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: a benefit and the risk it is weighed against are each placed on their own.
    part membershipWeighedAgainst : WorkspaceMembershipEntry { attribute :>> relation = "weighedAgainst"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A security property follows its asset.
    part membershipHasSecurityProperty : WorkspaceMembershipEntry { attribute :>> relation = "hasSecurityProperty"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // An attack surface follows the asset it exposes.
    part membershipExposesAsset : WorkspaceMembershipEntry { attribute :>> relation = "exposesAsset"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Neither: a threat actor is shared by every threat attributed to it.
    part membershipAttributedToThreatActor : WorkspaceMembershipEntry { attribute :>> relation = "attributedToThreatActor"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: an attack technique is a shared catalogue entry.
    part membershipUsesAttackTechnique : WorkspaceMembershipEntry { attribute :>> relation = "usesAttackTechnique"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: an attack technique is a shared catalogue entry.
    part membershipIncludesAttackTechnique : WorkspaceMembershipEntry { attribute :>> relation = "includesAttackTechnique"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A cyber hazard follows the threat that realizes it.
    part membershipRealizesCyberHazard : WorkspaceMembershipEntry { attribute :>> relation = "realizesCyberHazard"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A cyber risk assessment follows the risk it assesses.
    part membershipAssessesCyberRisk : WorkspaceMembershipEntry { attribute :>> relation = "assessesCyberRisk"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A security finding follows the vulnerability it identifies.
    part membershipIdentifiesVulnerability : WorkspaceMembershipEntry { attribute :>> relation = "identifiesVulnerability"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A vulnerability follows the SBOM entry it affects.
    part membershipAffectsSBOMEntry : WorkspaceMembershipEntry { attribute :>> relation = "affectsSBOMEntry"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A security finding follows the attack path it demonstrates.
    part membershipDemonstratesAttackPath : WorkspaceMembershipEntry { attribute :>> relation = "demonstratesAttackPath"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Evidence follows the mitigation it supports.
    part membershipSupportsMitigationEffectiveness : WorkspaceMembershipEntry { attribute :>> relation = "supportsMitigationEffectiveness"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // An assumption follows the cyber element it conditions.
    part membershipConditionsCyberElement : WorkspaceMembershipEntry { attribute :>> relation = "conditionsCyberElement"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A postmarket process follows the SBOM entry it monitors.
    part membershipMonitorsSBOMEntry : WorkspaceMembershipEntry { attribute :>> relation = "monitorsSBOMEntry"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A use error follows the task that commits it.
    part membershipCommitsUseError : WorkspaceMembershipEntry { attribute :>> relation = "commitsUseError"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // An evaluation follows the task it evaluates.
    part membershipEvaluatesTask : WorkspaceMembershipEntry { attribute :>> relation = "evaluatesTask"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A usability test follows the element or task it tests.
    part membershipTestedByUsability : WorkspaceMembershipEntry { attribute :>> relation = "testedByUsability"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // Neither: a need and its holder are each placed on their own.
    part membershipHeldBy : WorkspaceMembershipEntry { attribute :>> relation = "heldBy"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // An effect follows its cause.
    part membershipCauses : WorkspaceMembershipEntry { attribute :>> relation = "causes"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A detection method follows the failure mode it detects.
    part membershipDetectedBy : WorkspaceMembershipEntry { attribute :>> relation = "detectedBy"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // Neither: fault-tree nodes are joined, not placed, by their gates.
    part membershipInputToGate : WorkspaceMembershipEntry { attribute :>> relation = "inputToGate"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: fault-tree nodes are joined, not placed, by their gates.
    part membershipProducesEvent : WorkspaceMembershipEntry { attribute :>> relation = "producesEvent"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: a cut set names events that are placed on their own.
    part membershipContainsEvent : WorkspaceMembershipEntry { attribute :>> relation = "containsEvent"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A hazard follows the HAZOP deviation that identifies it.
    part membershipIdentifiesHazard : WorkspaceMembershipEntry { attribute :>> relation = "identifiesHazard"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A failure mode follows its element.
    part membershipHasFailureMode : WorkspaceMembershipEntry { attribute :>> relation = "hasFailureMode"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // Neither: a trace between risk elements places neither. Both ends are risk items (`TracesRisk` joins
    // RiskItem to RiskItem), so the relation names no design element to anchor to; a risk item belongs to the
    // system through the relation that ties it to one (a failure mode, a control measure's allocation).
    // Decided 2026-10-14: a risk chain with no such tie is Unassigned, which is the finding, not a gap here.
    part membershipTracesRisk : WorkspaceMembershipEntry { attribute :>> relation = "tracesRisk"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // An item scoped to a system follows that system: the whole purpose of the relation. The items an
    // item owns (a risk's hazard chain) join with it by ownership, so one link anchors a chain.
    part membershipScopedTo : WorkspaceMembershipEntry { attribute :>> relation = "scopedTo"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A harm follows the hazardous situation that leads to it.
    part membershipLeadsToHarm : WorkspaceMembershipEntry { attribute :>> relation = "leadsToHarm"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // Neither: a scenario illustrates a hazard without being part of it.
    part membershipHazardRelatedScenario : WorkspaceMembershipEntry { attribute :>> relation = "hazardRelatedScenario"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: a risk matrix is shared by every risk assessed against it.
    part membershipAssessedAgainst : WorkspaceMembershipEntry { attribute :>> relation = "assessedAgainst"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A risk estimate follows the risk element it is for.
    part membershipEstimatedFor : WorkspaceMembershipEntry { attribute :>> relation = "estimatedFor"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Neither: a residual risk and its control are each placed already.
    part membershipReducedBy : WorkspaceMembershipEntry { attribute :>> relation = "reducedBy"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: an overall residual-risk evaluation spans the whole device.
    part membershipEvaluatedIn : WorkspaceMembershipEntry { attribute :>> relation = "evaluatedIn"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A risk control follows the risk it mitigates.
    part membershipMitigates : WorkspaceMembershipEntry { attribute :>> relation = "mitigates"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A surveillance finding follows the design element it feeds back to.
    part membershipFeedsBackTo : WorkspaceMembershipEntry { attribute :>> relation = "feedsBackTo"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A test step follows its verification case.
    part membershipPerformsStep : WorkspaceMembershipEntry { attribute :>> relation = "performsStep"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A comment follows the element it annotates.
    part membershipCommentsOn : WorkspaceMembershipEntry { attribute :>> relation = "commentsOn"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A rationale follows the element it justifies.
    part membershipRationaleFor : WorkspaceMembershipEntry { attribute :>> relation = "rationaleFor"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A note follows the element it annotates.
    part membershipNotesOn : WorkspaceMembershipEntry { attribute :>> relation = "notesOn"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A need or driver follows the requirement derived from it.
    part membershipDerivesFrom : WorkspaceMembershipEntry { attribute :>> relation = "derivesFrom"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Evidence follows the case that produced it.
    part membershipProducesEvidence : WorkspaceMembershipEntry { attribute :>> relation = "producesEvidence"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A threat or risk follows the requirement derived from it.
    part membershipDerivesCyberRequirement : WorkspaceMembershipEntry { attribute :>> relation = "derivesCyberRequirement"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Neither: a crossing joins a boundary and an item that are each placed on their own.
    part membershipCrossesTrustBoundary : WorkspaceMembershipEntry { attribute :>> relation = "crossesTrustBoundary"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A validation case follows what it validates.
    part membershipValidates : WorkspaceMembershipEntry { attribute :>> relation = "validates"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A processing node follows the assembly that hosts it.
    part membershipHostedBy : WorkspaceMembershipEntry { attribute :>> relation = "hostedBy"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Neither: an interface definition is owned by the system of systems.
    part membershipBindsToInterface : WorkspaceMembershipEntry { attribute :>> relation = "bindsToInterface"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A requirement follows what satisfies it.
    part membershipSatisfiedBy : WorkspaceMembershipEntry { attribute :>> relation = "satisfiedBy"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A verification case follows what it verifies.
    part membershipVerifiedBy : WorkspaceMembershipEntry { attribute :>> relation = "verifiedBy"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A function follows the element it runs on.
    part membershipAllocatedTo : WorkspaceMembershipEntry { attribute :>> relation = "allocatedTo"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Neither: a chain that performs functions of three systems belongs to none of them. Decided 2026-10-14:
    // a chain step is the system of systems' own, so `performs` places nothing in a system.
    part membershipPerforms : WorkspaceMembershipEntry { attribute :>> relation = "performs"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: a step subsets the function it carries out; the function is not placed by it, as `performs` places nothing.
    part membershipSubsets : WorkspaceMembershipEntry { attribute :>> relation = "subsets"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: navigation joins two screens; the screen it opens is not placed by the element that opens it.
    part membershipNavigatesTo : WorkspaceMembershipEntry { attribute :>> relation = "navigatesTo"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: a use case that includes others belongs to the system of systems; pulling it would put it in every system it includes.
    part membershipIncludesStep : WorkspaceMembershipEntry { attribute :>> relation = "includesStep"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: a bare dependency says nothing about placement.
    part membershipDependency : WorkspaceMembershipEntry { attribute :>> relation = "dependency"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // An actor follows the use cases it takes part in.
    part membershipParticipatesIn : WorkspaceMembershipEntry { attribute :>> relation = "participatesIn"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A mode follows the component that exhibits it.
    part membershipExhibitsMode : WorkspaceMembershipEntry { attribute :>> relation = "exhibitsMode"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // Neither: a viewpoint frames concerns that no one workspace owns.
    part membershipFramesConcern : WorkspaceMembershipEntry { attribute :>> relation = "framesConcern"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A use case follows its subject.
    part membershipHasSubject : WorkspaceMembershipEntry { attribute :>> relation = "hasSubject"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // An assumption follows the contract that makes it.
    part membershipAssumes : WorkspaceMembershipEntry { attribute :>> relation = "assumes"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A guarantee follows the contract that makes it.
    part membershipRequires : WorkspaceMembershipEntry { attribute :>> relation = "requires"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A child follows its parent.
    part membershipComposes : WorkspaceMembershipEntry { attribute :>> relation = "composes"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // Neither: a refinement dependency says nothing about placement.
    part membershipRealizes : WorkspaceMembershipEntry { attribute :>> relation = "realizes"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: a binding equates two features; neither is placed by it.
    part membershipBind : WorkspaceMembershipEntry { attribute :>> relation = "bind"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: a flow joins peers; the chain it belongs to is not drawn into each system it touches.
    part membershipFlow : WorkspaceMembershipEntry { attribute :>> relation = "flow"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: an interface joins two systems and belongs to the system of systems.
    part membershipInterface : WorkspaceMembershipEntry { attribute :>> relation = "interface"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: ordering between steps places neither.
    part membershipSuccession : WorkspaceMembershipEntry { attribute :>> relation = "succession"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A variant follows its variation point.
    part membershipVariant : WorkspaceMembershipEntry { attribute :>> relation = "variant"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }

    // A feature follows the variants that realize it: realized by variants of two systems it is
    // shared, realized by none it is Unassigned (a feature nothing builds).
    part membershipRealizesFeature : WorkspaceMembershipEntry { attribute :>> relation = "realizesFeature"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // Neither: a release is a family-level record, and a feature it selects is placed by its variants.
    part membershipSelectsFeature : WorkspaceMembershipEntry { attribute :>> relation = "selectsFeature"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A feature lists the views that demonstrate it; listing one places it in no workspace.
    part membershipShowsView : WorkspaceMembershipEntry { attribute :>> relation = "showsView"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: two features that need each other are peers, and neither is placed by the other.
    part membershipRequiresFeature : WorkspaceMembershipEntry { attribute :>> relation = "requiresFeature"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: two features that exclude each other are peers.
    part membershipExcludesFeature : WorkspaceMembershipEntry { attribute :>> relation = "excludesFeature"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A design decision follows the option it weighs, as it follows the element it decides.
    part membershipAlternative : WorkspaceMembershipEntry { attribute :>> relation = "alternative"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A design decision follows the option it chose.
    part membershipSelected : WorkspaceMembershipEntry { attribute :>> relation = "selected"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }

    // A release record follows the item it releases: a release of a system is in that system's
    // workspace. With `neither` every record is Unassigned, which is a finding.
    part membershipReleaseOf : WorkspaceMembershipEntry { attribute :>> relation = "releaseOf"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Neither: a system of systems version contains system releases that belong to their systems.
    part membershipContains : WorkspaceMembershipEntry { attribute :>> relation = "contains"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: an interface revision belongs to the system of systems, and the systems that implement it are peers.
    part membershipImplements : WorkspaceMembershipEntry { attribute :>> relation = "implements"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: a verification case is placed by what it verifies, not by the release that cites it.
    part membershipVerifiedByCase : WorkspaceMembershipEntry { attribute :>> relation = "verifiedByCase"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // Neither: a change request is not placed by the release it is raised against.
    part membershipAffectsRelease : WorkspaceMembershipEntry { attribute :>> relation = "affectsRelease"; attribute :>> direction = WorkspaceMembershipKind::neither; }

    // A device follows the releases it covers, and they follow their items: a device that covers releases of
    // two systems is shared, and one that covers none is Unassigned (an approval for nothing).
    part membershipCovers : WorkspaceMembershipEntry { attribute :>> relation = "covers"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // An intended use follows the device it states the purpose of: it is in whichever workspace the device is.
    part membershipIntendedUseOf : WorkspaceMembershipEntry { attribute :>> relation = "intendedUseOf"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Two devices used together are peers; neither places the other (a pump and its infusion set may be approved
    // for different systems).
    part membershipUsedWith : WorkspaceMembershipEntry { attribute :>> relation = "usedWith"; attribute :>> direction = WorkspaceMembershipKind::neither; }

    // Neither: a step is not placed by the rule that says when it is done.
    part membershipDoneWhen : WorkspaceMembershipEntry { attribute :>> relation = "doneWhen"; attribute :>> direction = WorkspaceMembershipKind::neither; }

    // A project follows the releases it feeds, as a device follows what it covers: a project that feeds releases
    // of two systems is shared, and one that feeds none is Unassigned (work that reached nothing).
    part membershipFeeds : WorkspaceMembershipEntry { attribute :>> relation = "feeds"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // Neither: a variant is placed by its variation point; the project that introduced it is not drawn into it.
    part membershipIntroducedBy : WorkspaceMembershipEntry { attribute :>> relation = "introducedBy"; attribute :>> direction = WorkspaceMembershipKind::neither; }
}
