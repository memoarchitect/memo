package samples {
    private import memo::architecture::interfaces::*;
    private import memo::architecture::logical_structure::*;
    private import memo::core::relationships::*;
    private import memo::viewpoints::definitions::*;
    private import memo::core::enumerations::*;

    part systemA : LogicalComponent { attribute redefines name = "System A"; }
    part externalA : LogicalComponent { attribute redefines name = "External System"; }
    part partA : LogicalComponent { attribute redefines name = "Part A"; }
    part partB : LogicalComponent { attribute redefines name = "Part B With A Longer Engineering Label"; }
    part partC : LogicalComponent { attribute redefines name = "Part C"; }
    part nestedA : LogicalComponent { attribute redefines name = "Nested Part"; }

    port systemIn : DataPort;
    port systemOut : DataPort;
    port partAOut : DataPort;
    port partBIn : DataPort;

    connection : Composes connect parent ::> systemA to child ::> partA;
    connection : Composes connect parent ::> systemA to child ::> partB;
    connection : Composes connect parent ::> systemA to child ::> partC;
    connection : Composes connect parent ::> systemA to child ::> systemIn;
    connection : Composes connect parent ::> systemA to child ::> systemOut;
    connection : Composes connect parent ::> partA to child ::> nestedA;
    connection : Composes connect parent ::> partA to child ::> partAOut;
    connection : Composes connect parent ::> partB to child ::> partBIn;

    connection : ExchangesWith connect source ::> externalA to target ::> systemIn;
    connection : ExchangesWith connect source ::> systemIn to target ::> partA;
    connection : ExchangesWith connect source ::> partAOut to target ::> partBIn;
    connection : ExchangesWith connect source ::> partB to target ::> partC;
    connection : ExchangesWith connect source ::> partC to target ::> systemOut;

    part sampleInterconnectionView : DiagramView {
        attribute redefines title = "Sample · Interconnection";
        attribute redefines shortDescription = "Dummy parts, boundary ports, nested structure, and directional exchanges for renderer development.";
        attribute redefines viewKind = DiagramViewKind::interconnection;
        attribute redefines diagramType = "ibd";
        part selectionQuery {
            attribute redefines includeRelationshipKinds = {"Composes", "ExchangesWith"};
        }
    }

    connection : IncludedIn connect sourceElement ::> systemA to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> externalA to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> partA to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> partB to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> partC to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> nestedA to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> systemIn to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> systemOut to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> partAOut to targetView ::> sampleInterconnectionView;
    connection : IncludedIn connect sourceElement ::> partBIn to targetView ::> sampleInterconnectionView;
}
