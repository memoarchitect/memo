package memo {
    package examples {
        package gpca {
            package methodology {
                private import memo::methodology::profiles::*;
                private import memo::examples::gpca::methodology_profiles::*;
                private import memo::core::relationships::*;
                private import memo::examples::gpca::requirements::*;
                private import memo::examples::gpca::architecture::*;

                connection : ResolvesToMethodology connect boundModelElement ::> tlm to resolvedMethodology ::> gpcaMethodResolved;
            }
        }
    }
}
