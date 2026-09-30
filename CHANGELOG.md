# Changelog

Each entry lists what changed. An entry that requires changes to a game's own files (AGENTS.md, TASKS.md, the GDD) ends with **Upgrade steps**, which onboarding carries out during an upgrade.

## 2.0.1 (2026-09-30)

- The check no longer mistakes a type annotation that names an autoload's inner type, such as `var store: GuildStorage.Store = …`, for a screen writing to the autoload. It also ignores capitalised members, which are types and constants that can't be assigned to. Found while migrating a real game.

## 2.0.0 (2026-09-30)

A rework of the foundation. It has fewer files to keep in sync, a core that works with any assistant, and rules enforced by tooling instead of by reminders. To migrate a 1.x project, follow `ONBOARDING.md`; it detects 1.x.

### One core for any assistant, adapters per tool
- **The tool-neutral core** is `.claude4godot/rules.md` and `.claude4godot/procedures/*.md`, plus `tools/` and `.githooks/`. A game's `AGENTS.md` points to it; most assistants read `AGENTS.md` natively.
- **The Claude Code adapter** lives in `.claude/`. Its skills are thin wrappers that point to the procedures. It also holds the `builder` subagent (builds each item in a fresh context, on Haiku for `S` items if model sizing is on) and the read-only `reviewer` subagent, permissions, a Stop hook that runs the check, and a guard hook that blocks risky git commands wherever they appear in the command line. A game's `CLAUDE.md` is `@AGENTS.md`.
- **`install.sh --tools claude|none`** picks the adapters. Adding an adapter for another assistant means adding its files; nothing needs restructuring.
- **A Claude Code plugin** (`/claude4godot:setup`) runs onboarding. It is only the installer: the workflow itself is committed in the game.
- **Cowork is gone,** along with everything that coordinated two tools. From a phone, use Claude Code's Remote Control or Dispatch.

### Context and tokens
- Builds run in the `builder` subagent (`.claude4godot/procedures/build.md`), one at a time and in the foreground. The main session keeps only its short report: result, files, how each outcome is met, systems and API/save changes, placeholders, questions and discovered work. So a session that works through several items ("do the next 3 tasks") stays small. A design question from a build comes with options, and the answer is recorded in the GDD before the rebuild.
- The TASKS.md item format moved to `.claude4godot/tasks.md`, which only the procedures that write items read. The always-loaded rules are smaller, for the main session and for every subagent.
- The records are the hand-off: after a commit, a fresh session or `/clear` loses nothing. A paused item gets a one-line `Note:`.
- Model sizing now only chooses the builder's model (Haiku for `S` items), which replaced the separate `dev-small` subagent.

### Verification
- **New `tools/check.sh` + `tools/check.gd`.** They replace `godot --headless --path . --quit`, which only parsed scripts the main scene reached, exited 0 on parse errors, and failed on a fresh clone. The new check:
  - runs the import pass on every run (new assets and `class_name`s need it, and it's quick when nothing changed);
  - loads every script, scene and resource;
  - runs the tests;
  - fails when a screen script uses randomness or assigns to an autoload;
  - scans Godot's output for errors;
  - exits 0 (pass), 1 (fail) or 3 (couldn't run).

  It locks against concurrent runs, and `--if-changed` reuses the last pass.
- **What the check doesn't do:** plain GDScript warnings aren't printed, since that needs `-d`, and `-d` can wait for debugger input. Raise the warnings that matter to Error in `project.godot`. `untyped_declaration=2` is the default; the `unsafe_*` warnings are left to each project, because they flag a lot of ordinary dynamic code.
- **A built-in test base,** `tools/test_case.gd`. Each test runs on a fresh instance, and tests that use `await` are rejected. GUT and gdUnit4 suites are skipped and can run from `tools/check.local.sh`.
- **`[screens] known`** in `tools/check.cfg` accepts known violations while "Decouple:" items fix them.
- **`tools/setup-clone.sh`** handles each clone:
  - It finds Godot and saves the path in `tools/godot_bin.local`. That file is gitignored, and is read by the check and the git hook alike; that's why the path isn't in `.claude/settings.local.json`, which only Claude Code reads.
  - It installs a small pre-commit hook in `.git/hooks`, instead of setting `core.hooksPath`, so Git LFS and existing hooks keep working.

### Fewer files, one home per fact
- **Removed:** `SYSTEMS.md`, `.promptx/` (six personas and the core principles), `playtesting/FUNCTION_CHECK.md`, GDD §10 and §13, and the README's status and responsibility sections.
- **`AGENTS.md`** holds project facts, the layout, the architecture table (formerly `SYSTEMS.md`) and project rules.
- **Personas became procedures:** `next-task`, `design`, `playtest`, `function-check`, `align`, `prune`, `review`. Rebaser, Merger and Multiplan Manager were dropped. Their few useful rules, such as TASKS.md merge conflicts and non-interactive history cleanup, moved into `rules.md`.

### Records
- **TASKS.md:**
  - one heading per item;
  - statuses `todo` / `in-progress YYYY-MM-DD` / `done` ("ready" is derived);
  - an owner field;
  - bugs in the same queue as `B` items;
  - milestones at the top;
  - a `Next IDs` line;
  - done items go to `TASKS-archive.md`.
- **`Done when` outcomes are tagged** `(test)`, `(check)` or `(play)`. "Done" means the tests and the check pass and the `(play)` outcomes are implemented. Function checks are built from the `(play)` outcomes, and `all` adds GDD rules no done item covers.
- **GDD:** no section numbers, and references use heading names. There's no version number either: git holds the history, and **`design/decisions.md`** records why each decision was made.
- **Playtests** are named by date, with the build hash. Design findings are proposed to the human, not applied directly.
- **Commits** are one per item, restricted to its own paths (`git commit -- <paths>`), so parallel sessions don't take each other's staged work.

### Godot guidance
- **Saves and settings** are JSON in `user://`. Resource, `ConfigFile` and `str_to_var` data is never loaded from player-editable files. Autoloads skip player data while the check runs (`Engine.has_meta("claude4godot_check")`).
- **Dev tools** are gated on `OS.is_debug_build()` or a feature tag, and excluded from release presets.
- **Rule classes** are `RefCounted` and testable; there's one system per script.
- **Placeholders** carry `## PLACEHOLDER` on the schema field, because Godot rewrites `.tres` files on save.
- **Syntax** is Godot 4 only, with the Godot 3 forms listed so they're avoided.

### Installing and upgrading
- **MIT license** (`LICENSE`). Installed games get a copy in `.claude4godot/LICENSE`, so the notice travels with the files.
- **`install.sh`** is deterministic:
  - It keeps a manifest in `.claude4godot/manifest`.
  - It replaces files you haven't changed, and keeps your edits when upstream didn't change the file. It writes `<file>.c4g-new` only when both changed.
  - It removes files that were dropped from the framework.
  - It compares contents the way git does, so CRLF checkouts don't count as edits.
  - It writes LF files and makes the scripts executable.
  - It refuses a folder that isn't a repository root.
- **The pre-commit hook** refuses while unmerged `.c4g-new` files exist.
- **`examples/market-day`** is a small worked example. **`selftest.sh`** tests the installer, the check, the hooks and the guard against it, and **`examples/scenarios.md`** lists behaviour checks to run by hand.
