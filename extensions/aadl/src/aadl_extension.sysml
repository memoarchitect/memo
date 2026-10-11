// The AADL extension's public facade. A project imports this package for the
// definitions and names the extension in its binding with
// `ref :>> includedExtension = aadlExtensionMethod;`, which selects every
// package the extension ships.
package memo_extension_aadl {
    public import memo_extension_aadl_runtime::*;
    public import memo_extension_aadl_correspondence::*;
}
