# {{PROJECT_NAME}}

{{ONE_PARAGRAPH_PITCH}} Built in **Godot {{GODOT_VERSION}} (GDScript)**. See
[`design/gdd.md`](design/gdd.md) for the full Game Design Document.

This README serves two audiences:
- **Humans** — project overview, milestone status, content-editing guide, getting started.
- **AI coding agents** — start at [`AGENTS.md`](AGENTS.md), not here. It routes you to the one
  section of this file, the GDD, or the docs below that your task needs.

| Doc | Owns (single source of truth) |
|---|---|
| [`design/gdd.md`](design/gdd.md) | Design intent, technical blueprint (§10), open design questions (§11) |
| [`SYSTEMS.md`](SYSTEMS.md) | What systems exist in code, their files and dependencies |
| [`TASKS.md`](TASKS.md) | The work queue and bug table |
| [`AGENTS.md`](AGENTS.md) | Agent routing table and ground rules |
| [`.promptx/personas/`](.promptx/personas/) | Agent personas + shared `_core-principles.md` |
| [`playtesting/`](playtesting/) | Playtest reports and template |
| This README | Milestone status, content-editing guide, AI/human split, getting started |

The GDD is the master for *what* the game is; `TASKS.md` for the work; this README only tracks
**milestones**.

---

## Project Status

One row per milestone, in build order. Each row says what's true now in one line and points to GDD
sections or `TASKS.md` — never a list of individual tasks or features.

| Milestone | Status |
|---|---|
| Design (GDD) | 🟨 Drafting — open questions in GDD §11 |
| Phase 1 — Foundation: project settings, core systems, headless check passing | ⬜ Not started |
| Phase 2 — Core loop playable (grey-box) | ⬜ Not started |
| *(further phases from the GDD — one row each)* | ⬜ |
| Content & balance — replace placeholder `.tres` values with tuned ones (human-owned, driven by playtests) | ⬜ Not started |
| Production assets — art, animation, audio replacing placeholders (human-owned) | ⬜ Not started |
| Platform readiness — input parity, store packaging | ⬜ Not started |
| Playtesting (GDD §13) | ⬜ Template and function check ready; no playtests yet |

Legend: ✅ done · 🟨 in progress · ⬜ not started

---

## Editing Gameplay Content (for humans)

Balance and content are editable without touching code. Gameplay-tunable data is defined as Godot
`Resource` subclasses (in `scripts/resources/`) and authored as `.tres` files (in `data/`), editable
directly in the **Godot Inspector**.

---

## AI vs. Human Responsibilities

> **Design and creative direction are human-led. Production assets are human-made unless explicitly
> stated otherwise. Code, data scaffolding, and implementation are AI-produced.**
> *(Default split — adjust during onboarding.)*

| Responsibility | Owner | Notes |
|---|---|---|
| Game design decisions (mechanics, balance philosophy, narrative direction) | **Human** | AI proposes options; the human decides. |
| Answering GDD "Open Design Questions" (§11) | **Human** | Deliberately left open for human judgement. |
| GDScript implementation (systems, UI logic) | **AI — Claude Code** | Statically typed, follows patterns in `scripts/`. |
| Resource/data schema definitions (`scripts/resources/*.gd`) | **AI — Claude Code** | Structure only. |
| Gameplay content values (stats, rewards, prices) | **Human** (via `.tres`) | AI seeds labelled placeholders; balancing is a playtesting activity. |
| Placeholder art (per GDD §10) | **AI — Claude Code** | Just enough to block out scenes and readability. |
| Production art, models, animation, audio | **Human** | Unless the human explicitly asks otherwise. |
| Design docs, task planning, doc alignment, playtest processing | **AI — Cowork** | Writes only what the human decided. |
| Testing (headless checks, manual playtesting) | **Shared** | Claude Code runs automated checks; the human playtests. |
| Git history, merges, rebases | **AI — Claude Code** | Human approves before anything is pushed. |

---

## Getting Started

1. Install **Godot {{GODOT_VERSION}}+**.
2. Clone the repo and open `project.godot` in Godot.
3. Run the project (F5).
4. To validate scripts headlessly: `{{GODOT_BIN}} --headless --path . --quit` (should exit with no
   errors/warnings).
