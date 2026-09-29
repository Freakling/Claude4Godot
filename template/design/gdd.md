# {{PROJECT_NAME}} — Game Design Document

**Version:** 0.1 (initial draft from Claude4Godot onboarding, {{DATE}})
**Engine:** Godot {{GODOT_VERSION}} (GDScript)
**Platforms:** {{PLATFORMS}}
**Genre:** *(fill in)*

> **How this document works.** It describes design *intent*; `SYSTEMS.md` describes what exists in code.
> Every change is a **revision** (§13.3): bump the version line and note what changed and why. Anything
> undecided goes into §11 *Open Design Questions* — agents never guess an answer. Sections marked
> *(optional)* can be deleted if the game doesn't need them. Keep sections small: add a subsection (and
> an `AGENTS.md` routing row) rather than growing one long section.

---

## 1. High-Concept Pitch

{{ONE_PARAGRAPH_PITCH}}

---

## 2. Design Pillars

3–5 short statements every feature is checked against. Agents flag, never reinterpret, a change that
seems to contradict a pillar.

1. *(pillar)*
2. *(pillar)*
3. *(pillar)*

---

## 3. Core Gameplay Loop

### 3.1 Macro loop (run / campaign)
*(How a whole run or campaign unfolds and ends.)*

### 3.2 Session loop
*(What the player does in one sitting — e.g. a turn, a day, a level.)*

### 3.3 Starting conditions
*(What the player starts with, and why.)*

---

## 4. Meta-Progression *(optional)*

*(What carries over between runs, if anything.)*

---

## 5. Screens & Systems

One subsection per system or screen. Each should say what the player does there, what the system
owns, and how it connects to others. Add an `AGENTS.md` routing row for each.

### 5.1 *(system name)*

---

## 6. Characters / Units *(optional)*

*(Stats, progression, roles or classes, death and recovery.)*

---

## 7. World, Narrative & Lore *(optional)*

---

## 8. Difficulty & Scaling

*(How challenge grows; which numbers scale. Actual values live in `.tres`.)*

---

## 9. Win / Loss Conditions

---

## 10. Technical Blueprint

### Target Platforms
{{PLATFORMS}}. Target aspect ratio(s): *(e.g. 16:9 base; decide whether ultrawide and phone ratios
must work)*.

### Engine & Graphics Settings
*(Renderer, 2D/3D ({{DIMENSION}}), stretch mode and aspect, camera approach.)*

### Input & Camera Architecture
*(Mouse/keyboard, controller, touch; camera rules.)*

### Coding Standards
- Statically typed GDScript everywhere.
- **Game rules live in systems, not screens.** Autoloads or plain classes own rules and state; screens
  only display state and call system APIs. This keeps the UI rebuildable and the state saveable
  (every system holding run state should be able to serialize it).
- Many small, single-purpose files; every system has a `SYSTEMS.md` row.
- UI built from responsive containers; no hardcoded pixel positions.

### Architecture (intent)
*(Planned autoloads/systems and how they talk. `SYSTEMS.md` is authoritative for what exists.)*

### Content & Balance Pipeline
- All tunable values (stats, costs, rewards, curves, chances) live in `.tres` Resource files under
  `data/`, with schemas in `scripts/resources/`. Agents add fields with clearly labelled placeholder
  defaults; the human tunes values.

### Art Direction: Primitives First *(default — adjust during onboarding)*
- Agents build placeholder visuals from Godot's built-in primitive meshes / simple shapes and flat
  materials. No external models, textures or audio unless the human asks.
- Scenes are structured so placeholder art can be swapped for production art without restructuring
  the scene tree (a stable, named node the human can re-parent finished art under).
- The human owns production art.

### Settings & Dev Tools *(recommended)*
- **`settings.json`** holds user configuration. It's read from the project root in the editor and from
  next to the executable in exported builds (the packed `res://` is read-only), falling back to
  `user://`. Missing file or keys → defaults.
- **Dev menu** — enabled by `"dev_menu": true` in `settings.json` (default `false`). A hotkey opens an
  overlay for quick testing through existing system APIs (add resources, spawn entities, skip time,
  force outcomes). When disabled, none of it exists in the running game.
- The dev menu has **a tab per system** and a **read-only state inspector** for hidden values (timers,
  hidden meters, random rolls' inputs). **Every new system or feature adds its own dev-menu actions and
  inspector fields as part of its task**, so the menu always covers the whole backend.

---

## 11. Open Design Questions

Numbered, never renumbered. When answered: strike through, mark **Resolved vX.Y**, and point to the
section where the answer now lives. Follow-up questions get new numbers.

1. *(question)*

---

## 12. Glossary

| Term | Definition |
|---|---|

---

## 13. Playtesting Process

The GDD is a living document, and **playtest feedback is the primary mechanism for revising it** once a
feature is playable.

### 13.1 Cadence
- At least **one playtest per feature update** — whenever a meaningful, playable slice lands.

### 13.2 Structure & Location
- Reports live at `playtesting/<version>/playtest_<#>.md`, using `playtesting/TEMPLATE.md`.
  `<version>` matches this document's version.
- The template is organised by **gameplay loop, not by feature**: questions ask what the player
  decided, why, and how it felt. Each loop section has one **fixed 1–5 scored statement** that stays
  identical across builds so scores can be compared; changing a statement's wording is a GDD revision.
  Loops absent from a build are marked `skipped`.
- The Bugs section collects structured bug reports; the free-format section is as important as the
  structured ones.

### 13.3 Processing Playtest Feedback
- Playtest files are processed **on demand**, when the human asks.
- The agent (Game Designer persona):
  1. Reads the full report, including the free-format section.
  2. Turns design findings into **revisions** of this document — bump the version, note what changed
     and why, and trace it to the report (e.g. "per playtest_2.md").
  3. Puts genuine open questions into §11 instead of guessing.
  4. Turns every reported defect into a row in the `## Bugs` table in `TASKS.md`, not a GDD change.
  5. Adds or updates `TASKS.md` rows for work the findings create.
- The human retains final say; anything that seems to contradict a Design Pillar (§2) is flagged for
  explicit confirmation.

### 13.4 Function Checks
- A **function check** is a second kind of playtest: a human verifies, item by item, that **every rule
  in this GDD works in the game**. The loop-based playtest asks how the game feels; the function check
  asks whether each function works as written.
- The master list is `playtesting/FUNCTION_CHECK.md`. **Every GDD rule has exactly one checkable item**
  there, linked to its GDD section, with an ID (`FC-<section>-<nn>`) and a build status: built (the
  task that built it), waiting on a task, or **no task yet** — so any rule nobody has planned shows up
  as a gap.
- **Keeping it in sync:** a GDD revision that adds, changes or removes a rule updates
  `FUNCTION_CHECK.md` in the same revision. When a task is marked `done`, its items flip to built.
- **Running one:** copy the list to `playtesting/<version>/function_check_<#>.md` and tick each built
  item; mark failures ❌ with a note.
- **Processing:** every ❌ becomes a row in the `## Bugs` table in `TASKS.md`. Gaps (rules with no
  task) are raised with the human as possible new tasks.
- **Cadence:** a function check after each feature update, alongside or instead of a loop-based
  playtest.
