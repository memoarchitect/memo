# Cybersecurity

!!! question "The question this discipline answers"
    **What could an attacker do, and what stops them?**

Cybersecurity asks what in the device is worth protecting, who could attack it
and how, which weaknesses would let them, and what controls stand in the way.
For a medical device the answer matters beyond the data: an attack that changes
a therapy setting is a safety problem. MEMO therefore builds the security
argument from the same kinds of element as the safety argument. A threat is a
requirement driver, as a risk is. A vulnerability is a risk item, as a hazard
is. A cyber mitigation is a risk control. Security can show where it meets
safety.

**Namespace:** `memo::assurance::cybersecurity` · **Source:** `src/assurance/cybersecurity/`

## Key elements

**What is protected.** A `CybersecurityAsset` is something worth protecting:
data, a credential, a configuration, software, hardware, and so on. It states
its confidentiality, integrity and availability needs, and whether it is
privacy- or safety-relevant.

**Where attacks enter.** An `AttackSurface` is an entry point, with its exposure
and whether authentication is expected. A `TrustBoundary` is a boundary between
zones of different trust. It states the assumption made about each side and the
constraint on crossing.

**Who attacks, and through what.** A `Threat` is a requirement driver with a
threat category. The categories are STRIDE's six (spoofing, tampering,
repudiation, information disclosure, denial of service, elevation of privilege),
plus privacy loss and supply chain. A threat also records its attack vector,
source and preconditions. A `Vulnerability` is a weakness, with its CWE
reference and CVSS v3.1 base score and vector.

**Risk and control.** A `CyberHazard` is a hazard with security, safety, privacy
and operational impact. A `CyberRisk` is a risk with exploitability, attack
complexity and patient-safety contribution. A `CyberMitigation` is a risk
control, of a kind such as prevent, detect, respond, recover, hardening,
authentication, authorisation, encryption, or integrity protection. A
`SecurityRequirement` is a requirement with a security objective.

## How it connects

- **Assets are threatened** (`ThreatenedBy`, in Core), and a threat exploits a
  vulnerability (`Exploits`).
- **Threats play out in scenarios.** A threat is realised by an operative
  scenario (`RealizedByScenario`). See [Operational](operational.md).
- **Security meets safety.** A security element can impact a safety risk item
  (`ImpactsSafety`), and a mitigation reduces a vulnerability with `Mitigates`
  (`mitigationKind = vulnerability`). See [Safety and risk](safety-risk.md).
- **Threats drive requirements.** A threat or risk derives a security
  requirement (`DerivesCyberRequirement`, in Core). See
  [Requirements](requirements.md).
- **Trust boundaries sit on the architecture.** A `TrustBoundary` is an interface
  element, and an element can cross one (`CrossesTrustBoundary`, in Core). See
  [Logical](logical.md).

## In the running example

The temperature alarm has no security model, so this example comes from the
GPCA infusion pump. An unauthorised change to the therapy configuration through
the maintenance port is the threat. A shared default credential in service mode
is the vulnerability that enables it, and a tampered-configuration scenario is
how it plays out.

```sysml
--8<-- "examples/gpca-pump/model/catalog/gpca_cybersecurity.sysml:threat"
```

```sysml
--8<-- "examples/gpca-pump/model/catalog/gpca_cybersecurity.sysml:vulnerability"
```

```sysml
--8<-- "examples/gpca-pump/model/catalog/gpca_cybersecurity.sysml:chain"
```

## The full inventory

Generated from `src/assurance/cybersecurity/`.

--8<-- "docs/ontology/_generated/cybersecurity.md"

## Go deeper

- The GPCA infusion pump: [risk, cybersecurity, and assurance](../layers/risk-assurance.md).
- [The cybersecurity API](../sysml-api/index.md#assurance).
