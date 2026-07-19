# Surgical workflow modelling: sleeve gastrectomy

This tutorial models one illustrative operation end to end: a laparoscopic
sleeve gastrectomy. It is a modelling example, not a clinical protocol. The
point is to make the clinical work explicit before a device, software item, or
architecture is selected.

```mermaid
flowchart LR
    U["Clinical use case\nPerform sleeve gastrectomy"] --> W["Operational workflow\nTime-out → access → mobilise → create sleeve → assess → handover"]
    W --> N["Nominal scenario\nProcedure completes"]
    W --> R["Recovery scenario\nStaple-line bleeding"]
    N --> NA["Own operational activity\nComplete nominal procedure"]
    R --> RA["Own operational activity\nRecognize → control → reassess → escalate"]
```

## The clinical goal and setting

The use case records the operation's goal, people, and operating-room context.
It is one `ClinicalUseCase`, supported by a reusable workflow—not a duplicate
goal for every scenario.

```sysml
use case ucPerformSleeveGastrectomy : ClinicalUseCase {
    attribute :>> name = "PerformLaparoscopicSleeveGastrectomy";
    attribute :>> goalStatement =
        "Complete the planned laparoscopic sleeve gastrectomy and transfer the patient with the staple line assessed.";
    ref :>> primaryUser = bariatricSurgeon;
    ref :>> supportingActors = (scrubNurse, anesthetist);
    ref :>> useContext = bariatricOr;
}
```

## The reusable workflow

The workflow names the normal work of the operation: confirm time-out and
position, establish access, mobilise the stomach, create the sleeve, assess the
staple line, close, and hand over. `WorkflowStep`s refer to operational
activities, so the order is inspectable without embedding it in prose.

```sysml
action wfSleeveGastrectomy : OperationalWorkflow {
    attribute :>> name = "LaparoscopicSleeveGastrectomyWorkflow";
    attribute :>> entryCondition = "patient prepared; time-out ready";
    attribute :>> completionCondition = "staple line assessed; postoperative handover complete";
}
connection : WorkflowComprisesStep connect workflow ::> wfSleeveGastrectomy to step ::> wsMobilize;
connection : WorkflowComprisesStep connect workflow ::> wfSleeveGastrectomy to step ::> wsSleeve;
connection : StepPrecedes connect predecessor ::> wsMobilize to successor ::> wsSleeve;
connection : SupportsUseCase connect workflow ::> wfSleeveGastrectomy
    to useCase ::> ucPerformSleeveGastrectomy;
```

## A critical task inside the operation

`CreateAndInspectStapleLine` is a critical task, not merely a workflow step.
Its task steps state the work that needs focused review: confirm anatomy,
create the staple line, inspect for bleeding, and assess integrity.

```sysml
action taskCreateStapleLine : CriticalTask {
    attribute :>> name = "CreateAndInspectStapleLine";
    attribute :>> taskGoal =
        "create the planned sleeve and identify bleeding or integrity concerns before completion";
    attribute :>> potentialHarm =
        "bleeding or staple-line complication not recognized before handover";
}
connection : ActivityComprisesTask connect activity ::> actSizeAndCreateSleeve
    to task ::> taskCreateStapleLine;
connection : TaskComprisesStep connect task ::> taskCreateStapleLine to step ::> stInspectBleeding;
```

## Scenarios own their operational activity

The model has a nominal procedure path and a recovery path for observed
staple-line bleeding. Each scenario references its own operational activity.
The recovery activity is an action flow: recognize, control, reassess, then
escalate if needed. It is not a copy of the full surgical workflow.

```sysml
action oaControlStapleLineBleeding : OperationalActivity {
    attribute :>> name = "ControlStapleLineBleeding";
    action recognizeBleeding; action controlBleeding;
    action reassessStapleLine; action escalateIfNeeded;
    first start then recognizeBleeding;
    first recognizeBleeding then controlBleeding;
    first controlBleeding then reassessStapleLine;
}

part scStapleLineBleeding : OperationalScenario {
    attribute :>> name = "StapleLineBleedingRecovery";
    attribute :>> variantKind = ScenarioVariantKind::recovery;
    attribute :>> variationPoint = "bleeding observed during staple-line assessment";
    ref :>> baseScenario = scNominalSleeveProcedure;
    ref :>> parentWorkflow = wfSleeveGastrectomy;
    ref :>> activities = oaControlStapleLineBleeding;
}
connection : ScenarioComprisesActivity connect scenario ::> scStapleLineBleeding
    to activity ::> oaControlStapleLineBleeding;
```

## What this example deliberately does not model

This is an operational surgical-workflow model. It stops at clinical work,
tasks, workflow steps, scenarios, and action flows. A later model may trace a
selected scenario to functions, devices, requirements, hazards, or evidence;
those elements should be added only when there is a real review question.

Open the [source model](https://github.com/memoarchitect/memo/tree/main/examples/surgical-closure-workflow)
to inspect the full workflow and both scenario paths.
