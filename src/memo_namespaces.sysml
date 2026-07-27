package memo {
    private import ScalarValues::*;

    public import memo_core_enumerations::*;
    public import memo_core_dimensions::*;
    public import memo_core_terminology::*;
    public import memo_core_common::*;
    public import memo_core_relationships::*;

    public import memo_context_actors::*;
    public import memo_context_stakeholders::*;
    public import memo_context_use_context::*;
    public import memo_assurance_needs::*;
    public import memo_use_cases::*;
    public import memo_activities::*;
    public import memo_workflows::*;
    public import memo_scenarios::*;
    public import memo_assurance_human_factors::*;
    public import memo_architecture_ui::*;
    public import memo_architecture_operational::*;
    public import memo_assurance_requirements::*;
    public import memo_architecture_functions::*;
    public import memo_architecture_logical_structure::*;
    public import memo_architecture_interfaces::*;
    public import memo_architecture_behavior::*;
    public import memo_architecture_software_structure::*;
    public import memo_architecture_software_runtime::*;
    public import memo_architecture_deployment::*;
    public import memo_architecture_hardware_structure::*;
    public import memo_architecture_constraints::*;
    public import memo_assurance_safety_risk::*;
    public import memo_assurance_cybersecurity::*;
    public import memo_assurance_verification::*;
    public import memo_architecture_physical::*;
    public import memo_assurance_safety_analysis::*;
    public import memo_architecture_decisions::*;

    public import memo_viewpoints_definitions::*;
    public import memo_viewpoints_catalog::*;
    public import memo_viewpoints_context_context_viewpoint::*;
    public import memo_viewpoints_context_system_context_view::*;
    public import memo_viewpoints_operational_operational_viewpoint::*;
    public import memo_viewpoints_operational_use_case_view::*;
    public import memo_viewpoints_requirements_requirements_viewpoint::*;
    public import memo_viewpoints_requirements_requirements_traceability_view::*;
    public import memo_viewpoints_functional_functional_viewpoint::*;
    public import memo_viewpoints_functional_system_functional_tree_view::*;
    public import memo_viewpoints_functional_function_allocation_view::*;
    public import memo_viewpoints_logical_logical_viewpoint::*;
    public import memo_viewpoints_logical_logical_architecture_view::*;
    public import memo_viewpoints_software_software_viewpoint::*;
    public import memo_viewpoints_software_software_architecture_view::*;
    public import memo_viewpoints_physical_physical_viewpoint::*;
    public import memo_viewpoints_physical_physical_bom_view::*;
    public import memo_viewpoints_physical_network_topology_view::*;
    public import memo_viewpoints_risk_risk_viewpoint::*;
    public import memo_viewpoints_risk_risk_chain_view::*;
    public import memo_viewpoints_verification_verification_viewpoint::*;
    public import memo_viewpoints_verification_verification_coverage_view::*;
    public import memo_viewpoints_cybersecurity_cybersecurity_viewpoint::*;
    public import memo_viewpoints_cybersecurity_threat_model_view::*;
    public import memo_viewpoints_cybersecurity_cybersecurity_assessment_view::*;
    public import memo_viewpoints_clinical_clinical_viewpoint::*;
    public import memo_viewpoints_clinical_clinical_evidence_view::*;
    public import memo_viewpoints_usability_usability_viewpoint::*;
    public import memo_viewpoints_usability_usability_engineering_view::*;

    public import memo_artifacts_definitions::*;
    public import memo_compliance_artifacts::*;
    public import memo_compliance_change::*;
    public import memo_compliance_postmarket::*;

    public import memo_methodology_core::*;
    public import memo_methodology_rules::*;
    public import memo_methodology_patterns::*;
    public import memo_methodology_workflow::*;
    public import memo_methodology_gates::*;
    public import memo_methodology_profiles::*;

    alias architecture for memo_namespace_architecture;
    alias assurance for memo_namespace_assurance;
    alias artifacts for memo_namespace_artifacts;
    alias compliance for memo_namespace_compliance;
    alias core for memo_namespace_core;
    alias methodology for memo_namespace_methodology;
    alias rules for memo_namespace_rules;
    alias viewpoints for memo_namespace_viewpoints;
}

package memo_namespace_activities {
    public import memo_activities::*;
}

// Vertical axis — assurance disciplines (requirements, safety, cybersecurity,
// human factors, verification & validation). Each owns its own elements and
// crosses to the architecture layers only through typed relationships.
package memo_namespace_assurance {
    package requirements {
        public import memo_assurance_requirements::*;
        alias needs for memo_namespace_assurance_requirements_needs;
    }
    package safety_risk {
        public import memo_assurance_safety_risk::*;
        public import memo_assurance_safety_arch_risk::*;
        alias analysis for memo_namespace_assurance_safety_risk_analysis;
    }
    alias cybersecurity for memo_namespace_assurance_cybersecurity;
    alias human_factors for memo_namespace_assurance_human_factors;
    alias verification_validation for memo_namespace_assurance_verification_validation;
}

package memo_namespace_assurance_human_factors {
    public import memo_assurance_human_factors::*;
}

package memo_namespace_context {
    alias actors for memo_namespace_context_actors;
    alias stakeholders for memo_namespace_context_stakeholders;
    alias use_context for memo_namespace_context_use_context;
}

package memo_namespace_context_actors {
    public import memo_context_actors::*;
}

package memo_namespace_context_stakeholders {
    public import memo_context_stakeholders::*;
}

package memo_namespace_context_use_context {
    public import memo_context_use_context::*;
}

package memo_namespace_assurance_requirements_needs {
    public import memo_assurance_needs::*;
}

package memo_namespace_scenarios {
    public import memo_scenarios::*;
}

package memo_namespace_use_cases {
    public import memo_use_cases::*;
}

package memo_namespace_workflows {
    public import memo_workflows::*;
}

package memo_namespace_architecture_deployment {
    public import memo_architecture_deployment::*;
}

package memo_namespace_architecture_software_runtime {
    public import memo_architecture_software_runtime::*;
}

package memo_namespace_architecture_ui {
    public import memo_architecture_ui::*;
}

package memo_namespace_architecture_hardware_common {
    public import memo_architecture_hardware_common::*;
}

package memo_namespace_architecture_hardware_electrical {
    public import memo_architecture_hardware_electrical::*;
}

package memo_namespace_architecture_hardware_mechanical {
    public import memo_architecture_hardware_mechanical::*;
}

package memo_namespace_architecture_hardware_fluidic {
    public import memo_architecture_hardware_fluidic::*;
}

package memo_namespace_architecture_hardware_optical {
    public import memo_architecture_hardware_optical::*;
}

package memo_namespace_architecture_hardware_sensing {
    public import memo_architecture_hardware_sensing::*;
}

package memo_assurance_safety_compatibility {
    public import memo_assurance_safety_arch_risk::*;
}

// Horizontal axis — the five V-model architecture layers. Interfaces remain
// typed ports/connections inside Logical architecture; they are not a layer.
// Views and viewpoints are presentation packages and are exposed only through
// the Diagram workspace, never as architecture layers.
package memo_namespace_architecture {
    alias decisions for memo_namespace_architecture_decisions;

    package operational {
        alias structure for memo_namespace_architecture_operational;
        alias activities for memo_namespace_activities;
        alias context for memo_namespace_context;
        alias scenarios for memo_namespace_scenarios;
        alias use_cases for memo_namespace_use_cases;
        alias workflows for memo_namespace_workflows;
    }
    package functional {
        alias behavior for memo_namespace_architecture_behavior;
        alias constraints for memo_namespace_architecture_constraints;
        alias functions for memo_namespace_architecture_functions;
    }
    package logical {
        alias interfaces for memo_namespace_architecture_interfaces;
        alias structure for memo_namespace_architecture_logical_structure;
    }
    package implementation {
        package software {
            alias structure for memo_namespace_architecture_software_structure;
            alias runtime for memo_namespace_architecture_software_runtime;
        }
        package hardware {
            alias common for memo_namespace_architecture_hardware_common;
            alias structure for memo_namespace_architecture_hardware_structure;
            alias electrical for memo_namespace_architecture_hardware_electrical;
            alias mechanical for memo_namespace_architecture_hardware_mechanical;
            alias fluidic for memo_namespace_architecture_hardware_fluidic;
            alias optical for memo_namespace_architecture_hardware_optical;
            alias sensing for memo_namespace_architecture_hardware_sensing;
        }
        alias ui for memo_namespace_architecture_ui;
    }
    package realization {
        alias deployment for memo_namespace_architecture_deployment;
        alias physical for memo_namespace_architecture_physical;
    }
}

package memo_namespace_artifacts {
    alias definitions for memo_namespace_artifacts_definitions;
}

package memo_namespace_compliance {
    alias artifacts for memo_namespace_compliance_artifacts;
    alias change for memo_namespace_compliance_change;
    alias document_views for memo_namespace_compliance_document_views;
    alias iso14971 for memo_namespace_compliance_iso14971;
    alias postmarket for memo_namespace_compliance_postmarket;
}

package memo_namespace_core {
    alias common for memo_namespace_core_common;
    alias consistency_rules for memo_namespace_core_consistency_rules;
    alias dimensions for memo_namespace_core_dimensions;
    alias enumerations for memo_namespace_core_enumerations;
    alias methodology_scope for memo_namespace_core_methodology_scope;
    alias relationships for memo_namespace_core_relationships;
    alias semantics for memo_namespace_core_semantics;
    alias stdlib for memo_namespace_core_stdlib;
    alias terminology for memo_namespace_core_terminology;
}

package memo_namespace_methodology {
    alias archetypes for memo_namespace_methodology_archetypes;
    alias core for memo_namespace_methodology_core;
    alias gates for memo_namespace_methodology_gates;
    alias patterns for memo_namespace_methodology_patterns;
    alias profiles for memo_namespace_methodology_profiles;
    alias rules for memo_namespace_methodology_rules;
    alias viewpoints for memo_namespace_methodology_viewpoints;
    alias workflow for memo_namespace_methodology_workflow;
}

package memo_namespace_rules {
    alias closure for memo_namespace_rules_closure;
    alias coverage for memo_namespace_rules_coverage;
    alias crosslayer for memo_namespace_rules_crosslayer;
    alias lifecycle for memo_namespace_rules_lifecycle;
    alias ontology for memo_namespace_rules_ontology;
    alias quantitative for memo_namespace_rules_quantitative;
}

package memo_namespace_viewpoints {
    alias catalog for memo_namespace_viewpoints_catalog;
    alias clinical for memo_namespace_viewpoints_clinical;
    alias context for memo_namespace_viewpoints_context;
    alias cybersecurity for memo_namespace_viewpoints_cybersecurity;
    alias definitions for memo_namespace_viewpoints_definitions;
    alias functional for memo_namespace_viewpoints_functional;
    alias logical for memo_namespace_viewpoints_logical;
    alias operational for memo_namespace_viewpoints_operational;
    alias physical for memo_namespace_viewpoints_physical;
    alias requirements for memo_namespace_viewpoints_requirements;
    alias risk for memo_namespace_viewpoints_risk;
    alias software for memo_namespace_viewpoints_software;
    alias usability for memo_namespace_viewpoints_usability;
    alias verification for memo_namespace_viewpoints_verification;
}

package memo_namespace_assurance_safety_risk_analysis {
    public import memo_assurance_safety_analysis::*;
}

package memo_namespace_assurance_verification_validation {
    public import memo_assurance_verification::*;
}

package memo_namespace_architecture_behavior {
    public import memo_architecture_behavior::*;
}

package memo_namespace_architecture_constraints {
    public import memo_architecture_constraints::*;
}

package memo_namespace_assurance_cybersecurity {
    public import memo_assurance_cybersecurity::*;
}

package memo_namespace_architecture_decisions {
    public import memo_architecture_decisions::*;
}

package memo_namespace_architecture_functions {
    public import memo_architecture_functions::*;
}

package memo_namespace_architecture_hardware_structure {
    public import memo_architecture_hardware_structure::*;
}

package memo_namespace_architecture_interfaces {
    public import memo_architecture_interfaces::*;
}

package memo_namespace_architecture_logical_structure {
    public import memo_architecture_logical_structure::*;
}

package memo_namespace_architecture_operational {
    public import memo_architecture_operational::*;
}

package memo_namespace_architecture_physical {
    public import memo_architecture_physical::*;
}

package memo_namespace_architecture_software_structure {
    public import memo_architecture_software_structure::*;
}

package memo_namespace_artifacts_definitions {
    public import memo_artifacts_definitions::*;
}

package memo_namespace_compliance_artifacts {
    public import memo_compliance_artifacts::*;
}

package memo_namespace_compliance_change {
    public import memo_compliance_change::*;
}

package memo_namespace_compliance_document_views {
    public import memo_compliance_document_views::*;
}

package memo_namespace_compliance_iso14971 {
    public import memo_compliance_iso14971::*;
}

package memo_namespace_compliance_postmarket {
    public import memo_compliance_postmarket::*;
}

package memo_namespace_core_common {
    public import memo_core_common::*;
}

package memo_namespace_core_consistency_rules {
    public import memo_core_consistency_rules::*;
}

package memo_namespace_core_dimensions {
    public import memo_core_dimensions::*;
}

package memo_namespace_core_enumerations {
    public import memo_core_enumerations::*;
}

package memo_namespace_core_methodology_scope {
    public import memo_core_methodology_scope::*;
}

package memo_namespace_core_relationships {
    public import memo_core_relationships::*;
}

package memo_namespace_core_semantics {
    public import memo_core_semantics::*;
}

package memo_namespace_core_terminology {
    public import memo_core_terminology::*;
}

package memo_namespace_core_stdlib {
    alias collections for memo_namespace_core_stdlib_collections;
    alias functions for memo_namespace_core_stdlib_functions;
    alias scalars for memo_namespace_core_stdlib_scalars;
    alias time for memo_namespace_core_stdlib_time;
}

package memo_namespace_methodology_archetypes {
    public import memo_methodology_archetypes::*;
}

package memo_namespace_methodology_core {
    public import memo_methodology_core::*;
}

package memo_namespace_methodology_gates {
    public import memo_methodology_gates::*;
}

package memo_namespace_methodology_patterns {
    public import memo_methodology_patterns::*;
}

package memo_namespace_methodology_profiles {
    public import memo_methodology_profiles::*;
}

package memo_namespace_methodology_rules {
    public import memo_methodology_rules::*;
}

package memo_namespace_methodology_viewpoints {
    public import memo_methodology_viewpoints::*;
}

package memo_namespace_methodology_workflow {
    public import memo_methodology_workflow::*;
}

package memo_namespace_rules_closure {
    public import memo_rules_closure::*;
}

package memo_namespace_rules_coverage {
    public import memo_rules_coverage::*;
}

package memo_namespace_rules_crosslayer {
    public import memo_rules_crosslayer::*;
}

package memo_namespace_rules_lifecycle {
    public import memo_rules_lifecycle::*;
}

package memo_namespace_rules_ontology {
    public import memo_rules_ontology::*;
}

package memo_namespace_rules_quantitative {
    public import memo_rules_quantitative::*;
}

package memo_namespace_viewpoints_catalog {
    public import memo_viewpoints_catalog::*;
}

package memo_namespace_viewpoints_clinical {
    alias clinical_evidence_view for memo_namespace_viewpoints_clinical_clinical_evidence_view;
    public import memo_viewpoints_clinical_clinical_viewpoint::*;
}

package memo_namespace_viewpoints_context {
    alias system_context_view for memo_namespace_viewpoints_context_system_context_view;
    public import memo_viewpoints_context_context_viewpoint::*;
}

package memo_namespace_viewpoints_cybersecurity {
    alias cybersecurity_assessment_view for memo_namespace_viewpoints_cybersecurity_cybersecurity_assessment_view;
    alias threat_model_view for memo_namespace_viewpoints_cybersecurity_threat_model_view;
    public import memo_viewpoints_cybersecurity_cybersecurity_viewpoint::*;
}

package memo_namespace_viewpoints_definitions {
    public import memo_viewpoints_definitions::*;
}

package memo_namespace_viewpoints_functional {
    alias function_allocation_view for memo_namespace_viewpoints_functional_function_allocation_view;
    alias system_functional_tree_view for memo_namespace_viewpoints_functional_system_functional_tree_view;
    public import memo_viewpoints_functional_functional_viewpoint::*;
}

package memo_namespace_viewpoints_logical {
    alias logical_architecture_view for memo_namespace_viewpoints_logical_logical_architecture_view;
    public import memo_viewpoints_logical_logical_viewpoint::*;
}

package memo_namespace_viewpoints_operational {
    alias use_case_view for memo_namespace_viewpoints_operational_use_case_view;
    public import memo_viewpoints_operational_operational_viewpoint::*;
}

package memo_namespace_viewpoints_physical {
    alias network_topology_view for memo_namespace_viewpoints_physical_network_topology_view;
    alias physical_bom_view for memo_namespace_viewpoints_physical_physical_bom_view;
    public import memo_viewpoints_physical_physical_viewpoint::*;
}

package memo_namespace_viewpoints_requirements {
    alias requirements_traceability_view for memo_namespace_viewpoints_requirements_requirements_traceability_view;
    public import memo_viewpoints_requirements_requirements_viewpoint::*;
}

package memo_namespace_viewpoints_risk {
    alias risk_chain_view for memo_namespace_viewpoints_risk_risk_chain_view;
    public import memo_viewpoints_risk_risk_viewpoint::*;
}

package memo_namespace_viewpoints_software {
    alias software_architecture_view for memo_namespace_viewpoints_software_software_architecture_view;
    public import memo_viewpoints_software_software_viewpoint::*;
}

package memo_namespace_viewpoints_usability {
    alias usability_engineering_view for memo_namespace_viewpoints_usability_usability_engineering_view;
    public import memo_viewpoints_usability_usability_viewpoint::*;
}

package memo_namespace_viewpoints_verification {
    alias verification_coverage_view for memo_namespace_viewpoints_verification_verification_coverage_view;
    public import memo_viewpoints_verification_verification_viewpoint::*;
}

package memo_namespace_core_stdlib_collections {
    public import memo_core_stdlib_collections::*;
}

package memo_namespace_core_stdlib_functions {
    public import memo_core_stdlib_functions::*;
}

package memo_namespace_core_stdlib_scalars {
    public import memo_core_stdlib_scalars::*;
}

package memo_namespace_core_stdlib_time {
    public import memo_core_stdlib_time::*;
}

package memo_namespace_viewpoints_clinical_clinical_evidence_view {
    public import memo_viewpoints_clinical_clinical_evidence_view::*;
}

package memo_namespace_viewpoints_context_system_context_view {
    public import memo_viewpoints_context_system_context_view::*;
}

package memo_namespace_viewpoints_cybersecurity_cybersecurity_assessment_view {
    public import memo_viewpoints_cybersecurity_cybersecurity_assessment_view::*;
}

package memo_namespace_viewpoints_cybersecurity_threat_model_view {
    public import memo_viewpoints_cybersecurity_threat_model_view::*;
}

package memo_namespace_viewpoints_functional_function_allocation_view {
    public import memo_viewpoints_functional_function_allocation_view::*;
}

package memo_namespace_viewpoints_functional_system_functional_tree_view {
    public import memo_viewpoints_functional_system_functional_tree_view::*;
}

package memo_namespace_viewpoints_logical_logical_architecture_view {
    public import memo_viewpoints_logical_logical_architecture_view::*;
}

package memo_namespace_viewpoints_operational_use_case_view {
    public import memo_viewpoints_operational_use_case_view::*;
}

package memo_namespace_viewpoints_physical_network_topology_view {
    public import memo_viewpoints_physical_network_topology_view::*;
}

package memo_namespace_viewpoints_physical_physical_bom_view {
    public import memo_viewpoints_physical_physical_bom_view::*;
}

package memo_namespace_viewpoints_requirements_requirements_traceability_view {
    public import memo_viewpoints_requirements_requirements_traceability_view::*;
}

package memo_namespace_viewpoints_risk_risk_chain_view {
    public import memo_viewpoints_risk_risk_chain_view::*;
}

package memo_namespace_viewpoints_software_software_architecture_view {
    public import memo_viewpoints_software_software_architecture_view::*;
}

package memo_namespace_viewpoints_usability_usability_engineering_view {
    public import memo_viewpoints_usability_usability_engineering_view::*;
}

package memo_namespace_viewpoints_verification_verification_coverage_view {
    public import memo_viewpoints_verification_verification_coverage_view::*;
}
