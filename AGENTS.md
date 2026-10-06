# Atlas DM L100 — Platform Alpha

Hands-on module: `modules/examples/platform-alpha`.

Single Toolkit module (one `module.toml`). Inside it only standard resource folders: `data_modeling/`, `raw/`, `files/`, `transformations/`, `workflows/`, `functions/`, `agents/`. CDF external IDs (`sp_pal_*`, `fn_pal_*`, `tr_pal_*`, `wf_pal_ingestion`) stay prefixed so they stay unique in the project.

- [SPEC.md](modules/examples/platform-alpha/SPEC.md) — what to build and the ground truth.
- [TRAINER_GUIDE.md](modules/examples/platform-alpha/TRAINER_GUIDE.md) — session script.
- [RUNBOOK.md](modules/examples/platform-alpha/RUNBOOK.md) — commands. Build with `cdf build -c config.pal.yaml`.
- [SOURCES.md](modules/examples/platform-alpha/documents/SOURCES.md) — document provenance.

.