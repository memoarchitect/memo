// Reuse and reprocessing semantics (§14). Disposable/non-disposable is a
// property cluster, never a primary inheritance split or a lone boolean.
// Invariants (rules/lifecycle): a single-use product must not carry a
// reusable reprocessing lifecycle; a reusable sterile instrument must
// identify its reprocessing requirements.
package memo_medical_products_lifecycle {
    private import ScalarValues::*;

    enum def ReuseModeKind {
        enum singleUse;
        enum reusable;
        enum limitedReuse;
        enum consumable;
        enum implantable;
    }

    enum def SterilizationMethodKind {
        enum steamAutoclave;
        enum ethyleneOxide;
        enum gammaIrradiation;
        enum electronBeam;
        enum hydrogenPeroxidePlasma;
        enum dryHeat;
        enum notApplicable;
    }

    attribute def ReuseLifecycle {
        attribute reuseMode : ReuseModeKind;
        attribute maximumReuseCount : Integer;
        attribute reprocessingRequired : Boolean;
        attribute cleaningRequired : Boolean;
        attribute disinfectionRequired : Boolean;
        attribute suppliedSterile : Boolean;
        attribute sterilizable : Boolean;
        attribute sterilizationMethod : SterilizationMethodKind;
        attribute shelfLife : String;
        attribute lotTraceabilityRequired : Boolean;
        attribute udiApplicable : Boolean;
    }
}
