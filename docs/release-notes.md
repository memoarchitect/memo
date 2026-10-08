# Release notes

Versioned under [semantic versioning](https://semver.org/). Before 1.0 a change that breaks a model, a command or a setting raises the minor number; a fix or addition that breaks nothing raises the patch. Every release is tagged in the repository. The notes for all three packages are also on [memoarchitect.com/releases.html](https://memoarchitect.com/releases.html).

## 0.14.0 (not yet published)

### Breaking

- **A rule traces to a clause by a dependency.** The trace was a `ref enforces` member of the rule. It is now `#EnforcesClause dependency from <Rule> to <clause>, <clause>;`, written beside the rule. A rule may name several clauses or none.
  To move, replace each `ref enforces : StandardClause[1..*] = a.b.c;` with the dependency, spell the clause with `::`, and import `memo_artifacts_standards_traceability::EnforcesClause`. The previous form is tagged `pre-typed-rule-clause-relation`.

- **One project skeleton.** The manifest's `templates` map and `init.defaultTemplate` are replaced by `init.template: ./templates/default`, and the `samd`, `infusion-pump`, `monitoring-device` and `connected-device` starters are removed. Start from an example instead (`memo-architect init --example <id>`). A manifest in the old form is rejected by tools 0.14.0.

### Added

- **Rule obligation.** Every rule states `required`, `recommended` or `bestPractice` (`RuleObligationKind`). Rules that trace to a clause start `required`; the rest start `recommended`. A rule that states no severity takes `error`, `warning` or `info` from it.
