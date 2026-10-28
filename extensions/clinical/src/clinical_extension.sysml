// The clinical extension's public facade: it publicly imports every package
// the extension ships, so importing it brings in the whole extension. It also brings in the anatomy
// extension, which clinical work refers to (a step's `targets`) and does not contain.
package memo_extension_clinical {
    public import memo_extension_clinical_procedures::*;
    public import memo_extension_anatomy::*;
}
