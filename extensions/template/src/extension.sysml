// Skeleton for a new MEMO extension. Copy the directory, rename the packages,
// and replace the prefix.
//
// Two conventions this file follows and every extension must (extensions/README.md):
//
//   1. Every definition an extension declares is prefixed with the PascalCase
//      form of the extension's directory name — `template/` gives `Template`.
//      Extension names share one flat namespace with the base and with each
//      other, so the prefix is what keeps two independent extensions from both
//      declaring `Node`.
//   2. A relation an extension declares specializes a base relation. It never
//      roots independently.
//
// This package used to bind `baseMethodName = "MedicalDeviceLightDefault"` — a
// pre-flip spelling that resolves to nothing. It went unnoticed for as long as
// extensions lived under `examples/`, where the build did not check them; the
// build checks `extensions/` now, and reported it on the first run.
package memo_extension_template {
    private import ScalarValues::*;
    private import memo_core_enumerations::*;
    private import memo_methodology_core::*;
    private import memo_methodology_profiles::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    part extensionMethod : MethodologyDefinition {
        @MemoIdentity { :>> providedId = "EXT-METH-001"; }
        attribute :>> name = "ExtensionMethod";
        attribute :>> version = "0.1.0";
        attribute :>> domain = "project extension";
        attribute :>> description = "Adds a project or domain package to the selected MEMO methodology.";
        // The base is a typed SysML reference, not a name held in sync by hand.
        ref :>> baseMethodology = mdDefaultDefinition;
        // An extension adds its own module to whatever its base selected;
        // saying so explicitly is required now that an empty list means empty.
        attribute :>> scopeMode = ScopeModeKind::explicit;
        attribute :>> includedModule = "replace_with_extension_package";
    }
}
