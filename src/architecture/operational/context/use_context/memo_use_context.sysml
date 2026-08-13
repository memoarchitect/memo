// Operational use context (IEC 62366-1 use specification). Intended use and
// reasonably foreseeable misuse are assurance requirements/risk inputs and
// live in memo_assurance_requirements.
//
// This package once defined `ExchangesWith` for directional context-level data
// flow between boundary entities. It is deleted: SysML v2's own `flow` covers
// every case and is strictly stronger, because `of <ItemDef>` says WHAT moves
// and two untyped connection ends cannot. Delegation between a boundary port
// and the interior it stands for is `bind` — identity, not transport. SysML v2
// keeps the two apart the same way: training ch. 13 wires components with
// `flow`, ch. 12 delegates across a boundary with `bind`.
package memo_architecture_operational_context_use_context {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_architecture_operational_context_actors::*;

    part def UseContext specializes MemoPart {
        attribute careSetting : String;
        attribute environment : String;
        attribute jurisdiction : String;
        attribute connectedUse : Boolean;
        attribute intendedUseReference : String;
    }

    // The physical/organizational environment of use (IEC 62366-1 3.20),
    // separable from the care-setting context so environments are reusable.
    part def UseEnvironment specializes MemoPart {
        attribute lighting : String;
        attribute noise : String;
        attribute vibration : String;
        attribute temperatureRange : String;
        attribute infectionControlConstraints : String;
        attribute mobility : String;
    }

    // The single relation a system context view draws.
    //
    // A context diagram labels its edges with open-ended verbs — "directs
    // procedure", "electrical power", "fluid supply", "environmental
    // conditions". Enumerating those as relation kinds never terminates, so the
    // ontology fixes the *role* an edge plays and leaves the verb to the
    // project: a project declares `connection def SuppliesFluid :>
    // InteractsInContext` and the view picks it up through the specialization
    // closure, exactly as a FirmwareComponent is recognised as a
    // SoftwareComponent.
    //
    // Keeping it separate from InteractsWith is the point: a context view draws
    // this relation and nothing else, so a model's general-purpose edges cannot
    // leak into the boundary picture.
    connection def InteractsInContext :> MemoRelationship {
        // Which side of the boundary picture the participant belongs on.
        attribute contextSide : ContextSideKind;
        // The verb, as it should read on the edge ("Directs procedure").
        attribute interactionLabel : String[0..1];
        end contextParticipant : ArchitectureElement :>> source;
        // Untyped: the system of interest may be a part or an operational activity.
        end systemOfInterest : ArchitectureElement :>> target;
    }
    abstract connection interactsInContextLinks : InteractsInContext[*];
    metadata def <interactsInContext> InteractsInContextMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = interactsInContextLinks meta SysML::Usage;
    }

    connection def InteractsWith :> MemoRelationship {
        end contextParticipant : OperationalParticipant :>> source;
        // Untyped so operational activities (action def) can be targets as well as parts.
        end target;
    }
    abstract connection interactsWithLinks : InteractsWith[*];
    metadata def <interactsWith> InteractsWithMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = interactsWithLinks meta SysML::Usage;
    }
    // Physical connection between boundary entities (fluid path, mounting).
    connection def ConnectsPhysically :> MemoRelationship {
        end source : ArchitectureElement;
        end target : ArchitectureElement;
    }
    abstract connection connectsPhysicallyLinks : ConnectsPhysically[*];
    metadata def <connectsPhysically> ConnectsPhysicallyMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = connectsPhysicallyLinks meta SysML::Usage;
    }
    connection def AppliesInContext :> MemoRelationship {
        end useContext : UseContext :>> source;
        end subjectElement : MemoPart :>> target;
    }
    abstract connection appliesInContextLinks : AppliesInContext[*];
    metadata def <appliesInContext> AppliesInContextMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = appliesInContextLinks meta SysML::Usage;
    }
    connection def SituatedIn :> MemoRelationship {
        end useContext : UseContext :>> source;
        end environment : UseEnvironment :>> target;
    }
    abstract connection situatedInLinks : SituatedIn[*];
    metadata def <situatedIn> SituatedInMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = situatedInLinks meta SysML::Usage;
    }
}
