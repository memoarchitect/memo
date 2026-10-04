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

export const OVERVIEW = {
  groups: [
    { label: 'Understanding the need', from: 0, to: 1 },
    { label: 'Designing the solution', from: 2, to: 4 },
  ],
  layers: [
    {
      name: 'Operational',
      question: 'Why does the device exist, for whom, in what setting?',
      elements: ['UseCase', 'OperationalWorkflow', 'OperativeScenario', 'OperativeAction'],
      down: 'perform · #refinement',
      assurance: 'Motivates · Validates',
    },
    {
      name: 'Functional',
      question: 'What must the system do?',
      elements: ['SystemFunction', 'ComponentFunction', 'FunctionalFlow', 'StateMachine'],
      down: 'allocate',
      assurance: 'satisfy · subject',
    },
    {
      name: 'Logical',
      question: 'How is the solution organised, before choosing a technology?',
      elements: ['LogicalComponent', 'LogicalPort', 'ComponentExchange', 'IsolationBoundary'],
      down: '#refinement',
      assurance: 'satisfy',
    },
    {
      name: 'Implementation',
      question: 'What is it built from?',
      elements: ['SoftwareModule', 'SoftwareComponent', 'HardwareComponent', 'UIElement'],
      down: 'BuildsInto · DeploysTo',
      assurance: 'ControlImplementedBy',
    },
    {
      name: 'Realization',
      question: 'Where does it run, and how do its parts reach each other?',
      elements: ['SoftwareDeploymentUnit', 'ProcessingNode', 'RuntimeEnvironment', 'EndToEndFlow'],
      assurance: 'satisfy',
    },
  ],
  disciplines: [
    { name: 'Requirements', elements: ['Need', 'Requirement'] },
    { name: 'Safety and risk', elements: ['Hazard', 'Risk', 'RiskControlMeasure'] },
    { name: 'Cybersecurity', elements: ['Threat', 'Vulnerability', 'CyberMitigation'] },
    { name: 'Human factors', elements: ['UseError'] },
    { name: 'Verification and validation', elements: ['VerificationCase', 'ValidationCase'] },
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
        title: 'Supporting detail: workflow control and task difficulty',
        nodes: [
          { id: 'cn', type: 'WorkflowControlNode', col: 1, row: 1 },
          { id: 'tda', type: 'TaskDifficultyAssessment', col: 1, row: 3 },
        ],
        edges: [
          { from: 'wf', to: 'cn', contains: true },
          { from: 'tda', to: 'ac', rel: 'AssessesDifficulty' },
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
