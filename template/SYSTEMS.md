# SYSTEMS.md

How the codebase divides into systems, where each one lives, and what it depends on. This changes
**rarely** — update it only when an autoload, screen, schema or data folder is added, removed, or
restructured, not every session. For active work, see `TASKS.md`. For design intent behind a system,
follow the GDD ref.

**Reading order for an unfamiliar system:** find its row here → open its GDD ref → open its files.
Don't open `design/gdd.md` or `README.md` in full to answer "what does this system do."

| System | What it owns | Files | GDD ref | Depends on |
|---|---|---|---|---|
| *(example)* `GameState` | Run-level state: *(list the values it owns)* | `scripts/autoload/game_state.gd` | §3 | — |
| Resource schemas | Data shape for *(list Resource classes)* | `scripts/resources/*.gd` | §10 (content pipeline) | — |
| Content data | Actual balance values (human-owned) | `data/{…}/*.tres` | — | matching Resource schema |

## Notes

- "Depends on" here means *reads or is driven by*, not "must be edited together."
- If you add a new autoload, screen, schema or data folder, add or update a row here in the same
  session — this file is only useful if it stays current.
- Screens (UI) should depend on systems, never the other way round. If a screen script starts owning
  game rules, move them into a system and note it here.
