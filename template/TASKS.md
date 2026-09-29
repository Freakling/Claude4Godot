# TASKS.md

The active work queue — this is what "do the next step" points at. Task-level sequencing and
dependency lives **only** here; `README.md` "Project Status" tracks milestones, not individual tasks.

## How to use this file

1. Find the first task with status `ready` (every ID in its `Depends on` column is `done`). Claim it
   by setting Status to `in-progress: code` or `in-progress: cowork` before editing (see
   `AGENTS.md` "Two agents").
2. Open only the files in its `Touches` column, plus its `GDD ref` if you need design intent — not the
   full GDD or README. `Touches` is both your starting read set and the expected edit set.
3. If a task's dependency isn't satisfied but seems safe to start anyway, **ask the human** — don't
   reorder the queue yourself. Same if `Done when` names a GDD §11 question: ask before implementing
   anything beyond a labeled placeholder.
4. Before finishing, compare your diff against `Touches`. Editing a file not listed is fine if the
   trail led there — say so in your summary, and add it to the row if it'll matter to reviewers.
5. On completion (every `Done when` item true, plus the headless check passing — always implied):
   set its status to `done`. This may flip a dependent task from `blocked` to `ready` — check and
   update those too. If you couldn't run the headless check (Cowork), set `needs-validation` instead
   of `done`.
6. Keep entries to the columns below. Rationale/alternatives-considered belongs in the commit message,
   not a growing prose block here — this file needs to stay skimmable every session.
7. If a task reveals a new task (e.g. a missing prerequisite), add a row for it rather than doing it
   silently as a sub-step — keeps the dependency graph honest.
8. **Archiving:** move `done` rows below `## Archived` once their milestone (README "Project Status") is complete,
   or whenever the human asks for a prune. Never delete rows — archived IDs stay citable from GDD
   revision notes and playtest reports. Done bugs go to the archived bugs table. If it's unclear
   whether a `done` task might be revisited, leave it and ask the human.

### Columns

- **Status** — `ready` · `blocked` · `in-progress: code` / `in-progress: cowork` · `needs-validation`
  (edits done, headless check not run) · `done`.
- **Systems** — `SYSTEMS.md` row names; look up full file paths there.
- **Touches** — files expected to change. *(new)* = file to be created; `+field` = schema change. Paths
  are relative to `scripts/`, `scenes/`, or `data/` where obvious; `SYSTEMS.md` has the full ones.
- **Done when** — 1–3 checkable outcomes. `§11 Qn` means an open design question gates the real
  behavior: implement with a clearly-labeled placeholder and ask the human, don't pick an answer.
  A row that needs more than 3 outcomes, or spans 3+ systems, should be split.

## Queue

| ID | Task | Status | Depends on | Systems | Touches | Done when | GDD ref |
|---|---|---|---|---|---|---|---|
| T1 | Headless check passes on a clean checkout | ready | — | — | `project.godot` (only if needed) | `{{GODOT_BIN}} --headless --path . --quit` exits with no errors or warnings | §10 |
| T2 | Run + process a function check after each feature update (recurring) | blocked | — | — | `playtesting/<version>/function_check_N.md` *(new, copied from `FUNCTION_CHECK.md`)*, new `## Bugs` rows, new rows for ⚠ gaps the human approves | Becomes `ready` whenever a feature update lands. Human has checked every ✔ item; each ❌ is a bug row; ⚠ gaps have been raised. Stays in the queue as the next check's row | §13.4 |

## Bugs

Defects in what's already built. New features and design changes stay in the Queue above.

- **IDs** start with `B` (B1, B2, …). **Status** and claiming work exactly like the Queue.
- **Severity:** `high` (crash, blocks play, or corrupts state) · `med` (wrong behavior with a
  workaround) · `low` (cosmetic or minor).
- **Repro:** steps → expected / actual. A bug is `done` when the repro no longer happens and the
  headless check passes.
- **Found in:** a playtest file (e.g. `playtest_2`), a task ID, or `ad hoc`. When processing a
  playtest, every item in its Bugs section becomes a row here.
- If a fix turns out to need a design change, add a Queue row or a GDD §11 question instead.
- When more than ~10 bugs are open, move this table to its own `BUGS.md` and leave a pointer here.

| ID | Bug | Status | Severity | Systems | Repro (steps → expected / actual) | Found in |
|---|---|---|---|---|---|---|

## Notes

- *(Short, current notes only: ordering constraints, which tasks share files, what's waiting on the
  human. Delete notes once they stop being true.)*

## Archived

Rows keep their original ID so they stay citable from GDD revision notes and playtest reports.

| ID | Task | Status | Depends on | Systems | Touches | Done when | GDD ref |
|---|---|---|---|---|---|---|---|

### Archived bugs

| ID | Bug | Status | Severity | Systems | Repro (steps → expected / actual) | Found in |
|---|---|---|---|---|---|---|
