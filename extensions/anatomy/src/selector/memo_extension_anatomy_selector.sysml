// What part of human anatomy a project uses. A project declares one or more
// selectors in its entrypoint; `memo anatomy generate` writes the project's
// anatomy package from the union of them, so two selectors never declare the
// same class twice.
package memo_extension_anatomy_selector {
    private import ScalarValues::*;
    private import memo_core_common::*;

    // Seed classes by FMA id (`fma7148` is the stomach), and how many levels of
    // their parts to include. Every class a selected class names, and every
    // ancestor of one, is included as well, so nothing FMA states about a
    // selected class is lost.
    part def AnatomySelector specializes MemoPart {
        attribute fmaSeeds : String[1..*];
        attribute partDepth : Integer default 2;
    }
}
