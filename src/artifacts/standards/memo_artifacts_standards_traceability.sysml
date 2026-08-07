// Clause-level traceability: the project-facing half of the regulatory axis.
//
// MEMO carries standards in two mechanisms, and this file is one of them:
//
//   @StandardReference metadata (core/semantics)  — provenance INSIDE the MEMO
//     library: "this ontology type exists because ISO 14971 §5.4 says so".
//     Library-internal, not project data.
//   ConformsTo (here)                             — PROJECT traceability:
//     "this requirement in this project satisfies IEC 62304 §5.2.2".
//     Queryable, reportable, auditable.
//
// Do not add a third. A standard is data in the ontology, not a code path:
// adding ISO 13485 must be one new file of RegulatoryStandard/StandardClause
// instances and zero TypeScript changes.
//
// Nothing here is abstract. An abstract def cannot be instantiated, so a
// traceability matrix over abstract clause types is empty by construction —
// which is the failure mode this whole area exists to prevent.
//
// ─── The clause library and how a document cites it ──────────────────────
//
// The concrete instances live one file per standard beside this one
// (iec_62304.sysml, iec_60601_1.sysml, …). A DHF template cites them from its
// frontmatter, in one of two shapes:
//
//   clauses: ["5.4"]                              relative — the clause number
//                                                 belongs to this document's
//                                                 own `standard:`
//   clauses: ["ISO 14971:2019 §7"]                qualified — the designation
//                                                 before the section sign, the
//                                                 clause number after it
//
// An entry containing "§" is qualified and nothing else is: that is the whole
// grammar. The designation must match a RegulatoryStandard's `designation`
// exactly, amendments included, and the clause number must match a
// StandardClause's `clauseNumber` exactly. Both are checked by
// standards-library.test.ts in memo-tools, which is what makes "adding a
// standard is one file" true rather than aspirational.
package memo_artifacts_standards_traceability {
    private import ScalarValues::*;
    private import memo_core_common::*;
    private import memo_core_relationships::*;
    private import memo_artifacts_core::*;

    // =========================================================================
    // Standards and clauses
    // =========================================================================

    item def RegulatoryStandard :> MemoPart {
        doc /* A regulatory or consensus standard a project claims conformance
             * to, identified by its full designation including edition and
             * amendments (e.g. "IEC 62366-1:2015+AMD1:2020"). Dropping the
             * amendment is a CE/MDR regression, so it is carried explicitly
             * rather than folded into the designation by convention. */
        attribute designation : String;
        attribute edition : String[0..1];
        attribute issuer : String[0..1];
        attribute amendments : String[0..*];
    }

    item def StandardClause :> MemoPart {
        doc /* One normative clause of a RegulatoryStandard, at the depth at
             * which the standard makes a distinct requirement a MEMO document
             * actually claims. `title` is a MEMO-authored scope phrase — a
             * representative synonym for what the clause governs ("§17" →
             * "electromagnetic compatibility") — never the standard's own
             * normative wording, which is copyrighted. The scope phrase is a
             * label: queries traverse ConformsTo to the clause instance, they
             * never match on its text.
             *
             * Clause containment uses the existing Composes relation
             * (standard as parent, clause as child; clause as parent,
             * sub-clause as child). There is no clause-specific composition
             * type, because whole/part decomposition is already one relation
             * in MEMO. */
        attribute clauseNumber : String;
        attribute title : String[0..1];
        attribute normativeStrength : String[0..1];
    }

    // =========================================================================
    // Relationships
    // =========================================================================

    connection def ConformsTo :> MemoRelationship {
        doc /* Any model element claims conformance to a standard clause.
             * This is the edge the standards traceability matrix and the
             * clause coverage report are computed over. */
        end conformingElement : MemoPart;
        end clause : StandardClause;
    }

    connection def TracesToDocument :> MemoRelationship {
        doc /* Where the evidence for a clause claim is written down. The target
             * is the existing controlled-artifact type — MEMO does not model a
             * separate Document/DocumentSection family, because
             * ControlledArtifact / ModelOwnedArtifact / MarkdownDocumentSource
             * already carry version, owner and approval status. Section
             * granularity rides on the link as a reference string rather than
             * as a duplicate element type. */
        attribute sectionReference : String[0..1];
        end tracedElement : MemoPart;
        end artifact : ControlledArtifact;
    }
}
