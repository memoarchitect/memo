// The approvals this pump is cleared under (plan O6): one RegulatedDevice per jurisdiction. `memo standards
// check` reads their jurisdictions to decide which standards are required, so an EU and US launch pulls in
// the harmonised IEC/ISO packs and 21 CFR Part 820 where a CE-only project would not be asked for the FDA
// clauses. They replace the project binding's `regulatoryRegime`.
package memo_examples_gpca_pump_gpca_devices {
    private import memo_core_enumerations::*;
    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    private import memo_artifacts_configuration_management::*;

    part deviceCe : RegulatedDevice {
        @MemoIdentity { :>> providedId = "DEV-CE"; :>> label = "GpcaPumpCe"; }
        attribute :>> jurisdiction = RegulatoryRegimeKind::CE;
    }
    part deviceMdr : RegulatedDevice {
        @MemoIdentity { :>> providedId = "DEV-MDR"; :>> label = "GpcaPumpMdr"; }
        attribute :>> jurisdiction = RegulatoryRegimeKind::MDR;
    }
    part deviceFda : RegulatedDevice {
        @MemoIdentity { :>> providedId = "DEV-FDA"; :>> label = "GpcaPumpFda510k"; }
        attribute :>> jurisdiction = RegulatoryRegimeKind::FDA_510k;
    }
}
