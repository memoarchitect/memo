// The anatomy extension's public facade: it publicly imports every package the
// extension ships, so importing it brings in the whole extension. None of those
// packages holds an FMA class: a project's anatomy is generated into the
// project, from the selectors it declares (`memo anatomy generate`).
package memo_extension_anatomy {
    public import memo_extension_anatomy_vocabulary::*;
    public import memo_extension_anatomy_selector::*;
    public import memo_extension_anatomy_presets::*;
}
