---
name: godot-director
description: 'Sets up Claude4Godot in a Godot 4 project: you direct the game design while the AI builds it, design calls come to you as options, and one project check proves every change works. Use when the user asks to install, set up, upgrade or migrate Claude4Godot, or wants an AI design-and-build workflow for a Godot game.'
license: MIT
compatibility: 'Godot 4.3 or newer, git and bash (Git Bash on Windows). Needs network access to fetch Claude4Godot from GitHub unless it is already present.'
metadata:
  author: Freakling
  version: 2.0.2
  repository: https://github.com/Freakling/Godot-Director
---

# Claude4Godot setup

This skill only installs Claude4Godot. The workflow itself is committed into the game, so it keeps working without this skill.

1. **Find Claude4Godot (`$C4G`)**, the folder that holds `ONBOARDING.md` and `install.sh`. Use the first that exists:
   - `${CLAUDE_PLUGIN_ROOT}`, when this skill runs from the Claude Code plugin;
   - a `Claude4Godot/` folder in the game's root, for a manual install;
   - otherwise fetch it outside the game, so nothing lands in the game's repository. With bash (Git Bash on Windows):
     ```bash
     C4G="${TMPDIR:-/tmp}/claude4godot"
     if [ -d "$C4G/.git" ]; then git -C "$C4G" pull --ff-only; else git clone --depth 1 https://github.com/Freakling/Godot-Director.git "$C4G"; fi
     ```
     Pulling each time means an upgrade is simply running this skill again.
2. **Read `$C4G/ONBOARDING.md` and follow it** for the project in the current working directory, with `$C4G` set to that folder.
