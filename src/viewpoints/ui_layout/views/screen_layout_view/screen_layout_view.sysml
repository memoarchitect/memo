// The first geometry-kind view in MEMO. ADR-1-19 (memo-architect) deferred the
// geometry renderer because the ontology carried no geometric data and any 2D
// placement would have been invented layout rather than model content. With
// memo_architecture_implementation_ui_layout, placement is modelled: a region's
// RegionBounds are authored facts, drawn over an authored capture. The
// renderer now has something true to draw.
package memo_viewpoints_ui_layout_views_screen_layout_view {
    private import ScalarValues::*;

    private import memo_viewpoints_definitions::*;
    private import memo_core_enumerations::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    view def MemoScreenLayoutView :> MemoDiagramView {
        attribute :>> viewKind = DiagramViewKind::geometry;
        @MemoIdentity { :>> shortDescription = "Screen capture overlaid with its UI element tree."; }
        attribute :>> description = "Renders one ScreenCapture as the backdrop and each UIElement composed under the captured screen as a boundary box at its authored bounds, coloured by boundaryColor. Bounds are relative to the parent element, so the renderer accumulates transforms down the Composes tree. Selecting an element isolates it: siblings recede rather than compete. Following an element's NavigatesTo edge swaps the backdrop to the target screen's capture, so the view walks the interface the way the user does.";
        attribute :>> outputKind = (ViewOutputKind::diagram);
        attribute :>> presentationKind = (PresentationKind::screenLayout);
        attribute :>> layoutHint = "authored";
        attribute :>> autoPopulate = true;
        attribute :>> queryDescription = "One ScreenCapture, the screen UIElement it captures, and the UIElement tree composed beneath that screen.";
    }
}
