package memo {
    package methodology {
        package core {
            private import memo::core::common::*;
            private import memo::core::enumerations::*;

            part def MethodologyLibrary :> TraceableElement {
                attribute version : String;
                attribute domain : String;
                attribute description : String;
            }

            part def MethodologyDefinition :> TraceableElement {
                attribute version : String;
                attribute domain : String;
                attribute description : String;
                attribute baseMethodName : String;
            }

            part def ResolvedMethodology :> TraceableElement {
                attribute version : String;
                // Risk-proportionate scope keyed to the device's software safety
                // classification (IEC 62304 A/B/C) and lifecycle stage — not a
                // "rigor dial". The class + stage determine which layers, links,
                // viewpoints, and gates a release must clear.
                attribute safetyClassification : SafetyClassKind;
                attribute lifecycleStage : LifecycleStateKind;
                attribute resolutionSummary : String;
            }

            part def ProjectMethodBinding :> TraceableElement {
                attribute projectName : String;
            }

            part def DhfDocumentBinding :> TraceableElement {
                attribute documentTitle : String;
                attribute groupLabel : String;
                attribute templateId : String;
                attribute viewKind : String;
                attribute regulatoryReference : String;
                attribute lifecycleStage : WorkflowStageKind;
                attribute required : Boolean;
            }

            part def Archetype :> TraceableElement {
                attribute label : String;
                attribute description : String;
                attribute category : String;
                attribute includedLayer : String;
                attribute includedStandard : String;
                attribute templateDir : String;
            }
        }
    }
}
