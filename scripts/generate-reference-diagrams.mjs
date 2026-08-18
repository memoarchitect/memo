import { mkdirSync, writeFileSync } from 'node:fs';
import { join } from 'node:path';
import { fileURLToPath } from 'node:url';

const root = fileURLToPath(new URL('../', import.meta.url));
const output = join(root, 'docs', 'assets', 'reference');
mkdirSync(output, { recursive: true });

const esc = (value) => String(value)
  .replaceAll('&', '&amp;')
  .replaceAll('<', '&lt;')
  .replaceAll('>', '&gt;')
  .replaceAll('"', '&quot;');

const text = (x, y, label, { size = 22, weight = 700, fill = '#0b2b49', anchor = 'middle' } = {}) => {
  const lines = String(label).split('\n');
  const start = y - ((lines.length - 1) * size * 0.58);
  return `<text x="${x}" y="${start}" text-anchor="${anchor}" font-family="Nunito, Arial, sans-serif" font-size="${size}" font-weight="${weight}" fill="${fill}">${lines.map((line, index) => `<tspan x="${x}" dy="${index ? size * 1.16 : 0}">${esc(line)}</tspan>`).join('')}</text>`;
};

const group = (x, y, width, height, title, accent) => `
  <rect x="${x}" y="${y}" width="${width}" height="${height}" rx="24" fill="#f7fafc" stroke="${accent}" stroke-width="2"/>
  <rect x="${x}" y="${y}" width="${width}" height="58" rx="24" fill="${accent}"/>
  <rect x="${x}" y="${y + 34}" width="${width}" height="24" fill="${accent}"/>
  ${text(x + 24, y + 38, title, { size: 22, weight: 850, fill: '#ffffff', anchor: 'start' })}`;

const node = (x, y, width, height, label, accent, fill = '#ffffff') => `
  <rect x="${x}" y="${y}" width="${width}" height="${height}" rx="14" fill="${fill}" stroke="${accent}" stroke-width="2"/>
  ${text(x + width / 2, y + height / 2 + 7, label, { size: 19, weight: 750 })}`;

// Nunito at the given size/weight, in px per character — measured against
// this font's own metrics, not assumed. A hand-picked pixel width silently
// overflows the moment a label is longer than whoever wrote it expected;
// every box in this file is sized from this instead.
const charWidth = (size, weight) => size * (weight >= 850 ? 0.62 : weight >= 750 ? 0.58 : weight >= 700 ? 0.55 : 0.5);
const measureText = (label, size, weight) => Math.max(...String(label).split('\n').map((line) => line.length)) * charWidth(size, weight);

// A leaf element box, width computed from its own label so it can never
// overflow into a neighbor. Returns { svg, width } so callers can flow
// several in a row.
const autoNode = (x, y, label, accent, { height = 64, minWidth = 120, fill = '#ffffff', size = 19, weight = 750, padding = 36 } = {}) => {
  const width = Math.max(minWidth, Math.ceil(measureText(label, size, weight) + padding));
  return { svg: node(x, y, width, height, label, accent, fill), width, height };
};

// Flow a row of leaf elements left to right with a fixed gap, each auto-
// sized to its own label. Returns { svg, right, bottom } — `right` is where
// the next thing may start, `bottom` is y + height, so a group box can be
// sized to its own content instead of guessed.
const layoutRow = (x, y, labels, accent, opts = {}) => {
  const { gap = 22, ...nodeOpts } = opts;
  let cx = x;
  let svg = '';
  let height = nodeOpts.height ?? 64;
  for (const label of labels) {
    const result = autoNode(cx, y, label, accent, nodeOpts);
    svg += result.svg;
    cx += result.width + gap;
    height = result.height;
  }
  return { svg, right: cx - gap, bottom: y + height };
};

// A parent→children containment tree, the same elbow-connector convention
// ARCADIA breakdown diagrams use (see DiagBreakdown.png in the MBSE method
// summary this page is modeled on): a trunk down from the parent, a bar, a
// branch down into each child. No box drawn around the group — the tree
// itself is what says "contained by".
const treeDown = (parentCx, parentBottom, children, accent) => {
  if (children.length === 0) return '';
  const midY = parentBottom + 26;
  const cxs = children.map((c) => c.x + c.width / 2);
  const left = Math.min(...cxs);
  const right = Math.max(...cxs);
  let svg = `<path d="M ${parentCx} ${parentBottom} L ${parentCx} ${midY}" fill="none" stroke="${accent}" stroke-width="2"/>`;
  if (left !== right) svg += `<path d="M ${left} ${midY} L ${right} ${midY}" fill="none" stroke="${accent}" stroke-width="2"/>`;
  for (const c of children) svg += `<path d="M ${c.x + c.width / 2} ${midY} L ${c.x + c.width / 2} ${c.y}" fill="none" stroke="${accent}" stroke-width="2"/>`;
  return svg;
};

// One relation per row: source box, labeled arrow, target box, every box
// auto-sized to its own label (see autoNode) so nothing can silently
// overflow into its neighbor. Stacking rows instead of one crossing-heavy
// diagram keeps each relation legible.
//
// Three end styles, never conflated:
//   - solid ${accent} box  = a type this page's own area owns.
//   - dashed lavender box  = untyped end (the relation accepts any element).
//   - solid grey box + a second, smaller line giving its real SysML package
//                       = a type a DIFFERENT area owns (most often
//                         `memo::core::common`). This area does not own that
//                         type, so it is never drawn as if it belongs here.
const relationRow = (y, accent, sourceLabel, relationLabel, targetLabel, { untypedSource = false, untypedTarget = false, sourcePackage, targetPackage } = {}) => {
  const rowHeight = 64;
  const endBox = (x, label, untyped, pkg) => {
    const width = pkg
      ? Math.ceil(Math.max(measureText(label, 16, 750), measureText(pkg, 10, 650)) + 36)
      : Math.ceil(measureText(label, 17, 700) + 36);
    const svg = pkg
      ? `<rect x="${x}" y="${y}" width="${width}" height="${rowHeight}" rx="12" fill="#f1f2f5" stroke="#7c8798" stroke-width="2"/>
      ${text(x + width / 2, y + 27, label, { size: 16, weight: 750 })}
      ${text(x + width / 2, y + 46, pkg, { size: 10, weight: 650, fill: '#7c8798' })}`
      : `<rect x="${x}" y="${y}" width="${width}" height="${rowHeight}" rx="12" fill="${untyped ? '#f3f2fb' : '#ffffff'}" stroke="${accent}" stroke-width="2" ${untyped ? 'stroke-dasharray="6 5"' : ''}/>
      ${text(x + width / 2, y + rowHeight / 2 + 6, label, { size: 17, weight: 700 })}`;
    return { svg, width };
  };
  const sx = 60;
  const source = endBox(sx, sourceLabel, untypedSource, sourcePackage);
  const targetWidth = endBox(0, targetLabel, untypedTarget, targetPackage).width;
  const tx = 1600 - 60 - targetWidth;
  const target = endBox(tx, targetLabel, untypedTarget, targetPackage);
  return `
  ${source.svg}
  ${target.svg}
  ${edge(sx + source.width, y + rowHeight / 2, tx, y + rowHeight / 2, relationLabel, { color: accent, labelY: y + rowHeight / 2 - 20 })}`;
};

const edge = (x1, y1, x2, y2, label = '', { color = '#536b7a', dashed = false, labelX, labelY } = {}) => {
  const mx = labelX ?? (x1 + x2) / 2;
  const my = labelY ?? (y1 + y2) / 2;
  const labelWidth = Math.max(82, label.length * 9.2 + 22);
  return `
  <path d="M ${x1} ${y1} L ${x2} ${y2}" fill="none" stroke="${color}" stroke-width="2.4" ${dashed ? 'stroke-dasharray="8 7"' : ''} marker-end="url(#arrow)"/>
  ${label ? `<rect x="${mx - labelWidth / 2}" y="${my - 18}" width="${labelWidth}" height="28" rx="14" fill="#ffffff" stroke="#d8e2e9"/><text x="${mx}" y="${my + 2}" text-anchor="middle" font-family="JetBrains Mono, monospace" font-size="13" font-weight="650" fill="#395467">${esc(label)}</text>` : ''}`;
};

const diagram = ({ title, subtitle, width = 1600, height, accent, body }) => `<?xml version="1.0" encoding="UTF-8"?>
<svg xmlns="http://www.w3.org/2000/svg" width="${width}" height="${height}" viewBox="0 0 ${width} ${height}" role="img" aria-labelledby="title desc">
  <title id="title">${esc(title)}</title>
  <desc id="desc">${esc(subtitle)}</desc>
  <defs>
    <marker id="arrow" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
      <path d="M 0 0 L 10 5 L 0 10 z" fill="#536b7a"/>
    </marker>
    <filter id="shadow" x="-10%" y="-10%" width="120%" height="130%"><feDropShadow dx="0" dy="8" stdDeviation="12" flood-color="#0b2b49" flood-opacity=".09"/></filter>
  </defs>
  <rect width="${width}" height="${height}" rx="28" fill="#ffffff"/>
  <rect x="0" y="0" width="${width}" height="92" rx="28" fill="#0b2b49"/>
  <rect x="0" y="64" width="${width}" height="28" fill="#0b2b49"/>
  ${text(44, 48, title, { size: 30, weight: 900, fill: '#ffffff', anchor: 'start' })}
  ${text(width - 44, 48, subtitle, { size: 17, weight: 650, fill: '#bcd1df', anchor: 'end' })}
  <g filter="url(#shadow)">${body}</g>
  <rect x="24" y="24" width="12" height="44" rx="6" fill="${accent}"/>
</svg>`;

const write = (name, spec) => writeFileSync(join(output, `${name}.svg`), diagram(spec));

// PILOT: Operational layer, redrawn from src/architecture/operational/**
// (2026-08-16). Three artifacts, not one: a nesting diagram with zero
// relation arrows, then relation arrows split into two small scoped
// diagrams, one relation per row so nothing crosses.
//
// Grouped by semantic role (people / context / mission / work / workflows /
// scenarios), not by raw sub-package — the earlier package-literal grouping
// buried the actual reading order. Containment (OperationalParticipant→User,
// OperationalWorkflow→its steps) is drawn as a parent/child TREE, the same
// elbow-connector convention ARCADIA breakdown diagrams use, not a box
// nested inside a box.
//
// `ArchitectureDescription`/`ModelKind`/`CorrespondenceRule` are declared in
// this area's `context::stakeholders` sub-package, but they describe the
// MODEL (ISO/IEC/IEEE 42010 architecture-description apparatus), not the
// device's operational world — they are set apart in their own group, in
// grey rather than the area accent, with that distinction stated rather than
// silently folded in as if they were operational-world content.
{
  const accent = '#6f42c1';
  const modelDescAccent = '#7c8798';
  const x0 = 40;
  const fullWidth = 1520;
  let y = 120;
  let body = '';

  const rowGroup = (title, groupAccent, rowY, labels, opts = {}) => {
    const row = layoutRow(x0 + 30, rowY, labels, groupAccent, opts);
    const height = row.bottom - y + 30;
    const width = Math.max(fullWidth, row.right - x0 + 30);
    body += group(x0, y, width, height, title, groupAccent) + row.svg;
    y += height + 30;
  };

  // People — who is in the operational world (native specialization: the
  // only concrete OperationalParticipant today is User).
  {
    const parentY = y + 90;
    const parent = autoNode(x0 + 30, parentY, 'OperationalParticipant (abstract)', accent);
    const childY = parentY + parent.height + 46;
    const child = autoNode(x0 + 30, childY, 'User', accent);
    const height = childY + child.height - y + 30;
    body += group(x0, y, fullWidth, height, 'People — context::actors', accent);
    body += parent.svg + child.svg;
    body += treeDown(x0 + 30 + parent.width / 2, parentY + parent.height, [{ x: x0 + 30, y: childY, width: child.width }], accent);
    y += height + 30;
  }

  // Context — where, and under what conditions, work happens.
  rowGroup('Context — context::use_context', accent, y + 90, ['UseContext', 'UseEnvironment']);

  // Mission and operational architecture — the ARCADIA-style enterprise
  // layer: what the operation is for, and who/what delivers it.
  rowGroup('Mission and operational architecture — structure', accent, y + 90, [
    'Mission', 'OperationalEntity', 'OperationalCapability', 'OperationalInteraction',
  ]);

  // Goals and work — what a use case, activity, or task sets out to do.
  rowGroup('Goals and work — use_cases, activities', accent, y + 90, [
    'UseCase', 'OperationalActivity', 'UserTask', 'TaskStep', 'TaskDifficultyAssessment',
  ]);

  // Workflows — OperationalWorkflow is composed of its steps and control
  // nodes (tree); WorkflowResource is referenced, not contained, so it sits
  // apart with no tree connector into it.
  {
    const parentY = y + 90;
    const parent = autoNode(x0 + 30, parentY, 'OperationalWorkflow', accent);
    const childY = parentY + parent.height + 46;
    const stepX = x0 + 30;
    const step = autoNode(stepX, childY, 'WorkflowStep', accent);
    const controlX = stepX + step.width + 60;
    const control = autoNode(controlX, childY, 'WorkflowControlNode', accent);
    const resourceX = controlX + control.width + 120;
    const resource = autoNode(resourceX, childY, 'WorkflowResource', accent, { fill: '#fbfbfe' });
    const height = childY + step.height - y + 30;
    body += group(x0, y, fullWidth, height, 'Workflows — workflows', accent);
    body += parent.svg + step.svg + control.svg + resource.svg;
    body += treeDown(x0 + 30 + parent.width / 2, parentY + parent.height, [
      { x: stepX, y: childY, width: step.width },
      { x: controlX, y: childY, width: control.width },
    ], accent);
    body += text(resourceX + resource.width / 2, childY - 12, 'referenced, not contained', { size: 12, weight: 650, fill: '#7c8798' });
    y += height + 30;
  }

  // Scenarios — a selected path through a workflow, and an execution of one.
  rowGroup('Scenarios — scenarios', accent, y + 90, ['MemoScenario (operative)', 'ScenarioOccurrence']);

  // Set apart: model description, not operational-world content.
  {
    const rowY = y + 96;
    const row = layoutRow(x0 + 30, rowY, ['ArchitectureDescription', 'ModelKind', 'CorrespondenceRule'], modelDescAccent);
    const height = row.bottom - y + 34;
    body += group(x0, y, fullWidth, height, 'Model description (ISO/IEC/IEEE 42010) — not operational-world content', modelDescAccent);
    body += text(x0 + 30, y + 74, 'Declared in context::stakeholders, but these describe the MODEL — closer to Viewpoints than to the device\'s operational world.', { size: 13, weight: 600, fill: '#7c8798', anchor: 'start' });
    body += row.svg;
    y += height + 30;
  }

  write('architecture-operational-nesting', {
    title: 'Operational elements — nesting', subtitle: 'containment and specialization only, no relation arrows', height: y - 30, accent,
    body,
  });
}

{
  const accent = '#6f42c1';
  let y = 140;
  let body = '';
  const addRow = (source, relation, target, opts) => {
    body += relationRow(y, accent, source, relation, target, opts);
    y += 80;
  };
  addRow('MemoPart', 'Governs', 'MemoPart', { sourcePackage: 'memo::core::common', targetPackage: 'memo::core::common' });
  addRow('MemoPart', 'InteractsInContext', 'any element', { sourcePackage: 'memo::core::common', untypedTarget: true });
  addRow('OperationalParticipant', 'InteractsWith', 'any element', { untypedTarget: true });
  addRow('UseContext', 'AppliesInContext', 'MemoPart', { targetPackage: 'memo::core::common' });
  addRow('UseContext', 'SituatedIn', 'UseEnvironment');
  addRow('TaskDifficultyAssessment', 'AssessesDifficulty', 'UserTask');
  write('architecture-operational-relations-context', {
    title: 'Operational relations — context', subtitle: 'grey = owned by another area, dashed lavender = untyped (any element)', height: y - 16, accent,
    body,
  });
}

{
  const accent = '#6f42c1';
  let y = 140;
  let body = '';
  const addRow = (source, relation, target, opts) => {
    body += relationRow(y, accent, source, relation, target, opts);
    y += 80;
  };
  addRow('Need', 'Motivates', 'UseCase', { sourcePackage: 'memo::assurance::requirements::needs' });
  addRow('UseCase', 'Extends', 'UseCase');
  addRow('any action', 'Supports', 'MemoAction', { untypedSource: true, targetPackage: 'memo::core::common' });
  addRow('OperationalWorkflow', 'RequiresResource', 'WorkflowResource');
  addRow('MemoAction', 'Transforms', 'MemoAction', { sourcePackage: 'memo::core::common', targetPackage: 'memo::core::common' });
  addRow('MemoScenario', 'Selects', 'step or flow (any)', { untypedTarget: true });
  addRow('ScenarioOccurrence', 'OccursDuring', 'UseContext');
  write('architecture-operational-relations-work', {
    title: 'Operational relations — use cases, workflows, scenarios', subtitle: 'grey = owned by another area, dashed lavender = untyped (any element)', height: y - 16, accent,
    body,
  });
}

write('architecture-functional-elements', {
  title: 'Functional elements', subtitle: 'required behavior without implementation choices', height: 880, accent: '#1769d2',
  body: `
    ${group(40, 120, 1520, 390, 'Functions, exchanges, flows, and scenarios', '#1769d2')}
    ${node(85, 205, 200, 68, 'SystemFunction', '#1769d2')}${node(380, 205, 220, 68, 'FunctionalExchange', '#1769d2')}${node(695, 205, 200, 68, 'SystemFunction', '#1769d2')}
    ${edge(285, 239, 380, 239, 'sourceFunction ref')}${edge(600, 239, 695, 239, 'targetFunction ref')}
    ${node(85, 330, 200, 68, 'SystemAction', '#1769d2')}${edge(185, 330, 185, 273, 'performedFunction ref', { labelX: 295, labelY: 305 })}
    ${node(970, 205, 200, 68, 'FunctionalFlow', '#1769d2')}${node(1270, 205, 225, 68, 'FunctionalFlowStep', '#1769d2')}${edge(1170, 239, 1270, 239, 'IncludesStep')}
    ${node(970, 330, 220, 68, 'MemoScenario (functional)', '#1769d2')}${edge(1080, 330, 1080, 273, 'selectedFlow ref', { labelX: 1170, labelY: 305 })}

    ${group(40, 550, 1520, 260, 'Behavior and verifiable properties', '#1769d2')}
    ${node(85, 650, 190, 68, 'StateMachine', '#1769d2')}${node(355, 650, 170, 68, 'ModeState', '#1769d2')}${node(605, 650, 170, 68, 'Transition', '#1769d2')}${node(855, 650, 210, 68, 'BehaviorProperty', '#1769d2')}${node(1145, 650, 160, 68, 'Contract', '#1769d2')}${node(1385, 650, 140, 68, 'TimingConstraint', '#1769d2')}
    ${edge(525, 684, 605, 684, 'source / target state')}
  `,
});

write('architecture-logical-elements', {
  title: 'Logical elements', subtitle: 'technology-independent components and interfaces', height: 930, accent: '#008a8a',
  body: `
    ${group(40, 120, 1520, 390, 'Component interaction', '#008a8a')}
    ${node(85, 220, 220, 70, 'LogicalComponent', '#008a8a')}${node(400, 220, 210, 70, 'LogicalConnector', '#008a8a')}${node(705, 220, 220, 70, 'LogicalComponent', '#008a8a')}
    ${edge(305, 255, 400, 255)}${edge(610, 255, 705, 255)}
    ${node(85, 350, 190, 68, 'LogicalPort', '#008a8a')}${node(360, 350, 210, 68, 'LogicalInterface', '#008a8a')}${node(655, 350, 190, 68, 'LogicalPort', '#008a8a')}
    ${edge(275, 384, 360, 384, 'providerPort')}${edge(570, 384, 655, 384, 'consumerPort')}
    ${node(1010, 220, 200, 70, 'LogicalExchange', '#008a8a')}${node(1305, 220, 210, 70, 'LogicalExchangeItem', '#008a8a')}${edge(1210, 255, 1305, 255, 'exchangedItem ref')}
    ${node(1010, 350, 200, 68, 'LogicalMode', '#008a8a')}${edge(925, 255, 1010, 384, 'ExhibitsMode', { labelX: 1015, labelY: 315 })}

    ${group(40, 550, 930, 300, 'Reusable interface definitions', '#008a8a')}
    ${node(85, 650, 190, 66, 'MemoInterface', '#008a8a')}${node(355, 620, 175, 66, 'Interface', '#008a8a')}${node(355, 730, 175, 66, 'DataInterface', '#008a8a')}
    ${edge(275, 683, 355, 653, 'specialized by')}${edge(275, 683, 355, 763, 'specialized by')}
    ${node(610, 620, 170, 66, 'DataPort', '#008a8a')}${node(830, 590, 110, 66, 'SensorPort', '#008a8a')}${node(830, 700, 110, 66, 'CommandPort', '#008a8a')}
    ${edge(830, 623, 780, 653, 'specializes')}${edge(830, 733, 780, 653, 'specializes')}

    ${group(1010, 550, 550, 300, 'Boundaries and containment', '#008a8a')}
    ${node(1050, 650, 215, 70, 'IsolationBoundary', '#008a8a')}${node(1305, 650, 215, 70, 'FaultContainmentRegion', '#008a8a')}
  `,
});

write('architecture-implementation-elements', {
  title: 'Implementation elements', subtitle: 'software, hardware, and user-interface design', height: 1280, accent: '#ed6c02',
  body: `
    ${group(40, 120, 1520, 300, 'Software structure and runtime', '#ed6c02')}
    ${node(60, 205, 200, 68, 'SoftwareSystem', '#ed6c02')}${node(330, 205, 200, 68, 'SoftwareModule', '#ed6c02')}${node(680, 205, 200, 68, 'SoftwareModule', '#ed6c02')}${edge(530, 239, 680, 239, 'ModuleUses')}
    ${node(1010, 205, 210, 68, 'SoftwareComponent', '#ed6c02')}${node(1370, 205, 190, 68, 'SoftwareComponent', '#ed6c02')}${edge(1220, 239, 1370, 239, 'ComponentConnects')}
    ${node(330, 320, 150, 62, 'Algorithm', '#ed6c02')}${node(530, 320, 160, 62, 'DataModel', '#ed6c02')}${node(740, 320, 230, 62, 'ConfigurationArtifact', '#ed6c02')}${node(1020, 320, 150, 62, 'SBOMEntry', '#ed6c02')}

    ${group(40, 460, 1520, 300, 'Hardware', '#ed6c02')}
    ${node(60, 555, 220, 68, 'PhysicalAssembly', '#ed6c02')}${node(430, 525, 230, 68, 'PhysicalSubassembly', '#ed6c02')}${node(430, 645, 230, 68, 'HardwareAssembly', '#ed6c02')}
    ${edge(430, 559, 280, 589, 'specializes')}${edge(430, 679, 280, 589, 'specializes')}
    ${node(760, 555, 220, 68, 'PhysicalComponent', '#ed6c02')}${node(1130, 510, 390, 62, 'Electrical · Mechanical', '#ed6c02')}${node(1130, 595, 390, 62, 'Fluidic · Optical', '#ed6c02')}${node(1130, 680, 390, 62, 'Sensor · Actuator', '#ed6c02')}
    ${edge(1130, 541, 980, 589, 'specialize')}${edge(1130, 626, 980, 589, 'specialize')}${edge(1130, 711, 980, 589, 'specialize')}

    ${group(40, 800, 1520, 400, 'User interface and interaction', '#ed6c02')}
    ${node(60, 900, 200, 68, 'UserInterface', '#ed6c02')}${node(390, 900, 170, 68, 'UIState', '#ed6c02')}${edge(260, 934, 390, 934, 'PresentsState')}
    ${node(650, 900, 170, 68, 'UIElement', '#ed6c02')}${node(990, 900, 170, 68, 'UIAction', '#ed6c02')}${node(1350, 900, 190, 68, 'SystemFunction', '#ed6c02')}${edge(820, 934, 990, 934, 'ElementTriggersAction')}${edge(1160, 934, 1350, 934, 'ActionInvokesFunction')}
    ${node(60, 1055, 190, 68, 'MemoScenario (ui)', '#ed6c02')}${node(380, 1055, 210, 68, 'InteractionFlow', '#ed6c02')}${node(720, 1055, 170, 68, 'UseCase', '#ed6c02')}${edge(250, 1089, 380, 1089, 'parentFlow ref')}${edge(590, 1089, 720, 1089, 'FlowServesUseCase')}
    ${node(1050, 1055, 170, 68, 'UIEvent', '#ed6c02')}${node(1320, 1055, 190, 68, 'UIContainer', '#ed6c02')}
  `,
});

write('architecture-realization-elements', {
  title: 'Realization elements', subtitle: 'physical execution, deployment, and end-to-end flow', height: 760, accent: '#294a73',
  body: `
    ${group(40, 120, 1520, 300, 'Deployment', '#294a73')}
    ${node(80, 225, 210, 70, 'SoftwareModule', '#294a73')}${node(390, 225, 220, 70, 'DeploymentUnit', '#294a73')}${node(710, 225, 220, 70, 'ProcessingNode', '#294a73')}${node(1030, 225, 230, 70, 'RuntimeEnvironment', '#294a73')}
    ${edge(290, 260, 390, 260, 'BuildsInto')}${edge(610, 260, 710, 260, 'DeploysTo')}${edge(930, 260, 1030, 260, 'ProvidesEnvironment')}
    ${node(710, 335, 190, 60, 'MemoryDevice', '#294a73')}${node(970, 335, 180, 60, 'PhysicalPort', '#294a73')}

    ${group(40, 460, 1520, 230, 'Realized flow', '#294a73')}
    ${node(90, 555, 210, 70, 'EndToEndFlow', '#294a73')}${node(410, 555, 220, 70, 'FlowSpecification', '#294a73')}${node(740, 555, 220, 70, 'DeploymentUnit', '#294a73')}${node(1070, 555, 220, 70, 'ProcessingNode', '#294a73')}
    ${edge(300, 590, 410, 590, 'FlowComprisesSpec')}${edge(630, 590, 740, 590, 'FlowTraversesBinding')}${edge(960, 590, 1070, 590, 'hostNodes ref')}
  `,
});

write('core-elements', {
  title: 'Core elements', subtitle: 'shared foundations used by every ontology area', height: 850, accent: '#0a9b83',
  body: `
    ${group(40, 120, 1520, 280, 'Common foundations', '#0a9b83')}
    ${node(75, 215, 190, 68, 'MemoPart', '#0a9b83')}${node(330, 215, 190, 68, 'MemoAction', '#0a9b83')}${node(585, 215, 220, 68, 'MemoRequirement', '#0a9b83')}${node(870, 215, 190, 68, 'MemoEvidence', '#0a9b83')}${node(1125, 215, 200, 68, 'MemoInterface', '#0a9b83')}${node(1385, 215, 140, 68, 'MemoPort', '#0a9b83')}
    ${node(75, 315, 220, 60, 'VerifiableElement', '#0a9b83')}${node(360, 315, 220, 60, 'DocumentedElement', '#0a9b83')}${node(645, 315, 220, 60, 'MemoExchangeItem', '#0a9b83')}${node(930, 315, 220, 60, 'MemoVerificationCase', '#0a9b83')}

    ${group(40, 450, 730, 320, 'Meaning and classification', '#0a9b83')}
    ${node(80, 550, 190, 64, 'Dimensions', '#0a9b83')}${node(320, 550, 190, 64, 'Enumerations', '#0a9b83')}${node(560, 550, 170, 64, 'Semantics', '#0a9b83')}
    ${node(80, 660, 200, 64, 'TerminologyCode', '#0a9b83')}${node(330, 660, 200, 64, 'StandardReference', '#0a9b83')}${node(580, 660, 150, 64, 'Provenance', '#0a9b83')}

    ${group(820, 450, 740, 320, 'Shared connections and project support', '#0a9b83')}
    ${node(860, 550, 210, 64, 'MemoRelationship', '#0a9b83')}${node(1120, 550, 180, 64, 'MemoLink', '#0a9b83')}${node(1350, 550, 170, 64, 'Citation', '#0a9b83')}
    ${node(860, 660, 210, 64, 'MethodologyScope', '#0a9b83')}${node(1120, 660, 210, 64, 'ConsistencyRule', '#0a9b83')}${node(1380, 660, 140, 64, 'stdlib', '#0a9b83')}
  `,
});

write('assurance-elements', {
  title: 'Assurance elements', subtitle: 'requirements, analysis, control, verification, and evidence', height: 1160, accent: '#7657b7',
  body: `
    ${group(40, 120, 730, 250, 'Requirements', '#7657b7')}
    ${node(80, 220, 180, 68, 'Need', '#7657b7')}${node(340, 220, 200, 68, 'Requirement', '#7657b7')}${node(610, 220, 120, 68, 'SecurityRequirement', '#7657b7')}
    ${edge(260, 254, 340, 254, 'DerivesFrom')}

    ${group(820, 120, 740, 250, 'Verification and validation', '#7657b7')}
    ${node(860, 220, 210, 68, 'VerificationCase', '#7657b7')}${node(1130, 220, 190, 68, 'ValidationCase', '#7657b7')}${node(1380, 220, 140, 68, 'Evidence', '#7657b7')}
    ${edge(1070, 254, 1130, 254, 'complements')}${edge(1320, 254, 1380, 254, 'ProducesEvidence')}

    ${group(40, 420, 1520, 330, 'Safety and risk', '#7657b7')}
    ${node(70, 535, 160, 68, 'HazardCause', '#7657b7')}${node(280, 535, 140, 68, 'Hazard', '#7657b7')}${node(470, 535, 205, 68, 'SequenceOfEvents', '#7657b7')}${node(725, 535, 220, 68, 'HazardousSituation', '#7657b7')}${node(995, 535, 120, 68, 'Harm', '#7657b7')}${node(1165, 535, 120, 68, 'Risk', '#7657b7')}${node(1335, 535, 190, 68, 'RiskControlMeasure', '#7657b7')}
    ${edge(230, 569, 280, 569)}${edge(420, 569, 470, 569)}${edge(675, 569, 725, 569)}${edge(945, 569, 995, 569)}${edge(1115, 569, 1165, 569)}${edge(1285, 569, 1335, 569, 'Mitigates')}
    ${node(280, 650, 170, 60, 'ResidualRisk', '#7657b7')}${node(520, 650, 130, 60, 'Benefit', '#7657b7')}${node(720, 650, 300, 60, 'OverallResidualRiskEvaluation', '#7657b7')}

    ${group(40, 800, 730, 290, 'Cybersecurity and human factors', '#7657b7')}
    ${node(80, 900, 210, 64, 'CybersecurityAsset', '#7657b7')}${node(340, 900, 130, 64, 'Threat', '#7657b7')}${node(520, 900, 170, 64, 'Vulnerability', '#7657b7')}
    ${node(80, 995, 180, 64, 'CyberMitigation', '#7657b7')}${node(320, 995, 150, 64, 'UseError', '#7657b7')}${node(520, 995, 170, 64, 'UsabilityValidation', '#7657b7')}

    ${group(820, 800, 740, 290, 'Safety analysis', '#7657b7')}
    ${node(860, 900, 170, 64, 'FailureMode', '#7657b7')}${node(1080, 900, 170, 64, 'FailureCause', '#7657b7')}${node(1300, 900, 170, 64, 'FailureEffect', '#7657b7')}
    ${node(860, 995, 150, 64, 'FaultTree', '#7657b7')}${node(1060, 995, 190, 64, 'FaultTreeEvent', '#7657b7')}${node(1300, 995, 190, 64, 'MinimalCutSet', '#7657b7')}
  `,
});

write('artifacts-elements', {
  title: 'Artifact elements', subtitle: 'reusable classifications for model-backed outputs', height: 590, accent: '#d97904',
  body: `
    ${group(40, 120, 1520, 390, 'Artifact classification', '#d97904')}
    ${node(100, 265, 240, 76, 'ArtifactKindDef', '#d97904')}${node(470, 190, 240, 70, 'View artifact kinds', '#d97904')}${node(470, 310, 240, 70, 'Evidence artifact kinds', '#d97904')}${node(840, 190, 240, 70, 'Document artifact kinds', '#d97904')}${node(840, 310, 240, 70, 'Test artifact kinds', '#d97904')}${node(1210, 250, 250, 76, 'Methodology bindings', '#d97904')}
    ${edge(340, 303, 470, 225, 'classifies')}${edge(340, 303, 470, 345, 'classifies')}${edge(710, 225, 840, 225)}${edge(710, 345, 840, 345)}${edge(1080, 285, 1210, 288, 'selected by')}
  `,
});

write('compliance-elements', {
  title: 'Compliance elements', subtitle: 'controlled records and document-oriented model content', height: 760, accent: '#0f7e8d',
  body: `
    ${group(40, 120, 1520, 560, 'Controlled content', '#0f7e8d')}
    ${node(80, 240, 230, 72, 'ControlledArtifact', '#0f7e8d')}${node(410, 190, 220, 72, 'ChangeRequest', '#0f7e8d')}${node(410, 310, 220, 72, 'ConfigurationItem', '#0f7e8d')}
    ${node(760, 190, 240, 72, 'Document views', '#0f7e8d')}${node(760, 310, 240, 72, 'RiskManagementFile', '#0f7e8d')}
    ${node(1130, 190, 220, 72, 'ClinicalEvaluation', '#0f7e8d')}${node(1130, 310, 270, 72, 'PostMarketSurveillance', '#0f7e8d')}
    ${edge(310, 276, 410, 226, 'Changes')}${edge(310, 276, 410, 346, 'controls')}${edge(630, 226, 760, 226, 'recorded by')}${edge(630, 346, 760, 346, 'IncludedIn')}${edge(1000, 226, 1130, 226, 'supports')}${edge(1000, 346, 1130, 346, 'supports')}
    ${node(410, 500, 260, 68, 'Architecture content', '#0f7e8d')}${node(760, 500, 230, 68, 'Assurance evidence', '#0f7e8d')}${edge(670, 534, 760, 534, 'ProducesEvidence')}
  `,
});

write('viewpoints-elements', {
  title: 'Viewpoint elements', subtitle: 'selection and presentation of existing model content', height: 780, accent: '#3f7db6',
  body: `
    ${group(40, 120, 1520, 580, 'Concern to view', '#3f7db6')}
    ${node(80, 245, 190, 70, 'Stakeholder', '#3f7db6')}${node(370, 245, 170, 70, 'Concern', '#3f7db6')}${node(650, 245, 190, 70, 'Viewpoint', '#3f7db6')}${node(950, 245, 190, 70, 'MemoView', '#3f7db6')}${node(1250, 245, 240, 70, 'Selected model content', '#3f7db6')}
    ${edge(270, 280, 370, 280, 'HasConcern')}${edge(540, 280, 650, 280, 'FramesConcern')}${edge(840, 280, 950, 280, 'governs')}${edge(1140, 280, 1250, 280, 'includes')}
    ${node(370, 405, 230, 68, 'ViewSelectionQuery', '#3f7db6')}${node(650, 405, 220, 68, 'ViewInclusionRule', '#3f7db6')}${edge(600, 439, 650, 439)}
    ${node(950, 405, 210, 68, 'MemoDiagramView', '#3f7db6')}${node(1230, 405, 260, 68, 'MemoDocumentBackedView', '#3f7db6')}
    ${node(370, 545, 240, 68, 'Viewpoint catalog', '#3f7db6')}${node(690, 545, 230, 68, 'Concern-specific views', '#3f7db6')}${node(1000, 545, 240, 68, 'Diagram intent', '#3f7db6')}${node(1320, 545, 170, 68, 'Document intent', '#3f7db6')}
  `,
});

write('methodology-elements', {
  title: 'Methodology elements', subtitle: 'selection and governance of ontology use on a project', height: 850, accent: '#4d9a57',
  body: `
    ${group(40, 120, 1520, 650, 'Method resolution and project use', '#4d9a57')}
    ${node(80, 220, 260, 72, 'MethodologyDefinition', '#4d9a57')}${node(450, 180, 220, 64, 'Selected modules', '#4d9a57')}${node(450, 270, 220, 64, 'Selected viewpoints', '#4d9a57')}${node(450, 360, 220, 64, 'Selected rules', '#4d9a57')}
    ${edge(340, 256, 450, 212)}${edge(340, 256, 450, 302)}${edge(340, 256, 450, 392)}
    ${node(790, 270, 260, 72, 'ResolvedMethodology', '#4d9a57')}${edge(670, 302, 790, 306, 'resolves')}
    ${node(1170, 270, 260, 72, 'ProjectMethodBinding', '#4d9a57')}${edge(1050, 306, 1170, 306, 'applies')}
    ${node(80, 520, 180, 68, 'Archetype', '#4d9a57')}${node(320, 520, 210, 68, 'ModelingPattern', '#4d9a57')}${node(590, 520, 220, 68, 'ElementUsageRule', '#4d9a57')}${node(870, 520, 210, 68, 'WorkflowStep', '#4d9a57')}${node(1140, 520, 190, 68, 'QualityGate', '#4d9a57')}${node(1370, 520, 150, 68, 'DHF binding', '#4d9a57')}
    ${node(450, 650, 260, 68, 'Extension module', '#4d9a57')}${edge(580, 650, 580, 430, 'includedModule', { labelX: 675, labelY: 620 })}
  `,
});

write('rules-elements', {
  title: 'Rule packages', subtitle: 'selectable SysML constraints evaluated against a project model', height: 700, accent: '#7d61c8',
  body: `
    ${group(40, 120, 1520, 500, 'Constraint families', '#7d61c8')}
    ${node(80, 220, 200, 70, 'Closure', '#7d61c8')}${node(340, 220, 200, 70, 'Coverage', '#7d61c8')}${node(600, 220, 200, 70, 'Cross-layer', '#7d61c8')}${node(860, 220, 200, 70, 'Lifecycle', '#7d61c8')}${node(1120, 220, 200, 70, 'Ontology', '#7d61c8')}${node(1380, 220, 140, 70, 'Quantitative', '#7d61c8')}
    ${node(80, 390, 240, 68, 'Methodology selection', '#7d61c8')}${node(450, 390, 220, 68, 'Project model', '#7d61c8')}${node(800, 390, 220, 68, 'Constraint result', '#7d61c8')}${node(1150, 390, 260, 68, 'Quality gate evidence', '#7d61c8')}
    ${edge(320, 424, 450, 424, 'selects')}${edge(670, 424, 800, 424, 'evaluates')}${edge(1020, 424, 1150, 424, 'records')}
  `,
});

console.log('Generated reference diagrams.');
