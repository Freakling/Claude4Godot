# Market Day (Claude4Godot example)

A tiny Godot game run with Claude4Godot, frozen partway through development:
- **Done:** four items. Their tests are in `tests/test_market.gd`.
- **Recorded:** one playtest, processed into a bug, a task, a design decision and an open question; and one function check.
- **Waiting:** a low-priority bug (B1, actually present in `shop_screen.gd`), a small task, and a human tuning task.

What to look at: `AGENTS.md` (facts, layout, architecture), `TASKS.md` (item format, tags, bug items), `design/gdd.md` and `design/decisions.md`, and `playtesting/`.

The framework's own files aren't committed here. To try the example, install them into a copy (the installer wants the root of a git repository), then run the check:

```bash
cp -R . /tmp/market-day && cd /tmp/market-day && git init -q && git add -A && git commit -qm example
bash <path to Claude4Godot>/install.sh .
bash tools/setup-clone.sh "C:/path/to/Godot_console.exe"
bash tools/check.sh
```

`bash <path to Claude4Godot>/selftest.sh <godot>` does all of that, then checks that the check and the hooks catch the mistakes they should.
