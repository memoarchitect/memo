// ─── Figures for the ontology pages, checked against the source ────────────
//
// Each layer page builds its picture step by step: the core elements first,
// then the supporting ones. scripts/ontology-figures.mjs says what each step
// adds; this script checks every element, relationship and reference against
// src/ before drawing anything, and writes one SVG per step to
// docs/assets/ontology/. A figure that names something the ontology does not
// declare, or connects ends the relationship does not accept, fails here.
//
// Colour is the area an element belongs to: blue architecture, red assurance,
// green methodology, grey core and shared foundations.

import { mkdirSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { RELATIONSHIP_KINDS, byName, conformsTo, declarationRecords, root } from './lib/sysml-source.mjs';
import { LAYER_FIGURES, OVERVIEW } from './ontology-figures.mjs';

const output = join(root, 'docs', 'assets', 'ontology');

export const AREAS = {
  architecture: { label: 'Architecture', fill: '#e8f1fc', stroke: '#2f6fc4', text: '#123b6b' },
  assurance: { label: 'Assurance', fill: '#fdebea', stroke: '#c7433f', text: '#6b1916' },
  methodology: { label: 'Methodology', fill: '#e7f5ea', stroke: '#2f8a4a', text: '#14462a' },
  core: { label: 'Core and shared', fill: '#f1f3f5', stroke: '#7a8794', text: '#2c3640' },
};

// Native SysML relationships a figure may draw, with how each reads.
const NATIVE = new Set(['actor', 'subject', 'perform', 'allocate', 'satisfy', '#refinement', 'dependency', 'succession', 'flow', 'bind', 'include', 'transition', 'connect']);

const areaOf = (type) => {
  const path = byName.get(type)?.record.relativeSource ?? '';
  if (path.startsWith('architecture/')) return 'architecture';
  if (path.startsWith('assurance/')) return 'assurance';
  if (path.startsWith('methodology/')) return 'methodology';
  return 'core';
};
const kindLabel = (type) => byName.get(type)?.kind ?? '';

// ─── Checking ─────────────────────────────────────────────────────────────

const problems = [];
const check = (where, condition, message) => { if (!condition) problems.push(`${where}: ${message}`); };

function checkEdge(where, edge, nodes) {
  const from = nodes.get(edge.from);
  const to = nodes.get(edge.to);
  check(where, from && to, `connects ${edge.from} to ${edge.to}, which the figure does not place`);
  if (!from || !to) return;
  if (edge.rel) {
    const relation = byName.get(edge.rel);
    check(where, relation && RELATIONSHIP_KINDS.has(relation.kind), `${edge.rel} is not a relationship the ontology declares`);
    if (!relation) return;
    const [source, target] = [relation.relationEnds[0], relation.relationEnds.at(-1)];
    check(where, !source?.type || conformsTo(from.type, source.type), `${edge.rel} accepts ${source?.type} at its source, not ${from.type}`);
    check(where, !target?.type || conformsTo(to.type, target.type), `${edge.rel} accepts ${target?.type} at its target, not ${to.type}`);
  } else if (edge.native) {
    check(where, NATIVE.has(edge.native), `${edge.native} is not a native relationship this generator draws`);
  } else if (edge.ref) {
    const owner = byName.get(from.type);
    const ref = owner?.refs.find(({ name }) => name === edge.ref);
    check(where, ref, `${from.type} declares no reference \`${edge.ref}\``);
    check(where, !ref || conformsTo(to.type, ref.type), `${from.type}.${edge.ref} is typed ${ref?.type}, not ${to.type}`);
  } else {
    check(where, edge.contains, 'an edge must be a relationship, a native relationship, a reference, or containment');
  }
}

// ─── Drawing ──────────────────────────────────────────────────────────────

const esc = (value) => String(value).replaceAll('&', '&amp;').replaceAll('<', '&lt;').replaceAll('>', '&gt;').replaceAll('"', '&quot;');
const W = 210;
const H = 62;
const COL = 410;
const ROW = 150;
const PAD = 40;
// A figure may set its own column spacing (colWidth) when its edge labels are short.
let colWidth = COL;
const position = ({ col, row }) => ({ x: PAD + col * colWidth, y: PAD + 30 + row * ROW });

function boxEdgePoint(box, toward) {
  const cx = box.x + W / 2;
  const cy = box.y + H / 2;
  const dx = toward.x - cx;
  const dy = toward.y - cy;
  const scale = 1 / Math.max(Math.abs(dx) / (W / 2), Math.abs(dy) / (H / 2));
  return { x: cx + dx * scale, y: cy + dy * scale };
}

function renderNode(node, state) {
  const { x, y } = position(node);
  const area = AREAS[areaOf(node.type)];
  const faded = state === 'earlier';
  const label = node.label ?? node.type;
  const nameSize = label.length > 21 ? 13.5 : label.length > 17 ? 15 : 16;
  return `<g opacity="${faded ? 0.62 : 1}">
  <rect x="${x}" y="${y}" width="${W}" height="${H}" rx="10" fill="${area.fill}" stroke="${area.stroke}" stroke-width="${state === 'new' ? 3 : 1.5}"/>
  <rect x="${x}" y="${y}" width="6" height="${H}" rx="3" fill="${area.stroke}"/>
  <text x="${x + W / 2}" y="${y + 23}" text-anchor="middle" font-size="12" fill="${area.text}" font-style="italic">«${esc(kindLabel(node.type))}»</text>
  <text x="${x + W / 2}" y="${y + 45}" text-anchor="middle" font-size="${nameSize}" font-weight="700" fill="${area.text}">${esc(label)}</text>
  ${state === 'new' ? `<rect x="${x + W - 44}" y="${y - 10}" width="40" height="18" rx="9" fill="${area.stroke}"/><text x="${x + W - 24}" y="${y + 3}" text-anchor="middle" font-size="11" font-weight="700" fill="#ffffff">NEW</text>` : ''}
</g>`;
}

function renderEdge(edge, nodes, state) {
  const from = position(nodes.get(edge.from));
  const to = position(nodes.get(edge.to));
  const a = boxEdgePoint(from, { x: to.x + W / 2, y: to.y + H / 2 });
  const b = boxEdgePoint(to, { x: from.x + W / 2, y: from.y + H / 2 });
  const memo = Boolean(edge.rel);
  const colour = memo ? '#1f2a37' : '#4b5866';
  const label = edge.rel ?? (edge.native ? edge.native : edge.ref ? edge.ref : 'contains');
  const mid = { x: (a.x + b.x) / 2, y: (a.y + b.y) / 2 };
  const textWidth = label.length * 7.4 + 14;
  const dash = edge.ref ? 'stroke-dasharray="2 4"' : edge.contains || memo ? '' : 'stroke-dasharray="7 5"';
  const marker = edge.contains ? 'marker-start="url(#diamond)"' : 'marker-end="url(#arrow)"';
  return `<g opacity="${state === 'earlier' ? 0.62 : 1}">
  <line x1="${a.x}" y1="${a.y}" x2="${b.x}" y2="${b.y}" stroke="${colour}" stroke-width="${state === 'new' ? 2.4 : 1.6}" ${dash} ${marker}/>
  <rect x="${mid.x - textWidth / 2}" y="${mid.y - 11}" width="${textWidth}" height="20" rx="10" fill="#ffffff" stroke="${colour}" stroke-width="0.8"/>
  <text x="${mid.x}" y="${mid.y + 4}" text-anchor="middle" font-size="12" ${memo ? 'font-weight="700"' : 'font-style="italic"'} fill="${colour}">${esc(label)}</text>
</g>`;
}

function legend(y, areasShown, complete) {
  const items = [...areasShown].map((key) => AREAS[key]);
  let x = PAD;
  const parts = [];
  for (const area of items) {
    parts.push(`<rect x="${x}" y="${y}" width="16" height="16" rx="3" fill="${area.fill}" stroke="${area.stroke}" stroke-width="2"/><text x="${x + 24}" y="${y + 13}" font-size="13" fill="#2c3640">${esc(area.label)}</text>`);
    x += 40 + area.label.length * 7.5;
  }
  const line = (dash, text, marker = '') => {
    const piece = `<line x1="${x}" y1="${y + 8}" x2="${x + 34}" y2="${y + 8}" stroke="#1f2a37" stroke-width="2" ${dash} ${marker}/><text x="${x + 42}" y="${y + 13}" font-size="13" fill="#2c3640">${text}</text>`;
    x += 70 + text.replace(/<[^>]+>/g, '').length * 7.6;
    return piece;
  };
  parts.push(line('', '<tspan font-weight="700">MEMO relationship</tspan>'));
  parts.push(line('stroke-dasharray="7 5"', '<tspan font-style="italic">native SysML</tspan>'));
  parts.push(line('', 'contains', 'marker-start="url(#diamond)"'));
  parts.push(line('stroke-dasharray="2 4"', 'reference'));
  if (!complete) parts.push(`<rect x="${x}" y="${y - 1}" width="40" height="18" rx="9" fill="#2f6fc4"/><text x="${x + 20}" y="${y + 12}" text-anchor="middle" font-size="11" font-weight="700" fill="#ffffff">NEW</text><text x="${x + 48}" y="${y + 13}" font-size="13" fill="#2c3640">added in this step</text>`);
  return parts.join('\n  ');
}

function renderStep(figure, stepIndex, complete = false) {
  colWidth = figure.colWidth ?? COL;
  const shown = figure.steps.slice(0, stepIndex + 1);
  const nodes = new Map();
  const edges = [];
  shown.forEach((step, index) => {
    const state = complete ? 'all' : index === stepIndex ? 'new' : 'earlier';
    for (const node of step.nodes ?? []) nodes.set(node.id, { ...node, state });
    for (const edge of step.edges ?? []) edges.push({ ...edge, state });
  });
  const allNodes = figure.steps.flatMap((step) => step.nodes ?? []);
  const cols = Math.max(...allNodes.map(({ col }) => col)) + 1;
  const rows = Math.max(...allNodes.map(({ row }) => row)) + 1;
  const width = PAD * 2 + (cols - 1) * colWidth + W;
  const legendY = PAD + 30 + (rows - 1) * ROW + H + 40;
  const height = legendY + 40;
  const areasShown = new Set(allNodes.map(({ type }) => areaOf(type)));
  const step = figure.steps[stepIndex];
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${width} ${height}" width="${width}" height="${height}" font-family="Nunito, 'Segoe UI', Arial, sans-serif" role="img" aria-label="${esc(`${figure.title}, step ${stepIndex + 1}: ${step.title}`)}">
<defs>
  <marker id="arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="9" markerHeight="9" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#1f2a37"/></marker>
  <marker id="diamond" viewBox="0 0 14 10" refX="13" refY="5" markerWidth="14" markerHeight="10" orient="auto-start-reverse"><path d="M1,5 L7,1 L13,5 L7,9 z" fill="#1f2a37"/></marker>
</defs>
<rect width="100%" height="100%" fill="#ffffff"/>
<text x="${PAD}" y="${PAD}" font-size="18" font-weight="800" fill="#123b6b">${complete ? `${esc(figure.title)} · the whole picture` : `Step ${stepIndex + 1} of ${figure.steps.length} · ${esc(step.title)}`}</text>
${edges.map((edge) => renderEdge(edge, nodes, edge.state)).join('\n')}
${[...nodes.values()].map((node) => renderNode(node, node.state)).join('\n')}
${legend(legendY, areasShown, complete)}
</svg>
`;
}

// The overview: the architecture layers top to bottom, each with every element
// definition its folder in src/ declares, the link that carries the work down,
// and the links the assurance disciplines reach into it with; the disciplines
// follow in a second figure. The elements are read from the source, so a
// definition added to a layer appears here without anyone listing it. Drawn
// at about the width of the page column, so it is read at close to full size.
const OV = { width: 860, pad: 20, chipH: 32, chipGap: 8, chipFont: 14.5, labelW: 168 };
const ORANGE = '#b25a0c';
const RED = '#a12e2a';

// An element is a concrete definition a model element is typed by: not an
// abstract base, not a relationship, not an attribute, enum, constraint or
// metadata. Interface and flow definitions count unless they are MEMO
// relationships, because a model writes `interface x : PhysicalInterface`.
const NOT_ELEMENTS = new Set(['enum def', 'attribute def', 'metadata def', 'constraint def', 'viewpoint def', 'view def', 'calc def', 'analysis def', 'connection def', 'allocation def']);
const isElement = (declaration) => !declaration.abstract && !NOT_ELEMENTS.has(declaration.kind) && !conformsTo(declaration.name, 'MemoRelationship');
const groupLabel = (sub) => sub.split('/').map((part) => (part === 'ui' ? 'UI' : part.replaceAll('_', ' '))).join(' · ').replace(/^./, (c) => c.toUpperCase());
// An entry groups its elements by subfolder, or, when it names `groups`, by
// the base each element specializes.
function elementGroups({ folder, rootLabel = '', groups: byBase }) {
  if (byBase) {
    const names = declarationRecords.filter((d) => d.record.relativeSource.startsWith(`${folder}/`) && isElement(d)).map((d) => d.name);
    return byBase.map(({ label, base }) => ({ label, names: names.filter((name) => conformsTo(name, base)) }));
  }
  const groups = new Map();
  for (const declaration of declarationRecords) {
    const path = declaration.record.relativeSource;
    if (!path.startsWith(`${folder}/`) || !isElement(declaration)) continue;
    const sub = path.slice(folder.length + 1).split('/').slice(0, -1).join('/');
    const label = sub ? groupLabel(sub) : rootLabel;
    if (!groups.has(label)) groups.set(label, []);
    groups.get(label).push(declaration.name);
  }
  return [...groups].map(([label, names]) => ({ label, names }));
}
const elementsOf = (entry) => elementGroups(entry).flatMap(({ names }) => names);

const chipWidth = (name) => name.length * OV.chipFont * 0.6 + 20;
// Lays the groups out: a label column, then the group's chips wrapping in the
// rest of the card. Returns the SVG and the height it takes.
function chipGroups(groups, x, y, right, area) {
  const labelled = groups.some(({ label }) => label);
  const start = x + (labelled ? OV.labelW : 0);
  const parts = [];
  let top = y;
  for (const { label, names } of groups) {
    if (label) parts.push(`<text x="${x}" y="${top + 21}" font-size="12.5" font-weight="800" fill="${area.stroke}">${esc(label)}</text>`);
    let cx = start;
    let cy = top;
    for (const name of names) {
      const w = chipWidth(name);
      if (cx > start && cx + w > right) { cx = start; cy += OV.chipH + OV.chipGap; }
      parts.push(`<rect x="${cx}" y="${cy}" width="${w}" height="${OV.chipH}" rx="8" fill="#ffffff" stroke="${area.stroke}" stroke-width="1.4"/><text x="${cx + w / 2}" y="${cy + 21}" text-anchor="middle" font-size="${OV.chipFont}" font-weight="700" fill="${area.text}">${esc(name)}</text>`);
      cx += w + OV.chipGap;
    }
    top = cy + OV.chipH + OV.chipGap + 4;
  }
  return { svg: parts.join('\n  '), height: top - y - OV.chipGap - 4 };
}

// One link as a sentence: From  relation  To. A MEMO relationship is bold, a
// native one italic, as in every other figure.
const linkWidth = ({ from, rel, native, to }, size) => (from.length + to.join(' or ').length + 4) * size * 0.5 + (rel ?? native).length * size * 0.56;
function linkText({ from, rel, native, to }, x, y, size, colour) {
  const relation = rel ? `<tspan font-weight="800" fill="${colour}">${esc(rel)}</tspan>` : `<tspan font-style="italic" font-weight="700" fill="${colour}">${esc(native)}</tspan>`;
  return `<text x="${x}" y="${y}" font-size="${size}" fill="#1f2a37">${esc(from)}  ${relation}  ${esc(to.join(' or '))}</text>`;
}
function linkRows(links, size, maxWidth) {
  const rows = [];
  let row = [];
  let used = 0;
  for (const link of links) {
    const width = linkWidth(link, size);
    if (row.length && used + 30 + width > maxWidth) { rows.push(row); row = []; used = 0; }
    row.push({ link, x: used ? used + 30 : 0 });
    used += (used ? 30 : 0) + width;
  }
  if (row.length) rows.push(row);
  return rows;
}

// The map: the five layers as one line each, and the link that carries the
// work from each layer to the next. The elements are in the per-layer cards.
function renderMap() {
  const { width, pad } = OV;
  const cardW = width - pad * 2;
  const arch = AREAS.architecture;
  const parts = [];
  let y = pad;
  OVERVIEW.layers.forEach((layer) => {
    if (layer.group) {
      y += 18;
      parts.push(`<text x="${pad}" y="${y}" font-size="13" font-weight="800" letter-spacing="1.2" fill="#2f6fc4">${esc(layer.group.toUpperCase())}</text>`);
      parts.push(`<line x1="${pad + layer.group.length * 9.6 + 12}" y1="${y - 4}" x2="${width - pad}" y2="${y - 4}" stroke="#2f6fc4" stroke-width="1" opacity="0.5"/>`);
      y += 12;
    }
    const cardH = 62;
    parts.push(`<rect x="${pad}" y="${y}" width="${cardW}" height="${cardH}" rx="12" fill="${arch.fill}" stroke="${arch.stroke}" stroke-width="1.5"/>`);
    parts.push(`<rect x="${pad}" y="${y}" width="7" height="${cardH}" rx="3" fill="${arch.stroke}"/>`);
    parts.push(`<text x="${pad + 22}" y="${y + 39}" font-size="21" font-weight="800" fill="${arch.text}">${esc(layer.name)}</text>`);
    parts.push(`<text x="${pad + 210}" y="${y + 38}" font-size="16" font-style="italic" fill="#2c4f7a">${esc(layer.question)}</text>`);
    y += cardH;
    if (layer.down) {
      const gap = 20 + layer.down.length * 23;
      const ax = pad + 60;
      parts.push(`<line x1="${ax}" y1="${y + 4}" x2="${ax}" y2="${y + gap - 4}" stroke="#e07a1f" stroke-width="3" marker-end="url(#orange)"/>`);
      layer.down.forEach((link, line) => parts.push(linkText(link, ax + 20, y + 27 + line * 23, 15.5, ORANGE)));
      y += gap;
    }
  });
  return overviewSvg(parts, y + pad, "MEMO's five architecture layers, the question each answers, and the link that carries the work from each layer to the next");
}

// One card per layer or discipline: every element its folder declares and,
// for a layer, the links the assurance disciplines reach into it with.
function renderCard(entry, area) {
  const { width, pad } = OV;
  const cardW = width - pad * 2;
  const inner = pad + 18;
  const parts = [];
  const y = pad;
  const assuranceRows = entry.assurance ? linkRows(entry.assurance, 14, cardW - 130) : [];
  const chips = chipGroups(elementGroups(entry), inner, y + 64, pad + cardW - 16, area);
  const footer = assuranceRows.length ? 16 + assuranceRows.length * 22 + 6 : 0;
  const cardH = 64 + chips.height + 16 + footer;
  parts.push(`<rect x="${pad}" y="${y}" width="${cardW}" height="${cardH}" rx="12" fill="${area.fill}" stroke="${area.stroke}" stroke-width="1.5"/>`);
  parts.push(`<rect x="${pad}" y="${y}" width="7" height="${cardH}" rx="3" fill="${area.stroke}"/>`);
  parts.push(`<text x="${inner}" y="${y + 30}" font-size="21" font-weight="800" fill="${area.text}">${esc(entry.name)}</text>`);
  parts.push(`<text x="${inner}" y="${y + 52}" font-size="15" font-style="italic" fill="${area.text}" opacity="0.85">${esc(entry.question)}</text>`);
  parts.push(chips.svg);
  if (assuranceRows.length) {
    let ay = y + 64 + chips.height + 16;
    parts.push(`<line x1="${inner}" y1="${ay - 2}" x2="${pad + cardW - 18}" y2="${ay - 2}" stroke="#c7433f" stroke-width="1" stroke-dasharray="4 4" opacity="0.6"/>`);
    ay += 4;
    parts.push(`<text x="${inner}" y="${ay + 15}" font-size="13" font-weight="800" fill="${RED}">ASSURANCE</text>`);
    for (const row of assuranceRows) {
      for (const { link, x } of row) parts.push(linkText(link, inner + 100 + x, ay + 15, 14, RED));
      ay += 22;
    }
  }
  return overviewSvg(parts, y + cardH + pad, `${entry.name}: every element definition it declares`);
}

function overviewSvg(parts, height, label) {
  const { width } = OV;
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${width} ${height}" width="${width}" height="${height}" font-family="Nunito, 'Segoe UI', Arial, sans-serif" role="img" aria-label="${esc(label)}">
<defs>
  <marker id="orange" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="5" markerHeight="5" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#e07a1f"/></marker>
</defs>
<rect width="100%" height="100%" fill="#ffffff"/>
  ${parts.join('\n  ')}
</svg>
`;
}

// ─── Run ──────────────────────────────────────────────────────────────────

for (const figure of LAYER_FIGURES) {
  const placed = new Map();
  figure.steps.forEach((step, index) => {
    const where = `${figure.id} step ${index + 1}`;
    for (const node of step.nodes ?? []) {
      check(where, byName.has(node.type), `${node.type} is not a definition the ontology declares`);
      check(where, !placed.has(node.id), `places ${node.id} twice`);
      placed.set(node.id, node);
    }
    for (const edge of step.edges ?? []) checkEdge(where, edge, placed);
  });
}
function checkLink(where, link) {
  const ends = [link.from, ...link.to];
  for (const name of ends) check(where, byName.has(name), `${name} is not a definition the ontology declares`);
  if (link.native) {
    check(where, NATIVE.has(link.native), `${link.native} is not a native relationship this generator draws`);
    return;
  }
  const relation = byName.get(link.rel);
  check(where, relation && RELATIONSHIP_KINDS.has(relation.kind), `${link.rel} is not a relationship the ontology declares`);
  if (!relation) return;
  const [source, target] = [relation.relationEnds[0], relation.relationEnds.at(-1)];
  check(where, !source?.type || conformsTo(link.from, source.type), `${link.rel} accepts ${source?.type} at its source, not ${link.from}`);
  for (const to of link.to) check(where, !target?.type || conformsTo(to, target.type), `${link.rel} accepts ${target?.type} at its target, not ${to}`);
}
OVERVIEW.layers.forEach((layer, index) => {
  const where = `overview ${layer.name}`;
  const elements = elementsOf(layer);
  check(where, elements.length, `${layer.folder} declares no element definitions`);
  const next = OVERVIEW.layers[index + 1];
  const nextElements = next ? elementsOf(next) : [];
  for (const link of layer.down ?? []) {
    checkLink(`${where} down`, link);
    check(`${where} down`, elements.includes(link.from), `${link.from} starts the link down but is not one of this layer's elements`);
    for (const to of link.to) check(`${where} down`, nextElements.includes(to), `${to} ends the link down but is not one of ${next?.name ?? 'the next layer'}'s elements`);
  }
  for (const link of layer.assurance) {
    checkLink(`${where} assurance`, link);
    const own = [link.from, ...link.to].filter((name) => elements.includes(name));
    check(`${where} assurance`, own.length, `${link.rel ?? link.native} names none of this layer's elements`);
  }
});
for (const discipline of OVERVIEW.disciplines) check(`overview ${discipline.name}`, elementsOf(discipline).length, `${discipline.folder} declares no element definitions`);
for (const foundation of OVERVIEW.foundations) {
  const shown = new Set(elementsOf(foundation));
  const declared = declarationRecords.filter((d) => d.record.relativeSource.startsWith(`${foundation.folder}/`) && isElement(d)).map((d) => d.name);
  for (const name of declared) check(`overview ${foundation.name}`, shown.has(name), `${name} is declared in ${foundation.folder} but falls in none of the card's groups`);
}
if (problems.length) {
  console.error(`Ontology figures do not match the source:\n  ${problems.join('\n  ')}`);
  process.exit(1);
}

mkdirSync(output, { recursive: true });
writeFileSync(join(output, 'overview-layers.svg'), renderMap());
for (const layer of OVERVIEW.layers) writeFileSync(join(output, `overview-${layer.id}.svg`), renderCard(layer, AREAS.architecture));
for (const discipline of OVERVIEW.disciplines) writeFileSync(join(output, `overview-${discipline.id}.svg`), renderCard(discipline, AREAS.assurance));
for (const foundation of OVERVIEW.foundations) writeFileSync(join(output, `overview-${foundation.id}.svg`), renderCard(foundation, AREAS.core));
for (const figure of LAYER_FIGURES) {
  figure.steps.forEach((_, index) => writeFileSync(join(output, `${figure.id}-step${index + 1}.svg`), renderStep(figure, index)));
  writeFileSync(join(output, `${figure.id}.svg`), renderStep(figure, figure.steps.length - 1, true));
}
console.log(`Generated ontology figures: overview and ${LAYER_FIGURES.length} layer(s).`);
