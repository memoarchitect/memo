# The MEMO mental model

MEMO is a way to make one engineering argument explicit. It does not replace
your engineering judgement or force a project through fixed phases. It gives
each claim a clear kind, places it in independent classification dimensions,
and connects it to the reason, design, risk, and evidence around it.

<div class="memo-argument-map" aria-label="An engineering argument from clinical intent to evidence">
  <div class="argument-intent"><span>Why?</span><strong>Clinical intent</strong><small>What does a person need?</small></div>
  <i>→</i>
  <div class="argument-obligation"><span>What must be true?</span><strong>Requirement</strong><small>A testable obligation</small></div>
  <i>→</i>
  <div class="argument-design"><span>How?</span><strong>Design response</strong><small>Function and architecture</small></div>
  <i>→</i>
  <div class="argument-proof"><span>How do we know?</span><strong>Evidence</strong><small>Verification and records</small></div>
</div>

Risk is not a late-stage column in this story. A hazard can introduce a new
requirement at any time, and a failed verification can send you back to the
design. The model is a connected argument, not a waterfall checklist.

## The four things to keep straight

<div class="memo-card-grid">
  <article class="memo-card memo-card-purple"><h3>1. Perspectives are questions</h3><p><strong>Operational</strong> answers why and for whom. <strong>Functional</strong> answers what the system must do. <strong>Logical</strong> answers how the solution is organized. <strong>Implementation</strong> answers how it is realized in software, hardware, and physics.</p><p><a href="../layers/index.md">Explore the Layer Map →</a></p></article>
  <article class="memo-card memo-card-blue"><h3>2. Claims have a type</h3><p>A nurse is a <code>ClinicalUser</code>; a goal is a <code>MedicalUseCase</code>; a “shall” statement is a <code>SystemRequirement</code>; a potential source of harm is a <code>Hazard</code>. The type tells reviewers how to interpret it.</p><p><a href="../modeling/elements.md">Choose element kinds →</a></p></article>
  <article class="memo-card memo-card-teal"><h3>3. Links say something testable</h3><p><code>Motivates</code> means “this need is why the use case exists.” <code>VerifiedBy</code> means “this test checks this claim.” A typed link is a reviewable assertion, not decoration.</p><p><a href="../modeling/relationships.md">Learn relationships →</a></p></article>
  <article class="memo-card memo-card-orange"><h3>4. One element, many dimensions</h3><p>A dose-limit checker is implementation architecture <em>and</em> safety-related <em>and</em> cybersecurity-relevant <em>and</em> subject to verification — as classification data on one element, never as four copies.</p></article>
</div>

## Dimensions, not duplicates

The single most common modeling failure MEMO is designed against is
duplication: the same component appearing once in the "software view", once in
the "safety analysis", and once in the "cyber assessment", drifting apart with
every edit. In MEMO, classification is data *on* the element, and views filter
on it:

![One element participating in four orthogonal dimensions](../assets/ontology-dimensions.svg)

## Start with a small argument, not a complete layer

The most productive first model is a **vertical slice**: one narrow scenario
that reaches from a real user concern to a checkable result. For example:

<div class="memo-slice-example">
  <span class="slice-need"><b>Need</b> Clinician needs warning</span><i>→</i>
  <span class="slice-requirement"><b>Requirement</b> Alarm above limit</span><i>→</i>
  <span class="slice-design"><b>Function</b> Detect and alert</span><i>→</i>
  <span class="slice-proof"><b>Verification</b> High-temperature test</span>
</div>

That slice is enough to expose missing rationale, an unaddressed hazard, or an
untestable requirement. Expand the model one scenario at a time.

## Begin modeling

First, [set up MEMO in your model](../tutorials/setup.md). Then complete the
[Temperature Alarm tutorial](../tutorials/first-model.md), which assumes the
library is already included and focuses only on building the model. When a
concept is unfamiliar, find the example that exercises it in
[Learn from the examples](../examples/index.md).
