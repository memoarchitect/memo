---
id: sbom
title: Software Bill of Materials (SBOM)
standard: IEC 62304:2006+AMD1:2015
clauses: ["8.1.2"]
required_for: ["FDA_510k", "FDA_PMA", "CE"]
---

{{include:shared/snippets/document-control-header.md}}

{{toc}}

---

## 1. Purpose

This Software Bill of Materials (SBOM) provides a complete inventory of software components in **{{project.product}}**, including first-party code, SOUP, and open-source dependencies. Required for FDA cybersecurity submissions and EU MDR.

---

## 2. First-Party Software

Software developed in-house for this system is listed below from the model:

```memo-query
kind: [SoftwareSystem, SoftwareItem, SoftwareUnit]
display: table
columns: name, kind, layer, doc
sort: name
empty: "No first-party software items defined."
```

---

## 3. SOUP and Third-Party Components

All third-party and SOUP components with their versions and origins, generated from the model:

```memo-query
kind: SOUPComponent
display: table
columns: name, doc, layer
sort: name
empty: "No SOUP components defined."
```

---

## 4. Dependency Versions

Exact component versions currently recorded in the model — keep these synchronized with the build system:

_[TODO: Attach machine-readable SBOM (CycloneDX or SPDX format)]_

---

## 5. Vulnerability Assessment

Assessment of component vulnerabilities and their disposition:

_[TODO: Reference FDA cybersecurity submission or security assessment]_

---

{{include:shared/snippets/revision-history-table.md}}

{{include:shared/snippets/approval-block.md}}
