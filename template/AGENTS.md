# AGENTS.md

Read this file first, every session, before opening `gdd.md` or `README.md`. It's a **router**, not a
summary — it tells you *which* section to open for your task, not what's in it. Its own job is to stay
short enough to cost nothing to load.

## Project, in one paragraph

{{PROJECT_NAME}} is a Godot {{GODOT_VERSION}} (GDScript) {{DIMENSION}} game for {{PLATFORMS}}.
{{ONE_PARAGRAPH_PITCH}} Full design intent lives in `design/gdd.md`; current phase status lives in
`README.md`; the task queue in `TASKS.md`; what exists in code in `SYSTEMS.md`.

## Golden rule

**Don't read the whole GDD or README "to be safe."** Both grow long, and any single task typically
touches 1–3 sections. Use the table below to open only what you need. If your task genuinely spans
several systems, open those specific sections one at a time rather than the full file.

## Where to look, by task

| Working on... | Open |
|---|---|
| *(one row per GDD system section — add a row whenever a section is added)* | `gdd.md` §5.x |
| Core loop, starting conditions | `gdd.md` §3 |
| Difficulty/scaling intent | `gdd.md` §8 |
| Win/loss conditions | `gdd.md` §9 |
| Balance/content values (stats, costs, rewards) | Go straight to the relevant `.tres` file in `data/` and its schema in `scripts/resources/` — **not** the GDD. The GDD describes intent; the `.tres` files are the actual tunable values. |
| Current autoload/screen architecture (what actually exists) | `SYSTEMS.md` — **authoritative** |
| Coding standards, architecture principles, art policy | `gdd.md` §10 |
| `settings.json`, dev menu | `gdd.md` §10 "Settings & Dev Tools" |
| What's built, what's next | `README.md` "Project Status" (milestones), `TASKS.md` (the queue) |
| Reporting or fixing a bug | `TASKS.md` `## Bugs` — one row per bug, with repro |
| "Do the next step" / pick up new work | `TASKS.md` — find the first `ready` task, open only its `Touches` column; finish when its `Done when` holds |
| Touching a system you haven't worked in before | `SYSTEMS.md` — find its row, then its GDD ref, then its files |
| AI vs. human responsibility for a given change | `README.md` "AI vs. Human Responsibilities" |
| An open question you're about to resolve by guessing | Check `gdd.md` §11 first — if it's listed there, **stop and ask the human**, don't silently pick an answer |
| Playtesting | `playtesting/README.md`, `gdd.md` §13 |
| Function checks (is every GDD rule working?) | `playtesting/FUNCTION_CHECK.md`, `gdd.md` §13.4 |
| Agent workflow / process | `.promptx/personas/_core-principles.md` + the persona file for your role (see `CLAUDE.md`) |
| Which agent owns what / claiming a task | "Two agents" section below |
| Which model runs a task | `TASKS.md` "Model sizing" — the row's Size column |

## Doc authority

`gdd.md` describes *intent*. **For what actually exists, `SYSTEMS.md` wins** — if they disagree,
flag it rather than trusting the GDD.

## Ground rules (condensed — full versions in GDD §10)

- **Prefer many small, single-purpose files over few large ones — scripts, scenes, and docs alike.**
  Token cost is driven by what has to be *read*, not what exists: scanning a filename or a `SYSTEMS.md`
  row is nearly free, reading a 400-line file to find the 20 relevant lines isn't. If a script owns
  more than one system (per `SYSTEMS.md`), or a doc section has grown past what one task needs, split
  it — and update `SYSTEMS.md` or the relevant index in the same session.
- **Game rules live in systems (autoloads / plain classes), not in screens.** Screens display state
  and call system APIs; they never roll dice or write game state directly. This keeps the UI
  replaceable and the state saveable.
- Statically-typed GDScript everywhere. No untyped `var` without a typed inferred expression.
- Gameplay content (stats, costs, rewards, curves) lives in `.tres` Resource files, never hardcoded in
  scripts. If a task needs a new balance number and none exists, add a field with a clearly-labeled
  placeholder default — don't hand-pick a "final" value in code. Values are a human/playtesting call.
- Placeholder art follows GDD §10 "Art Direction" (default: Godot primitives only). No external
  models, textures, or audio unless explicitly asked.
- UI in responsive containers — no hardcoded pixel coordinates.
- Design decisions and balance philosophy are human calls, not agent calls. If the task requires
  resolving something in GDD §11 Open Design Questions, stop and ask rather than guessing.
- Validate headlessly before calling a task done: `{{GODOT_BIN}} --headless --path . --quit` should
  exit clean, no errors/warnings. (Claude Code only — Cowork: see "Two agents" below)

## Two agents: Claude Code and Cowork

| | Claude Code | Cowork |
|---|---|---|
| Runs Godot (headless check) and git (commits, pushes) | Yes — its job | No — hands Claude Code a file list and a commit prompt |
| Owns (edits freely) | `scripts/`, `scenes/`, `data/`, `project.godot`, `SYSTEMS.md` | `design/`, `playtesting/` |
| Shared: edit only your claimed row / relevant section | `TASKS.md`, `README.md` "Project Status", `AGENTS.md`, `.promptx/` | same |

- **Claim before editing.** Set the row's Status to `in-progress: code` or `in-progress: cowork`
  first. Never edit a file listed in the other agent's in-progress row.
- Editing outside your owned folders needs a human request; say so in your summary.
- Cowork doesn't validate: its changes under code/data folders end at `needs-validation`. Claude Code
  runs the headless check and sets `done`.
- Only Claude Code commits (with human approval). Cowork's doc edits go in a separate `docs:` commit.
  When Cowork hands over a commit, it lists **every** file it changed since the last push.
- Rebaser/Merger personas, worktrees and parallel subagents are Claude Code-only.

## Model sizing — spend where it pays

- Every task and bug row has a **Size**: `S` → smallest model, `M` → mid, `L` → largest (rules and
  current model names in `TASKS.md` "Model sizing"). Whoever writes the row sets it — a quick
  judgement, never a separate analysis pass.
- Claude Code runs a task (or its subagent) on the model its Size names. Failing the headless check
  twice or getting stuck → rerun one size up and note `(escalated from …)` on the row.
- The main session's model keeps orchestration, merging, reviews and shared-doc updates.
- The cheapest token is one not read: keep tasks small and `Touches` accurate, so every model reads
  only what the task needs.

## Updating docs after a task

- **Where things live:** the GDD is the master for *what* the game is; `TASKS.md` holds the work;
  `README.md` "Project Status" holds only **milestones** — one row each, one line saying what's true
  now, pointing to GDD sections or tasks. Never list individual tasks or features in the README; the
  *why* of a change belongs in the commit message.
- When a task finishes a milestone (or changes what's true about one), update that milestone's row.
- GDD edits are **revisions**, per GDD §13.3 — bump the version and state the change in the version
  line (only the latest change; history lives in the git log). Replace superseded text instead of
  striking it through, and don't add version tags inline. Flag anything that looks like it
  contradicts a Design Pillar (GDD §2) for human confirmation instead of resolving it yourself.
- Finishing or unblocking a task updates `TASKS.md`. Adding a new autoload, screen, schema or data
  folder updates `SYSTEMS.md` in the same session — don't let it go stale.
