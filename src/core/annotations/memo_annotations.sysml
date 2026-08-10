// Universal model annotations carried as model content rather than source-text
// `doc` / `comment` annotations. Comments capture review conversation, notes
// preserve useful context, and rationales explain why an engineering choice was
// made. Each is independently traceable, queryable, and exportable.
//
// The distinction is deliberate and load-bearing: `description` is what an
// element IS, a ModelComment is what someone SAID ABOUT IT. A design review
// needs an author, a timestamp, a thread, and a resolution state, and none of
// those survive inside a documentation string. Merging the two would put
// unresolved review chatter into a generated DHF section, so they never merge.
//
// Annotations attach to every metaclass — parts, actions, requirements, views,
// connections, and MEMO specializations — so CommentsOn, RationaleFor, and
// NotesOn leave their subject ends untyped, following the MemoLink precedent in
// memo_core_relationships.
package memo_core_annotations {
    private import Metaobjects::SemanticMetadata;
    private import ScalarValues::*;

    private import memo_core_common::*;
    private import memo_core_enumerations::*;
    private import memo_core_relationships::*;

    abstract part def ModelAnnotation specializes MemoPart {
        // `body` is the annotation content; `shortDescription` is the one-line
        // form shown in badges, tables, and generated indexes.
        attribute body : String;
        attribute author : String;
        // ISO 8601. Strings, not a date type: MEMO stays portable content and
        // does not depend on a tool's date library.
        attribute createdAt : String;
        // Optional pinpoint inside the annotated element: an attribute name,
        // requirement clause, diagram node, or other stable local reference.
        attribute anchor : String;
    }

    part def ModelComment specializes ModelAnnotation {
        attribute commentStatus : CommentStatusKind;
        // Why the comment closed. Required in practice for `resolved` and
        // `rejected` — a closed review point with no stated disposition is an
        // audit gap.
        attribute resolution : String;
        attribute resolvedBy : String;
        attribute resolvedAt : String;
    }

    part def ModelRationale specializes ModelAnnotation {
        // Decision, trade-off, standard clause, or evidence that the rationale
        // rests on. The body explains the reasoning in full.
        attribute basis : String;
    }

    part def ModelNote specializes ModelAnnotation {
        // A lightweight category for filtering notes without constraining their
        // content (for example assumption, usage, implementation, or warning).
        attribute noteKind : String;
    }

    // Replies form a thread through the ordinary Composes relation (parent
    // comment → reply), so CR-ONT-001's acyclicity invariant already covers
    // comment threads and no thread-specific relation is needed.
    // The end is `remark`, not `comment`: `comment` is a reserved KerML
    // keyword and cannot name a feature.
    connection def CommentsOn :> MemoRelationship {
        end remark : ModelComment :>> source;
        end annotatedElement :>> target;
    }
    abstract connection commentsOnLinks : CommentsOn[*];
    metadata def <commentsOn> CommentsOnMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = commentsOnLinks meta SysML::Usage;
    }

    connection def RationaleFor :> MemoRelationship {
        end rationaleRecord : ModelRationale :>> source;
        end justifiedElement :>> target;
    }
    abstract connection rationaleForLinks : RationaleFor[*];
    metadata def <rationaleFor> RationaleForMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = rationaleForLinks meta SysML::Usage;
    }

    connection def NotesOn :> MemoRelationship {
        end noteRecord : ModelNote :>> source;
        end notedElement :>> target;
    }
    abstract connection notesOnLinks : NotesOn[*];
    metadata def <notesOn> NotesOnMetadata :> SemanticMetadata {
        :> annotatedElement : SysML::ConnectionDefinition;
        :> annotatedElement : SysML::ConnectionUsage;
        :>> baseType = notesOnLinks meta SysML::Usage;
    }
}
