# Claude4Godot — Onboarding script (for Claude Cowork)

You are installing Claude4Godot into the Godot project this folder sits in, and adapting it to that
project. Follow the steps in order. The human decides everything that is a design or ownership call;
you gather, propose, write and align.

**Placeholders** in `template/` look like `{{NAME}}`. Every one must be replaced or removed before you
finish — search for `{{` at the end.

| Placeholder | Meaning |
|---|---|
| `{{PROJECT_NAME}}` | The game's name |
| `{{ONE_PARAGRAPH_PITCH}}` | A 3–5 sentence description of the game |
| `{{GODOT_VERSION}}` | e.g. `4.4` |
| `{{GODOT_BIN}}` | The command Claude Code uses to run Godot, e.g. `godot`, `Godot.exe`, `/Applications/Godot.app/Contents/MacOS/Godot` |
| `{{PLATFORMS}}` | Target platforms |
| `{{DIMENSION}}` | `2D`, `3D` or both |
| `{{DATE}}` | Today's date |
| `{{LOOP_1}}`, `{{FIXED STATEMENT…}}`, `{{Open question…}}` | Only in `playtesting/TEMPLATE.md`: one section per core gameplay loop, each with a fixed scored statement and open questions (see Step 3) |
| `{{GDD_VERSION}}`, `{{SYSTEM NAME}}`, `{{Observable behaviour…}}`, `{{how to reach it}}` | Only in `playtesting/FUNCTION_CHECK.md`: one item per GDD rule (see Step 3) |

Placeholders appear in `AGENTS.md`, `TASKS.md`, `README.md`, `design/gdd.md`,
`playtesting/TEMPLATE.md`, `playtesting/FUNCTION_CHECK.md` and
`.promptx/personas/_core-principles.md`.

---

## Step 0 — Check your access

1. Confirm you can read and write the project root (the folder containing `project.godot`, or the repo
   root if there's no project yet). If you can't, ask the human to connect that folder.
2. Read this whole file, then `Claude4Godot/README.md`. Read the files in `Claude4Godot/template/` as
   you install them.

## Step 1 — Scan the project

Collect, without changing anything:

- Does `project.godot` exist? Its `[application]` name, `[autoload]` entries, rendering method, and
  display/stretch settings.
- Folder layout: where scripts, scenes, resources/data, assets and tests live. Count `.gd`, `.tscn`,
  `.tres` files per folder.
- Existing docs: `README.md`, `CLAUDE.md`, `AGENTS.md`, any design doc, TODO lists, changelogs,
  issue exports. Note every file that the template would collide with.
- `TODO` / `FIXME` / `HACK` comments in scripts (file + line + text).
- Anything that looks like game logic living inside UI/screen scripts (e.g. random rolls or state
  writes in a screen controller) — note it; it may become a decoupling task.

Then **ask the human** (use your multiple-choice question tool):

- Is this an **existing game in development** or **a fresh start**? (Suggest the answer your scan points
  to.)
- The values for the placeholders above that the scan couldn't find — especially `{{GODOT_BIN}}`.

## Step 2 — Install the files

For each file in `template/`, copy it to the same relative path in the project root:

- **If the target doesn't exist:** copy it.
- **If it exists** (commonly `README.md`, `CLAUDE.md`, `AGENTS.md`): **don't overwrite.** Merge — keep
  the human's content, add the Claude4Godot sections that are missing, and list what you merged. For
  `README.md`, add the "Project Status", "Roadmap" and "AI vs. Human Responsibilities" sections and the
  doc-ownership table from `template/README.md` if they're missing.
- Keep the empty `.gdignore` files in `design/` and `playtesting/` — they stop Godot from importing
  those Markdown folders. (`.promptx/` is a hidden folder, which Godot skips anyway.)
- Replace the placeholders you already know.

## Step 3a — Existing game: adapt from what's there

1. **`SYSTEMS.md`:** one row per autoload, per screen/scene group and per data folder you found. Fill
   "What it owns" from reading the scripts' top comments and public functions, not from guessing.
2. **`design/gdd.md`:** fill each section from existing docs and code. Anything you inferred rather
   than read in a design doc is marked *"(inferred — please confirm)"*. Anything you can't tell becomes
   a numbered question in §11 *Open Design Questions*. Delete sections the game doesn't need (e.g.
   meta-progression) only after the human agrees.
3. **`TASKS.md`:** turn TODOs, known bugs and the human's current priorities into rows (bugs into the
   `## Bugs` table). If logic lives in screens, propose `[Decouple]` tasks that move it into systems.
4. **`AGENTS.md`:** one routing row per GDD section you filled, plus the existing-code folders.
5. **`playtesting/TEMPLATE.md`:** replace the `{{LOOP_…}}` sections with one section per core loop
   from the GDD, each with one fixed scored statement and 1–2 open questions about decisions and
   feel. If the loops aren't clear yet, leave the placeholders and add a `TASKS.md` row for Cowork:
   "Fill the playtest template's loop sections (after GDD §3 is decided)".
6. **`playtesting/FUNCTION_CHECK.md`:** replace the example items with **one item per rule in the
   GDD**, grouped by GDD section and linked to it (GDD §13.4). For each item, set the build status
   from what you found in the code: ✔ if it clearly exists (name the task if there is one, otherwise
   "✔ existing"), ⏳ with the task ID if a `TASKS.md` row covers it, ⚠ if nothing does. Show the human
   the ⚠ list — those are rules nobody has planned yet.

## Step 3b — Fresh start: design interview

Adopt the Game Designer persona (`template/.promptx/personas/agent-designer.md`). Keep it short — a
few questions per round, options with a lean, the human picks:

1. Pitch, genre and the feeling the game should give.
2. 3–5 Design Pillars (§2).
3. The core loop: moment-to-moment, session, and run/campaign level (§3).
4. Platforms, input, 2D/3D, art direction (placeholder-art policy), target aspect ratios (§10).

Write the answers into the GDD; everything undecided goes into §11. Seed `TASKS.md` with setup rows,
e.g. project settings, folder layout, a first autoload for game state, a first playable scene, and the
headless check passing. Fill the playtest template's loop sections from the core loop you agreed
(same as Step 3a item 5), and write the function check from the GDD you just drafted (Step 3a item 6)
— for a fresh game every item starts as ⏳ or ⚠.

## Step 4 — Responsibility split

Walk the human through the default split in `template/README.md` ("AI vs. Human Responsibilities") and
the two-agent table in `template/AGENTS.md`. For each row, ask whether it fits; change owners, folders
and rules to match their answers. Common adjustments:

- Which folders each agent owns (code folders for Claude Code, docs folders for Cowork).
- Whether AI may produce any non-placeholder art, audio or text content.
- Whether Claude Code may push directly or only commit locally.
- Which personas they want (remove unused ones from `CLAUDE.md`).

Write the result into the README table, the `AGENTS.md` two-agent table and, if principles changed,
`.promptx/personas/_core-principles.md`.

## Step 5 — Alignment pass

Check, and fix what's yours to fix:

- No `{{` placeholders remain — except in `playtesting/TEMPLATE.md` if you deliberately left its loop
  sections for later and added the `TASKS.md` row for it.
- Every GDD section has an `AGENTS.md` routing row; every `SYSTEMS.md` row has a GDD ref (or `—`).
- Every `TASKS.md` row has Status, Depends on, Touches, Done when and GDD ref; `ready` rows have all
  dependencies `done`.
- Every GDD rule has a `FUNCTION_CHECK.md` item, every item links to an existing GDD heading, and every
  ⏳ item names a real task.
- The headless command uses the real Godot binary everywhere it appears: `AGENTS.md`,
  `.promptx/personas/_core-principles.md`, `TASKS.md` (row T1) and `README.md` (Getting Started).
- The personas listed in `CLAUDE.md` all exist.

## Step 6 — Hand-off

Tell the human, briefly:

1. What mode you used and what you inferred that needs their confirmation.
2. **Every file you created or changed** (the full list — Claude Code commits exactly what you name).
3. A ready-to-paste prompt for Claude Code:

   > Run the headless check, then commit these files as one `docs:` commit — "docs: install
   > Claude4Godot workflow" — and push only if I approve: {file list}

4. The next steps: in Claude Code, "Do the next task"; in Cowork, "Which open questions block
   development?"

Finally, ask whether to delete the `Claude4Godot/` folder or keep it for reference.
