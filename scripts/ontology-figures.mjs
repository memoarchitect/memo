// ─── What the ontology figures show ─────────────────────────────────────────
//
// Read by scripts/generate-ontology-figures.mjs, which checks every name here
// against src/ before drawing. A layer figure is built in steps: step 1 is
// the layer's core, and each later step adds supporting elements, the way a
// reader should meet them. Nodes sit on a grid (col, row); an edge is one of
//
//   { rel: 'RelationshipName' }   a MEMO relationship, ends checked
//   { native: 'allocate' }        a native SysML relationship
//   { ref: 'featureName' }        a typed reference feature of the source
//   { contains: true }            native containment, owner first

// The overview: each architecture layer and assurance discipline names the
// folder of src/ it lives in, and the generator draws every element definition
// declared there; the links that carry the work down to the next layer, and the
// links the assurance disciplines reach into each layer with, are listed here. A link is { from, rel | native, to } and is
// checked like an edge: a MEMO relationship's declared ends must accept the
// definitions named. `to` may list several targets the same link accepts.
export const OVERVIEW = {
  layers: [
    {
      id: 'operational',
      name: 'Operational',
      group: 'Understanding the need',
      question: 'Why does the device exist, for whom, in what setting?',
      folder: 'architecture/operational',
      down: [{ from: 'OperativeAction', native: 'perform', to: ['SystemFunction'] }],
      assurance: [
        { from: 'Need', rel: 'Motivates', to: ['ClinicalUseCase'] },
        { from: 'OperativeAction', rel: 'CommitsUseError', to: ['UseError'] },
        { from: 'OperativeAction', rel: 'Validates', to: ['ValidationCase'] },
      ],
    },
    {
      id: 'functional',
      name: 'Functional',
      question: 'What must the system do?',
      folder: 'architecture/functional',
      down: [{ from: 'ComponentFunction', native: 'allocate', to: ['LogicalComponent'] }],
      assurance: [
        { from: 'Requirement', native: 'satisfy', to: ['SystemFunction'] },
        { from: 'VerificationCase', native: 'subject', to: ['SystemFunction'] },
      ],
    },
    {
      id: 'logical',
      name: 'Logical',
      group: 'Designing the solution',
      question: 'How is the solution organised, before choosing a technology?',
      folder: 'architecture/logical',
      down: [{ from: 'LogicalComponent', rel: 'RealizedBy', to: ['SoftwareSystem', 'HardwareAssembly'] }],
      assurance: [
        { from: 'Requirement', native: 'satisfy', to: ['LogicalComponent'] },
        { from: 'TrustBoundary', rel: 'CrossesTrustBoundary', to: ['ComponentExchange'] },
      ],
    },
    {
      id: 'implementation',
      name: 'Implementation',
      question: 'What is it built from?',
      folder: 'architecture/implementation',
      down: [
        { from: 'SoftwareModule', rel: 'BuildsInto', to: ['SoftwareDeploymentUnit'] },
        { from: 'SoftwareComponent', rel: 'MemoryBinding', to: ['MemoryDevice'] },
      ],
      assurance: [
        { from: 'RiskControlMeasure', rel: 'ControlImplementedBy', to: ['UIElement'] },
        { from: 'UseError', rel: 'ErrorAtElement', to: ['UIElement'] },
        { from: 'HardwareComponent', rel: 'HasFailureMode', to: ['FailureMode'] },
      ],
    },
    {
      id: 'realization',
      name: 'Realization',
      question: 'Where does it run, and how do its parts reach each other?',
      folder: 'architecture/realization',
      assurance: [
        { from: 'ProcessingNode', rel: 'HasFailureMode', to: ['FailureMode'] },
      ],
    },
  ],
  disciplines: [
    { id: 'requirements', name: 'Requirements', question: 'What must be true, and why?', folder: 'assurance/requirements', rootLabel: 'Requirements' },
    { id: 'safety-risk', name: 'Safety and risk', question: 'What can harm the patient or user, and what controls it?', folder: 'assurance/safety_risk', rootLabel: 'Risk' },
    { id: 'cybersecurity', name: 'Cybersecurity', question: 'What can an attacker reach, and what stops them?', folder: 'assurance/cybersecurity' },
    { id: 'human-factors', name: 'Human factors', question: 'Where can a user get it wrong?', folder: 'assurance/human_factors' },
    { id: 'verification-validation', name: 'Verification and validation', question: 'What shows it was built right, and is the right thing?', folder: 'assurance/verification_validation', rootLabel: 'Verification and validation' },
  ],
  foundations: [
    {
      id: 'stakeholders-concerns',
      name: 'Stakeholders and concerns',
      question: 'Who has a stake in the device, and what do they care about?',
      folder: 'viewpoints/stakeholders_concerns',
      groups: [
        { label: 'Stakeholders', base: 'MemoStakeholder' },
        { label: 'Concerns', base: 'MemoConcern' },
        { label: 'Quality attributes', base: 'MemoQualityAttribute' },
      ],
    },
  ],
};

export const LAYER_FIGURES = [
  {
    id: 'operational',
    title: 'Operational layer',
    steps: [
      {
        title: 'The work: a goal, the workflow that realises it, its scenarios, their actions',
        nodes: [
          { id: 'uc', type: 'UseCase', col: 2, row: 0 },
          { id: 'wf', type: 'OperationalWorkflow', col: 2, row: 1 },
          { id: 'sc', type: 'OperativeScenario', col: 2, row: 2 },
          { id: 'ac', type: 'OperativeAction', col: 2, row: 3 },
        ],
        edges: [
          { from: 'wf', to: 'uc', rel: 'RealizesUseCase' },
          { from: 'wf', to: 'sc', contains: true },
          { from: 'sc', to: 'ac', contains: true },
        ],
      },
      {
        title: 'Who and why: the users, the need behind the goal, the intended use',
        nodes: [
          { id: 'user', type: 'User', col: 3, row: 2 },
          { id: 'need', type: 'Need', col: 3, row: 0 },
          { id: 'iu', type: 'IntendedUse', col: 0, row: 0 },
          { id: 'cap', type: 'OperationalCapability', col: 1, row: 0 },
        ],
        edges: [
          { from: 'uc', to: 'user', native: 'actor' },
          { from: 'user', to: 'ac', native: 'perform' },
          { from: 'need', to: 'uc', rel: 'Motivates' },
          { from: 'iu', to: 'cap', rel: 'RequiresCapability' },
          { from: 'cap', to: 'uc', rel: 'EnablesUseCase' },
        ],
      },
      {
        title: 'Where: the context of use and its environment',
        nodes: [
          { id: 'ctx', type: 'UseContext', col: 1, row: 2 },
          { id: 'env', type: 'UseEnvironment', col: 0, row: 2 },
        ],
        edges: [
          { from: 'sc', to: 'ctx', ref: 'useContext' },
          { from: 'ctx', to: 'env', rel: 'SituatedIn' },
        ],
      },
      {
        title: 'Supporting detail: task difficulty',
        nodes: [
          { id: 'tda', type: 'TaskDifficultyAssessment', col: 1, row: 3 },
        ],
        edges: [
          { from: 'tda', to: 'ac', rel: 'AssessesDifficulty' },
        ],
      },
    ],
  },
  {
    id: 'functional',
    title: 'Functional layer',
    steps: [
      {
        title: 'The chain: a system function decomposes into component functions',
        nodes: [
          { id: 'sf', type: 'SystemFunction', col: 1, row: 0 },
          { id: 'cf', type: 'ComponentFunction', col: 1, row: 1 },
        ],
        edges: [{ from: 'sf', to: 'cf', contains: true }],
      },
      {
        title: 'Exchanges: a function passes something to another through a typed flow',
        nodes: [{ id: 'cf2', type: 'ComponentFunction', col: 2, row: 1 }],
        edges: [{ from: 'cf', to: 'cf2', native: 'flow' }],
      },
      {
        title: 'Obligations: behaviour properties and timing constraints are requirements the functions meet',
        nodes: [
          { id: 'bp', type: 'BehaviorProperty', col: 0, row: 2 },
          { id: 'tc', type: 'TimingConstraint', col: 2, row: 2 },
        ],
        edges: [
          { from: 'bp', to: 'sf', native: 'satisfy' },
          { from: 'tc', to: 'cf2', native: 'satisfy' },
        ],
      },
      {
        title: 'Behaviour and reuse: states and modes, a reusable route through responsibilities',
        nodes: [
          { id: 'sm', type: 'StateMachine', col: 0, row: 0 },
          { id: 'mc', type: 'ModeConfiguration', col: 0, row: 1 },
          { id: 'ff', type: 'FunctionalFlow', col: 2, row: 0 },
        ],
        edges: [
          { from: 'sm', to: 'mc', contains: true },
          { from: 'ff', to: 'sf', native: 'include' },
        ],
      },
    ],
  },
  {
    id: 'logical',
    title: 'Logical layer',
    steps: [
      {
        title: 'The hierarchy: a system, its subsystems, the components that make them up',
        nodes: [
          { id: 'sys', type: 'System', col: 1, row: 0 },
          { id: 'sub', type: 'Subsystem', col: 1, row: 1 },
          { id: 'lc', type: 'LogicalComponent', col: 1, row: 2 },
        ],
        edges: [
          { from: 'sys', to: 'sub', contains: true },
          { from: 'sub', to: 'lc', contains: true },
        ],
      },
      {
        title: 'Interfaces: components meet at their ports, over an exchange',
        nodes: [
          { id: 'lp', type: 'LogicalPort', col: 2, row: 2 },
          { id: 'lp2', type: 'LogicalPort', col: 3, row: 2 },
          { id: 'lc2', type: 'LogicalComponent', col: 3, row: 3 },
        ],
        edges: [
          { from: 'lc', to: 'lp', contains: true },
          { from: 'lc2', to: 'lp2', contains: true },
          { from: 'lp', to: 'lp2', rel: 'ComponentExchange' },
        ],
      },
      {
        title: 'Independence and boundaries: channels that claim independence, and where faults must stop',
        nodes: [
          { id: 'ib', type: 'IsolationBoundary', col: 0, row: 2 },
          { id: 'fcr', type: 'FaultContainmentRegion', col: 0, row: 3 },
        ],
        edges: [
          { from: 'lc2', to: 'lc', rel: 'IndependentOf' },
          { from: 'ib', to: 'lc', contains: true },
          { from: 'fcr', to: 'lc2', contains: true },
        ],
      },
      {
        title: 'State: the modes of the logical solution',
        nodes: [{ id: 'lb', type: 'LogicalBehavior', col: 2, row: 1 }],
        edges: [{ from: 'lc', to: 'lb', contains: true }],
      },
    ],
  },
  {
    id: 'implementation',
    title: 'Implementation layer',
    colWidth: 330,
    steps: [
      {
        title: 'Software: a logical component is realized by a module, inside a software system, with the task that runs it',
        nodes: [
          { id: 'ss', type: 'SoftwareSystem', col: 0, row: 0 },
          { id: 'lcP', type: 'LogicalComponent', col: 1, row: 0 },
          { id: 'task', type: 'SoftwareComponent', col: 0, row: 1 },
          { id: 'item', type: 'SoftwareModule', label: 'SoftwareModule (item)', col: 1, row: 1 },
          { id: 'req', type: 'Requirement', col: 0, row: 2 },
          { id: 'unit', type: 'SoftwareModule', label: 'SoftwareModule (unit)', col: 1, row: 2 },
        ],
        edges: [
          { from: 'lcP', to: 'item', rel: 'RealizedBy' },
          { from: 'ss', to: 'item', contains: true },
          { from: 'ss', to: 'task', contains: true },
          { from: 'item', to: 'unit', contains: true },
          { from: 'task', to: 'item', native: '#refinement' },
          { from: 'req', to: 'item', native: 'satisfy' },
        ],
      },
      {
        title: 'Hardware: a logical component is realized by an assembly, and the assembly holds the parts',
        nodes: [
          { id: 'lcS', type: 'LogicalComponent', col: 2, row: 0 },
          { id: 'ha', type: 'HardwareAssembly', col: 2, row: 1 },
          { id: 'emitter', type: 'OpticalComponent', col: 3, row: 1 },
          { id: 'sensor', type: 'Sensor', col: 2, row: 2 },
          { id: 'pad', type: 'HardwareComponent', col: 3, row: 2 },
        ],
        edges: [
          { from: 'lcS', to: 'ha', rel: 'RealizedBy' },
          { from: 'ha', to: 'emitter', contains: true },
          { from: 'ha', to: 'sensor', contains: true },
          { from: 'ha', to: 'pad', contains: true },
        ],
      },
      {
        title: 'User interface: what the user operates, and the action an element triggers',
        nodes: [
          { id: 'lcD', type: 'LogicalComponent', col: 4, row: 0 },
          { id: 'ui', type: 'UserInterface', col: 4, row: 1 },
          { id: 'screen', type: 'UIElement', label: 'UIElement (screen)', col: 4, row: 2 },
          { id: 'button', type: 'UIElement', label: 'UIElement (button)', col: 4, row: 3 },
          { id: 'uia', type: 'UIAction', col: 4, row: 4 },
          { id: 'fn', type: 'SystemFunction', col: 3, row: 4 },
        ],
        edges: [
          { from: 'lcD', to: 'ui', rel: 'RealizedBy' },
          { from: 'ui', to: 'screen', contains: true },
          { from: 'screen', to: 'button', contains: true },
          { from: 'button', to: 'uia', rel: 'ElementTriggersAction' },
          { from: 'uia', to: 'fn', native: 'perform' },
        ],
      },
      {
        title: 'Third-party software: a module depends on an off-the-shelf module, which the SBOM lists',
        nodes: [
          { id: 'ots', type: 'OTSSoftwareModule', col: 0, row: 3 },
          { id: 'entry', type: 'SBOMEntry', col: 0, row: 4 },
          { id: 'sbom', type: 'SoftwareBillOfMaterials', col: 1, row: 4 },
        ],
        edges: [
          { from: 'item', to: 'ots', rel: 'DependsOnSoup' },
          { from: 'sbom', to: 'entry', contains: true },
          { from: 'entry', to: 'ots', ref: 'inventoriedElement' },
        ],
      },
    ],
  },
  {
    id: 'realization',
    title: 'Realization layer',
    colWidth: 370,
    steps: [
      {
        title: 'The deployment chain: a module builds into a unit, the unit deploys to a node, the node is hosted by its board',
        nodes: [
          { id: 'sm', type: 'SoftwareModule', col: 0, row: 1 },
          { id: 'sdu', type: 'SoftwareDeploymentUnit', col: 1, row: 1 },
          { id: 'pn', type: 'ProcessingNode', col: 1, row: 2 },
          { id: 'board', type: 'HardwareAssembly', col: 2, row: 2 },
        ],
        edges: [
          { from: 'sm', to: 'sdu', rel: 'BuildsInto' },
          { from: 'sdu', to: 'pn', rel: 'DeploysTo' },
          { from: 'pn', to: 'board', rel: 'HostedBy' },
        ],
      },
      {
        title: 'What the node provides: a runtime environment, and the memory a task is bound to',
        nodes: [
          { id: 're', type: 'RuntimeEnvironment', col: 0, row: 2 },
          { id: 'mem', type: 'MemoryDevice', col: 0, row: 3 },
          { id: 'task', type: 'SoftwareComponent', col: 0, row: 4 },
        ],
        edges: [
          { from: 'pn', to: 're', rel: 'ProvidesEnvironment' },
          { from: 'pn', to: 'mem', contains: true },
          { from: 'task', to: 'mem', rel: 'MemoryBinding' },
        ],
      },
      {
        title: 'End to end: a flow made of flow specifications on logical ports, traced to the unit it crosses',
        nodes: [
          { id: 'e2e', type: 'EndToEndFlow', col: 1, row: 0 },
          { id: 'fs', type: 'FlowSpecification', col: 2, row: 0 },
          { id: 'lp', type: 'LogicalPort', col: 3, row: 0 },
        ],
        edges: [
          { from: 'e2e', to: 'sdu', rel: 'FlowTraversesBinding' },
          { from: 'e2e', to: 'fs', rel: 'FlowComprisesSpec' },
          { from: 'fs', to: 'lp', ref: 'outPort' },
        ],
      },
      {
        title: 'The physical boundary: a physical interface joins two ports, carries the flow, and is bound to the traces',
        nodes: [
          { id: 'pIn', type: 'PhysicalPort', label: 'PhysicalPort (in)', col: 1, row: 3 },
          { id: 'fe', type: 'ElectronicComponent', col: 3, row: 2 },
          { id: 'pOut', type: 'PhysicalPort', label: 'PhysicalPort (out)', col: 3, row: 3 },
          { id: 'iface', type: 'PhysicalInterface', col: 2, row: 4 },
          { id: 'traces', type: 'HardwareComponent', col: 2, row: 5 },
        ],
        edges: [
          { from: 'pn', to: 'pIn', contains: true },
          { from: 'board', to: 'fe', contains: true },
          { from: 'fe', to: 'pOut', contains: true },
          { from: 'iface', to: 'pOut', native: 'connect' },
          { from: 'iface', to: 'pIn', native: 'connect' },
          { from: 'pOut', to: 'pIn', native: 'flow' },
          { from: 'iface', to: 'traces', rel: 'ConnectionBinding' },
        ],
      },
    ],
  },
  {
    id: 'requirements',
    title: 'Requirements',
    steps: [
      {
        title: 'The pair: a requirement derives from a need',
        nodes: [
          { id: 'need', type: 'Need', col: 0, row: 1 },
          { id: 'req', type: 'Requirement', col: 2, row: 1 },
        ],
        edges: [{ from: 'need', to: 'req', rel: 'DerivesFrom' }],
      },
      {
        title: 'Whose need, and what it motivates',
        nodes: [
          { id: 'user', type: 'User', col: 0, row: 0 },
          { id: 'uc', type: 'UseCase', col: 1, row: 0 },
        ],
        edges: [
          { from: 'need', to: 'user', rel: 'HeldBy' },
          { from: 'need', to: 'uc', rel: 'Motivates' },
        ],
      },
      {
        title: 'Other drivers: risk and threat are drivers a requirement derives from',
        nodes: [
          { id: 'risk', type: 'Risk', col: 3, row: 0 },
          { id: 'threat', type: 'Threat', col: 3, row: 1 },
        ],
        edges: [
          { from: 'risk', to: 'req', rel: 'DerivesFrom' },
          { from: 'threat', to: 'req', rel: 'DerivesFrom' },
        ],
      },
      {
        title: 'Satisfaction and supporting definitions',
        nodes: [
          { id: 'fn', type: 'SystemFunction', col: 2, row: 2 },
          { id: 'sc', type: 'SystemConstant', col: 1, row: 2 },
        ],
        edges: [
          { from: 'req', to: 'fn', native: 'satisfy' },
          { from: 'req', to: 'sc', native: 'dependency' },
        ],
      },
    ],
  },
  {
    id: 'safety-risk',
    title: 'Safety and risk',
    steps: [
      {
        title: 'The chain: a hazard, the situation it creates, the harm that can follow',
        nodes: [
          { id: 'hz', type: 'Hazard', col: 2, row: 0 },
          { id: 'hs', type: 'HazardousSituation', col: 2, row: 1 },
          { id: 'harm', type: 'Harm', col: 2, row: 2 },
        ],
        edges: [
          { from: 'hz', to: 'hs', rel: 'TracesRisk' },
          { from: 'hs', to: 'harm', rel: 'LeadsToHarm' },
        ],
      },
      {
        title: 'Estimation: a risk is estimated for the hazard, against a matrix',
        nodes: [
          { id: 'risk', type: 'Risk', col: 1, row: 1 },
          { id: 'rm', type: 'RiskMatrix', col: 0, row: 1 },
        ],
        edges: [
          { from: 'risk', to: 'hz', rel: 'EstimatedFor' },
          { from: 'risk', to: 'rm', rel: 'AssessedAgainst' },
        ],
      },
      {
        title: 'Control: a measure mitigates the hazard, leaving a residual risk weighed against a benefit',
        nodes: [
          { id: 'rcm', type: 'RiskControlMeasure', col: 3, row: 0 },
          { id: 'rr', type: 'ResidualRisk', col: 3, row: 1 },
          { id: 'ben', type: 'Benefit', col: 0, row: 2 },
        ],
        edges: [
          { from: 'rcm', to: 'hz', rel: 'Mitigates' },
          { from: 'rr', to: 'rcm', rel: 'ReducedBy' },
          { from: 'ben', to: 'risk', rel: 'WeighedAgainst' },
        ],
      },
      {
        title: 'Analysis methods: failure modes, hazard studies and fault trees feed the chain',
        nodes: [
          { id: 'part', type: 'HardwareComponent', col: 4, row: 0 },
          { id: 'fm', type: 'FailureMode', col: 4, row: 1 },
          { id: 'dm', type: 'DetectionMethod', col: 4, row: 2 },
          { id: 'hd', type: 'HAZOPDeviation', col: 1, row: 0 },
          { id: 'mcs', type: 'MinimalCutSet', col: 2, row: 3 },
          { id: 'ftn', type: 'FaultTreeNode', col: 3, row: 3 },
        ],
        edges: [
          { from: 'part', to: 'fm', rel: 'HasFailureMode' },
          { from: 'fm', to: 'dm', rel: 'DetectedBy' },
          { from: 'hd', to: 'hz', rel: 'IdentifiesHazard' },
          { from: 'mcs', to: 'ftn', rel: 'ContainsEvent' },
        ],
      },
    ],
  },
  {
    id: 'cybersecurity',
    title: 'Cybersecurity',
    steps: [
      {
        title: 'The core: a threat to an asset exploits a vulnerability, a mitigation reduces it',
        nodes: [
          { id: 'asset', type: 'CybersecurityAsset', col: 2, row: 0 },
          { id: 'threat', type: 'Threat', col: 2, row: 1 },
          { id: 'vuln', type: 'Vulnerability', col: 2, row: 2 },
          { id: 'cm', type: 'CyberMitigation', col: 1, row: 2 },
        ],
        edges: [
          { from: 'asset', to: 'threat', rel: 'ThreatenedBy' },
          { from: 'threat', to: 'vuln', rel: 'Exploits' },
          { from: 'cm', to: 'vuln', rel: 'Mitigates' },
        ],
      },
      {
        title: 'Who and how: the threat actor, the techniques, the path through them',
        nodes: [
          { id: 'ta', type: 'ThreatActor', col: 3, row: 1 },
          { id: 'tech', type: 'AttackTechnique', col: 3, row: 2 },
          { id: 'path', type: 'AttackPath', col: 4, row: 2 },
        ],
        edges: [
          { from: 'threat', to: 'ta', rel: 'AttributedToThreatActor' },
          { from: 'threat', to: 'tech', rel: 'UsesAttackTechnique' },
          { from: 'path', to: 'tech', rel: 'IncludesAttackTechnique' },
        ],
      },
      {
        title: 'The asset: what must be protected, and where it is exposed',
        nodes: [
          { id: 'sp', type: 'SecurityProperty', col: 1, row: 0 },
          { id: 'as', type: 'AttackSurface', col: 3, row: 0 },
        ],
        edges: [
          { from: 'asset', to: 'sp', rel: 'HasSecurityProperty' },
          { from: 'as', to: 'asset', rel: 'ExposesAsset' },
        ],
      },
      {
        title: 'Consequence and findings: the hazard a threat realises, the requirement it drives, the findings against a vulnerability',
        nodes: [
          { id: 'ch', type: 'CyberHazard', col: 0, row: 0 },
          { id: 'sr', type: 'SecurityRequirement', col: 1, row: 1 },
          { id: 'sf', type: 'SecurityFinding', col: 4, row: 3 },
          { id: 'sbom', type: 'SBOMEntry', col: 3, row: 3 },
        ],
        edges: [
          { from: 'threat', to: 'ch', rel: 'RealizesCyberHazard' },
          { from: 'threat', to: 'sr', rel: 'DerivesCyberRequirement' },
          { from: 'sf', to: 'vuln', rel: 'IdentifiesVulnerability' },
          { from: 'vuln', to: 'sbom', rel: 'AffectsSBOMEntry' },
        ],
      },
    ],
  },
  {
    id: 'human-factors',
    title: 'Human factors',
    steps: [
      {
        title: 'The core: an operative action is where a use error is committed',
        nodes: [
          { id: 'ac', type: 'OperativeAction', col: 1, row: 0 },
          { id: 'ue', type: 'UseError', col: 1, row: 1 },
        ],
        edges: [{ from: 'ac', to: 'ue', rel: 'CommitsUseError' }],
      },
      {
        title: 'Where and what follows: the element it happens at, the hazard it causes',
        nodes: [
          { id: 'uie', type: 'UIElement', col: 2, row: 1 },
          { id: 'hz', type: 'Hazard', col: 1, row: 2 },
        ],
        edges: [
          { from: 'ue', to: 'uie', rel: 'ErrorAtElement' },
          { from: 'ue', to: 'hz', rel: 'Causes' },
        ],
      },
      {
        title: 'Evidence: how demanding the task is, and what an evaluation found',
        nodes: [
          { id: 'tda', type: 'TaskDifficultyAssessment', col: 0, row: 0 },
          { id: 'ev', type: 'MemoEvidence', col: 2, row: 0 },
        ],
        edges: [
          { from: 'tda', to: 'ac', rel: 'AssessesDifficulty' },
          { from: 'ev', to: 'ac', rel: 'EvaluatesTask' },
        ],
      },
    ],
  },
  {
    id: 'verification-validation',
    title: 'Verification and validation',
    steps: [
      {
        title: 'Verification: a case checks a requirement and produces evidence',
        nodes: [
          { id: 'vc', type: 'VerificationCase', col: 1, row: 1 },
          { id: 'req', type: 'Requirement', col: 0, row: 1 },
          { id: 'ev', type: 'MemoEvidence', col: 2, row: 1 },
        ],
        edges: [
          { from: 'vc', to: 'req', native: 'subject' },
          { from: 'vc', to: 'ev', rel: 'ProducesEvidence' },
        ],
      },
      {
        title: 'The steps a case performs',
        nodes: [{ id: 'ts', type: 'TestStep', col: 1, row: 2 }],
        edges: [{ from: 'vc', to: 'ts', rel: 'PerformsStep' }],
      },
      {
        title: 'Validation: a case validates the use, and produces evidence too',
        nodes: [
          { id: 'ac', type: 'OperativeAction', col: 0, row: 0 },
          { id: 'val', type: 'ValidationCase', col: 1, row: 0 },
        ],
        edges: [
          { from: 'ac', to: 'val', rel: 'Validates' },
          { from: 'val', to: 'ev', rel: 'ProducesEvidence' },
        ],
      },
    ],
  },
  {
    id: 'assurance',
    title: 'Assurance disciplines',
    steps: [
      {
        title: 'Requirements: a need motivates the goal and drives the requirements the design satisfies',
        nodes: [
          { id: 'uc', type: 'UseCase', col: 0, row: 0 },
          { id: 'fn', type: 'SystemFunction', col: 1, row: 0 },
          { id: 'need', type: 'Need', col: 0, row: 1 },
          { id: 'req', type: 'Requirement', col: 1, row: 1 },
        ],
        edges: [
          { from: 'need', to: 'uc', rel: 'Motivates' },
          { from: 'need', to: 'req', rel: 'DerivesFrom' },
          { from: 'req', to: 'fn', native: 'satisfy' },
        ],
      },
      {
        title: 'Human factors and safety: a use error causes a hazard, a control mitigates it',
        nodes: [
          { id: 'ac', type: 'OperativeAction', col: 2, row: 0 },
          { id: 'sm', type: 'SoftwareModule', col: 3, row: 0 },
          { id: 'ue', type: 'UseError', col: 2, row: 1 },
          { id: 'hz', type: 'Hazard', col: 2, row: 2 },
          { id: 'hs', type: 'HazardousSituation', col: 2, row: 3 },
          { id: 'harm', type: 'Harm', col: 2, row: 4 },
          { id: 'risk', type: 'Risk', col: 1, row: 3 },
          { id: 'rcm', type: 'RiskControlMeasure', col: 3, row: 2 },
        ],
        edges: [
          { from: 'ac', to: 'ue', rel: 'CommitsUseError' },
          { from: 'ue', to: 'hz', rel: 'Causes' },
          { from: 'hz', to: 'hs', rel: 'TracesRisk' },
          { from: 'hs', to: 'harm', rel: 'LeadsToHarm' },
          { from: 'risk', to: 'hz', rel: 'EstimatedFor' },
          { from: 'rcm', to: 'hz', rel: 'Mitigates' },
          { from: 'rcm', to: 'sm', rel: 'ControlImplementedBy' },
        ],
      },
      {
        title: 'Cybersecurity: a threat to an asset exploits a vulnerability, a mitigation reduces it',
        nodes: [
          { id: 'asset', type: 'CybersecurityAsset', col: 4, row: 1 },
          { id: 'threat', type: 'Threat', col: 4, row: 2 },
          { id: 'vuln', type: 'Vulnerability', col: 4, row: 3 },
          { id: 'cm', type: 'CyberMitigation', col: 3, row: 3 },
        ],
        edges: [
          { from: 'asset', to: 'threat', rel: 'ThreatenedBy' },
          { from: 'threat', to: 'vuln', rel: 'Exploits' },
          { from: 'cm', to: 'vuln', rel: 'Mitigates' },
        ],
      },
      {
        title: 'Verification and validation: cases check the design and the use, and produce evidence',
        nodes: [
          { id: 'vc', type: 'VerificationCase', col: 0, row: 2 },
          { id: 'val', type: 'ValidationCase', col: 1, row: 2 },
          { id: 'ev', type: 'MemoEvidence', col: 0, row: 3 },
        ],
        edges: [
          { from: 'vc', to: 'req', native: 'subject' },
          { from: 'ac', to: 'val', rel: 'Validates' },
          { from: 'vc', to: 'ev', rel: 'ProducesEvidence' },
          { from: 'val', to: 'ev', rel: 'ProducesEvidence' },
        ],
      },
    ],
  },
];
