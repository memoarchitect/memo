// Re-export-only wrapper. No new types.
//
// The quantity value types (`DurationValue`, `FrequencyValue`, `StorageCapacityValue`, …), the SI units (`s`, `Hz`,
// `V`, `A`, `B`) and the prefixes (`milli`, `mega`, `kibi`) a measurable attribute is typed and written with.
//
// A range on a parameter or an attribute is a constraint on its TYPE, so every use of the type
// carries it:
//
//     attribute def DoseMass :> MassValue {
//         assert constraint { self >= 0 [kg] and self <= 5 [kg] }
//     }
//     action def DeliverDose { in amount : DoseMass; }
//
// The builder emits that constraint as an element owned by the type, with its expression and unit, so
// it is found with `where: owner == "<the type's qualified id>"`. No kind for a range exists.
package memo_core_stdlib_quantities {
    private import ScalarValues::*;

    public import ISQ::*;
    public import SI::*;
    public import SIPrefixes::*;
    public import MeasurementReferences::DimensionOneValue;
    public import MeasurementReferences::one;
}
