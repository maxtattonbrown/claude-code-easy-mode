# Friendly Setup

One command to make [Claude Code](https://docs.anthropic.com/en/docs/claude-code) feel less intimidating.

## What it does

1. **Installs a warm colour theme** — parchment background, soft text, coral accents. Replaces the black void. Detects your terminal automatically (Terminal.app, Ghostty, iTerm2, Warp, Kitty, Alacritty).

2. **Adds a status bar** — a simple traffic light that tells you when your conversation is getting long and what to do about it:

```
🟢 Plenty of context · my-project
🟡 Context filling up — type /compact · my-project
🔴 Running low on context — type /compact now · my-project
```

3. **Enables useful plugins** — frontend design (build web pages), document skills (PDFs, docs, spreadsheets), and explanatory mode (Claude explains what it's doing as it goes).

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/maxtattonbrown/friendly-setup/main/install.sh | bash
```

That's it. Open Claude Code and you'll see the difference.

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/maxtattonbrown/friendly-setup/main/install.sh | bash -s -- --uninstall
```

This restores your original settings. Nothing permanent.

## What's the status bar telling me?

When you chat with Claude Code, it keeps track of everything you've said in the conversation. This is called "context." The longer you talk, the more context builds up — and eventually Claude starts to forget the earlier parts.

The status bar watches this for you:

- **🟢 Green** — you're fine, carry on
- **🟡 Yellow** — conversation is getting long. Type `/compact` to let Claude summarise and free up space
- **🔴 Red** — you really need to type `/compact` now, or start a new conversation

You'll also see **⚡ Fast mode** if Claude is running on a quicker but less capable model. This usually means your plan has usage limits — nothing you need to fix, just good to know.

## Requirements

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) installed
- macOS or Linux
- `jq` or `python3` (for the status bar — most Macs have python3)

## Credits

Made by [Max Tatton-Brown](https://github.com/maxtattonbrown). Part of the [Friendly Terminal](https://github.com/maxtattonbrown/friendly-terminal) project.
