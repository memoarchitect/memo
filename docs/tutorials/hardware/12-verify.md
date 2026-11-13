# Lesson 12 · Verify it

[Series overview](index.md) · Previous: [Interfaces as contracts](11-interfaces.md) · Next: [Recap: the whole slice](13-recap.md)

## The idea

A verification case is the planned check. It says what it verifies (a
requirement), what it tests (its subject: a function, a control), how, and what
counts as a pass. The result, when the test has run, is an evidence record.

SysML v2 has all of this natively: `verification` cases, an `objective` that
`verify`s a requirement, and a `subject`. MEMO types the case by
`VerificationCase` and adds the method and acceptance criteria.

## Write it

After the `allocation`:

```sysml
    verification vcSpO2Accuracy : VerificationCase {
        @MemoIdentity { :>> providedId = "VC-1"; :>> label = "Verify SpO2 accuracy"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria =
            "Against a reference over 70 % to 100 %, every reading is within 2 points.";

        objective { verify reqSpO2Accuracy; }
        subject verified : Base::Anything[*] = (fnMeasureSpO2);
    }
    verification vcWithholdOnPoorSignal : VerificationCase {
        @MemoIdentity { :>> providedId = "VC-2"; :>> label = "Verify reading withheld on poor signal"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria =
            "With the probe signal attenuated below the threshold, no SpO2 value is shown.";

        objective { verify reqWithholdOnPoorSignal; }
        subject verified : Base::Anything[*] = (rcSignalQualityCheck, fnMeasureSpO2.fnCheckSignalQuality);
    }
    part evSpO2AccuracyReport : MemoEvidence {
        @MemoIdentity { :>> providedId = "EV-1"; :>> label = "SpO2 accuracy test report"; }
        attribute :>> evidenceKind = EvidenceKind::evidence;
    }
    connection : ProducesEvidence connect vcSpO2Accuracy to evSpO2AccuracyReport;
```

## Line by line

Each line or small group from the snippet above, with its notation, what it says, and why it is written that way. The symbols are collected in [Reading the notation](00-reading-the-notation.md).

```sysml
verification vcSpO2Accuracy : VerificationCase {
```

- **Notation.** `verification` declares a verification case usage.
- **What it says.** There is a verification case, verify SpO2 accuracy.
- **Why.** SysML has verification cases built in; MEMO's `VerificationCase` adds the method and acceptance criteria that a design-verification record needs.

```sysml
@MemoIdentity { :>> providedId = "VC-1"; :>> label = "Verify SpO2 accuracy"; }
```

- **Notation.** `@MemoIdentity { … }` attaches metadata to the element whose body it is in. Inside it, `:>> providedId = "…";` gives a value (`=`) to an attribute the metadata already declares (`:>>`, "redefines"); each assignment ends with `;`.
- **What it says.** This element's engineering id and the name people read.

```sysml
attribute :>> methodKind = MemoVerificationMethodKind::test;
```

- **Notation.** An enumeration value: `inspection`, `analytical`, `demonstration`, `test`, `simulation`, `formalProof` or `modelChecking`.
- **What it says.** It is verified by test.
- **Why.** The method decides what kind of evidence will come back: a test report, an analysis, an inspection record.

```sysml
attribute :>> acceptanceCriteria =
    "Against a reference over 70 % to 100 %, every reading is within 2 points.";
```

- **Notation.** A text value over two lines.
- **What it says.** What counts as a pass.
- **Why.** Written so someone else could judge the result: it repeats the requirement's tolerance and range as a check.

```sysml
objective { verify reqSpO2Accuracy; }
```

- **Notation.** `objective { … }` is the case's objective; `verify r` inside it names a requirement.
- **What it says.** This case verifies the accuracy requirement.
- **Why.** It ties the test to the obligation it proves, so a requirement with no verifying case can be found.

```sysml
subject verified : Base::Anything[*] = (fnMeasureSpO2);
```

- **Notation.** `subject` declares what is under test. `verified` is the subject's name. `Base::Anything` is the most general type in SysML (`::` picks `Anything` from the `Base` library). `[*]` means any number. `= ( … )` gives the list.
- **What it says.** What this case tests is the measuring function.
- **Why.** Naming the function here is what makes it *verified*, and clears the CR-ONT-040 finding from lesson 8. Name a function only when the test checks what that function produces.

```sysml
}
```

- **Notation.** Closes the case.

```sysml
verification vcWithholdOnPoorSignal : VerificationCase {
    @MemoIdentity { :>> providedId = "VC-2"; :>> label = "Verify reading withheld on poor signal"; }
    attribute :>> methodKind = MemoVerificationMethodKind::test;
    attribute :>> acceptanceCriteria =
        "With the probe signal attenuated below the threshold, no SpO2 value is shown.";
```

- **Notation.** As above.
- **What it says.** A second case, for the safety requirement.
- **Why.** A risk control needs its own verification (CR-MED-003).

```sysml
objective { verify reqWithholdOnPoorSignal; }
```

- **Notation.** As above.
- **What it says.** It verifies the safety requirement.

```sysml
subject verified : Base::Anything[*] = (rcSignalQualityCheck, fnMeasureSpO2.fnCheckSignalQuality);
```

- **Notation.** A list of two, separated by a comma.
- **What it says.** It tests the risk control and the function that implements it.
- **Why.** Withholding the reading is exactly what this test observes, so both are genuinely under test. This clears CR-MED-003 from lesson 10.

```sysml
}
```

- **Notation.** Closes the case.

```sysml
part evSpO2AccuracyReport : MemoEvidence {
    @MemoIdentity { :>> providedId = "EV-1"; :>> label = "SpO2 accuracy test report"; }
    attribute :>> evidenceKind = EvidenceKind::evidence;
}
```

- **Notation.** A part usage.
- **What it says.** There is a test report.
- **Why.** The case is the plan; the evidence is what a run produced. Keeping them apart is how a plan with no result yet is told apart from a passed test.

```sysml
connection : ProducesEvidence connect vcSpO2Accuracy to evSpO2AccuracyReport;
```

- **Notation.** A typed connection.
- **What it says.** The accuracy case produced this report.
- **Why.** Case first, record second. VC-2 has no evidence yet, which is why one warning (CR-MED-032) is left.

## Good to know

Name a function as the subject only when the test checks what that function
produces. VC-2 names both the control and the function that implements it,
because withholding the reading is exactly what it observes.

## Validate it

Run `memo validate` again. The unverified function and risk control from
lessons 8 and 10 are gone. One rule finding is left, a warning:

> Verification results should be documented as evidence records.

It is about VC-2, and it is right: that test has not been run, so there is no
report yet. When it runs, add a `MemoEvidence` part and a `ProducesEvidence`
connection, as for VC-1.

## The model so far

```sysml
package pulse_oximeter {
    private import memo::*;

    part def PulseOximeterSystem specializes System {
        attribute :>> systemBoundaryDescription =
            "The handheld pulse oximeter and its finger probe.";
    }

    part oximeter : HardwareAssembly {
        @MemoIdentity {
            :>> providedId = "HW-1";
            :>> label = "Pulse oximeter";
        }
        doc /* The handheld unit: case, battery, display and electronics. */

        in port chargeIn : PhysicalPort {
            @MemoIdentity { :>> label = "Charging socket"; }
            attribute :>> connectorType = "USB-C";
        }

        inout port probeSocket : PhysicalPort {
            @MemoIdentity { :>> label = "Probe socket"; }
            attribute :>> connectorType = "DB-9";

            out port ledDrive : PhysicalPort {
                @MemoIdentity { :>> label = "LED drive pins"; }
            }
            in port photoSignal : PhysicalPort {
                @MemoIdentity { :>> label = "Photodiode signal pins"; }
            }
        }

        part frontEnd : ElectronicComponent {
            @MemoIdentity { :>> providedId = "HW-2"; :>> label = "Analog front end"; }
            attribute :>> patientContact = false;
            out port ledDriveOut : PhysicalPort;
            in port signalIn : PhysicalPort;
        }

        bind probeSocket.ledDrive = frontEnd.ledDriveOut;
        bind probeSocket.photoSignal = frontEnd.signalIn;
    }

    part fingerProbe : HardwareAssembly {
        @MemoIdentity { :>> providedId = "HW-3"; :>> label = "Finger probe"; }

        inout port probePlug : PhysicalPort {
            attribute :>> connectorType = "DB-9";
            in port ledDrive : PhysicalPort;
            out port photoSignal : PhysicalPort;
        }

        part ledPair : ElectronicComponent {
            @MemoIdentity { :>> providedId = "HW-4"; :>> label = "Red and infrared LEDs"; }
            attribute :>> patientContact = false;
            in port driveIn : PhysicalPort;
        }
        part photodiode : Sensor {
            @MemoIdentity { :>> providedId = "HW-5"; :>> label = "Photodiode"; }
            attribute :>> measurand = "red and infrared light through the finger";
            attribute :>> patientContact = false;
            out port signalOut : PhysicalPort;
        }
        part fingerPad : MechanicalPart {
            @MemoIdentity { :>> providedId = "HW-6"; :>> label = "Finger pad"; }
            attribute :>> patientContact = true;
            attribute :>> contactNature = "intact skin, surface device";
            attribute :>> contactDuration = "limited, up to 24 h";
        }

        bind probePlug.ledDrive = ledPair.driveIn;
        bind probePlug.photoSignal = photodiode.signalOut;
    }

    interface probeLink : PhysicalInterface
        connect oximeter.probeSocket to fingerProbe.probePlug {
        @MemoIdentity { :>> providedId = "IF-1"; :>> label = "Probe interface"; }
        attribute :>> direction = DirectionKind::inputOutput;
        attribute :>> signalingKind = SignalingKind::analog;
        attribute :>> mediumKind = PhysicalMediumKind::electrical;
        attribute :>> connectorStandard = "DB-9, 6 pins used";
    }

    flow ledDriveCurrent : PhysicalTransfer
        from oximeter.probeSocket.ledDrive to fingerProbe.probePlug.ledDrive {
        attribute :>> quantity = "LED drive current";
        attribute :>> unit = "mA";
        attribute :>> nominalValue = "50";
    }
    flow photoCurrent : PhysicalTransfer
        from fingerProbe.probePlug.photoSignal to oximeter.probeSocket.photoSignal {
        attribute :>> quantity = "photodiode current";
        attribute :>> unit = "uA";
    }

    action fnMeasureSpO2 : SystemFunction {
        @MemoIdentity { :>> providedId = "FN-1"; :>> label = "Measure oxygen saturation"; }
        attribute :>> criticality = CriticalityKind::high;

        action fnIlluminate : ComponentFunction {
            @MemoIdentity { :>> providedId = "FN-2"; :>> label = "Illuminate the finger"; }
        }
        action fnSenseLight : ComponentFunction {
            @MemoIdentity { :>> providedId = "FN-3"; :>> label = "Sense transmitted light"; }
        }
        action fnCheckSignalQuality : ComponentFunction {
            @MemoIdentity { :>> providedId = "FN-4"; :>> label = "Check signal quality"; }
        }
        first fnIlluminate then fnSenseLight;
        first fnSenseLight then fnCheckSignalQuality;
    }

    allocate fnMeasureSpO2 to oximeter;
    allocate fnMeasureSpO2.fnIlluminate to fingerProbe.ledPair;
    allocate fnMeasureSpO2.fnSenseLight to fingerProbe.photodiode;
    allocate fnMeasureSpO2.fnCheckSignalQuality to oximeter.frontEnd;

    requirement needTrustworthyReading : Need {
        @MemoIdentity { :>> providedId = "NEED-1"; :>> label = "Trustworthy oxygen reading"; }
        attribute :>> needKind = NeedKind::clinicalUser;
        doc /* A clinician needs an oxygen saturation reading they can act on. */
    }
    requirement reqSpO2Accuracy : Requirement {
        @MemoIdentity { :>> providedId = "REQ-1"; :>> label = "SpO2 accuracy"; }
        attribute :>> requirementType = RequirementTypeKind::system;
        doc /* The oximeter shall report SpO2 within 2 percentage points of the
             * reference value over the range 70 % to 100 %. */
    }
    part clinician : User {
        @MemoIdentity { :>> providedId = "USR-1"; :>> label = "Ward clinician"; }
    }
    connection : HeldBy connect needTrustworthyReading to clinician;
    connection : DerivesFrom connect needTrustworthyReading to reqSpO2Accuracy;
    satisfy reqSpO2Accuracy by fnMeasureSpO2;

    item hzFalseNormalReading : Hazard {
        @MemoIdentity { :>> providedId = "HAZ-1"; :>> label = "Falsely normal SpO2 reading"; }
        attribute :>> hazardType = HazardTypeKind::informationError;
        attribute :>> severity = SeverityKind::serious;
    }
    item hsHypoxiaMissed : HazardousSituation {
        @MemoIdentity { :>> providedId = "HS-1"; :>> label = "Hypoxic patient reads as normal"; }
        attribute :>> exposedPersons = "patient";
    }
    item harmHypoxicInjury : Harm {
        @MemoIdentity { :>> providedId = "HARM-1"; :>> label = "Hypoxic injury"; }
    }
    connection : TracesRisk connect hzFalseNormalReading to hsHypoxiaMissed;
    connection : TracesRisk connect hsHypoxiaMissed to harmHypoxicInjury;

    item fmPhotodiodeDegraded : FailureMode {
        @MemoIdentity { :>> providedId = "FM-1"; :>> label = "Photodiode signal degraded"; }
        attribute :>> failureModeKind = FailureModeKind::degradedFunction;
    }
    connection : HasFailureMode connect fingerProbe.photodiode to fmPhotodiodeDegraded;
    connection : Causes connect fmPhotodiodeDegraded to hzFalseNormalReading {
        attribute :>> causeKind = CauseKind::contributesToHazard;
    }

    part rcSignalQualityCheck : RiskControlMeasure {
        @MemoIdentity { :>> providedId = "RC-1"; :>> label = "Withhold reading on poor signal"; }
        attribute :>> controlKind = RiskControlKind::plausibilityCheck;
        attribute :>> implementationKind = RiskControlImplementationKind::hardwareDesign;
    }
    connection : Mitigates connect rcSignalQualityCheck to hzFalseNormalReading {
        attribute :>> mitigationKind = MitigationKind::hazard;
    }
    connection : ControlImplementedBy connect rcSignalQualityCheck to fnMeasureSpO2.fnCheckSignalQuality;

    requirement reqWithholdOnPoorSignal : Requirement {
        @MemoIdentity { :>> providedId = "REQ-2"; :>> label = "Withhold reading on poor signal"; }
        attribute :>> requirementType = RequirementTypeKind::system;
        doc /* When the photodiode signal is below the quality threshold, the
             * oximeter shall show no SpO2 value and indicate poor signal. */
    }
    connection : DerivesFrom connect hzFalseNormalReading to reqWithholdOnPoorSignal;
    satisfy reqWithholdOnPoorSignal by fnMeasureSpO2.fnCheckSignalQuality;

    part probeCable : Cable {
        @MemoIdentity { :>> providedId = "HW-7"; :>> label = "Probe cable"; }
        attribute :>> patientContact = false;
        attribute :>> conductorCount = "6";
        attribute :>> shielding = "braided screen";
    }
    allocation : ConnectionBinding allocate probeLink to probeCable;

    verification vcSpO2Accuracy : VerificationCase {
        @MemoIdentity { :>> providedId = "VC-1"; :>> label = "Verify SpO2 accuracy"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria =
            "Against a reference over 70 % to 100 %, every reading is within 2 points.";

        objective { verify reqSpO2Accuracy; }
        subject verified : Base::Anything[*] = (fnMeasureSpO2);
    }
    verification vcWithholdOnPoorSignal : VerificationCase {
        @MemoIdentity { :>> providedId = "VC-2"; :>> label = "Verify reading withheld on poor signal"; }
        attribute :>> methodKind = MemoVerificationMethodKind::test;
        attribute :>> acceptanceCriteria =
            "With the probe signal attenuated below the threshold, no SpO2 value is shown.";

        objective { verify reqWithholdOnPoorSignal; }
        subject verified : Base::Anything[*] = (rcSignalQualityCheck, fnMeasureSpO2.fnCheckSignalQuality);
    }
    part evSpO2AccuracyReport : MemoEvidence {
        @MemoIdentity { :>> providedId = "EV-1"; :>> label = "SpO2 accuracy test report"; }
        attribute :>> evidenceKind = EvidenceKind::evidence;
    }
    connection : ProducesEvidence connect vcSpO2Accuracy to evSpO2AccuracyReport;
}
```

Next: [Lesson 13 · Recap: the whole slice](13-recap.md)
