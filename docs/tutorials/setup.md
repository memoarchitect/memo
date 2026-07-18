# Set up MEMO in your model

Do this once before beginning a tutorial. The tutorials then assume that your
editor can resolve the MEMO library and that this import is valid:

```sysml
private import memo_medical_device_library::*;
```

## 1. Obtain the library source

Use a local checkout of this repository and keep its `src/` directory intact.
That directory is the MEMO source library; `src/medical_device_library.sysml`
is its public entry point.

```text
memo/
├── src/
│   └── medical_device_library.sysml
└── syside.toml
```

## 2. Include it in your SysML project

Register the MEMO `src/` directory as a library source in your SysML v2
editor or project. In SysIDE, the repository’s `syside.toml` demonstrates the
library-side setting:

```toml
include = ["src"]
```

For a product model, keep your product source separate and configure the
project so it can resolve the MEMO source directory as a library. Do not copy
MEMO definitions into your device model; that makes upgrades and traceability
harder.

## 3. Confirm one import

Create a small scratch file in your model and add the public import:

```sysml
package import_check {
    private import memo_medical_device_library::*;

    part reviewer : Actor;
}
```

If `Actor` resolves without an error, your model can use MEMO. Continue to the
[Temperature Alarm tutorial](first-model.md), which assumes this inclusion is
already complete.
