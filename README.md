# Platform Alpha

Self-service CDF getting started: a synthetic offshore sample (SAP-style records, time series, and documents), Atlas agents that reason across it, and a Core Data Model extension deployed with the Toolkit.

## What it does

Platform Alpha is one small seawater-lift system you can load into a CDF project and use immediately. Duty pump **P-101A** and standby pump **P-101B** share lube-oil unit **U-105**. Pump A’s vibration and bearing temperature have been rising since early September and are still below alarm. Pump B failed earlier from contaminated oil. The latest oil sample, an open inspection notification, and a rising oil level on U-105 point at the shared oil unit.

The package loads that story as RAW tables, files, and generated time series, maps it onto a custom data model built by extending the Cognite Core Data Model, and publishes two Atlas agents with the same instructions. **PAL Assistant — Enriched** can use the Platform Alpha views. **PAL Assistant — Baseline** is limited to CogniteCore views. Asking both the same question shows what the extra graph context changes.

You can stop at the agents and the sample, or change the data model and redeploy.

## What's in it

Everything lives in `modules/examples/platform-alpha`. `config.pal.yaml` selects only that module.

| Piece | Where | What you get |
|---|---|---|
| SAP-style RAW | `raw/` database `pal_source` | Functional locations (`sap_iflot`), equipment (`sap_equi`), characteristics (`sap_equi_char`), notifications (`sap_qmel`), orders (`sap_aufk`) |
| Line list | `raw/pid_line_list` | Which lube-oil line feeds which pump |
| Document register | `raw/doc_register` plus `files/` | Type, revision, status, authority, and which equipment each file applies to |
| Time series | `raw/ts_register` and `functions/fn_pal_ts_generator` | 10 series: vibration, bearing temperature, and discharge pressure on both pumps; oil temperature and reservoir level on U-105 |
| Data model | `data_modeling/pal-sap-apm-dm` | `PalAssetManagement` v1 in space `sp_pal_schema`. Views extend Cognite Core: functional location, pump, lube-oil unit, notification, maintenance order, document, and the `servedBy` relation |
| Transformations | `transformations/population` then `transformations/connection` | Nodes first, then relations (installed-at, parent location, notification, order, document, time series, served-by) |
| Workflow | `workflows/wf_pal_ingestion` | Ingestion orchestration for the module |
| Agents | `agents/` | **PAL Assistant — Enriched** and **PAL Assistant — Baseline**, model `azure/gpt-5.4-mini`, plus skills `pal_asset_reasoning` and `pal_root_cause_analysis` |

Documents in the sample:

- Pump manual FS-MARK3-IOM Rev B (superseded) and Rev C (current; limits depend on bearing arrangement)
- Company procedure PAL-TR-CM-001 Rev 4 (stricter alarm than the manual)
- Oil-unit manual KLS-KLU60-OM Rev A
- Datasheet PAL-50-DS-0101 Rev 0
- P&ID PAL-50-PID-0001 Rev 2
- MOC-2026-014, oil reports OA-2026-0415 and OA-2026-0908, inspection IR-2026-0828

Hierarchy in the data: Platform Alpha → Module 20 → System 50 → pump and oil-unit positions. Equipment is installed at a position. Bearing arrangement is an equipment characteristic, not a statement in a document.

Instance space is `sp_pal_instances`. Function space is `sp_pal_functions`. Names use the `pal` prefix so this module can sit beside other content in the same project.

## Prerequisites

- A CDF project where you can deploy data models, RAW, files, transformations, functions, workflows, and agents
- Cognite Core Data Model available in the project (this module extends it; it does not replace it)
- Atlas AI, if you want to run the agents
- Python 3.12 or newer and [uv](https://docs.astral.sh/uv/)
- An identity-provider client with deploy rights. Set `IDP_CLIENT_ID` and `IDP_CLIENT_SECRET`
- To chat with the agents: `agents:read` and `agents:run` on your user. The deploy service principal can publish the agents and still be denied when it tries to chat

## How to use

1. Clone the repo and install dependencies from the repo root:

   ```bash
   git clone https://github.com/EmbSandbox-Cognite/Atlas-DM-L100-Platform-Alpha
   cd Atlas-DM-L100-Platform-Alpha
   uv sync
   ```

2. Point the module at your project. In `config.pal.yaml`, set `environment.project`. The file in the repo names `sandbox-sap-dev` as an example. Export `IDP_CLIENT_ID` and `IDP_CLIENT_SECRET` before you deploy. The time-series function reads those two variables.

3. Build and deploy only this module. Do not run a bare `cdf build`. `cdf.toml` defaults to `config.dev.yaml`, which still lists QuickStart paths that are not in this repo.

   ```bash
   uv run cdf build -c config.pal.yaml
   uv run cdf deploy --dry-run
   uv run cdf deploy
   ```

4. Load the sample. In CDF, open **Workflows** and run `wf_pal_ingestion`. Deploy has already uploaded the RAW tables and files. The workflow writes the nodes, then the relations, then calls `fn_pal_ts_generator` to fill the ten time series.

5. Open **Atlas AI → Agents**. Start with **PAL Assistant — Enriched**. The published starters are:

   - What serves P-101A and P-101B?
   - What vibration limits apply to P-101A?
   - Has anything like this happened on this system before?
   - What does the latest oil analysis say?
   - Is switching duty to P-101B a safe fix?

   Use a new conversation per question. Open **PAL Assistant — Baseline** and ask the vibration-limits question again if you want to compare graph scope. Answers are drafts. The agents do not create SAP notifications.

6. Optional — change the data model. Add a property on `modules/examples/platform-alpha/data_modeling/pal-sap-apm-dm/containers/PalPump.Container.yaml`, map it in `views/PalPump.View.yaml`, then:

   ```bash
   uv run cdf build -c config.pal.yaml
   uv run cdf deploy --dry-run --verbose --include data_modeling
   uv run cdf deploy
   ```

   `--verbose` prints the YAML diff. A container-only edit is not queryable until the view maps the property.

7. Remove this module’s resources when you are done. Delete spaces `sp_pal_schema`, `sp_pal_instances`, and `sp_pal_functions`, RAW database `pal_source`, and the pal transformations, function, workflow, and agents. Other project content stays.

## Configuration

| Setting | Where | Description |
|---|---|---|
| `environment.project` | `config.pal.yaml` | CDF project to deploy into |
| `schemaSpace` | `config.pal.yaml` | Data model space. Default `sp_pal_schema` |
| `instanceSpace` | `config.pal.yaml` | Instance space. Default `sp_pal_instances` |
| `functionSpace` | `config.pal.yaml` | Function space. Default `sp_pal_functions` |
| `rawSourceDatabase` | `config.pal.yaml` | RAW database. Default `pal_source` |
| `datamodelVersion` | `config.pal.yaml` | Data model version. Default `v1` |
| `workflow` | `config.pal.yaml` | Ingestion workflow external id. Default `wf_pal_ingestion` |
| `IDP_CLIENT_ID`, `IDP_CLIENT_SECRET` | Environment | Credentials for deploy and for `fn_pal_ts_generator` |

`config.dev.yaml` and `config.prod.yaml` are the QuickStart scaffold this repo was copied from. They are not the Platform Alpha config. Repo layout and developer commands are in [README.dev.md](README.dev.md).

## Known limitations

- The site, SAP numbers, tags, and events are synthetic. Equipment limits are taken from public manuals and short authored pages. There is no customer data.
- The time series are generated inside CDF. There is no live historian or SAP connection.
- Agents recommend a draft notification on equipment **10004730** (U-105). They cannot write to SAP.
- **PAL Assistant — Baseline** does not see Platform Alpha fields such as bearing arrangement, document applicability, or `servedByUnit`.
- Chat as the deployment service principal returns 403 with the current setup. Use a user that has `agents:read` and `agents:run`.
- Removing the sample deletes `pal` resources only. It does not clean other spaces or QuickStart content.
