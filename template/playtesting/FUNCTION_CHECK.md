# Function Check — master list

A **function check** is a playtest where a human verifies, one by one, that each rule in the GDD actually
works in the game. It complements the loop-based playtest (`TEMPLATE.md`), which asks how the game
*feels*. See GDD §13.4.

**How to run one**

1. Copy this file to `playtesting/<version>/function_check_<#>.md` (version = GDD version).
2. Work through the items marked **✔** (built). Tick `[x]` when it works as written. If it doesn't,
   write `❌` and a short note after the item — each ❌ becomes a row in the `## Bugs` table in
   `TASKS.md` when the check is processed. Use `➖` for "couldn't reach it this session".
3. Skip items marked **⏳** (task not done yet) and **⚠** (no task exists — a gap). They're listed so
   nothing in the GDD goes untracked.
4. If the project has a dev menu (GDD §10 "Settings & Dev Tools"), use it to reach states quickly.

**Keeping it current**

- Every GDD rule has exactly one item here, linked to its GDD section. When a GDD revision adds,
  changes or removes a rule, this file changes in the same revision (Game Designer persona).
- When a task is marked `done`, its items flip from ⏳ to ✔ (Developer persona).
- IDs are `FC-<GDD section>-<nn>` and are never reused.
- GDD links use heading anchors (lower-case, punctuation removed, spaces → `-`); if a GDD heading is
  renamed, fix its links here.

**Writing good items**

- One observable behaviour per item, written as what the player sees: *"A new run starts with 0 gold."*
- Add a short *Check:* hint when it isn't obvious how to reach the state.
- Keep "how it feels" questions out — those belong in `TEMPLATE.md`.

Legend: **✔ Tn** built by task Tn · **⏳ Tn** waiting on task Tn · **⚠ no task** in the GDD but not
planned yet

*Last synced with GDD v{{GDD_VERSION}}.*

---

## §3 Core loop

[§3](../design/gdd.md#3-core-gameplay-loop)

- [ ] **FC-3-01** *(example)* A new run starts with the starting conditions in GDD §3.3. *Check:* start a new run. — **⏳ T{n}**

## §5.1 {{SYSTEM NAME}}

[§5.1](../design/gdd.md#51-system-name)

- [ ] **FC-5.1-01** {{Observable behaviour from the GDD}} *Check:* {{how to reach it}} — **⚠ no task**
