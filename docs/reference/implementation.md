# Source and Maintenance

The repository is the portable content layer of the MEMO stack. It contains
SysML v2 and KerML source, package descriptors, templates, methodologies, rules,
and examples. The parser and CLI live in Memo Tools; the visual workbench lives
in Memo Architect.

## Validate ontology changes

```bash
pnpm test
pnpm run build
```

The build uses SysAnd to parse and package the ontology. A successful text edit
is not enough: update or add an example that demonstrates the user-facing
meaning, then verify affected relationships, rules, and viewpoints.

## Documentation rule

When adding a public element or relationship:

1. describe the engineering question it answers;
2. show a minimal valid usage;
3. state source and target direction for relationships;
4. add it to a worked scenario where practical;
5. identify the owning package and validation coverage.

See the repository `README.md` for package layout and maintainer commands.
