// The AADL extension's public facade. It publicly imports every package the
// extension ships, so one import brings the extension into a project: a
// project that imports it sees the definitions, and one that imports it
// publicly from its entrypoint package (or a methodology that does) selects
// every package below.
package memo_extension_aadl {
    public import memo_extension_aadl_runtime::*;
    public import memo_extension_aadl_correspondence::*;
}
