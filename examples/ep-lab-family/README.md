# EP Lab Family

A reference **product family**: one model, compiled once, holding a system of
systems, what its systems share, and each system. The names are fictional.

```text
model/
  catalog/project.sysml     model identity and method binding (the entrypoint)
  sos/                      the electrophysiology lab: the system of systems,
                            its interface control documents, a functional chain
                            across systems, and the clinical use cases
  shared/                   signals, ports, a component and the users that more
                            than one system needs
  systems/mapping/          cardiac mapping system
  systems/ablation/         ablation generator system
  systems/recording/        signal recording system
```

**Direction of reference.** A system imports `shared/` and nothing else of the
family; it never names the system of systems or another system. Only `sos/`
names the systems together.

**Use case scope comes from `subject`.** A clinical use case's subject is the
lab; a system use case's subject is its system. The clinical use case
`include`s the system use cases and binds each one's subject to the
constituent that carries it out.

**Interface control documents** are one `interface def` per pair of systems
that exchange something, with the port types on both ends taken from
`shared/`. The lab connects the systems' ports with them.

This is the skeleton (milestone M0 of the product-family plan). Features,
markets, release records, regulated devices, imported requirements and a
shared platform package are added by later milestones.
