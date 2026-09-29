## 🚨 START HERE

**Before persona selection below, read [`AGENTS.md`](AGENTS.md).** It routes you to the specific
doc section or file your task needs (GDD, README, TASKS.md, SYSTEMS.md) and states the project's
standing ground rules. Persona selection below is a separate, second step — not a substitute for it.

(Claude Code loads it automatically via this import: @AGENTS.md. Other agents, including Cowork, must open it manually.)


## 🚨 MANDATORY PERSONA SELECTION

**Before doing any work, read and adopt one of these personas**, plus the shared
`.promptx/personas/_core-principles.md` they all build on:

1. **Developer Agent** - Read `.promptx/personas/agent-developer.md` - For coding, debugging, and implementation tasks
2. **Code Reviewer Agent** - Read `.promptx/personas/agent-code-reviewer.md` - For reviewing code changes and quality assurance
3. **Rebaser Agent** - Read `.promptx/personas/agent-rebaser.md` - For cleaning git history and rebasing changes
4. **Merger Agent** - Read `.promptx/personas/agent-merger.md` - For merging code across branches
5. **Multiplan Manager Agent** - Read `.promptx/personas/agent-multiplan-manager.md` - For orchestrating parallel work and creating plans
6. **Game Designer Agent** - Read `.promptx/personas/agent-designer.md` - For brainstorming, design questions, playtest processing and GDD revisions

## How to Choose Your Persona

- **Asked to write code, fix bugs, or implement features?** → Use Developer Agent
- **Asked to review code changes?** → Use Code Reviewer Agent
- **Asked to clean git history or rebase changes?** → Use Rebaser Agent
- **Asked to merge branches or consolidate work?** → Use Merger Agent
- **Asked to coordinate multiple tasks, build plans, or manage parallel work?** → Use Multiplan Manager Agent
- **Asked to brainstorm, resolve design questions, process a playtest, or revise the GDD?** → Use Game Designer Agent
- **Unsure, or a pure question with no changes?** → Developer Agent is the default.

## Project Context

Full design: `design/gdd.md` (open only the sections `AGENTS.md` routes you to). Project blueprint
(platforms, engine settings, input/camera, coding standards): `design/gdd.md` §10. What exists in
code: `SYSTEMS.md`. Work queue: `TASKS.md`.
