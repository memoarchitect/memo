// Software module view (§11; IEC 62304 5.3-5.4). Following the SEI Views and
// Beyond viewtypes, modules are implementation/code units; interacting runtime
// elements are SoftwareComponents in
// memo_architecture_implementation_software_runtime, and allocation lives in
// memo_architecture_realization_deployment.
package memo_architecture_implementation_software_structure {
    private import Metaobjects::SemanticMetadata;
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
    // Structural software decomposition is part-native. The standard's
    // "software item" is this part, not an `item def`: exchanged or stored
    // values are DataItem, below.
    abstract part def SoftwareElement specializes MemoPart {
        attribute safetyClass : SafetyClassKind;
        attribute complexity : ComplexityKind;
    }

    part def SoftwareSystem specializes SoftwareElement {
        attribute version : String;
        attribute operatingSystem : String;
    }

    // Module-view element (design responsibility). Runtime properties
    // (period, WCET, scheduling) moved to SoftwareComponent.
    // item / unit / package / library / code / firmware (IEC 62304). SOUP is
    // a type (SOUPSoftwareModule), not a value here.
    enum def ModuleKind {
        enum 'item';
        enum unit;
        enum 'package';
        enum 'library';
        enum code;
        enum firmware;
    }

    part def SoftwareModule specializes SoftwareElement {
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
    }

    part def Algorithm specializes MemoPart {
        attribute algorithmKind : String;
        attribute inputSummary : String;
        attribute outputSummary : String;
        attribute clinicalPerformanceClaim : String;
    }
    part def DataModel specializes MemoPart {
        attribute schemaReference : String;
        attribute persistenceScope : String;
    }
    part def ConfigurationArtifact specializes MemoPart {
        attribute configurationScope : String;
        attribute version : String;
    }

    // Data content that may be stored or exchanged through ports. Named
    // DataItem, not SoftwareItem: IEC 62304 uses "software item" for a
    // structural part of a program (a SoftwareElement here), and the item
    // family is the exchanged or stored value.
    abstract item def DataItem specializes MemoItem {
        attribute schemaIdentifier : String;
        attribute schemaVersion : String;
        attribute :>> encoding : String;
        attribute :>> timestampRequired : Boolean;
    }

    // SOUP and OTS (IEC 62304 §3.29). The standard's SOUP definition covers
    // off-the-shelf software and also previously developed software that
    // lacks development records, so OTS is the narrower type: every OTS
    // module is SOUP, and SOUP also covers legacy in-house code with no
    // supplier, license or package to record. SOUP is a type, not a
    // module-kind value; the CR-MED-015..017 closure rules apply to it and so
    // to OTS.
    //
    // §8.1.2 (SOUP identification: supplier, version) and §7.1.3 (published
    // anomaly lists) are SOUP obligations, so those attributes sit here; the
    // acquisition identity of a bought or downloaded package sits on
    // OTSSoftwareModule.
    part def SOUPSoftwareModule specializes SoftwareModule {
        attribute supplier : String[0..1];
        attribute version : String[0..1];
        attribute knownAnomalies : String[0..1];
        attribute riskAcceptance : String[0..1];
        attribute soupClassification : SOUPClassificationKind[0..1];
    }
    part def OTSSoftwareModule specializes SOUPSoftwareModule {
        attribute licenseExpression : String;
        attribute packageUrl : String;
        attribute checksum : String;
    }

    enum def SbomFormatKind {
        enum spdx;
        enum cycloneDx;
        enum other;
    }

    // An SBOM is a document; its entries are inventory records. An entry
    // names one software element and says what is known about it as shipped.
    // Vulnerabilities, anomalies and risks are separate objects that point at
    // the entry; they are not attributes of the document.
    part def SBOMEntry specializes MemoPart {
        attribute componentName : String;
        attribute version : String;
        attribute supplier : String;
        attribute licenseExpression : String;
        attribute checksum : String;
        attribute packageUrl : String;
        attribute bomReference : String;
        ref inventoriedElement : SoftwareElement[0..1];
    }
    part def SoftwareBillOfMaterials specializes MemoPart {
        attribute sbomFormat : SbomFormatKind;
        attribute specVersion : String;
        attribute generationTool : String;
        attribute generatedOn : String;
        part sbomEntry : SBOMEntry[0..*];
    }

    // `ModuleUses` is native `dependency` (R10-S6): write
    // `dependency <usingModule> to <usedModule>;` instead of a connection.

    // ── Relations owned by this package ─────────────────────────────
    // Moved out of memo_core_relationships: their ends are typed against
    // types declared here, and core must not depend on a domain package.
    connection def DependsOnSoup :> MemoRelationship {
        end component : MemoPart :>> source;
        end soupItem : SoftwareElement :>> target;
    }
    abstract connection dependsOnSoupLinks : DependsOnSoup[*];
    metadata def <dependsOnSoup> DependsOnSoupMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = dependsOnSoupLinks meta SysML::Usage;
    }
}
