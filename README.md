# nushell-prompt

A themeable, git-aware [Nushell](https://www.nushell.sh) prompt with multiple
color themes and switchable layout styles — including a neon **cyberpunk** one.
Works on **macOS** and **Linux**.

![styles](docs/preview.txt)

## Features

- **6 color themes**: `gruvbox`, `catppuccin-mocha`, `catppuccin-macchiato`,
  `catppuccin-frappe`, `catppuccin-latte`, and a neon **`cyberpunk`**. Themes
  recolor syntax highlighting, tables **and** the prompt.
- **Ghostty auto-follow** (optional): by default the theme follows your Ghostty
  config (`theme = …`), matched automatically. Pick a theme manually with
  `theme <name>` to **pin** it (survives new shells); `theme-sync` re-enables
  auto-follow.
- **7 prompt styles**: `full`, `compact`, `minimal`, `lambda`, `pure`,
  `powerline`, `cyberpunk`.
- **oh-my-zsh style git info**: branch, `⇡`ahead `⇣`behind `=`conflict
  `+`staged `!`modified `?`untracked `*`stash, `✔` clean.
- **Command duration** (for commands > 2s) and an **exit-status-aware** prompt
  indicator (turns red after a failed command).
- Everything persists across sessions and is a **drop-in** — it installs into
  Nushell's autoload dir and does **not** touch your `config.nu`.

## Requirements

- Nushell ≥ 0.101 (developed on 0.111)
- A [Nerd Font](https://www.nerdfonts.com/) for the branch glyph and the
  `powerline` style. Not required otherwise — run `$env.PROMPT_NERD = false`
  for plain ASCII.

## Install

Requires [Nushell](https://www.nushell.sh) — the installer is pure Nushell,
no bash needed.

```sh
git clone https://github.com/sorinirimies/my_nushell_theming
cd my_nushell_theming
nu install.nu            # symlink (repo stays the source of truth)
# or:  nu install.nu --copy
```

One-liner (no clone needed):

```sh
nu -c "let d = (mktemp -d); http get https://raw.githubusercontent.com/sorinirimies/my_nushell_theming/main/install.nu | save ($d | path join install.nu); nu ($d | path join install.nu)"
```

Open a new shell (or `exec nu`). That's it.

To update: `git pull` (if you symlinked, changes apply on next shell).

To remove: `nu uninstall.nu`.

## Full cyberpunk mode

```nu
theme cyberpunk          # neon colors (pinned across shells)
prompt-style cyberpunk   # two-line neon layout with ⚡ and ▶▶▶
```

## Usage

```nu
theme                 # interactive theme picker (fuzzy)
theme cyberpunk       # pin a theme
theme-sync            # re-enable Ghostty auto-follow
theme-list

prompt-style          # interactive style picker
prompt-style cyberpunk
```

### Styles

| Style       | Look                                                        |
|-------------|-------------------------------------------------------------|
| `full`      | `user@host in ~/path on  branch +git`  (default)          |
| `compact`   | `…/last2/dirs on  branch +git`                             |
| `minimal`   | `dirname on  branch`                                       |
| `lambda`    | `λ ~/path on  branch +git`                                 |
| `pure`      | two-line, [pure](https://github.com/sindresorhus/pure)-like |
| `powerline` | Nerd-Font segments with `` separators                     |
| `cyberpunk` | two-line neon box-drawing with `⚡` and `▶▶▶`                |

### Toggles

- `$env.PROMPT_NERD` — `true`/`false`, use Nerd Font glyphs (default `true`).

## How it works

One self-contained file, `nushell-prompt.nu`, is placed in your Nushell
autoload directory (`~/Library/Application Support/nushell/autoload` on macOS,
`~/.config/nushell/autoload` on Linux), so it loads automatically without
touching your `config.nu`. Symlink installs keep the repo as the source of
truth — `git pull` and changes apply on the next shell.

Selections are stored in `current-theme.txt` and `prompt-style.txt` in your
Nushell config dir.

## Adding a theme

In `nushell-prompt.nu`, add a palette + `color_config`, then register its name
in `theme-list` and `theme-get`. The prompt reads accent colors from the
theme's `palette` record, so new themes restyle the prompt automatically.

## License

MIT
