// The approvals this pump is cleared under (plan O6): one RegulatedDevice per jurisdiction. `memo standards
// check` reads their jurisdictions to decide which standards are required, so an EU and US launch pulls in
// the harmonised IEC/ISO packs and 21 CFR Part 820 where a CE-only project would not be asked for the FDA
// clauses. They replace the project binding's `regulatoryRegime`.
package memo_examples_gpca_pump_gpca_devices {
    private import memo::*;

    part deviceCe : RegulatedDevice {
        @MemoIdentity { :>> providedId = "DEV-CE"; :>> label = "GPCA pump CE"; }
        attribute :>> jurisdiction = RegulatoryRegimeKind::CE;
    }
    part deviceMdr : RegulatedDevice {
        @MemoIdentity { :>> providedId = "DEV-MDR"; :>> label = "GPCA pump MDR"; }
        attribute :>> jurisdiction = RegulatoryRegimeKind::MDR;
    }
    part deviceFda : RegulatedDevice {
        @MemoIdentity { :>> providedId = "DEV-FDA"; :>> label = "GPCA pump FDA 510(k)"; }
        attribute :>> jurisdiction = RegulatoryRegimeKind::FDA_510k;
    }
}
