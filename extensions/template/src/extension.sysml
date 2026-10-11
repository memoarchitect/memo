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
//   3. This package is the extension's facade: the one package a project
//      imports. It publicly imports every other package the extension ships
//      (`public import memo_extension_template_<sub>::*;`) and every extension
//      it builds on (`public import memo_extension_<other>::*;`). A public
//      import is what passes those packages on, so importing this one selects
//      the whole extension, and the KPAR build reads the same imports to
//      record the dependency. There is no list of package names to keep
//      beside it.
package memo_extension_template {
    // Definitions go here, each prefixed `Template`; sub-packages and the
    // extensions this one builds on are publicly imported here.
}
