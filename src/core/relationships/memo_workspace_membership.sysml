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
// `neither` is the conservative reading and is deliberate, not a default: a
// test requires a row for every relation, so adding a relation forces the
// decision. Notably `neither` for `includesStep`, `interface`, `flow` and
// `performs`: a clinical use case that includes three system use cases, or a
// chain that performs functions of three systems, belongs to the system of
// systems and must not be pulled into each system it touches.
package memo_core_relationships_workspace_membership {
    private import ScalarValues::*;
    private import memo_core_enumerations::*;

    part def WorkspaceMembershipEntry {
        doc /* One relation and the direction it places elements in a workspace. */
        attribute relation : String;
        attribute direction : WorkspaceMembershipKind;
    }

    part membershipDecisionRecordedInADR : WorkspaceMembershipEntry { attribute :>> relation = "decisionRecordedInADR"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipDecides : WorkspaceMembershipEntry { attribute :>> relation = "decides"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipDependsOnSoup : WorkspaceMembershipEntry { attribute :>> relation = "dependsOnSoup"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipCapturesScreen : WorkspaceMembershipEntry { attribute :>> relation = "capturesScreen"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipElementTriggersAction : WorkspaceMembershipEntry { attribute :>> relation = "elementTriggersAction"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipFlowServesUseCase : WorkspaceMembershipEntry { attribute :>> relation = "flowServesUseCase"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipErrorAtElement : WorkspaceMembershipEntry { attribute :>> relation = "errorAtElement"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A risk control follows the element that implements it.
    part membershipControlImplementedBy : WorkspaceMembershipEntry { attribute :>> relation = "controlImplementedBy"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    part membershipLogicalConnector : WorkspaceMembershipEntry { attribute :>> relation = "logicalConnector"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipIndependentOf : WorkspaceMembershipEntry { attribute :>> relation = "independentOf"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipAssessesDifficulty : WorkspaceMembershipEntry { attribute :>> relation = "assessesDifficulty"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipGoverns : WorkspaceMembershipEntry { attribute :>> relation = "governs"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipInteractsInContext : WorkspaceMembershipEntry { attribute :>> relation = "interactsInContext"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipAppliesInContext : WorkspaceMembershipEntry { attribute :>> relation = "appliesInContext"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipSituatedIn : WorkspaceMembershipEntry { attribute :>> relation = "situatedIn"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipRequiresCapability : WorkspaceMembershipEntry { attribute :>> relation = "requiresCapability"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipEnablesUseCase : WorkspaceMembershipEntry { attribute :>> relation = "enablesUseCase"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipMotivates : WorkspaceMembershipEntry { attribute :>> relation = "motivates"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipRealizesUseCase : WorkspaceMembershipEntry { attribute :>> relation = "realizesUseCase"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipTransforms : WorkspaceMembershipEntry { attribute :>> relation = "transforms"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A module follows the deployment unit it is built into.
    part membershipBuildsInto : WorkspaceMembershipEntry { attribute :>> relation = "buildsInto"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A deployment unit follows the node it runs on.
    part membershipDeploysTo : WorkspaceMembershipEntry { attribute :>> relation = "deploysTo"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    part membershipProvidesEnvironment : WorkspaceMembershipEntry { attribute :>> relation = "providesEnvironment"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipMemoryBinding : WorkspaceMembershipEntry { attribute :>> relation = "memoryBinding"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipConnectionBinding : WorkspaceMembershipEntry { attribute :>> relation = "connectionBinding"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipFlowComprisesSpec : WorkspaceMembershipEntry { attribute :>> relation = "flowComprisesSpec"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipFlowTraversesBinding : WorkspaceMembershipEntry { attribute :>> relation = "flowTraversesBinding"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipChanges : WorkspaceMembershipEntry { attribute :>> relation = "changes"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipConformsTo : WorkspaceMembershipEntry { attribute :>> relation = "conformsTo"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipTracesToDocument : WorkspaceMembershipEntry { attribute :>> relation = "tracesToDocument"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipThreatenedBy : WorkspaceMembershipEntry { attribute :>> relation = "threatenedBy"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipExploits : WorkspaceMembershipEntry { attribute :>> relation = "exploits"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipRealizedByScenario : WorkspaceMembershipEntry { attribute :>> relation = "realizedByScenario"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipImpactsSafety : WorkspaceMembershipEntry { attribute :>> relation = "impactsSafety"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipHasSecurityProperty : WorkspaceMembershipEntry { attribute :>> relation = "hasSecurityProperty"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipExposesAsset : WorkspaceMembershipEntry { attribute :>> relation = "exposesAsset"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipAttributedToThreatActor : WorkspaceMembershipEntry { attribute :>> relation = "attributedToThreatActor"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipUsesAttackTechnique : WorkspaceMembershipEntry { attribute :>> relation = "usesAttackTechnique"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipIncludesAttackTechnique : WorkspaceMembershipEntry { attribute :>> relation = "includesAttackTechnique"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipRealizesCyberHazard : WorkspaceMembershipEntry { attribute :>> relation = "realizesCyberHazard"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipAssessesCyberRisk : WorkspaceMembershipEntry { attribute :>> relation = "assessesCyberRisk"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipIdentifiesVulnerability : WorkspaceMembershipEntry { attribute :>> relation = "identifiesVulnerability"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipAffectsSBOMEntry : WorkspaceMembershipEntry { attribute :>> relation = "affectsSBOMEntry"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipDemonstratesAttackPath : WorkspaceMembershipEntry { attribute :>> relation = "demonstratesAttackPath"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipSupportsMitigationEffectiveness : WorkspaceMembershipEntry { attribute :>> relation = "supportsMitigationEffectiveness"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipConditionsCyberElement : WorkspaceMembershipEntry { attribute :>> relation = "conditionsCyberElement"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipMonitorsSBOMEntry : WorkspaceMembershipEntry { attribute :>> relation = "monitorsSBOMEntry"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipCommitsUseError : WorkspaceMembershipEntry { attribute :>> relation = "commitsUseError"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipEvaluatesTask : WorkspaceMembershipEntry { attribute :>> relation = "evaluatesTask"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipTestedByUsability : WorkspaceMembershipEntry { attribute :>> relation = "testedByUsability"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipHeldBy : WorkspaceMembershipEntry { attribute :>> relation = "heldBy"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // An effect follows its cause.
    part membershipCauses : WorkspaceMembershipEntry { attribute :>> relation = "causes"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    part membershipDetectedBy : WorkspaceMembershipEntry { attribute :>> relation = "detectedBy"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipInputToGate : WorkspaceMembershipEntry { attribute :>> relation = "inputToGate"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipProducesEvent : WorkspaceMembershipEntry { attribute :>> relation = "producesEvent"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipContainsEvent : WorkspaceMembershipEntry { attribute :>> relation = "containsEvent"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipIdentifiesHazard : WorkspaceMembershipEntry { attribute :>> relation = "identifiesHazard"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipHasFailureMode : WorkspaceMembershipEntry { attribute :>> relation = "hasFailureMode"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipTracesRisk : WorkspaceMembershipEntry { attribute :>> relation = "tracesRisk"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipLeadsToHarm : WorkspaceMembershipEntry { attribute :>> relation = "leadsToHarm"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipHazardRelatedScenario : WorkspaceMembershipEntry { attribute :>> relation = "hazardRelatedScenario"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipAssessedAgainst : WorkspaceMembershipEntry { attribute :>> relation = "assessedAgainst"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipEstimatedFor : WorkspaceMembershipEntry { attribute :>> relation = "estimatedFor"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipReducedBy : WorkspaceMembershipEntry { attribute :>> relation = "reducedBy"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipEvaluatedIn : WorkspaceMembershipEntry { attribute :>> relation = "evaluatedIn"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A risk control follows the risk it mitigates.
    part membershipMitigates : WorkspaceMembershipEntry { attribute :>> relation = "mitigates"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    part membershipFeedsBackTo : WorkspaceMembershipEntry { attribute :>> relation = "feedsBackTo"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipPerformsStep : WorkspaceMembershipEntry { attribute :>> relation = "performsStep"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipCommentsOn : WorkspaceMembershipEntry { attribute :>> relation = "commentsOn"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipRationaleFor : WorkspaceMembershipEntry { attribute :>> relation = "rationaleFor"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipNotesOn : WorkspaceMembershipEntry { attribute :>> relation = "notesOn"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A need or driver follows the requirement derived from it.
    part membershipDerivesFrom : WorkspaceMembershipEntry { attribute :>> relation = "derivesFrom"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    part membershipProducesEvidence : WorkspaceMembershipEntry { attribute :>> relation = "producesEvidence"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A threat or risk follows the requirement derived from it.
    part membershipDerivesCyberRequirement : WorkspaceMembershipEntry { attribute :>> relation = "derivesCyberRequirement"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    part membershipCrossesTrustBoundary : WorkspaceMembershipEntry { attribute :>> relation = "crossesTrustBoundary"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A validation case follows what it validates.
    part membershipValidates : WorkspaceMembershipEntry { attribute :>> relation = "validates"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A processing node follows the assembly that hosts it.
    part membershipHostedBy : WorkspaceMembershipEntry { attribute :>> relation = "hostedBy"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    part membershipBindsToInterface : WorkspaceMembershipEntry { attribute :>> relation = "bindsToInterface"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A requirement follows what satisfies it.
    part membershipSatisfiedBy : WorkspaceMembershipEntry { attribute :>> relation = "satisfiedBy"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    // A verification case follows what it verifies.
    part membershipVerifiedBy : WorkspaceMembershipEntry { attribute :>> relation = "verifiedBy"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    // A function follows the element it runs on.
    part membershipAllocatedTo : WorkspaceMembershipEntry { attribute :>> relation = "allocatedTo"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    part membershipPerforms : WorkspaceMembershipEntry { attribute :>> relation = "performs"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipIncludesStep : WorkspaceMembershipEntry { attribute :>> relation = "includesStep"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipDependency : WorkspaceMembershipEntry { attribute :>> relation = "dependency"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // An actor follows the use cases it takes part in.
    part membershipParticipatesIn : WorkspaceMembershipEntry { attribute :>> relation = "participatesIn"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    part membershipExhibitsMode : WorkspaceMembershipEntry { attribute :>> relation = "exhibitsMode"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipFramesConcern : WorkspaceMembershipEntry { attribute :>> relation = "framesConcern"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A use case follows its subject.
    part membershipHasSubject : WorkspaceMembershipEntry { attribute :>> relation = "hasSubject"; attribute :>> direction = WorkspaceMembershipKind::sourceFollowsTarget; }
    part membershipAssumes : WorkspaceMembershipEntry { attribute :>> relation = "assumes"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipRequires : WorkspaceMembershipEntry { attribute :>> relation = "requires"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    // A child follows its parent.
    part membershipComposes : WorkspaceMembershipEntry { attribute :>> relation = "composes"; attribute :>> direction = WorkspaceMembershipKind::targetFollowsSource; }
    part membershipRealizes : WorkspaceMembershipEntry { attribute :>> relation = "realizes"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipBind : WorkspaceMembershipEntry { attribute :>> relation = "bind"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipFlow : WorkspaceMembershipEntry { attribute :>> relation = "flow"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipInterface : WorkspaceMembershipEntry { attribute :>> relation = "interface"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipSuccession : WorkspaceMembershipEntry { attribute :>> relation = "succession"; attribute :>> direction = WorkspaceMembershipKind::neither; }
    part membershipVariant : WorkspaceMembershipEntry { attribute :>> relation = "variant"; attribute :>> direction = WorkspaceMembershipKind::neither; }
}
