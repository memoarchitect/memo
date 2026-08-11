# ROS mobile robot

A focused MEMO example that demonstrates **using an extension**. The subject is
a ROS 2 mobile logistics robot; the point is the mechanism.

Extensions are a way to model, so they live in [`extensions/`](../../extensions),
beside the ontology. This project is one of their consumers.

- `model/catalog/project.sysml` — the binding. It lists three extension modules
  (`memo_extension_messaging`, `memo_extension_container`, `memo_extension_ros`)
  in `includedModule`. That is how extensions compose: at the project binding,
  never by chaining methodologies.
- `model/catalog/ros_mobile_robot.sysml` — the model.
- `model/catalog/viewpoints/` — diagram views over that catalog.

## What it shows

1. **Extension types are used exactly like base types.** `RosNode` specializes
   `SoftwareComponent`, so it inherits period, WCET, priority, safety class and
   fault containment, and every base rule still applies to it. The three nodes
   set `runtimeKind` individually — two composed into one container process,
   the safety monitor in its own — because that is a design decision the
   extension type must not make for the modeller.
2. **Publish and subscribe use native SysML.** A ROS message is an item
   definition, a named topic is its item usage, nodes own `out` publisher and
   `in` subscriber ports, and native interfaces/flows connect those ports. The
   extension declares no publish/subscribe relation.
3. **Deployment reuses the base relations unchanged.** `BuildsInto`,
   `DeploysTo` and `ProvidesEnvironment` carry the whole chain from source
   module to container image to compute unit to ROS runtime, with no
   ROS-specific relation anywhere in it. That is the evidence the base is
   factored correctly.
4. **QoS is a typed profile, not a property bag.** Publisher ports carry an
   offered `RosQosProfile` and subscriber ports a requested one, so the incompatibility
   that silently delivers nothing at runtime is two adjacent values in the
   model. This is why the `PropertySet` stub was deleted rather than made real.
5. **Services and actions are different native interface contracts.** A service
   has one request and one correlated response. An action has goal,
   acceptance, feedback, cancellation, result, and status features plus a
   native execution-state family.
