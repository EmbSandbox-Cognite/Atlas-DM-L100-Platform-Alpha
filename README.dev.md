# Platform Alpha — developer notes

Partner-facing usage is [README.md](README.md). This file is for people changing the repository.

The runnable module is `modules/examples/platform-alpha`. It extends the Cognite Core Data Model, loads a synthetic SAP-style sample, generates time series, and deploys two Atlas agents. `modules/workspace` is only a placeholder readme.

## What a clone contains

```
modules/examples/platform-alpha/
  module.toml
  data_modeling/pal-sap-apm-dm/   # PalAssetManagement
  raw/                            # pal_source tables
  files/                          # PDFs and file metadata
  transformations/                # population, then connection
  functions/fn_pal_ts_generator/  # deployed function, including handler.py
  workflows/wf_pal_ingestion      # nodes, relations, then the time-series function
  agents/
```

Deploy with `config.pal.yaml` only. `cdf.toml` defaults to `config.dev.yaml`, which still lists QuickStart paths that are not in this repo. A bare `cdf build` fails.

```bash
uv sync
uv run cdf build -c config.pal.yaml
uv run cdf deploy --dry-run
uv run cdf deploy
```

Set `environment.project` in `config.pal.yaml`. Export `IDP_CLIENT_ID` and `IDP_CLIENT_SECRET` before deploy. After deploy, run workflow `wf_pal_ingestion` in CDF.

Toolkit version is pinned in `pyproject.toml` (`cognite-toolkit`) and `cdf.toml` (`[modules] version`). Keep those two in step when you upgrade.

## Where to edit the deployed module

| Change | Start here |
|---|---|
| Views and containers | `data_modeling/pal-sap-apm-dm/`. Model external id `PalAssetManagement` |
| Sample rows | `raw/*.Table.csv` |
| Documents users receive | `files/` |
| Agent behavior | `agents/`. Enriched vs baseline is graph scope only |
| Load order | `workflows/wf_pal_ingestion.WorkflowVersion.yaml` |

Spaces: schema `sp_pal_schema`, instances `sp_pal_instances`, functions `sp_pal_functions`, RAW database `pal_source`.

## Not in git

Specs, the session script, `_tooling/`, and `documents/` (PDF build scripts) stay on the maintainer machine. `RUNBOOK.md` and `DATA_MODEL_UPDATE_ASSIGNMENT.md` are part of the module and are not ignored. `.gitignore` lists them under `# repo and other dev files`. Do not remove those lines to "ship the source." The files another user needs to deploy and run the module are the folders in the tree above.
