package memo_methodology_core {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;

    part def MethodologyLibrary :> MemoPart {
        attribute version : String;
        attribute domain : String;
        attribute :>> description : String;
    }

    part def MethodologyDefinition :> MemoPart {
        attribute version : String;
        attribute domain : String;
        attribute :>> description : String;
        attribute baseMethodName : String;
        // A methodology is an inclusion set. Layer entries normally name a
        // public MEMO layer namespace; module entries may name any qualified
        // package available to the project, including packages outside MEMO.
        attribute includedLayer : String[0..*];
        attribute includedModule : String[0..*];
    }

    part def ResolvedMethodology :> MemoPart {
        attribute version : String;
        // The effective inclusion set after the project binding has added any
        // project- or supplier-specific modules.
        attribute includedLayer : String[0..*];
        attribute includedModule : String[0..*];
    }

    part def ProjectMethodBinding :> MemoPart {
        attribute projectName : String;
        attribute methodologyName : String;
        // Project bindings may add project or supplier modules to the selected
        // methodology without requiring those packages to live under memo::.
        attribute includedModule : String[0..*];
    }

    part def DhfDocumentBinding :> MemoPart {
        attribute documentTitle : String;
        attribute groupLabel : String;
        attribute templateId : String;
        attribute viewKind : String;
        attribute regulatoryReference : String;
        attribute lifecycleStage : WorkflowStageKind;
        attribute required : Boolean;
    }

    part def Archetype :> MemoPart {
        attribute label : String;
        attribute :>> description : String;
        attribute category : String;
        attribute includedLayer : String;
        attribute includedStandard : String;
        attribute templateDir : String;
    }
}
