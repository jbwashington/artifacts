# artifacts

Public artifacts by [jbwashington](https://github.com/jbwashington). Each file is a single self-contained HTML document with embedded DSL source and grammar — open any one to read, edit, or download.

**Index:** [https://jbwashington.github.io/artifacts/](https://jbwashington.github.io/artifacts/)

## What is an artifact?

An artifact is a durable, self-describing single-file HTML page:

- **Single file**, zero external dependencies
- **Embedded grammar** — each artifact carries the spec for its own DSL inside `<pre id="artifact-grammar">`
- **Embedded source** — the content lives in a `<textarea id="artifact-source">` that's editable in-browser
- **Live re-render** — type in the textarea, the rendered view updates instantly
- **Copy markdown** — a button generates a 4-section bundle (title · rendered · source · grammar) for pasting into chat with another LLM
- **Download .html** — a button serializes the current textarea state into a fresh self-contained file

The pattern is documented in the [`artifact` Claude Code skill](https://github.com/jbwashington/.claude) at `~/.claude/skills/artifact/SKILL.md`.

## Publishing flow

1. Author artifacts locally at `~/Documents/artifacts/personal/`
2. Copy the file into this repo's root directory
3. Run `./regen-index.sh` to refresh `index.html`
4. Commit and push — GitHub Pages serves the file at `https://jbwashington.github.io/artifacts/{filename}`

Work artifacts stay in `~/Documents/artifacts/work/` and are never pushed here.

## Editing & sharing

Anyone with the URL can:

- Read the rendered view
- Edit the source in the textarea (changes stay client-side in their browser tab)
- Click **Download .html** to walk away with their edits baked into a fresh file
- Click **Copy markdown** to grab the current state as a paste-able bundle

To send changes back to the author: download a snapshot, attach via email/iMessage.
