// Traceability matrices and design structure matrices, declared as views.
//
// A matrix is a native SysML `view` usage (ViewUsage, SysML-textual-bnf.kebnf:1610)
// typed by a `view def` (ViewDefinition, :1584), like every other MEMO view, so
// it is written, derived, listed and moved by the same machinery. It declares no
// `expose`: ViewBodyItem makes Expose optional (:1618-1622), and a matrix shows
// what its axes select, not a package's contents.
//
// An axis is a part usage (PartUsage, :627) typed by MemoMatrixAxis. It is
// hand-picked elements, a memo-query, or both. A query is stored as its text and
// evaluated against the model when the matrix opens, so the matrix answers the
// same question after the model has grown; the ids it matched are never stored.
package memo_viewpoints_matrix {
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_viewpoints_definitions::*;

    enum def MatrixOrderingKind {
        enum natural;
        enum kind;
        enum partition;
        enum cluster;
    }

    enum def MatrixGroupKind {
        enum owningPackage;
        enum memoQuery;
        enum clusterResult;
    }

    /**
     * One axis of a matrix: the elements it lists.
     *
     * `includeElementKinds` and `includeElementIds` are inherited from the
     * selection query a view already carries; the ids are hand-picked elements,
     * by qualified name. `query` adds the text of a `memo-query` block, the same
     * query language the DHF templates use. The axis is the union of the two.
     */
    part def MemoMatrixAxis :> ViewSelectionQuery {
        attribute query : String[0..1];
    }

    /** A named group of rows in a design structure matrix. */
    part def MemoMatrixGroup :> MemoPart {
        attribute groupName : String;
        attribute groupedBy : MatrixGroupKind;
        /** A package qualified name, or the text of a `memo-query`; empty for a cluster result. */
        attribute expression : String[0..1];
    }

    /**
     * Which elements the relationship types connect, and how the matrix reads
     * them. The relationship types are the model's own, never a list kept here.
     */
    view def MemoTraceabilityMatrixView :> MemoDiagramView {
        attribute :>> viewKind = DiagramViewKind::grid;
        @MemoIdentity { :>> shortDescription = "Rows traced to columns by relationships, each axis chosen by hand or by query."; }
        /**
         * The system or system of systems the matrix is about: the qualified name
         * of its definition (a workspace root). Its queries run in that workspace.
         * A string, because a `ref` cannot name a definition.
         */
        attribute system : String[0..1];
        part rowAxis : MemoMatrixAxis[0..1];
        part columnAxis : MemoMatrixAxis[0..1];
        /** Relationship types that count as a link; empty means any. */
        attribute linkTypes : String[*];
    }

    /**
     * A design structure matrix has one axis because rows equal columns. The
     * options after `axis` apply to a dependency reading and are not on the
     * traceability definition.
     */
    view def MemoDependencyMatrixView :> MemoDiagramView {
        attribute :>> viewKind = DiagramViewKind::grid;
        @MemoIdentity { :>> shortDescription = "Dependencies among one set of elements, chosen by hand or by query."; }
        /** The system or system of systems the matrix is about, as on the traceability matrix. */
        attribute system : String[0..1];
        part axis : MemoMatrixAxis[0..1];
        /** Relationship types that put a mark in a cell; empty means any. */
        attribute dependencyTypes : String[*];
        /** Relationship types that build the nesting, so the hierarchy is the one the model declares. */
        attribute containmentTypes : String[*];
        attribute symmetric : Boolean[0..1];
        attribute ordering : MatrixOrderingKind[0..1];
        part groups : MemoMatrixGroup[*];
        /** Elements to highlight on the axis and in the cell inspector. */
        part criticalElements : MemoMatrixAxis[0..1];
    }
}
