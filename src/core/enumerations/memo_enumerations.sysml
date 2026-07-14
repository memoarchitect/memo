package memo_core_enumerations {
    private import ScalarValues::*;

    enum def ConcernKind {
        enum safety;
        enum usability;
        enum cybersecurity;
        enum performance;
        enum interoperability;
        enum reliability;
        enum privacy;
        enum regulatory;
        enum clinical;
    }
    enum def RequirementSourceKind {
        enum stakeholderNeed;
        enum risk;
        enum designDecision;
        enum changeRequest;
        enum sourceDocument;
        enum extension;
    }
    // Notification/alarm priority as used by source requirement documents
    // (e.g. CriSys GPCA REQ 59 action table: High/Med/Low).
    enum def NotificationPriorityKind {
        enum high;
        enum medium;
        enum low;
    }
    enum def RequirementStatusKind {
        enum draft;
        enum approved;
        enum implemented;
        enum verified;
        enum validated;
        enum retired;
    }
    enum def RequirementNotationKind {
        enum freeText;
        enum ears;
        enum sophist;
        enum formalConstraint;
    }
    enum def EarsPatternKind {
        enum ubiquitous;
        enum eventDriven;
        enum stateDriven;
        enum optionalFeature;
        enum unwantedBehavior;
        enum complex;
    }
    enum def ObligationKind {
        enum shall;
        enum should;
        enum will;
    }
    enum def ArcadiaLayerKind {
        enum operational;
        enum system;
        enum logical;
        enum physical;
    }
    enum def InterfaceKind {
        enum data;
        enum control;
        enum analogSignal;
        enum digitalSignal;
        enum power;
        enum network;
        enum api;
        enum userInteraction;
        enum notification;
        enum logging;
        enum mechanical;
        enum fluidic;
    }
    enum def FlowKind {
        enum information;
        enum command;
        enum status;
        enum telemetry;
        enum alarm;
        enum configuration;
        enum measurement;
        enum audit;
        enum power;
    }
    enum def DirectionKind {
        enum input;
        enum output;
        enum inputOutput;
        enum bidirectional;
    }
    enum def CriticalityKind {
        enum low;
        enum medium;
        enum high;
        enum catastrophic;
    }
    enum def SafetyClassKind {
        enum none;
        enum A;
        enum B;
        enum C;
    }
    enum def ComplexityKind {
        enum low;
        enum medium;
        enum high;
        enum complex;
    }
    enum def LifecycleStateKind {
        enum concept;
        enum development;
        enum released;
        enum maintenance;
        enum obsolete;
    }
    enum def VerificationMethodKind {
        enum inspection;
        enum analytical;
        enum demonstration;
        enum test;
        enum simulation;
        enum formalProof;
        enum modelChecking;
    }
    enum def ArtifactKind {
        enum plan;
        enum requirementSpecification;
        enum architectureDescription;
        enum softwareDesignDescription;
        enum riskRecord;
        enum traceMatrix;
        enum testProtocol;
        enum testReport;
        enum evidenceRecord;
        enum cybersecurityAssessment;
        enum threatModel;
        enum usabilityEngineeringReport;
        enum clinicalSafetyReport;
        enum failureModeEffectsAnalysis;
        enum soupList;
        enum designInputPlan;
        enum designOutputPlan;
        enum softwareDevelopmentPlan;
        enum labelingSpecification;
        enum designHistoryFileIndex;
        enum designChangeLog;
    }
    enum def RiskControlKind {
        enum inherentSafeDesign;
        enum protectiveMeasure;
        enum informationForSafety;
        enum alarm;
        enum interlock;
        enum monitoring;
        enum plausibilityCheck;
    }
    enum def HazardTypeKind {
        enum drugDeliveryError;
        enum energyExposure;
        enum informationError;
        enum mechanicalFailure;
        enum biologicalContamination;
        enum softwareAnomaly;
        enum useError;
        enum environmentalHazard;
    }
    // Cause-source categories for hazard causal trees. Mirrors the
    // cause-source tables of the FDA GIIP hazard taxonomy (Zhang et al.
    // 2010, Tables 2-9) and the section headings of the GIP Hazard
    // Analysis v1.0 (Arney et al. 2009, section 2.4.1-2.4.8).
    enum def CauseSourceKind {
        enum operational;
        enum environmental;
        enum electrical;
        enum hardware;
        enum software;
        enum mechanical;
        enum biologicalChemical;
        enum usageCause;
    }
    // The eight standard SysML v2 view kinds (spec taxonomy). Every
    // diagram view resolves to exactly one of these (Epic KK).
    enum def DiagramViewKind {
        enum general;
        enum interconnection;
        enum actionflow;
        enum statetransition;
        enum sequence;
        enum grid;
        enum browser;
        enum geometry;
    }
    enum def DocumentViewKind {
        enum DHF;
        enum SDD;
        enum RMF;
        enum VV;
        enum ArchitectureDescription;
        enum CybersecurityAssessment;
        enum ThreatModel;
        enum Clinical;
        enum Usability;
    }
    enum def SchedulingPolicyKind {
        enum nonRealTime;
        enum roundRobin;
        enum fixedPriorityPreemptive;
        enum rateMonotonic;
        enum deadlineMonotonic;
        enum EDF;
    }
    enum def LinkStatusKind {
        enum planned;
        enum active;
        enum verified;
        enum obsolete;
    }
    enum def BehaviorPropertyKind {
        enum stateInvariant;
        enum transitionRule;
        enum temporalProperty;
        enum safetyProperty;
        enum livenessProperty;
        enum assumption;
        enum guarantee;
    }
    enum def PropertyLanguageKind {
        enum naturalLanguage;
        enum pseudoFormal;
        enum agreeLike;
        enum ltlLike;
        enum ctlLike;
    }
    enum def RuleStrengthKind {
        enum optional;
        enum recommended;
        enum required;
        enum forbidden;
    }
    enum def RulePredicateKind {
        enum requireRelationship;
        enum conditionalRequireRelationship;
        enum requireAttribute;
        enum uniqueAttribute;
        enum cardinalityCheck;
        enum coverageCheck;
    }
    enum def RuleSeverityKind {
        enum error;
        enum warning;
        enum info;
    }
    enum def RuleCategoryKind {
        enum closure;
        enum coverage;
        enum lifecycle;
        enum crossLayer;
        enum quantitative;
    }
    enum def WorkflowStageKind {
        enum context;
        enum requirements;
        enum behavior;
        enum architecture;
        enum interfaces;
        enum risk;
        enum verificationStage;
        enum evidence;
        enum documents;
    }
    enum def AudienceKind {
        enum systemArchitect;
        enum softwareArchitect;
        enum hardwareEngineer;
        enum safetyEngineer;
        enum verificationEngineer;
        enum regulatoryEngineer;
        enum projectLead;
        enum securityEngineer;
        enum privacyEngineer;
        enum clinicalEngineer;
        enum usabilityEngineer;
    }
    enum def ThreatCategoryKind {
        enum spoofing;
        enum tampering;
        enum repudiation;
        enum informationDisclosure;
        enum denialOfService;
        enum elevationOfPrivilege;
        enum privacyLoss;
        enum supplyChain;
    }
    enum def CyberControlKind {
        enum prevent;
        enum detect;
        enum respond;
        enum recover;
        enum hardening;
        enum monitoring;
        enum authentication;
        enum authorization;
        enum encryption;
        enum integrityProtection;
        enum audit;
        enum updateMechanism;
    }
    enum def AssetKind {
        enum data;
        enum credential;
        enum configuration;
        enum software;
        enum hardware;
        enum networkConnection;
        enum auditRecord;
        enum safetyCriticalFunction;
    }
    enum def ViewOutputKind {
        enum diagram;
        enum table;
        enum matrix;
        enum documentSection;
        enum dashboard;
    }
    enum def PresentationKind {
        enum blockDiagram;
        enum internalDiagram;
        enum activityDiagram;
        enum stateDiagram;
        enum riskTable;
        enum traceMatrix;
        enum narrativeSection;
        enum custom;
    }
    enum def DeploymentKind {
        enum native;
        enum containerized;
        enum cloudHosted;
        enum embedded;
        enum partitioned;
    }
    enum def ActorKind {
        enum patient;
        enum clinician;
        enum caregiver;
        enum technician;
        enum administrator;
    }
    enum def ValidationMethodKind {
        enum clinicalTrial;
        enum summativeUsabilityTest;
        enum comparativeStudy;
        enum benchmarkTest;
        enum simulatedUse;
    }
    enum def SOUPClassificationKind {
        enum classA;
        enum classB;
        enum classC;
        enum unclassified;
    }
    enum def OperationalEntityKind {
        enum human;
        enum externalSystem;
        enum environmentalEntity;
        enum regulatoryBody;
        enum device;
        enum informationArtifact;
    }
    enum def ScenarioKind {
        enum nominal;
        enum degraded;
        enum emergency;
        enum maintenance;
        enum error;
        enum timeout;
        enum alarm;
    }
    enum def FunctionalChainKind {
        enum nominal;
        enum error;
        enum degraded;
        enum alarm;
        enum startup;
        enum shutdown;
        enum calibration;
    }
    enum def ProcessingNodeKind {
        enum microcontroller;
        enum FPGA;
        enum SoC;
        enum gateway;
        enum cloudServer;
        enum edgeDevice;
        enum DSP;
    }
    enum def FailureModeKind {
        enum lossOfFunction;
        enum degradedFunction;
        enum unintendedFunction;
        enum intermittentFunction;
        enum prematureFunction;
        enum delayedFunction;
    }
    enum def FailureEffectLevelKind {
        enum local;
        enum nextHigher;
        enum endEffect;
    }
    enum def FailureCauseCategoryKind {
        enum design;
        enum manufacturing;
        enum material;
        enum wear;
        enum misuse;
        enum environmental;
        enum software;
    }
    // ISO 14971 severity of harm — distinct from the general-purpose
    // CriticalityKind used elsewhere for architecture/software criticality.
    enum def SeverityKind {
        enum negligible;
        enum minor;
        enum serious;
        enum critical;
        enum catastrophic;
    }
    // Qualitative likelihood of occurrence (ISO 14971 / AAMI TIR style
    // Likert scale), used wherever a hazard, failure, or fault-tree event
    // carries a qualitative occurrence estimate rather than a measured rate.
    enum def ProbabilityKind {
        enum incredible;
        enum improbable;
        enum remote;
        enum occasional;
        enum probable;
        enum frequent;
    }
    // Qualitative ability to detect a failure/threat before it causes harm —
    // used for FMEA detection ratings and cybersecurity detectability.
    enum def DetectionKind {
        enum high;
        enum moderate;
        enum low;
        enum none;
    }
    // ISO 14971 clause 3.14/8 risk acceptability decision.
    enum def RiskAcceptabilityKind {
        enum acceptable;
        enum alarp;
        enum unacceptable;
    }
    enum def DetectionMethodKind {
        enum inspection;
        enum testing;
        enum monitoring;
        enum alarm;
        enum userReport;
        enum selfDiagnostic;
        enum periodicMaintenance;
    }
    enum def FMEAActionKind {
        enum designChange;
        enum processChange;
        enum verificationActivity;
        enum labeling;
        enum training;
        enum monitoring;
    }
    enum def FaultTreeEventKind {
        enum topEvent;
        enum intermediateEvent;
        enum basicEvent;
        enum undevelopedEvent;
        enum houseEvent;
        enum externalEvent;
        enum conditionalEvent;
    }
    enum def FaultTreeGateKind {
        enum andGate;
        enum orGate;
        enum kOfNGate;
        enum xorGate;
        enum inhibitGate;
        enum priorityAndGate;
    }
    enum def DesignDecisionStatusKind {
        enum proposed;
        enum accepted;
        enum superseded;
        enum rejected;
    }
    enum def RiskControlImplementationKind {
        enum hardwareDesign;
        enum softwareDesign;
        enum labeling;
        enum training;
        enum proceduralControl;
    }
    enum def ActionKind {
        enum transform;
        enum validate;
        enum route;
        enum store;
        enum present;
        enum actuate;
        enum sense;
        enum compute;
        enum filtering;
        enum encrypt;
        enum authenticate;
    }
    enum def ActivityFlowKind {
        enum controlFlow;
        enum objectFlow;
        enum exceptionFlow;
    }
    enum def MessageKind {
        enum synchronous;
        enum asynchronous;
        enum reply;
        enum create;
        enum destroy;
        enum timeout;
    }
    enum def TimingConstraintKind {
        enum deadline;
        enum period;
        enum jitter;
        enum latency;
        enum separation;
        enum burstInterval;
    }
    enum def HAZOPGuideWordKind {
        enum no;
        enum more;
        enum less;
        enum asWellAs;
        enum partOf;
        enum reverse;
        enum other;
        enum early;
        enum late;
        enum before;
        enum subsequent;
    }
    enum def ChangeTypeKind {
        enum corrective;
        enum preventive;
        enum enhancement;
        enum regulatoryDriven;
    }
    enum def UseErrorCategoryKind {
        enum perception;
        enum cognition;
        enum actionCategory;
        enum memoryRecall;
    }
}
