// Software module view (§11; IEC 62304 5.3-5.4). Code/module structure only:
// runtime structure lives in memo_architecture_software_runtime and
// allocation in memo_architecture_deployment.
package memo_architecture_software_structure {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_logical_structure::*;

    part def SoftwareSystem specializes ArchitectureElement {
        attribute version : String;
        attribute safetyClass : SafetyClassKind;
        attribute complexity : ComplexityKind;
        attribute operatingSystem : String;
    }

    // Module-view element (design responsibility). Runtime properties
    // (period, WCET, scheduling) moved to SoftwareComponent.
    part def SoftwareModule specializes ArchitectureElement {
        attribute responsibility : String;
        attribute safetyClass : SafetyClassKind;
        attribute complexity : ComplexityKind;
    }
    part def SoftwareItem specializes SoftwareModule {
        attribute softwareItemKind : String;
        attribute iec62304Role : String;
    }
    part def CodeModule specializes SoftwareModule {
        attribute moduleKind : String;
    }
    // IEC 62304 software unit: not further decomposed.
    part def SoftwareUnit specializes SoftwareModule {
        attribute implementationLanguage : String;
    }
    part def SoftwarePackage specializes SoftwareModule {
        attribute namespacePath : String;
    }
    part def SoftwareLibrary specializes SoftwareModule {
        attribute libraryVersion : String;
        attribute internallyDeveloped : Boolean;
    }
    part def FirmwareItem specializes SoftwareItem {
        attribute firmwareTarget : String;
        attribute updateMechanism : String;
    }
    part def SOUPComponent specializes SoftwareModule {
        attribute soupVersion : String;
        attribute soupVendor : String;
        attribute knownAnomalies : String;
        attribute riskAcceptance : String;
        attribute classification : SOUPClassificationKind;
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
