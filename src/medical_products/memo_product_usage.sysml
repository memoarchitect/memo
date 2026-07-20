// Products used in activities (§15). A product participates in an activity
// through a contextual ProductUsage relationship carrying the role — the
// product is never duplicated as an "operational tool" alongside its
// physical-architecture identity. "Tool" is the role, not a second element.
package memo_medical_products_usage {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_relationships::*;
    private import memo_activities::*;
    private import memo_medical_products_definitions::*;

    enum def ProductRoleKind {
        enum primaryInstrument;
        enum assistingInstrument;
        enum measurementInstrument;
        enum visualizationInstrument;
        enum cuttingInstrument;
        enum graspingInstrument;
        enum closureInstrument;
        enum energyDeliveryInstrument;
        enum monitoringDevice;
        enum implant;
        enum accessory;
        enum consumable;
        enum protectiveEquipment;
        enum softwareTool;
    }

    // Contextual use of a product by an activity or task.
    connection def UsesProduct :> MemoRelationship {
        attribute productRole : ProductRoleKind;
        attribute required : Boolean;
        attribute quantity : String;
        attribute setupSummary : String;
        attribute sterileRequired : Boolean;
        attribute calibrationRequired : Boolean;
        attribute permittedAlternative : String;
        attribute usageInstructions : String;
        // `using` is generic (activity or task) — unifies the former
        // UsesProduct / TaskUsesProduct synonyms.
        end using : MemoPart;
        end product : MedicalDevice;
    }
}
