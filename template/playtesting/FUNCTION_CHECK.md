# Function Check — master list

A **function check** is a playtest where a human verifies, one by one, that each rule in the GDD actually
works in the game. It complements the loop-based playtest (`TEMPLATE.md`), which asks how the game
*feels*. See GDD §13.4.

**How a round works**

1. Ask Cowork to **"prepare a function check"**. It writes `playtesting/<version>/function_check_<#>.md`
   with only the **Built** items, each like this:

   ```
   - **FC-3-01** A new run starts with the starting conditions. Check: start a new run.
     - [ ] Works   - [ ] Broken / missing
     - Notes:
   ```

2. Play and tick: **Works** = passed, **Broken / missing** = failed (say what in Notes), **nothing
   ticked = not checked this round**. No symbols to copy.
3. Ask Cowork to **"process the function check"**: broken items become bug rows (or design changes, if
   the notes say the rule itself should change), and each item's *Last result* below is updated.
4. If the project has a dev menu (GDD §10 "Settings & Dev Tools"), use it to reach states quickly.

**This master list**

- One item per GDD rule, linked to its section. A GDD revision that adds, changes or removes a rule
  updates this file in the same revision (Game Designer persona).
- **Status:** `Built (Tn)` · `Waiting (Tn)` — task not done yet · `No task` — in the GDD but not
  planned (a gap). When a task is marked `done`, its items change from Waiting to Built (Developer
  persona).
- **Last result:** `OK v<version>` · `Broken v<version> → Bn` · `Changed v<version>` (the rule was
  revised after the check) · blank = never verified.
- IDs are `FC-<GDD section>-<nn>` and are never reused. GDD links use heading anchors (lower-case,
  punctuation removed, spaces → `-`); if a heading is renamed, fix its links here.

**Writing good items**

- One observable behaviour per item, written as what the player sees: *"A new run starts with 0 gold."*
- Add a short *Check:* hint when it isn't obvious how to reach the state.
- Keep "how it feels" questions out — those belong in `TEMPLATE.md`.

*Last synced with GDD v{{GDD_VERSION}}.*

---

## §3 Core loop

[§3](../design/gdd.md#3-core-gameplay-loop)

- **FC-3-01** *(example)* A new run starts with the starting conditions in GDD §3.3. Check: start a new run. — Waiting (T{n})

## §5.1 {{SYSTEM NAME}}

[§5.1](../design/gdd.md#51-system-name)

- **FC-5.1-01** {{Observable behaviour from the GDD}} Check: {{how to reach it}} — No task
