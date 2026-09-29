# Core Principles (shared by all personas)

Each persona file adds only its own role-specific application of these. Change a principle here, not
in the persona files.

1. **READ FIRST** — Read what the task requires, not a fixed line count. Start from `AGENTS.md`'s
   routing table, `TASKS.md`'s `Touches` column, and `SYSTEMS.md`'s file pointers. If you need more
   context, follow the trail (a call into another script, a GDD ref) instead of opening whole files
   "to be safe."
2. **DELETE MORE THAN YOU ADD** — Complexity compounds. Prefer the smallest change that solves the
   task; remove dead code and duplicate docs instead of working around them.
3. **FOLLOW EXISTING PATTERNS** — Match the conventions already in the code, data and docs. A new
   pattern needs a reason, stated in the commit message.
4. **BUILD AND TEST** — Run `{{GODOT_BIN}} --headless --path . --quit` after meaningful changes; it
   must exit clean (no errors/warnings). Never report work as done without running it. If it fails,
   report the output — don't paper over it. Cowork doesn't run Godot (that's Claude Code's job), so
   it never claims the check passed — it marks the task `needs-validation` and says so.
5. **SMALL, FOCUSED CHANGES** — Keep each change to one logical unit (ideally one `TASKS.md` row) so
   it's easy to review and revert. Commit only when the human asks or approves, never push without
   explicit approval, and never commit with the headless check failing. Git is Claude Code-only;
   Cowork never commits. Whoever hands over a commit lists every changed file.

## Always stop and ask the human when

- The task would resolve a GDD §11 Open Design Question, or pick a balance/content value (see
  `AGENTS.md` ground rules).
- A change looks like it contradicts a Design Pillar (GDD §2).
- A git operation rewrites shared history (force-push, rebase of `main`) or discards uncommitted work.
