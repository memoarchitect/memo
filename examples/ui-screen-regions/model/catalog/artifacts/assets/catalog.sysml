// Controlled asset identities.
//
// SysML owns each capture's identity, URI, hash, dimensions, and capture
// context; the PNG under `screen-captures/` owns its payload.
package memo_examples_ui_screen_regions_artifacts_assets {
    private import ScalarValues::*;

    private import memo_core_relationships::*;
    private import memo_core_annotations::*;
    private import memo_architecture_functional_functions::*;
    private import memo_assurance_requirements::*;
    private import memo_assurance_requirements_needs::*;
    private import memo_assurance_human_factors::*;
    private import memo_assurance_safety_risk::*;
    private import memo_assurance_verification_validation::*;

    private import memo_core_enumerations::*;
    private import memo_artifacts_core::*;
    private import memo_architecture_implementation_ui::*;

    private import memo_core_common::*;
    private import memo_core_common::MemoIdentity;
    // ── The captures ────────────────────────────────────────────
    part capMain : ScreenCapture {
        @MemoIdentity { :>> providedId = "UIR-CAP-001"; } attribute :>> name = "MainScreenCapture_v2.4.1";
        @MemoIdentity { :>> shortDescription = "Main infusion screen, build 2.4.1."; }
        attribute :>> description = "Screenshot of the running-infusion screen taken from release candidate 2.4.1 on the 7-inch panel at 1024×600, English (US), daylight theme, clinician role.";
        attribute :>> imageUri = "model/catalog/artifacts/assets/screen-captures/mainScreenLayout/main-screen-2.4.1.png";
        attribute :>> imageHash = "sha256:086d8a3c2956ad8ed81f1e565a97308b55ba8a384c22c1b2138626ad8928a88a";
        attribute :>> pixelWidth = 1024;
        attribute :>> pixelHeight = 600;
        attribute :>> captureDate = "2026-07-14";
        attribute :>> capturedBuild = "pump-fw-2.4.1-rc3";
        attribute :>> captureContext = "7in panel, 1024x600, en-US, daylight theme, clinician role";
    }

    part capDrugSelector : ScreenCapture {
        @MemoIdentity { :>> providedId = "UIC-003"; } attribute :>> name = "ExpandedDrugSelectorCapture_v2.4.1";
        @MemoIdentity { :>> shortDescription = "Expanded drug-selector region crop."; }
        attribute :>> description = "Focused capture of the reusable DrugSelectorRegion in its expanded state, used when a reviewer drills into the region from the main layout.";
        attribute :>> imageUri = "model/catalog/artifacts/assets/screen-captures/drugSelectorRegion/drug-selector-expanded-2.4.1.png";
        attribute :>> imageHash = "sha256:2265b48864be8561a86099a99cf8aea2f4fcf06c19ccacbcc55784fbb1c37975";
        attribute :>> pixelWidth = 798;
        attribute :>> pixelHeight = 390;
        attribute :>> captureDate = "2026-07-31";
        attribute :>> capturedBuild = "pump-fw-2.4.1-rc3";
        attribute :>> captureContext = "drug-selector region crop, expanded state, en-US";
    }

    part capSettings : ScreenCapture {
        @MemoIdentity { :>> providedId = "UIR-CAP-002"; } attribute :>> name = "SettingsScreenCapture_v2.4.1";
        @MemoIdentity { :>> shortDescription = "Infusion settings screen, build 2.4.1."; }
        attribute :>> description = "Screenshot of the settings screen reached from the main screen's settings row, same build and capture conditions as the main screen capture.";
        attribute :>> imageUri = "model/catalog/artifacts/assets/screen-captures/settingsScreenLayout/settings-screen-2.4.1.png";
        attribute :>> imageHash = "sha256:2ad7f11427fdb2eb179cf94d96a1679a2ece31505d247ee0b659bec06a669dbf";
        attribute :>> pixelWidth = 1024;
        attribute :>> pixelHeight = 600;
        attribute :>> captureDate = "2026-07-14";
        attribute :>> capturedBuild = "pump-fw-2.4.1-rc3";
        attribute :>> captureContext = "7in panel, 1024x600, en-US, daylight theme, clinician role";
    }

}
