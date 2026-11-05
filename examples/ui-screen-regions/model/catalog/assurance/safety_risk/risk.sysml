// Safety/risk assurance: hazards and the risk controls that address them.
package memo_examples_ui_screen_regions_assurance_safety_risk {
    private import memo::*;
    private import ScalarValues::*;



    item hzWrongRate : Hazard {
        @MemoIdentity { :>> providedId = "UIR-HZ-001"; :>> label = "Infusion at incorrect rate"; }
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
    }

    part rcRateConfirm : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "UIR-RC-001"; :>> label = "Rate change confirmation dialog"; :>> shortDescription = "Explicit confirmation step before a rate change applies."; }
        doc /* A confirmation dialog restates the requested rate in words and numerals before the change is committed, so a mis-set decimal point has a second chance to be caught. */
        attribute :>> controlKind = RiskControlKind::protectiveMeasure;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }

    item hzWrongDrug : Hazard {
        @MemoIdentity { :>> providedId = "UIR-HZ-002"; :>> label = "Therapy configured for wrong drug"; }
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
    }

    part rcDrugLibraryGuard : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "UIR-RC-002"; :>> label = "Care area drug library guard"; :>> shortDescription = "Restrict selection to enabled care-area drug-library entries."; }
        doc /* Filters the dynamic selector to the active care-area formulary and validates the selected drug and concentration before its dosing limits are used. */
        attribute :>> controlKind = RiskControlKind::inherentSafeDesign;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }

    item hzUnexpectedPowerLoss : Hazard {
        @MemoIdentity { :>> providedId = "UIR-HZ-003"; :>> label = "Unexpected therapy interruption from power loss"; }
        attribute :>> hazardType = HazardTypeKind::energyExposure;
        attribute :>> severity = SeverityKind::critical;
        attribute :>> foreseeable = true;
    }

    part rcLowBatteryProminence : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "UIR-RC-003"; :>> label = "Prominent low battery status"; :>> shortDescription = "Update and emphasize low remaining battery status within one second."; }
        doc /* Monitors battery telemetry and changes the status indicator's color and icon state at the low-runtime threshold so the clinician can restore power before therapy interruption. */
        attribute :>> controlKind = RiskControlKind::monitoring;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }

    item hzIncorrectDeliveredVolumeAssessment : Hazard {
        @MemoIdentity { :>> providedId = "UIR-HZ-004"; :>> label = "Incorrect delivered volume assessment"; }
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
        attribute :>> foreseeable = true;
    }

    part rcDisplayFreshnessMonitor : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "UIR-RC-004"; :>> label = "Infusion display freshness monitor"; :>> shortDescription = "Refresh displayed rate and volume at 1 Hz and detect stale telemetry."; }
        doc /* Maintains a one-second display age budget for infusion status and detects a missed telemetry refresh before stale values can persist. */
        attribute :>> controlKind = RiskControlKind::monitoring;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }

    item hzIncorrectEventChronology : Hazard {
        @MemoIdentity { :>> providedId = "UIR-HZ-005"; :>> label = "Incorrect therapy event chronology"; }
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::minor;
        attribute :>> foreseeable = true;
    }

    part rcClockFreshnessCheck : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "UIR-RC-005"; :>> label = "Synchronized clock freshness check"; :>> shortDescription = "Synchronize the display clock and bound visible time error."; }
        doc /* Checks the displayed clock against the synchronized device clock and refreshes the visible minute at rollover. */
        attribute :>> controlKind = RiskControlKind::plausibilityCheck;
        attribute :>> implementationKind = RiskControlImplementationKind::softwareDesign;
    }

    // Illustrative: authored for this example.
    item hsAuthoredHzWrongRate : HazardousSituation {
        @MemoIdentity { :>> providedId = "USR-HS-A01"; :>> label = "Infusion at incorrect rate situation"; }
        attribute :>> exposedPersons = "patient";
        attribute :>> operatingCondition = "During use, the hazard InfusionAtIncorrectRate is present and the patient is exposed to it.";
    }
    connection : TracesRisk connect hzWrongRate to hsAuthoredHzWrongRate;
    // Illustrative: authored for this example.
    item hsAuthoredHzWrongDrug : HazardousSituation {
        @MemoIdentity { :>> providedId = "USR-HS-A02"; :>> label = "Therapy configured for wrong drug situation"; }
        attribute :>> exposedPersons = "patient";
        attribute :>> operatingCondition = "During use, the hazard TherapyConfiguredForWrongDrug is present and the patient is exposed to it.";
    }
    connection : TracesRisk connect hzWrongDrug to hsAuthoredHzWrongDrug;
    // Illustrative: authored for this example.
    item hsAuthoredHzUnexpectedPowerLoss : HazardousSituation {
        @MemoIdentity { :>> providedId = "USR-HS-A03"; :>> label = "Unexpected therapy interruption from power loss situation"; }
        attribute :>> exposedPersons = "patient";
        attribute :>> operatingCondition = "During use, the hazard UnexpectedTherapyInterruptionFromPowerLoss is present and the patient is exposed to it.";
    }
    connection : TracesRisk connect hzUnexpectedPowerLoss to hsAuthoredHzUnexpectedPowerLoss;
    // Illustrative: authored for this example.
    item hsAuthoredHzIncorrectDeliveredVolumeAssessment : HazardousSituation {
        @MemoIdentity { :>> providedId = "USR-HS-A04"; :>> label = "Incorrect delivered volume assessment situation"; }
        attribute :>> exposedPersons = "patient";
        attribute :>> operatingCondition = "During use, the hazard IncorrectDeliveredVolumeAssessment is present and the patient is exposed to it.";
    }
    connection : TracesRisk connect hzIncorrectDeliveredVolumeAssessment to hsAuthoredHzIncorrectDeliveredVolumeAssessment;
    // Illustrative: authored for this example.
    item hsAuthoredHzIncorrectEventChronology : HazardousSituation {
        @MemoIdentity { :>> providedId = "USR-HS-A05"; :>> label = "Incorrect therapy event chronology situation"; }
        attribute :>> exposedPersons = "patient";
        attribute :>> operatingCondition = "During use, the hazard IncorrectTherapyEventChronology is present and the patient is exposed to it.";
    }
    connection : TracesRisk connect hzIncorrectEventChronology to hsAuthoredHzIncorrectEventChronology;
    item harmAuthoredHzWrongRate : Harm {
        @MemoIdentity { :>> providedId = "USR-HM-A01"; :>> label = "Hz wrong rate harm"; }
        attribute :>> clinicalImpact = "Illustrative: injury to the patient that needs clinical intervention.";
    }
    connection : TracesRisk connect hsAuthoredHzWrongRate to harmAuthoredHzWrongRate;
    item harmAuthoredHzWrongDrug : Harm {
        @MemoIdentity { :>> providedId = "USR-HM-A02"; :>> label = "Hz wrong drug harm"; }
        attribute :>> clinicalImpact = "Illustrative: injury to the patient that needs clinical intervention.";
    }
    connection : TracesRisk connect hsAuthoredHzWrongDrug to harmAuthoredHzWrongDrug;
    item harmAuthoredHzUnexpectedPowerLoss : Harm {
        @MemoIdentity { :>> providedId = "USR-HM-A03"; :>> label = "Hz unexpected power loss harm"; }
        attribute :>> clinicalImpact = "Illustrative: injury to the patient that needs clinical intervention.";
    }
    connection : TracesRisk connect hsAuthoredHzUnexpectedPowerLoss to harmAuthoredHzUnexpectedPowerLoss;
    item harmAuthoredHzIncorrectDeliveredVolumeAssessment : Harm {
        @MemoIdentity { :>> providedId = "USR-HM-A04"; :>> label = "Hz incorrect delivered volume assessment harm"; }
        attribute :>> clinicalImpact = "Illustrative: injury to the patient that needs clinical intervention.";
    }
    connection : TracesRisk connect hsAuthoredHzIncorrectDeliveredVolumeAssessment to harmAuthoredHzIncorrectDeliveredVolumeAssessment;
    item harmAuthoredHzIncorrectEventChronology : Harm {
        @MemoIdentity { :>> providedId = "USR-HM-A05"; :>> label = "Hz incorrect event chronology harm"; }
        attribute :>> clinicalImpact = "Illustrative: injury to the patient that needs clinical intervention.";
    }
    connection : TracesRisk connect hsAuthoredHzIncorrectEventChronology to harmAuthoredHzIncorrectEventChronology;
}
