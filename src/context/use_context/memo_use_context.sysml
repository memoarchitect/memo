// Intended use and use context (IEC 62366-1 use specification; ISO 14971
// §5.2). Relocated from the former memo_architecture_context.
package memo_context_use_context {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    private import memo_context_actors::*;

    part def IntendedUse specializes DocumentedElement {
        attribute indication : String;
        attribute contraindication : String;
        attribute patientPopulation : String;
        attribute clinicalBenefit : String;
        attribute regulatoryClassification : String;
    }

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

    connection def InteractsWith :> MemoRelationship {
        end contextParticipant : Actor;
        end target : MemoPart;
    }
    // Directional context-level data flow between boundary entities.
    connection def ExchangesWith :> MemoRelationship {
        end source : MemoPart;
        end target : MemoPart;
    }
    // Physical connection between boundary entities (fluid path, mounting).
    connection def ConnectsPhysically :> MemoRelationship {
        end source : MemoPart;
        end target : MemoPart;
    }
    connection def AppliesInContext :> MemoRelationship {
        end useContext : UseContext;
        end subjectElement : MemoPart;
    }
    connection def SituatedIn :> MemoRelationship {
        end useContext : UseContext;
        end environment : UseEnvironment;
    }
}
