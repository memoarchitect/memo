# Layer Map

MEMO layers organize **engineering questions**, not folders, departments, or a
sequence that every project must follow. Use this map to place the information
you already have, then follow one connected thread until it is ready for review.

<div class="memo-layer-map" markdown>

<a class="memo-layer-step layer-context" href="context/">
<span class="memo-layer-number">01</span>
<span class="memo-layer-copy"><strong>Start with clinical intent</strong><em>Who uses the device, for what purpose, and in which setting?</em></span>
<span class="memo-layer-examples"><code>Actor</code> <code>IntendedUse</code> <code>UseContext</code></span>
</a>

<a class="memo-layer-step layer-operational" href="operations-system/">
<span class="memo-layer-number">02</span>
<span class="memo-layer-copy"><strong>Describe operation and system purpose</strong><em>What work, capability, and scenario must the device support?</em></span>
<span class="memo-layer-examples"><code>OperationalActivity</code> <code>SystemCapability</code> <code>FunctionalChain</code></span>
</a>

<a class="memo-layer-step layer-requirements" href="requirements-architecture/">
<span class="memo-layer-number">03</span>
<span class="memo-layer-copy"><strong>State the obligations</strong><em>What must be true, measurable, and reviewable?</em></span>
<span class="memo-layer-examples"><code>StakeholderNeed</code> <code>SystemRequirement</code></span>
</a>

<a class="memo-layer-step layer-architecture" href="requirements-architecture/">
<span class="memo-layer-number">04</span>
<span class="memo-layer-copy"><strong>Realize the design</strong><em>Which functions, responsibilities, interfaces, and implementations answer the obligation?</em></span>
<span class="memo-layer-examples"><code>LogicalFunction</code> <code>LogicalComponent</code> <code>SoftwareItem</code> <code>HardwareAssembly</code></span>
</a>

<a class="memo-layer-step layer-risk" href="risk-assurance/">
<span class="memo-layer-number">05</span>
<span class="memo-layer-copy"><strong>Control risk</strong><em>What can lead to harm or compromise, and how is it controlled?</em></span>
<span class="memo-layer-examples"><code>Hazard</code> <code>Threat</code> <code>RiskControl</code></span>
</a>

<a class="memo-layer-step layer-assurance" href="risk-assurance/">
<span class="memo-layer-number">06</span>
<span class="memo-layer-copy"><strong>Close the claim with evidence</strong><em>What verification, validation, and controlled evidence support the engineering claim?</em></span>
<span class="memo-layer-examples"><code>VerificationCase</code> <code>Evidence</code></span>
</a>

</div>

## Use the map in a review

Start with the strongest available fact. A clinical scenario may begin in
**Context**; a change request may begin with a **Requirement**; an incident may
begin in **Risk**. Then follow the connection in either direction until you can
answer the review question.

<div class="memo-review-thread" markdown>

<span>Patient requests a bolus</span><i>→</i><span>Pump shall enforce a limit</span><i>→</i><span>Monitor flow</span><i>→</i><span>Independent flow control</span><i>→</i><span>Over-delivery test evidence</span>

</div>

The direction is not a workflow gate. Risk can expose a missing requirement;
verification can reveal a design ambiguity. The map helps keep each discovery
connected to its source and its consequence.
