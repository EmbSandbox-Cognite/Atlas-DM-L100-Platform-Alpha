
> [!IMPORTANT]
> **Using this template — delete this section after you clone it into your pattern.**
>
> This repository is a starting point, not a finished pattern. Create your own repo from it, then remove this highlighted block before you fill in the pattern below.
>
> 1. Click **Use this template** (or clone) and name the new repository `psp-<kebab-name>`.
> 2. Fill in `psp.json`: `name`, `description`, `type`, and `tags`.
>    - **type** — exactly one of: `notebook`, `toolkit-module`, `guide`, `flows-app`, `bundle`
>    - **tags** — a few short keywords, for example: `mqtt`, `contextualization`, `historian`, `extraction`, `data-modeling`
> 3. Replace the placeholders and HTML comments in this README with your pattern’s content. The pattern README starts at `# <Pattern name>`.
> 4. Replace `psp_icon.svg` using the icon guidelines in the maintainer notes at the bottom.
> 5. Delete this highlighted section. Also delete the maintainer notes (`<details>` at the bottom) before you publish.

> Use Icon Guidelines in bottom to generate SVG for this Solution Pattern. 

# <Pattern name>

<!-- One or two sentences. Same text as `description` in pattern.json. -->

## What it does

<!-- 3–6 sentences. The problem this pattern addresses and what you end up with after using it.
     Write for a partner engineer who has never seen this before. -->


## Prerequisites

<!-- Everything needed before starting. Delete lines that do not apply. -->

- CDF project with: <capabilities / data models / data sets>
- Quick Start Dataset

## How to use

<!-- Numbered, copy-pasteable. Start from "download or clone this repo".
     For toolkit-module: where to place the module and the deploy commands.
     For notebook: how to configure the client and which cells to edit.
     For guide: how to read it / where to start. -->

1. Download the ZIP or `git clone <repo-url>`
2.
3.

## Configuration

<!-- Variables, config files, environment values a partner must change. Delete if none. -->

| Setting | Where | Description |
|---|---|---|
|Env Variable | .env | Add CDF Project Variables.  |

## Known limitations

<!-- Be direct. What this does not handle, scale limits, versions not tested. -->

-




<details>
<summary>Maintainer notes – delete this section before publishing</summary>

### Publishing checklist

- [ ] `pattern.json` filled in (`name`, `description`, `type`, `tags`, `icon`)
- [ ] `icon.svg` replaced following the icon guidelines below
- [ ] All `<placeholders>` and HTML comments in this README replaced or removed
- [ ] No credentials, tokens, customer names or customer data anywhere in the repo
- [ ] `LICENSE` (Apache-2.0) present and unchanged
- [ ] Repo name follows `psp-<kebab-name>`
- [ ] Repo description set (same as `description`)
- [ ] Topic `partner-solution-pattern` added — this is what publishes the pattern

### Icon guidelines

Edit the provided `icon.svg`; keep the frame, change only the motif.

- **Canvas:** `viewBox="0 0 256 256"`, background `<rect>` with `rx="48"` and the existing gradient. Never change the background.
- **Safe area:** keep all motif shapes inside x/y 40–216. Nothing touches the edge.
- **Palette:** exactly three colors — primary `#4A7BF7`, accent `#7FD1B9`, background gradient. Use opacity `1`, `0.75`, `0.5` on the primary for depth. No other colors, no extra gradients.
- **Motif:** one idea, 2–5 shapes. Show what the pattern *does* (flow, sync, transform, monitor, model…), not what it is built with. No logos, no tool icons, no text.
- **Strokes:** `stroke-width` 6 for main lines, 4 for secondary; `stroke-linecap="round"`, `stroke-linejoin="round"`. Corner radius 6–14 on rectangles.
- **Accent use:** the accent color marks the "action" element (arrow, highlight, new item). Everything static uses the primary.
- **Test:** it must read clearly at 48×48. If you have to squint, remove shapes.
- **File:** plain SVG, no raster, no external references, no `<script>`, under 3 KB.

</details>
