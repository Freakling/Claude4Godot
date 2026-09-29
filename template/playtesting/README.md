# Playtesting

This folder holds structured playtest reports, one per session, organized by version.

## How to add a playtest

1. Copy [`TEMPLATE.md`](TEMPLATE.md).
2. Save it as `playtesting/<version>/playtest_<#>.md`, e.g. `playtesting/0.3/playtest_1.md`.
   - Use the current GDD version (see `design/gdd.md` header) for `<version>`.
   - Increment `<#>` per report within that folder.
3. Fill in what you played, the loop sections you reached, the bugs you hit, and the free-format
   section at the end — the free-format section matters just as much as the scored questions.
4. For a pure bug-hunting session, say so at the top and mark the loop sections `skipped`.

## Function checks

A **function check** verifies that every rule in the GDD actually works, one item at a time.

1. Copy [`FUNCTION_CHECK.md`](FUNCTION_CHECK.md) to `playtesting/<version>/function_check_<#>.md`.
2. Work through the items marked ✔ (built). Tick `[x]` when it works; write `❌` and a note when it
   doesn't; `➖` if you couldn't reach it. Skip ⏳ (not built yet) and ⚠ (no task yet).
3. If the project has a dev menu, use it to reach states quickly.
4. Ask Cowork to process it: every ❌ becomes a bug row, and ⚠ gaps are raised as possible tasks.

See GDD §13.4.

## How feedback gets used

Playtest files are **not** applied automatically. When you're ready, ask Cowork to process one or more
reports. It uses the Game Designer persona (`.promptx/personas/agent-designer.md`) to:

- propose and apply GDD revisions (version bumped, with a note on what changed and why),
- add open questions to GDD §11 where feedback raises a question rather than an answer,
- turn every reported bug into a row in the `## Bugs` table in `TASKS.md`,
- add `TASKS.md` rows for the work the findings create.

See GDD §13 for the full process.
