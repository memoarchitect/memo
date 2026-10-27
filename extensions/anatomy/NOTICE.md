# Anatomy extension: attribution

The anatomy this extension provides is derived from the **Foundational Model of Anatomy (FMA)**,
release 5.1.0, by the **Structural Informatics Group, University of Washington**
(<http://purl.org/sig/ont/fma.owl>; source repository <https://github.com/uw-sig/FMA>).

The FMA is licensed under the **Creative Commons Attribution 4.0 International** licence
(CC BY 4.0, <https://creativecommons.org/licenses/by/4.0/>); the licence text is in
`LICENSES/CC-BY-4.0.txt`.

**Changes made:** the FMA's OWL classes, class hierarchy and `someValuesFrom` restrictions were
converted to SysML v2 — part definitions, specialization, and part and reference features — by
`scripts/build_fma_index.py` in the MEMO ontology repository. The result is
`data/fma-index.json.gz` and `src/vocabulary/memo_extension_anatomy_vocabulary.sysml`; the
anatomy a project generates from them with `memo anatomy generate` carries the same attribution
in each generated file. Inverse relations, anonymous class expressions, attribute and temporal
entities, deprecated terms, synonyms and non-English names were not converted.

The University of Washington does not endorse MEMO or this conversion. The rest of the extension
is MIT-licensed, like MEMO.
