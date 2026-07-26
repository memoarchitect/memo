# Rules

MEMO's checks are **native SysML v2 constraints in the model**, not
configuration in a tool. Any conformant SysML v2 tool evaluates them; the
`memo` CLI is a runner, not the authority on legality.

A rule answers a review question mechanically. *Does every hazard have a risk
control? Is every risk control verified?* — expressed as a constraint that
walks the required typed links and flags a missing path.

**65 rules** in 6 categories.

## Closure

Is the argument complete? An unmitigated hazard, an unverified risk control, a requirement with no design response.

`src/rules/closure/` — 16 rules

| Rule |
| --- |
| `assetThreatLinkRule` |
| `evidenceProductionRule` |
| `hazardMitigationRule` |
| `hazardSeverityRule` |
| `initialRiskMatrixRule` |
| `logicalFunctionAllocationRule` |
| `logicalInterfaceDirectionRule` |
| `riskControlVerificationRule` |
| `safetyClassCVerificationRule` |
| `swComponentReqRule` |
| `swComponentSafetyClassRule` |
| `swReqTraceRule` |
| `sysReqTraceRule` |
| `threatMitigationRule` |
| `verificationCaseMethodRule` |
| `verificationCaseTargetRule` |

## Coverage

Does the model contain what a given standard expects to exist at all?

`src/rules/coverage/` — 22 rules

| Rule |
| --- |
| `fda820DesignInputCoverage` |
| `fda820DesignVerificationCoverage` |
| `fdaCyberAssetCoverage` |
| `fdaCyberHazardCoverage` |
| `fdaCyberMitigationCoverage` |
| `fdaCyberRiskCoverage` |
| `fdaCyberSecurityReqCoverage` |
| `fdaCyberThreatCoverage` |
| `fdaCyberThreatScenarioCoverage` |
| `fdaCyberTrustBoundaryCoverage` |
| `fdaCyberVerificationCoverage` |
| `fdaCyberVulnerabilityCoverage` |
| `iec60601HarmCoverage` |
| `iec62304SwArchCoverage` |
| `iec62304SwReqCoverage` |
| `iec62366ActorCoverage` |
| `iec82304SwSystemCoverage` |
| `iso13485StakeholderNeedCoverage` |
| `iso14155UseContextCoverage` |
| `iso14971HazardCoverage` |
| `iso14971ResidualRiskCoverage` |
| `iso14971RiskMatrixCoverage` |

## Cross-layer

Do the links between the two axes actually run?

`src/rules/crosslayer/` — 3 rules

| Rule |
| --- |
| `cyberToSafetyTraceRule` |
| `reqToArchTraceRule` |
| `riskToReqTraceRule` |

## Lifecycle

Did things happen in a defensible order?

`src/rules/lifecycle/` — 3 rules

| Rule |
| --- |
| `evidenceAfterVerificationRule` |
| `reqBeforeArchRule` |
| `riskBeforeVerificationRule` |

## Ontology

Is the model well-formed against MEMO itself?

`src/rules/ontology/` — 19 rules

| Rule |
| --- |
| `alternateScenarioHasBaseRule` |
| `connectorEndpointsExistRule` |
| `containmentAcyclicRule` |
| `criticalTaskValidatedRule` |
| `deployToCapableNodeRule` |
| `directionAgreesWithFlowRule` |
| `exchangedItemTypeRule` |
| `instanceHasDefinitionRule` |
| `layersOptionalRule` |
| `logicalRealizationTypedRule` |
| `noInstanceIdentityOnDefinitionRule` |
| `patientContactCharacterizedRule` |
| `portCompatibilityRule` |
| `reusableSterileIdentifiesReprocessingRule` |
| `runtimeTracesToModuleRule` |
| `safetyCriticalFunctionVerifiedRule` |
| `singleAxisOwnershipRule` |
| `singleUseNoReprocessingRule` |
| `useErrorTracesToHazardRule` |

## Quantitative

Are the counts within configured bounds?

`src/rules/quantitative/` — 2 rules

| Rule |
| --- |
| `hazardMaxControlsRule` |
| `swComponentMaxInterfacesRule` |
