> **Installing Claude4Godot into a game?** Ignore this file and follow `ONBOARDING.md`. This file is
> only for working on Claude4Godot itself.

# Claude4Godot (the framework itself)

This repository is Claude4Godot, the workflow that gets installed into Godot games. It is not a game.

- **Templates, not instructions.** `framework/` and `project/` are templates. The rules, procedures, skills, agents and settings in them are the product being edited here: they're instructions for games, not for this repository, so don't follow them while working on the framework. Claude Code shows `framework/.claude/skills` as nested skills; ignore them here.
- **What's where.**
  - `framework/` holds files installed into games and replaced on upgrade. That's the tool-neutral core (`.claude4godot/`, `tools/`, `.githooks/`, `playtesting/README.md`) plus one folder per assistant adapter (`.claude/`).
  - `project/` holds seeds, copied once and then owned by the game.
  - `.claude-plugin/` and `skills/setup/` make this repository a Claude Code plugin whose only job is running `ONBOARDING.md`.
  - `examples/market-day` is a small game that uses the workflow; the self-test runs against it.
- **One place per rule.** Rules live in `framework/.claude4godot/rules.md`. Each procedure lives in `framework/.claude4godot/procedures/`, and the adapters only point at it. Install, migration and upgrade are in `ONBOARDING.md`. If you find a rule copied into a second file, delete the copy and link to the original.
- **Tool-neutral core.** Nothing in `.claude4godot/`, `tools/` or `.githooks/` may depend on one assistant. Tool-specific behaviour belongs in that tool's adapter folder.
- **After any change:**
  1. Run `bash selftest.sh <path to Godot 4.3+>`. It must pass.
  2. Add the change to `CHANGELOG.md`, with "Upgrade steps" if games' own files need changing.
  3. For a release, bump `VERSION` and `.claude-plugin/plugin.json` together; the self-test checks that they match.
  4. If the change affects what a game's files look like, update `examples/market-day` too.
- **Scripts** must run in Git Bash on Windows, in macOS bash 3.2 with BSD tools, and on Linux. Use `/usr/bin/find`, `/usr/bin/sort` and `/usr/bin/tar` instead of the Windows programs with the same names. Avoid GNU-only flags and `declare -A`. Keep process starts few, because they're slow on Windows. Keep files LF (see `.gitattributes`).
- **GDScript** here must compile on Godot 4.3+ with `untyped_declaration=2`.
