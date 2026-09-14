# Dashboards

Markdown pages with live diagrams, opened in MEMO Architect under **Dashboards**.

| Folder | Who sees it | In git? |
| --- | --- | --- |
| `dashboards/` | everyone on the project | committed |
| `dashboards/user/` | only you, on this machine | ignored — listed in `.gitignore` |

Each `.md` file is one dashboard; its file name is its id. Every viewpoint also
has a generated dashboard until a file named `viewpoint-<viewpoint id>.md`
replaces it — `viewpoint-vp-demo-ibd.md` here is a filled-in example.

Embed a live, read-only diagram with a directive on its own line:

    {{diagram:<view id or name>}}
    {{diagram:<view id or name> height=640}}
