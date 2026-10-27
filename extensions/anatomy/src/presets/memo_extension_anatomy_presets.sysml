// Selectors the extension ships. A project uses one by subsetting it:
// `part upperGi :> upperGastrointestinal;`.
package memo_extension_anatomy_presets {
    private import memo_extension_anatomy_selector::*;

    // Esophagus, stomach, duodenum and jejunum: the organs of bariatric and
    // upper gastrointestinal surgery.
    part upperGastrointestinal : AnatomySelector {
        attribute :>> fmaSeeds = ("fma7131", "fma7148", "fma7206", "fma7207");
        attribute :>> partDepth = 3;
    }
}
