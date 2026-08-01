// Software module view (§11; IEC 62304 5.3-5.4). Code/module structure only:
// runtime structure lives in memo_architecture_implementation_software_runtime and
// allocation in memo_architecture_realization_deployment.
package memo_architecture_implementation_software_structure {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_logical_structure::*;

    // IEC 62304 §3.25: a SOFTWARE ITEM is "any identifiable part of a computer
    // program". It is the general, recursive term — a SOFTWARE SYSTEM (§3.24)
    // is the top item and a SOFTWARE UNIT (§3.26) is one not subdivided
    // further; both are software items. So this is a base, not a fourth
    // sibling of system/module/component.
    //
    // It exists because §4.3 classifies, and §5.3–5.4 decompose, SOFTWARE
    // ITEMS — not "modules" or "components" specifically. Anything the
    // standard obliges at item level therefore belongs here, and every
    // software view inherits it rather than re-declaring it: the code view
    // (SoftwareModule), the runtime view (SoftwareComponent), the system, and
    // the user interface (memo_architecture_implementation_ui::UIElement).
    abstract part def SoftwareItem specializes ArchitectureElement {
        attribute safetyClass : SafetyClassKind;
        attribute complexity : ComplexityKind;
    }

    part def SoftwareSystem specializes SoftwareItem {
        attribute version : String;
        attribute operatingSystem : String;
    }

    // Module-view element (design responsibility). Runtime properties
    // (period, WCET, scheduling) moved to SoftwareComponent.
    // item / unit / package / library / code / firmware / soup (IEC 62304).
    enum def ModuleKind {
        enum 'item';
        enum unit;
        enum 'package';
        enum 'library';
        enum code;
        enum firmware;
        enum soup;
    }

    part def SoftwareModule specializes SoftwareItem {
        attribute moduleKind : ModuleKind;
        attribute responsibility : String;
        // module-kind-specific detail (set only for the relevant moduleKind)
        attribute iec62304Role : String[0..1];
        attribute implementationLanguage : String[0..1];
        attribute namespacePath : String[0..1];
        attribute libraryVersion : String[0..1];
        attribute internallyDeveloped : Boolean[0..1];
        attribute firmwareTarget : String[0..1];
        attribute updateMechanism : String[0..1];
        // SOUP (IEC 62304 §8) — set only when moduleKind = soup
        attribute soupVersion : String[0..1];
        attribute soupVendor : String[0..1];
        attribute knownAnomalies : String[0..1];
        attribute riskAcceptance : String[0..1];
        attribute soupClassification : SOUPClassificationKind[0..1];
    }

    part def Algorithm specializes ArchitectureElement {
        attribute algorithmKind : String;
        attribute inputSummary : String;
        attribute outputSummary : String;
        attribute clinicalPerformanceClaim : String;
    }
    part def DataModel specializes ArchitectureElement {
        attribute schemaReference : String;
        attribute persistenceScope : String;
    }
    part def ConfigurationArtifact specializes ArchitectureElement {
        attribute configurationScope : String;
        attribute version : String;
    }

    item def SBOMEntry specializes MemoExchangeItem {
        attribute componentName : String;
        attribute version : String;
        attribute supplier : String;
        attribute license : String;
        attribute hash : String;
    }

    connection def ModuleUses :> MemoRelationship {
        end usingModule : SoftwareModule;
        end usedModule : SoftwareModule;
    }
}
