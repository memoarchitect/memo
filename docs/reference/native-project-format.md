# Native project format (moved)

This page is now [Native model format](native-model-format.md).

What Architect opens, one repository compiled once, is called a **model**.
"Project" now means a change set to one or more systems in an iteration.
The binding is `ModelMethodBinding` with `modelName`. The former spelling,
`ProjectMethodBinding` with `projectName`, still binds until 0.15.0 and warns.
