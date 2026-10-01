# Claude4Godot

**Make the game you designed, with AI doing the building and you staying the designer.**

A workflow for Godot projects, new or already in development. You decide the design, the balance and the priorities. The AI builds, tests and keeps the records. Built for Claude Code, and usable with any AI coding assistant that reads `AGENTS.md`. Everything lives in your game's own git repository.

## Why

AI writes game code fast. Without structure, that speed goes wrong in familiar ways:

- **The design drifts.** The AI quietly decides a mechanic or a number you never agreed to. With Claude4Godot, design calls come to you as 2–4 options with a recommendation. Only your choice is written down, and anything undecided goes on an open-questions list instead of being guessed.
- **"Done" means "it compiled".** One check defines "works": the whole project loads and the tests pass. It runs before every commit that touches code, and in Claude Code also before the AI ends its turn.
- **Rules end up inside UI screens.** Game rules live in testable classes and screens only display them. The check fails when a screen rolls dice or writes game state.
- **Context gets lost between sessions.** A few plain files hold everything: the design document, a decision log, the task queue, and an architecture table. Each fact has one home, so any session picks up where the last one stopped.

## How to use it

### Install

Your game needs git (`git init` if it has none) and no uncommitted changes. You also need Godot 4.3 or newer, and bash (on Windows it comes with Git for Windows).

**Option 1: the skill.** In your game's folder, run:

```
npx skills add Freakling/Godot-Director
```

That installs the `godot-director` skill for your assistant (Claude Code, Cursor, Codex and many others; you pick in the prompt). Then ask your assistant to set up Claude4Godot, or in Claude Code run `/godot-director`. The skill fetches Claude4Godot outside your game and runs onboarding.

**Option 2: the Claude Code plugin.** In Claude Code:

```
/plugin marketplace add Freakling/Godot-Director
/plugin install claude4godot@claude4godot
```

Then open a new Claude Code session in your game's folder (or run `/reload-plugins`), and run `/claude4godot:godot-director`.

**Option 3: manual install.** Put this repository in your game's root folder, next to `project.godot`, as a folder named `Claude4Godot`. Either run `git clone https://github.com/Freakling/Godot-Director.git Claude4Godot` there, or download the zip and rename the extracted `Godot-Director-main` folder. Then ask your assistant:

> Read Claude4Godot/ONBOARDING.md and follow it to install Claude4Godot into this project.

Either way, onboarding works out whether this is a new game, an existing game, a Claude4Godot 1.x project to migrate, or an upgrade. It then:
1. installs the files and finds your Godot;
2. interviews you (new game) or reads the existing game;
3. agrees with you who owns what;
4. ends with one commit for you to approve.

Afterwards, restart Claude Code so the new commands load. Each new clone of the game later needs one command: `bash tools/setup-clone.sh`.

**With another AI assistant:** tell onboarding, and it installs the tool-neutral core only (`--tools none`); you can also keep the Claude adapter alongside. Your assistant reads `AGENTS.md`, which points it to `.claude4godot/rules.md` and the procedures. The check and the git hook work the same for every tool, and for you.

### Upgrade
- **Skill:** ask for the skill again (`/godot-director` in Claude Code); it fetches the latest Claude4Godot each time.
- **Plugin:** run `/plugin marketplace update claude4godot` and then `/plugin update claude4godot@claude4godot`. Start a new session in the game, and run `/claude4godot:godot-director` again.
- **Manual:** put the new Claude4Godot folder in the game, and ask for ONBOARDING.md again.

Only Claude4Godot's own files are replaced, and your edits to them are kept. When a new version also changes a file you edited, the new version is written next to it as `<file>.c4g-new` for you to merge. Review the result with `git diff`.

### Day to day

| Say | What happens |
|---|---|
| "Do the next task" (`/next-task`) | Builds the next ready item (high-severity bugs first), proves it with the check, updates the records, and asks you to approve the commit. |
| "Do the next 3 tasks", "Work through the queue" | The same, item after item, until one needs you. |
| "Which open questions block development?" (`/design questions`) | Ranks the open design questions by what they unblock, with options and a recommendation for each. |
| "Let's brainstorm {topic}" (`/design {topic}`) | A design session. Your decisions become GDD text, decision-log lines and task items. |
| "New playtest", "Process my playtest" (`/playtest`) | Creates a report from the template, or turns a filled-in one into bugs, score trends and design proposals. |
| "Prepare a function check", "Process the function check" (`/function-check`) | A checklist of what's been built since the last round and needs a human eye; you tick Works or Broken. |
| "Check the docs are aligned" (`/align`) | A consistency pass. Drift gets fixed; gaps and conflicts come to you. |
| "Prune the task list" (`/prune`) | Moves done items to `TASKS-archive.md`. |

```
you play, or have an idea
        │
        ▼
design session ── options + a recommendation ── you decide ──► GDD + decisions.md + TASKS.md items
        │
        ▼
next task ── builds the next ready item ── tests ── bash tools/check.sh ──► commit (you approve)
        │
        ▼
playtest (how it feels)   ·   function check (does each built rule work?)
        │
        ▼
bugs and design proposals ── you decide ── repeat
```

**From your phone:** start a Claude Code session on your workstation, turn on Remote Control (`/remote-control`), and continue it from the Claude mobile app; or send a task with Dispatch. The work still runs on your workstation, with Godot, git and your files, so the workstation has to stay awake.

---

## What this is

### Who does what
| | Responsible for |
|---|---|
| **You** | Design, balance, art direction, priorities; playing and playtesting; approving commits. You have the final say on everything. |
| **The AI assistant** | GDScript, scenes, `.tres` schemas, placeholder art, tests, running Godot and git, keeping the records true. |

### What gets installed in your game
```
your-game/
│  yours: never overwritten
├── AGENTS.md                   for every assistant: project facts, layout, architecture, project rules
├── CLAUDE.md                   "@AGENTS.md", for Claude Code
├── TASKS.md                    milestones and the queue (tasks and bugs)
├── design/gdd.md               the game's current design, and Open Questions
├── design/decisions.md         why: one line per design decision
├── playtesting/TEMPLATE.md     playtest template, one section per core loop
├── tools/check.cfg             check settings: screen folders, folders to skip
│
│  Claude4Godot's, tool-neutral: updated on upgrade
├── .claude4godot/rules.md      the workflow rules, loaded through AGENTS.md
├── .claude4godot/tasks.md      the TASKS.md item format, read when items are written
├── .claude4godot/procedures/   next-task · build · design · playtest · function-check · align · prune · review
├── tools/check.sh, check.gd    the check;  tools/test_case.gd: base for tests in tests/
├── tools/setup-clone.sh        per clone: finds Godot, installs the pre-commit hook
├── .githooks/pre-commit        runs the check before commits that touch code, scenes or data
├── playtesting/README.md       how playtests and function checks work
│
│  Claude4Godot's, Claude Code adapter: updated on upgrade
├── .claude/skills/             /next-task and the rest: each points to its procedure
├── .claude/agents/             builder (builds each item in a fresh context) · reviewer (read-only)
├── .claude/hooks/              runs the check before a turn ends; blocks risky git commands
└── .claude/settings.json       permissions, hooks, timeouts
```
Machine-local and gitignored: `tools/godot_bin.local` (the path to your Godot) and `.claude/settings.local.json`.

### The rules, briefly
The full rules are in `.claude4godot/rules.md`, and the assistant reads them every session.
- **You decide design.** The assistant offers options and a recommendation. It never picks balance numbers (new values are marked `## PLACEHOLDER`), and never answers an open question itself.
- **Each fact lives in one place,** and is updated in the same change that makes it untrue.
- **Rules live in systems, not screens.** They sit in plain classes that tests can build directly. Saves are JSON in `user://`, never Resources, which can run scripts when loaded.
- **Done means the check passes,** and the work is committed only with your approval.
- **Guarded git:** in Claude Code, force-push, `reset --hard`, `--no-verify` and other work-destroying commands are blocked by a hook that checks the whole command line. It's a strong safety net, not a guarantee.

In Claude Code's default mode, the harness asks you before each commit and push. In auto or bypass mode those prompts don't appear, so the rules tell the assistant to ask you in the conversation instead.

### Context and token use
- **Small at the start.** A session starts with about 10 KB of instructions (AGENTS.md and the rules). Each procedure, and the task format, loads only when it's used.
- **Builds run in a fresh context.** In Claude Code, the `builder` subagent reads, edits and checks, and the main session keeps only its short report. A session that gets through several tasks stays small instead of carrying every file it touched.
- **Nothing to hand off.** TASKS.md, the commits and AGENTS.md hold the state, so after a commit you can `/clear`, or start a new session, and lose nothing. An item paused midway gets a one-line `Note:`.
- **Model sizing** (optional, off by default): builds of small items run on Haiku. Turn it on in AGENTS.md › Project rules.

### The check
`bash tools/check.sh` runs four steps:
1. Godot's import pass;
2. loads every script, scene and resource, checks screen scripts for game rules, and runs `tests/**/test_*.gd`;
3. scans Godot's output for errors;
4. runs `tools/check.local.sh`, if the game has one.

It exits 0 on pass, 1 on fail, and 3 when it can't run. It remembers the last passing state, so hooks don't run it again when nothing has changed. Game-specific settings go in `tools/check.cfg`, and extra steps (for example an existing GUT suite) go in `tools/check.local.sh`.

### Customising
- **Project-specific rules** go in AGENTS.md › Project rules, where they win over the defaults. Project-wide Claude permissions and hooks go in `.claude/settings.json`. Per-machine ones go in `.claude/settings.local.json`.
- **Change the framework itself:** edit `framework/` (installed files) or `project/` (seeds for new games), add the change to `CHANGELOG.md`, and run `bash selftest.sh <path to Godot>`. Then upgrade your games.

### This repository
| Path | |
|---|---|
| `ONBOARDING.md` | what the assistant follows to install, migrate or upgrade |
| `install.sh` | copies the files deterministically, keeps your edits, writes a manifest (`--tools claude\|none`) |
| `framework/` | installed into each game: the tool-neutral core, plus `.claude/` for Claude Code |
| `project/` | seeds for the game's own files, copied only when missing |
| `skills/godot-director/` | the installer skill, for `npx skills add` and the plugin |
| `.claude-plugin/` | the Claude Code plugin (`/claude4godot:godot-director`) |
| `examples/market-day/` | a tiny game that uses the workflow: a worked example, and the self-test's fixture |
| `examples/scenarios.md` | prompts to try after changing the framework, to check that behaviour still holds |
| `selftest.sh` | tests the installer, the check and the hooks (`bash selftest.sh [path to Godot]`) |
| `CHANGELOG.md` | what changed, and the upgrade steps for games |
| `CLAUDE.md` | instructions for an assistant working on Claude4Godot itself |

## License
MIT © 2026 Vikingur Saemundsson: see [LICENSE](LICENSE). You may use, fork and change Claude4Godot, including in commercial games, as long as the copyright notice and the license stay with it. Installed games carry a copy in `.claude4godot/LICENSE`.
