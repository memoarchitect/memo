// The GPCA methodology package.
//
// The `ResolvesToMethodology` connection that used to live here bound a model
// element to an authored `ResolvedMethodology` instance. A resolved methodology
// is derived from the project binding and the methodology chain, so there is
// nothing here to connect to: see `model/catalog/gpca_project.sysml` for the
// binding, and `gpca_profiles.sysml` for the methodology it selects.
package memo_examples_gpca_pump_methodology_gpca_methodology {
    private import memo_examples_gpca_pump_methodology_gpca_profiles::*;
}
