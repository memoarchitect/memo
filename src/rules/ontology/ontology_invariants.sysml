// Ontology conformance invariants (§25, 0.5 rework). Same native pattern as
// memo_rules_closure: `constraint def` bodies with declarative rule metadata
// (`predicateExpression`) evaluated by the external constraint engine.
// Structural invariants (endpoint existence, cycle freedom) are expressed over
// the typed relations introduced in 0.5 — typed references make them checkable.
package memo_rules_ontology {
    private import ScalarValues::*;

    private import memo_core_consistency_rules::*;
    private import memo_core_enumerations::*;

    // ─── Structure ───────────────────────────────────────────────────────

    constraint def containmentAcyclicRule {
        attribute id = "CR-ONT-001";
        attribute appliesTo = "MemoPart";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Containment/composition relations (Composes) must form no cycles.";
        attribute predicateExpression = "acyclic(composes)";
        constraint { true }
    }
    constraint def connectorEndpointsExistRule {
        attribute id = "CR-ONT-002";
        attribute appliesTo = "ComponentExchange";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Connector endpoints must resolve to model elements via the typed refs sourceEndpoint/targetEndpoint; port-path strings are descriptive labels only.";
        attribute predicateExpression = "sourceEndpoint->size() = 1 and targetEndpoint->size() = 1";
        constraint { true }
    }
    constraint def portCompatibilityRule {
        attribute id = "CR-ONT-003";
        attribute appliesTo = "LogicalConnector";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Connected ports must agree on content kind; a fluid port cannot connect to an information port.";
        attribute predicateExpression = "sourceComponent.ports.contentKind->intersect(targetComponent.ports.contentKind)->size() >= 1";
        constraint { true }
    }
    constraint def directionAgreesWithFlowRule {
        attribute id = "CR-ONT-004";
        attribute appliesTo = "LogicalExchange";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Exchange direction must agree with the direction of its source and target ports.";
        attribute predicateExpression = "sourcePort.direction != DirectionKind::input and targetPort.direction != DirectionKind::output";
        constraint { true }
    }
    constraint def exchangedItemTypeRule {
        attribute id = "CR-ONT-005";
        attribute appliesTo = "LogicalExchange";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Exchanged items must be type-compatible with the exchange content kind.";
        attribute predicateExpression = "exchangedItem->isEmpty() or exchangedItem.contentKind = contentKind";
        constraint { true }
    }

    // ─── Deployment and realization ──────────────────────────────────────

    constraint def deployToCapableNodeRule {
        attribute id = "CR-ONT-010";
        attribute appliesTo = "DeploysTo";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Software deploys only to capable execution nodes (e.g. containerized units require supportsContainerization).";
        attribute predicateExpression = "deploymentKind != DeploymentKind::containerized or node.supportsContainerization = true";
        constraint { true }
    }
    constraint def runtimeTracesToModuleRule {
        attribute id = "CR-ONT-011";
        attribute appliesTo = "SoftwareComponent";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Every runtime component must trace to a module-view definition (Realizes).";
        attribute predicateExpression = "realizes->size() >= 1";
        constraint { true }
    }
    constraint def logicalRealizationTypedRule {
        attribute id = "CR-ONT-012";
        attribute appliesTo = "Realizes";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Realization relations must resolve both ends to model elements, not name strings.";
        attribute predicateExpression = "realizing->size() = 1 and realized->size() = 1";
        constraint { true }
    }

    // ─── Device identity ─────────────────────────────────────────────────

    constraint def instanceHasDefinitionRule {
        attribute id = "CR-ONT-020";
        attribute appliesTo = "MedicalDeviceInstance";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "A device instance must reference exactly one device definition (FHIR Device→DeviceDefinition).";
        attribute predicateExpression = "definition->size() = 1";
        constraint { true }
    }
    constraint def noInstanceIdentityOnDefinitionRule {
        attribute id = "CR-ONT-021";
        attribute appliesTo = "MedicalDeviceDefinition";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Instance identifiers (serial, lot, UDI-PI, expiry) must not appear on definitions; the definition carries only the UDI-DI.";
        attribute predicateExpression = "attributes->excludes('serialNumber') and attributes->excludes('lotNumber')";
        constraint { true }
    }

    // ─── Reuse lifecycle ─────────────────────────────────────────────────

    constraint def singleUseNoReprocessingRule {
        attribute id = "CR-ONT-030";
        attribute appliesTo = "MedicalDeviceDefinition";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Single-use products must not carry a reusable reprocessing lifecycle (FDA reprocessing guidance).";
        attribute predicateExpression = "reuse.reuseMode != ReuseModeKind::singleUse or (reuse.reprocessingRequired = false and reuse.maximumReuseCount <= 1)";
        constraint { true }
    }
    constraint def reusableSterileIdentifiesReprocessingRule {
        attribute id = "CR-ONT-031";
        attribute appliesTo = "MedicalDeviceDefinition";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Reusable instruments used sterile must identify reprocessing requirements and a sterilization method.";
        attribute predicateExpression = "reuse.reuseMode != ReuseModeKind::reusable or reuse.sterilizable = false or (reuse.reprocessingRequired = true and reuse.sterilizationMethod != SterilizationMethodKind::notApplicable)";
        constraint { true }
    }
    constraint def patientContactCharacterizedRule {
        attribute id = "CR-ONT-032";
        attribute appliesTo = "PhysicalComponent";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Patient-contact components must identify contact nature and duration (ISO 10993-1).";
        attribute predicateExpression = "patientContact = false or (contactNature != '' and contactDuration != '')";
        constraint { true }
    }

    // ─── Assurance coverage ──────────────────────────────────────────────

    constraint def safetyCriticalFunctionVerifiedRule {
        attribute id = "CR-ONT-040";
        attribute appliesTo = "SystemFunction";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Safety-critical functions (criticality high or catastrophic) must trace to at least one verification case.";
        attribute predicateExpression = "criticality < CriticalityKind::high or verifiedBy->size() >= 1";
        constraint { true }
    }
    constraint def criticalTaskValidatedRule {
        attribute id = "CR-ONT-041";
        attribute appliesTo = "CriticalTask";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Critical tasks must trace to usability validation (FDA HF guidance; IEC 62366-1 summative evaluation).";
        attribute predicateExpression = "validates->size() >= 1";
        constraint { true }
    }
    constraint def useErrorTracesToHazardRule {
        attribute id = "CR-ONT-042";
        attribute appliesTo = "UseError";
        attribute severity = RuleSeverityKind::warning;
        attribute rationaleText = "Safety-relevant use errors (severity serious or worse) must trace to a hazard.";
        attribute predicateExpression = "severity < SeverityKind::serious or useErrorLeadsToHazard->size() >= 1";
        constraint { true }
    }
    constraint def alternateScenarioHasBaseRule {
        attribute id = "CR-ONT-043";
        attribute appliesTo = "MemoScenario";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Alternate, exception, and recovery scenarios must identify their base scenario or variation point — never duplicate the workflow.";
        attribute predicateExpression = "variantKind = ScenarioVariantKind::nominal or baseScenario->size() = 1 or variationPoint != ''";
        constraint { true }
    }
    constraint def singleAxisOwnershipRule {
        attribute id = "CR-ONT-045";
        attribute appliesTo = "MemoPart";
        attribute severity = RuleSeverityKind::error;
        attribute rationaleText = "Every element is owned by exactly one axis, encoded by its owning package: a horizontal architecture layer (memo_architecture_*) XOR a vertical assurance discipline (memo_assurance_*) — never both. Cross-axis participation is expressed by typed relationships, not by dual membership.";
        attribute predicateExpression = "owningPackage.startsWith('memo_architecture_') xor owningPackage.startsWith('memo_assurance_')";
        constraint { true }
    }
    constraint def layersOptionalRule {
        attribute id = "CR-ONT-044";
        attribute appliesTo = "MedicalDevice";
        attribute severity = RuleSeverityKind::info;
        attribute rationaleText = "Irrelevant layers are never mandatory: no rule may require functional/logical/software elements for a product whose technology domains do not include them.";
        attribute predicateExpression = "true";
        constraint { true }
    }
}
