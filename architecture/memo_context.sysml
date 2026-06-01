package memo {
    package architecture {
        package context {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;
            part def IntendedUse specializes DocumentedElement { attribute indication : String; attribute contraindication : String; attribute patientPopulation : String; attribute clinicalBenefit : String; attribute regulatoryClassification : String; }
            part def Actor specializes TraceableElement { attribute actorKind : ActorKind; attribute trainingLevel : String; }
            part def UseContext specializes TraceableElement { attribute careSetting : String; attribute environment : String; attribute jurisdiction : String; attribute connectedUse : Boolean; attribute intendedUseReference : String; }
            part def UseError specializes TraceableElement { attribute errorCategory : UseErrorCategoryKind; attribute taskReference : String; attribute severity : CriticalityKind; attribute rootCauseType : String; }
        }
    }
}
