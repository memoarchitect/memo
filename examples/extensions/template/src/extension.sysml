// Replace the package name and included module with extension-specific names.
package memo_extension_template {
    private import ScalarValues::*;
    private import memo_methodology_core::*;

    part extensionMethod : MethodologyDefinition {
        attribute :>> id = "EXT-METH-001";
        attribute :>> name = "ExtensionMethod";
        attribute :>> version = "0.1.0";
        attribute :>> domain = "project extension";
        attribute :>> description = "Adds a project or domain package to the selected MEMO methodology.";
        attribute :>> baseMethodName = "MedicalDeviceLightDefault";
        attribute :>> includedModule = "replace_with_extension_package";
    }
}
