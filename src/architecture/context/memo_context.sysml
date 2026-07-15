package memo_architecture_context {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;
    part def IntendedUse specializes DocumentedElement {
        attribute indication : String;
        attribute contraindication : String;
        attribute patientPopulation : String;
        attribute clinicalBenefit : String;
        attribute regulatoryClassification : String;
    }
    part def Actor specializes TraceableElement {
        attribute actorKind : ActorKind;
        attribute trainingLevel : String;
    }
    part def UseContext specializes TraceableElement {
        attribute careSetting : String;
        attribute environment : String;
        attribute jurisdiction : String;
        attribute connectedUse : Boolean;
        attribute intendedUseReference : String;
    }
    part def UseError specializes TraceableElement {
        attribute errorCategory : UseErrorCategoryKind;
        attribute taskReference : String;
        attribute severity : SeverityKind;
        attribute rootCauseType : String;
    }

    connection def InteractsWith :> SemanticLink {
        end contextParticipant : Actor;
        end target : TraceableElement;
    }
    // Directional context-level data flow between boundary entities
    // (Fig 2.1-style "Data Flow" edges).
    connection def ExchangesWith :> SemanticLink {
        end source : TraceableElement;
        end target : TraceableElement;
    }
    // Physical connection between boundary entities (fluid path,
    // mechanical mounting) as opposed to a data flow.
    connection def ConnectsPhysically :> SemanticLink {
        end source : TraceableElement;
        end target : TraceableElement;
    }
    // Anchors an intended use to the system it governs.
    connection def GovernsUse :> SemanticLink {
        end intendedUse : IntendedUse;
        end governedElement : TraceableElement;
    }
    // Binds a use context to the system or environment it applies to.
    connection def AppliesInContext :> SemanticLink {
        end useContext : UseContext;
        end subjectElement : TraceableElement;
    }
}
