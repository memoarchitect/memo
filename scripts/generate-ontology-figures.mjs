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
import { RELATIONSHIP_KINDS, byName, conformsTo, root } from './lib/sysml-source.mjs';
import { LAYER_FIGURES, OVERVIEW } from './ontology-figures.mjs';

const output = join(root, 'docs', 'assets', 'ontology');

export const AREAS = {
  architecture: { label: 'Architecture', fill: '#e8f1fc', stroke: '#2f6fc4', text: '#123b6b' },
  assurance: { label: 'Assurance', fill: '#fdebea', stroke: '#c7433f', text: '#6b1916' },
  methodology: { label: 'Methodology', fill: '#e7f5ea', stroke: '#2f8a4a', text: '#14462a' },
  core: { label: 'Core and shared', fill: '#f1f3f5', stroke: '#7a8794', text: '#2c3640' },
};

// Native SysML relationships a figure may draw, with how each reads.
const NATIVE = new Set(['actor', 'subject', 'perform', 'allocate', 'satisfy', '#refinement', 'dependency', 'succession', 'flow', 'bind', 'include', 'transition']);

const areaOf = (type) => {
  const path = byName.get(type)?.record.relativeSource ?? '';
  if (path.startsWith('architecture/')) return 'architecture';
  if (path.startsWith('assurance/')) return 'assurance';
  if (path.startsWith('methodology/')) return 'methodology';
  return 'core';
};
const kindLabel = (type) => byName.get(type)?.kind.replace(/ def$/, '') ?? '';

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
const COL = 340;
const ROW = 150;
const PAD = 40;
const position = ({ col, row }) => ({ x: PAD + col * COL, y: PAD + 30 + row * ROW });

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
  const width = PAD * 2 + (cols - 1) * COL + W;
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

// The stacked-layer overview: the architecture layers as planes, the
// assurance disciplines as a band across all of them.
function renderOverview() {
  const planeW = 760;
  const planeH = 120;
  const skew = 60;
  const gap = 56;
  const left = 210;
  const top = 60;
  const bandX = left + planeW + skew + 150;
  const height = top + OVERVIEW.layers.length * (planeH + gap) - gap + 30;
  const width = bandX + 300;
  const planes = OVERVIEW.layers.map((layer, index) => {
    const y = top + index * (planeH + gap);
    const shade = ['#dbe8fb', '#d3e3fa', '#cadcf7', '#c1d5f4', '#b8cef1'][index];
    const chips = layer.elements.map((name, chipIndex) => {
      const cx = left + skew + 22 + chipIndex * 172;
      return `<rect x="${cx}" y="${y + 60}" width="160" height="34" rx="8" fill="#ffffff" stroke="#2f6fc4" stroke-width="1.5"/><text x="${cx + 80}" y="${y + 82}" text-anchor="middle" font-size="${name.length > 20 ? 12 : 14}" font-weight="700" fill="#123b6b">${esc(name)}</text>`;
    }).join('');
    const arrow = index < OVERVIEW.layers.length - 1 ? `
  <path d="M${left + 40} ${y + planeH + 4} C ${left + 10} ${y + planeH + 30}, ${left + 10} ${y + planeH + 30}, ${left + 40} ${y + planeH + gap - 4}" fill="none" stroke="#e07a1f" stroke-width="2.2" stroke-dasharray="6 5" marker-end="url(#orange)"/>
  <text x="${left + 54}" y="${y + planeH + gap / 2 + 5}" font-size="13" font-style="italic" fill="#b25a0c">${esc(layer.down)}</text>` : '';
    return `
  <polygon points="${left + skew},${y} ${left + skew + planeW},${y} ${left + planeW},${y + planeH} ${left},${y + planeH}" fill="${shade}" stroke="#2f6fc4" stroke-width="1.5"/>
  <text x="${left + skew + 22}" y="${y + 28}" font-size="19" font-weight="800" fill="#123b6b">${esc(layer.name)}</text>
  <text x="${left + skew + 22}" y="${y + 48}" font-size="14" font-style="italic" fill="#2c4f7a">${esc(layer.question)}</text>
  ${chips}${arrow}`;
  }).join('');
  const groups = OVERVIEW.groups.map(({ label, from, to }) => {
    const y1 = top + from * (planeH + gap);
    const y2 = top + to * (planeH + gap) + planeH;
    const mid = (y1 + y2) / 2;
    return `<line x1="${left - 40}" y1="${y1}" x2="${left - 40}" y2="${y2}" stroke="#2f6fc4" stroke-width="3"/>
  <text transform="translate(${left - 56} ${mid}) rotate(-90)" text-anchor="middle" font-size="16" font-weight="800" fill="#123b6b">${esc(label)}</text>`;
  }).join('\n  ');
  const bandTop = top - 10;
  const bandBottom = top + (OVERVIEW.layers.length - 1) * (planeH + gap) + planeH + 10;
  const disciplines = OVERVIEW.disciplines.map(({ name, elements }, index) => {
    const y = bandTop + 78 + index * ((bandBottom - bandTop - 96) / OVERVIEW.disciplines.length);
    return `<text x="${bandX + 20}" y="${y}" font-size="16" font-weight="800" fill="#ffffff">${esc(name)}</text>
  <text x="${bandX + 20}" y="${y + 20}" font-size="12.5" fill="#fde7e6">${esc(elements.join(' · '))}</text>`;
  }).join('\n  ');
  const links = OVERVIEW.layers.map((layer, index) => {
    const y = top + index * (planeH + gap) + planeH / 2;
    return `<line x1="${bandX - 6}" y1="${y}" x2="${left + planeW + skew / 2 + 8}" y2="${y}" stroke="#c7433f" stroke-width="2" stroke-dasharray="6 5" marker-end="url(#red)"/>
  <text x="${(bandX + left + planeW + skew / 2) / 2 + 2}" y="${y - 8}" text-anchor="middle" font-size="12" font-style="italic" fill="#a12e2a">${esc(layer.assurance)}</text>`;
  }).join('\n  ');
  return `<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ${width} ${height}" width="${width}" height="${height}" font-family="Nunito, 'Segoe UI', Arial, sans-serif" role="img" aria-label="MEMO's architecture layers, stacked, with the assurance disciplines across them">
<defs>
  <marker id="orange" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#e07a1f"/></marker>
  <marker id="red" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="8" markerHeight="8" orient="auto-start-reverse"><path d="M0,0 L10,5 L0,10 z" fill="#c7433f"/></marker>
</defs>
<rect width="100%" height="100%" fill="#ffffff"/>
<text x="${left + skew}" y="${top - 26}" font-size="15" font-weight="800" fill="#123b6b">ARCHITECTURE LAYERS · the device, from purpose to deployment</text>
  ${groups}
  ${planes}
<rect x="${bandX}" y="${bandTop}" width="270" height="${bandBottom - bandTop}" rx="14" fill="#c7433f"/>
<text x="${bandX + 20}" y="${bandTop + 28}" font-size="15" font-weight="800" fill="#ffffff">ASSURANCE · across every layer</text>
  ${disciplines}
  ${links}
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
for (const layer of OVERVIEW.layers) {
  for (const name of layer.elements) check(`overview ${layer.name}`, byName.has(name), `${name} is not a definition the ontology declares`);
}
for (const { name, elements } of OVERVIEW.disciplines) {
  for (const element of elements) check(`overview ${name}`, byName.has(element), `${element} is not a definition the ontology declares`);
}
if (problems.length) {
  console.error(`Ontology figures do not match the source:\n  ${problems.join('\n  ')}`);
  process.exit(1);
}

mkdirSync(output, { recursive: true });
writeFileSync(join(output, 'overview-layers.svg'), renderOverview());
for (const figure of LAYER_FIGURES) {
  figure.steps.forEach((_, index) => writeFileSync(join(output, `${figure.id}-step${index + 1}.svg`), renderStep(figure, index)));
  writeFileSync(join(output, `${figure.id}.svg`), renderStep(figure, figure.steps.length - 1, true));
}
console.log(`Generated ontology figures: overview and ${LAYER_FIGURES.length} layer(s).`);
