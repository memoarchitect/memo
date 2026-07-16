# Your First Model

This tutorial creates one traceable safety slice for an infusion pump. It is
small enough to understand in one sitting and structured so you can extend it.

## 1. Create a project

Use the `memo` command from
[Memo Tools](https://github.com/memoarchitect/memo-tools):

```bash
memo init my-infusion-pump
cd my-infusion-pump
```

The generated project imports the medical modeling profile. Keep the project
model separate from the ontology source.

## 2. Record the context and need

```sysml
package my_pump {
    private import memo_medical_device_library::*;

    part nurse : Actor {
        attribute :>> id = "ACT-001";
        attribute :>> name = "Nurse";
    }

    requirement safeTherapy : StakeholderNeed {
        attribute :>> id = "NEED-001";
        attribute :>> name = "SafeTherapy";
        attribute :>> statement =
            "The patient needs medication delivered without unintended over-infusion.";
    }
}
```

Use a stable machine-readable name (`safeTherapy`) and a human identifier
(`NEED-001`). Put the actual claim in `statement`.

## 3. Add the requirement, design response, and risk

```sysml
package my_pump {
    private import memo_medical_device_library::*;

    requirement stopOnOverDelivery : SystemRequirement {
        attribute :>> id = "REQ-001";
        attribute :>> name = "StopOnOverDelivery";
        attribute :>> statement =
            "The pump shall stop delivery when measured flow exceeds the allowed limit.";
    }

    part monitorFlow : LogicalFunction {
        attribute :>> id = "LF-001";
        attribute :>> name = "MonitorFlow";
    }

    item overInfusion : Hazard {
        attribute :>> id = "HAZ-001";
        attribute :>> name = "OverInfusion";
    }

    item independentFlowMonitor : RiskControl {
        attribute :>> id = "RC-001";
        attribute :>> name = "IndependentFlowMonitor";
    }
}
```

## 4. Connect the claims

```sysml
connection : DerivesFrom
    connect sourceDriver ::> safeTherapy
    to targetRequirement ::> stopOnOverDelivery;

connection : MitigatesHazard
    connect riskControl ::> independentFlowMonitor
    to mitigatedHazard ::> overInfusion;
```

Add a verification case:

```sysml
part overDeliveryTest : VerificationCase {
    attribute :>> id = "VER-001";
    attribute :>> name = "OverDeliveryShutoffTest";
}

connection : VerifiedBy
    connect verificationTarget ::> stopOnOverDelivery
    to verificationCase ::> overDeliveryTest;
```

## 5. Validate and inspect

```bash
memo validate .
memo export json --output model.json
```

Treat each reported gap as a review question. A missing link may mean:

- the relationship has not been modeled;
- the wrong element kind was selected;
- the claim is outside the current model scope; or
- the project needs an explicit, justified exception.

Next, use the [Layer Map](../layers/index.md) to expand this slice and
[Relationships](../modeling/relationships.md) to choose precise links.
