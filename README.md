# Claude4Godot

A drop-in workflow for building Godot games with two Claude agents and one human:

| Who | Where | Responsible for |
|---|---|---|
| **You** (the developer) | — | Design, balance, art direction and priorities; playing and playtesting; approving commits and pushes. You have the final say on everything. |
| **Claude Cowork** | Claude desktop app | Design sessions, GDD revisions, planning `TASKS.md`, keeping the docs aligned, processing playtests |
| **Claude Code** | Terminal, IDE or desktop app | GDScript, scenes, `.tres` data, **running Godot** (the headless check) and **git** (commits and pushes, with your approval) |

Running Godot and git is **Claude Code's job only**. Cowork doesn't commit: when it changes files, it
lists them and gives you a ready-to-paste commit prompt for Claude Code. Neither agent makes design
decisions or picks final balance numbers — those are yours.

The agents coordinate through a small set of plain Markdown files — a design document, a task queue,
a system map, a router and a set of personas — so either agent can pick up where the other left off,
and so you always know what's decided, what's open and what's next.

---

## What's in this folder

```
Claude4Godot/
├── README.md          ← this file (for you)
├── ONBOARDING.md      ← the install-and-adapt script Cowork follows
├── .gdignore          ← keeps Godot from importing this folder
└── template/          ← the files that get installed into your project root
    ├── CLAUDE.md              entry point for every agent session
    ├── AGENTS.md              router: which doc/section to open for which task + ground rules
    ├── TASKS.md               the work queue + bug table + archive
    ├── SYSTEMS.md             what exists in code: systems, files, dependencies
    ├── README.md              skeleton for your project README (milestones, responsibility split)
    ├── design/gdd.md          Game Design Document skeleton with the revision + open-question process
    ├── playtesting/           loop-based playtest template, function-check list (every GDD rule,
    │                          human-checkable), and how feedback flows back into the GDD
    └── .promptx/personas/     shared core principles + 6 personas (developer, code reviewer,
                               game designer, planner, rebaser, merger)
```

After installation your project root holds `CLAUDE.md`, `AGENTS.md`, `TASKS.md`, `SYSTEMS.md`,
`design/`, `playtesting/` and `.promptx/`, and your `README.md` gains the milestone status and
responsibility sections (merged into it if you already had one). The `Claude4Godot/` folder can then
be deleted or kept for reference.

---

## Getting started

### 1. Copy Claude4Godot into your project

Copy the whole `Claude4Godot` folder into the root of your Godot project's git repository (next to
`project.godot`). It works for an empty repo, a brand-new project, or a game already in development.

### 2. Point both agents at the project folder

- **Claude Code:** open a session in the project root (the folder with `project.godot`). Make sure it can
  run Godot headlessly — you'll tell onboarding the path to your Godot binary.
- **Claude Cowork:** in the Claude desktop app, start a Cowork session and select the same project
  folder when it asks for folder access.

### 3. Ask Cowork to install and adapt Claude4Godot

Paste this into Cowork:

> Read `Claude4Godot/ONBOARDING.md` and follow it to install Claude4Godot into this project.

Cowork will scan the project and ask whether you're **adapting an existing game** or **starting
fresh**:

- **Existing game:** it maps your autoloads, scenes and scripts into `SYSTEMS.md`, drafts a GDD from
  your existing docs and code (clearly marked *"inferred — please confirm"*), and turns TODOs and known
  problems into `TASKS.md` rows and open questions.
- **New game:** it runs a short design interview (pitch, pillars, core loop, platforms, art direction)
  and writes a first GDD and a first set of setup tasks.

Existing files are never overwritten — Cowork merges into your `README.md`, `CLAUDE.md` and any other
file that already exists, and shows you what it changed.

### 4. Decide the responsibility split

Cowork walks you through who owns what — you, Claude Code, Cowork — using the default split as a
starting point (design and balance are yours; code, data schemas and placeholder art are Claude Code's;
design docs and planning are Cowork's). Change anything you like; the result is written into your
README and `AGENTS.md`, and every agent follows it from then on.

### 5. Align everything

Cowork does a final pass so the GDD, `TASKS.md`, `SYSTEMS.md`, `AGENTS.md` and the personas all agree
with each other and with what you want. It then lists every file it created or changed and gives you a
ready-to-paste commit prompt for Claude Code.

### 6. Start developing

- In **Claude Code**: paste the commit prompt Cowork gave you in step 5 (it runs the headless check and
  commits the listed files as one `docs:` commit), then say *"Do the next task."*
- In **Cowork**: brainstorm, answer open questions, plan, and keep the docs aligned while you play.

---

## How the workflow runs day to day

```
   you play / have an idea
            │
            ▼
 Cowork · Game Designer ──► options + a lean ──► you decide
            │
            ▼
 GDD revision (version bump)  +  new/updated TASKS.md rows  +  open questions (GDD §11)
            │
            ▼
 Claude Code · Developer ──► claims a ready task ──► implements ──► headless Godot check
            │
            ▼
 marks it done, updates SYSTEMS.md ──► you approve ──► commit + push
            │
            ▼
 playtest (how it feels) + function check (does every GDD rule work?)
            │
            ▼
 bugs table + new tasks + GDD revisions ──► repeat
```

### Useful prompts

| Say this | To | What happens |
|---|---|---|
| "Do the next task." | Claude Code | Picks the first `ready` row in `TASKS.md` (high-severity bugs first), claims it, builds it, runs the headless check |
| "Which open questions block development?" | Cowork | Ranks GDD §11 questions by what they unblock, with options and a lean for each |
| "Let's brainstorm {topic}." | Cowork | Design session; your answers become GDD revisions and task rows |
| "Review the documentation and make sure the tasks are aligned." | Cowork | Consistency pass across GDD, tasks, systems, README and routing; fixes drift and flags what needs your call |
| "Process my playtest." | Cowork | Turns a playtest report into GDD revisions, new tasks and bug rows |
| "Prepare a function check." | Cowork | Writes this round's checklist (built items only, Works / Broken boxes + Notes) — nothing to copy |
| "Process the function check." | Cowork | Broken items become bug rows or design changes; each item's last result is recorded; unchecked items stay for next round |
| "Prune the task list." | Cowork | Archives done tasks and bugs (nothing is deleted) |
| "Commit and push." | Claude Code | Commits exactly the files named, after the headless check, only with your approval |

---

## The rules both agents follow

- **You decide design.** Agents offer options and a lean; they write down only what you chose. Anything
  undecided goes into GDD §11 *Open Design Questions* instead of being guessed.
- **Numbers are placeholders.** Balance values live in `.tres` resources with labelled placeholder
  defaults; tuning is a playtesting job, not an agent decision.
- **Claim before editing.** A task's status becomes `in-progress: code` or `in-progress: cowork` before
  any work starts; agents never edit files listed in the other agent's claimed task.
- **Only Claude Code runs Godot and git.** Cowork's work on code or data ends at `needs-validation`; Claude
  Code runs the headless check and commits. Every push needs your approval.
- **Game logic lives in systems, not screens.** Screens display state and call system APIs — so the UI can
  be rebuilt without breaking gameplay, and state can be saved.
- **Small files, findable.** Every new system gets a `SYSTEMS.md` row; every new GDD section gets an
  `AGENTS.md` routing row. Agents read only what a task needs.
- **Spend where it pays.** Every task row carries a Size — `S`, `M` or `L` — that picks the model tier
  Claude Code (or its subagents) runs it on: smallest for data and simple fixes, mid for typical
  features, largest for cross-cutting work. It's set in seconds when the row is written, a task that
  gets stuck is rerun one size up, and no extra analysis passes run unless they're likely to save more
  than they cost.
- **Docs stay honest, and each fact lives in one place.** The GDD is the master for what the game is
  and always states the current design (history lives in git); `TASKS.md` is the only queue;
  `SYSTEMS.md` is the truth about what exists in code; your README tracks only milestones — one line
  each, including the human-owned ones (tuning placeholder values, production assets).
- **Everything in the GDD is checkable.** Every GDD rule has one item in
  `playtesting/FUNCTION_CHECK.md`, linked to its section and marked built, waiting on a task, or not
  planned — so a human can verify each function, and nothing in the design goes untracked.

---

## Requirements

- Godot 4.x (GDScript). Other languages work, but the templates assume statically typed GDScript.
- A git repository for the project.
- Claude Code, and the Claude desktop app with Cowork.

## Customising Claude4Godot itself

Everything is plain Markdown. Change a principle in `template/.promptx/personas/_core-principles.md`,
add a persona and list it in `template/CLAUDE.md`, or reshape the GDD skeleton — then copy the updated
folder into your next project.
