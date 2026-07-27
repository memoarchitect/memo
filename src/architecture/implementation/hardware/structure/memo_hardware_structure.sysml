// Physical realization taxonomy (§12) — aggregator. The hardware subgroup is
// split by technology domain into nested packages; this package re-exports the
// shared roots plus every domain subgroup under the historical name
// `memo_architecture_hardware_structure`, so importers see one flat surface.
package memo_architecture_hardware_structure {
    public import memo_architecture_hardware_common::*;
    public import memo_architecture_hardware_electrical::*;
    public import memo_architecture_hardware_mechanical::*;
    public import memo_architecture_hardware_fluidic::*;
    public import memo_architecture_hardware_optical::*;
    public import memo_architecture_hardware_sensing::*;
}
