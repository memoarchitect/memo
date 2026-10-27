"""Build the anatomy extension's FMA index and its relation vocabulary from FMA's OWL release.

    python3 -I scripts/build_fma_index.py <fma.owl>

fma.owl comes from the University of Washington's mirror of the release, not GitHub's
large-file storage: http://purl.org/sig/ont/fma.owl, or fma.zip (11 MB) under
http://sig.biostr.washington.edu/share/downloads/fma/release/5.1.0/.

FMA 5.1.0 (University of Washington Structural Informatics Group, CC BY 4.0) is a
frozen release, so this runs once per FMA version, not per build. It writes:

    extensions/anatomy/data/fma-index.json.gz
        every class under Anatomical entity: its SysML name, parent, home file,
        definition and its own relations, and each relation's feature and naming.
        `memo anatomy generate` reads only this; it knows nothing of OWL.
    extensions/anatomy/src/vocabulary/memo_extension_anatomy_vocabulary.sysml
        `AnatomyEntity`, with one abstract feature per FMA relation, subsetting
        as FMA's relation hierarchy does.

The mapping is by OWL axiom, never by a class's name:
    named class                         part def <fmaNNN> Name :> Parent
    rdfs:subClassOf named class         specialization (FMA is single-inheritance)
    subClassOf (p some C), p <= part    a composite relation: a part feature typed C
    subClassOf (p some C), other p      a reference relation: a ref part feature typed C
    property hierarchy                  feature subsetting on AnatomyEntity
    inverse property                    dropped: FMA states both directions
    anonymous filler                    not converted
"""
import gzip
import json
import re
import sys
import xml.etree.ElementTree as ET
from collections import Counter, defaultdict
from pathlib import Path

RDF = "{http://www.w3.org/1999/02/22-rdf-syntax-ns#}"
RDFS = "{http://www.w3.org/2000/01/rdf-schema#}"
OWL = "{http://www.w3.org/2002/07/owl#}"
FMA = "http://purl.org/sig/ont/fma/"
ROOT = "fma62955"  # Anatomical entity

# A home file is fixed from the whole of FMA, so a class sits in the same file in
# every project. First match: organ system, then cardinal body part (region), then
# the home of the nearest ancestor that has one, else `core`. A home holding more
# than SPLIT_AT classes is split by taxonomy branch, each branch of BRANCH_AT or more
# classes in a file of its own; again decided on the whole.
ORGAN_SYSTEM = "Organ system"
BODY_PART = "Cardinal body part"
SPLIT_AT = 5000
BRANCH_AT = 1000

RESERVED = set("""
about abstract accept action actor after alias all allocate allocation analysis and as assert assign
assume at attribute bind binding by calc case comment concern connect connection constant constraint
crosses decide def default defined dependency derived do doc else end entry enum event exhibit exit
expose false filter first flow for fork frame from hastype if implies import in include individual
inout interface istype item join language library locale loop merge message meta metadata nonunique
not null objective occurrence of or ordered out package parallel part perform port private protected
public redefines ref references render rendering rep require requirement return satisfy send snapshot
specializes stakeholder standard state subject subsets succession terminate then timeslice to
transition true until use variant variation verification verify via view viewpoint when while xor
""".split())

ROOT_DIR = Path(__file__).resolve().parent.parent
OUT_INDEX = ROOT_DIR / "extensions/anatomy/data/fma-index.json.gz"
OUT_VOCAB = ROOT_DIR / "extensions/anatomy/src/vocabulary/memo_extension_anatomy_vocabulary.sysml"


def local(iri):
    return iri[len(FMA):] if iri and iri.startswith(FMA) else iri


def pascal(label):
    words = re.findall(r"[A-Za-z0-9]+", label)
    name = "".join(w[:1].upper() + w[1:] for w in words) or "Unnamed"
    return name if name[0].isalpha() else "N" + name


def camel(label):
    p = pascal(label)
    c = p[:1].lower() + p[1:]
    return c + "_" if c in RESERVED else c


def snake(label):
    return "_".join(w.lower() for w in re.findall(r"[A-Za-z0-9]+", label))


def read_owl(path):
    classes, props, version = {}, {}, None
    for _, el in ET.iterparse(path, events=("end",)):
        if el.tag == OWL + "versionInfo" and version is None:
            version = el.text
        elif el.tag == OWL + "ObjectProperty" and el.get(RDF + "about"):
            p = local(el.get(RDF + "about"))
            lab = el.find(RDFS + "label")
            inv = el.find(OWL + "inverseOf")
            props[p] = {
                "label": lab.text if lab is not None else p,
                "super": [local(s.get(RDF + "resource")) for s in el.findall(RDFS + "subPropertyOf")],
                "inverse": local(inv.get(RDF + "resource")) if inv is not None and inv.get(RDF + "resource") else None,
            }
            el.clear()
        elif el.tag == OWL + "Class" and el.get(RDF + "about"):
            c = local(el.get(RDF + "about"))
            lab = el.find("{" + FMA + "}preferred_name")
            if lab is None or not lab.text:
                lab = el.find(RDFS + "label")
            if lab is not None and not lab.text:
                lab = None
            parents, rels = [], []
            for s in el.findall(RDFS + "subClassOf"):
                if s.get(RDF + "resource"):
                    parents.append(local(s.get(RDF + "resource")))
                    continue
                r = s.find(OWL + "Restriction")
                if r is None:
                    continue
                prop = r.find(OWL + "onProperty")
                some = r.find(OWL + "someValuesFrom")
                if prop is not None and some is not None and some.get(RDF + "resource"):
                    rels.append((local(prop.get(RDF + "resource")), local(some.get(RDF + "resource"))))
            defn = el.find("{" + FMA + "}definition")
            classes[c] = {
                "label": lab.text if lab is not None else c,
                "parents": parents,
                "rels": rels,
                "def": " ".join(defn.text.split()) if defn is not None and defn.text else None,
            }
            el.clear()
    return classes, props, version


def main(owl_path):
    C, P, version = read_owl(owl_path)

    def p_ancestors(p):
        out, todo = [], list(P.get(p, {}).get("super", []))
        while todo:
            q = todo.pop()
            if q not in out:
                out.append(q)
                todo += P.get(q, {}).get("super", [])
        return out

    composite = {p for p in P if p == "part" or "part" in p_ancestors(p)}
    inverses = {v["inverse"] for k, v in P.items() if v["inverse"] and v["inverse"] != k}
    kept = sorted(p for p in P if p not in inverses and not p.startswith("attributed_"))

    def parent(c):
        ps = [p for p in C[c]["parents"] if p in C]
        return ps[0] if ps else None

    under = {}
    def is_under(c):
        if c in under:
            return under[c]
        chain = []
        x = c
        result = False
        while x is not None:
            if x in under:
                result = under[x]
                break
            if x == ROOT:
                result = True
                break
            chain.append(x)
            x = parent(x)
        for y in chain:
            under[y] = result
        return result

    sel = {c for c in C if is_under(c)}

    # Names: PascalCase of the preferred name; the few duplicates get their id.
    counts = Counter(pascal(C[c]["label"]) for c in sel)
    name = {c: (pascal(C[c]["label"]) if counts[pascal(C[c]["label"])] == 1 else f"{pascal(C[c]['label'])}_{c}") for c in sel}
    name[ROOT] = "AnatomicalEntity"

    # Home files.
    parts = defaultdict(set)
    for c in sel:
        for p, t in C[c]["rels"]:
            if p in composite and t in sel:
                parts[c].add(t)
    def closure(c):
        seen, todo = set(), [c]
        while todo:
            x = todo.pop()
            if x not in seen:
                seen.add(x)
                todo += parts[x]
        return seen
    by_label = {C[c]["label"]: c for c in sel}
    roots = [k for k in sel if parent(k) == by_label[ORGAN_SYSTEM]] + \
            [k for k in sel if parent(k) == by_label[BODY_PART]]
    roots.sort(key=lambda k: (parent(k) != by_label[ORGAN_SYSTEM], C[k]["label"]))
    home = {}
    for r in roots:
        module = snake(C[r]["label"].replace(" system", ""))
        for x in sorted(closure(r)):
            home.setdefault(x, module)
    def home_of(c):
        x = c
        while x not in home:
            x = parent(x)
            if x is None or x == ROOT:
                return "core"
        return home[x]
    for c in sorted(sel):
        home[c] = home_of(c) if c not in home else home[c]
    home[ROOT] = "core"
    # Split oversized homes by taxonomy branch, one level at a time, on the whole of FMA.
    def depth_ancestor(c, depth):
        chain = []
        x = c
        while x is not None:
            chain.append(x)
            if x == ROOT:
                break
            x = parent(x)
        chain.reverse()  # ROOT first
        return chain[depth] if depth < len(chain) else chain[-1]
    def split(base, module, members, depth):
        # A branch large enough to stand alone gets its own file, named for its home
        # and the branch (`cardiovascular_artery`); the small ones stay together in
        # the file they came from, so a project does not get a file per handful.
        if len(members) <= SPLIT_AT or depth > 12:
            return {c: module for c in members}
        groups = defaultdict(list)
        for c in members:
            groups[depth_ancestor(c, depth)].append(c)
        if len(groups) == 1:
            return split(base, module, members, depth + 1)
        out, rest = {}, []
        for branch, group in sorted(groups.items()):
            if len(group) >= BRANCH_AT:
                out.update(split(base, f"{base}_{snake(C[branch]['label'])}", group, depth + 1))
            else:
                rest += group
        if rest:
            out.update(split(base, module, rest, depth + 1) if len(rest) > SPLIT_AT else {c: module for c in rest})
        return out

    final = {}
    by_module = defaultdict(list)
    for c in sel:
        by_module[home[c]].append(c)
    for module, members in by_module.items():
        final.update(split(module, module, sorted(members), 1))
    home = final

    feature_of = {p: camel(P[p]["label"]) + "Features" for p in kept}
    keep = set(kept)

    index = {
        "source": {
            "title": "Foundational Model of Anatomy (FMA)",
            "version": version,
            "publisher": "University of Washington Structural Informatics Group",
            "iri": "http://purl.org/sig/ont/fma.owl",
            "licence": "CC BY 4.0, https://creativecommons.org/licenses/by/4.0/",
            "modification": "Converted from OWL to SysML v2 by MEMO's anatomy extension.",
        },
        "root": ROOT,
        # relation -> the abstract feature it subsets, whether it is composition, and the words a
        # feature for it is named with (`arterialSupply` + target, `…AsArterialSupply` on a clash).
        "relations": {p: {
            "feature": feature_of[p],
            "composite": p in composite,
            "prefix": camel(P[p]["label"]).rstrip("_"),
            "suffix": pascal(P[p]["label"]),
        } for p in kept},
        # id -> [name, parent id, home file, definition, [[relation, target id]...]] — the class's own
        # `some` restrictions, in source order; the generator resolves them against its ancestors.
        "classes": {c: [name[c], parent(c) if c != ROOT else None, home[c], C[c]["def"],
                        [[p, t] for p, t in C[c]["rels"] if p in keep and t in sel]] for c in sorted(sel)},
    }
    OUT_INDEX.parent.mkdir(parents=True, exist_ok=True)
    # mtime=0 and no file name in the header: the same FMA gives the same bytes.
    payload = json.dumps(index, separators=(",", ":"), sort_keys=True).encode("utf-8")
    with open(OUT_INDEX, "wb") as raw, gzip.GzipFile(filename="", fileobj=raw, mode="wb", compresslevel=9, mtime=0) as f:
        f.write(payload)

    lines = [
        "// GENERATED by scripts/build_fma_index.py from the Foundational Model of Anatomy (FMA) "
        f"{version},",
        "// University of Washington Structural Informatics Group, http://purl.org/sig/ont/fma.owl,",
        "// CC BY 4.0 (https://creativecommons.org/licenses/by/4.0/). Modified: converted from OWL to",
        "// SysML v2. Do not edit; regenerate.",
        "//",
        "// The root every generated FMA class specializes, with one abstract feature per FMA",
        "// relation. A relation that is a kind of `part` is composition; any other is a reference.",
        "// The features subset each other as FMA's relations do (`regional_part` is a `part`), so a",
        "// query over `partFeatures` reaches every kind of part.",
        "package memo_extension_anatomy_vocabulary {",
        "    private import memo_core_common::*;",
        "",
        "    abstract part def AnatomyEntity specializes MemoPart {",
    ]
    for p in kept:
        sup = [q for q in P[p]["super"] if q in kept]
        subs = "".join(f" :> {feature_of[q]}" for q in sup)
        kind = "part" if p in composite else "ref part"
        lines.append(f"        abstract {kind} {feature_of[p]} : AnatomyEntity[0..*]{subs};")
    lines += ["    }", "}", ""]
    OUT_VOCAB.write_text("\n".join(lines))

    sizes = Counter(home.values())
    print(json.dumps({
        "version": version, "classes": len(sel), "relations": len(kept),
        "homes": len(sizes), "largestHomes": sizes.most_common(8),
        "indexBytes": OUT_INDEX.stat().st_size,
    }, indent=1))


if __name__ == "__main__":
    main(sys.argv[1])
