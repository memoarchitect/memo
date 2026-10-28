// Money as a quantity, the one stated exception to "a measurable value is ISQ".
//
// ISQ (ISO/IEC 80000) has no monetary quantity, and a cost kept as a bare `Real`
// or a `String` cannot be summed with `QuantityCalculations::sum` or multiplied
// by a duration into a cost. So money is a quantity of its own: a base quantity
// (`monetaryAmount`), a unit type for it (`CurrencyUnit`), and the rate that is
// money per time (`CostRateValue`, `CostRateUnit`), built exactly as ISQBase builds
// `DurationValue`/`DurationUnit` and `FrequencyUnit`. A sum of `MoneyValue`s then
// type-checks, and so does `capacityCostRate * expectedDuration`.
//
// One currency per project. The library declares no currency: a project declares
// the one it uses, once, as a `CurrencyUnit` (`attribute <EUR> euro : CurrencyUnit;`)
// and writes every amount in it. No conversion between currencies is modelled, so
// two currency units in one project is an error, checked by a consistency rule.
//
// Where it lives: `memo_core_stdlib_quantities` re-exports ISQ, SI and the SI prefixes
// and declares nothing, so a declaration does not go there. This package is the same
// kind of unit beside it, in core because both the operational layer (resource cost)
// and the realization layers (bill-of-material cost) price things, and core is the
// only layer every one of them may import. It imports the SysML quantity libraries
// and nothing of MEMO's.
package memo_core_stdlib_money {
    private import ScalarValues::Real;
    private import Quantities::*;
    private import MeasurementReferences::*;
    private import ISQ::DurationUnit;
    private import ISQ::isq;

    attribute def MoneyValue :> ScalarQuantityValue {
        attribute :>> num: Real;
        attribute :>> mRef: CurrencyUnit[1];
    }

    attribute monetaryAmount: MoneyValue[*] nonunique :> scalarQuantities;

    attribute def CurrencyUnit :> SimpleUnit {
        private attribute moneyPF: QuantityPowerFactor[1] { :>> quantity = monetaryAmount; :>> exponent = 1; }
        attribute :>> quantityDimension { :>> quantityPowerFactors = moneyPF; }
    }

    attribute def CostRateValue :> ScalarQuantityValue {
        attribute :>> num: Real;
        attribute :>> mRef: CostRateUnit[1];
    }

    attribute costRate: CostRateValue[*] nonunique :> scalarQuantities;

    attribute def CostRateUnit :> DerivedUnit {
        private attribute moneyPF: QuantityPowerFactor[1] { :>> quantity = monetaryAmount; :>> exponent = 1; }
        private attribute durationPF: QuantityPowerFactor[1] { :>> quantity = isq.T; :>> exponent = -1; }
        attribute :>> quantityDimension { :>> quantityPowerFactors = (moneyPF, durationPF); }
    }
}
