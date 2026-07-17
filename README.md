# nuance

![platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-blue)
![nushell](https://img.shields.io/badge/nushell-%E2%89%A50.101-4E9A06)
![themes](https://img.shields.io/badge/themes-26-cba6f7)
![styles](https://img.shields.io/badge/prompt%20styles-22-89b4fa)
![license](https://img.shields.io/badge/license-MIT-green)
![ci](https://github.com/sorinirimies/nuance/actions/workflows/ci.yml/badge.svg)

**nuance** *(a portmanteau of **nu** + **nuance** — the subtle differences
between colors)* is a themeable, git-aware prompt for
[Nushell](https://www.nushell.sh), shipped as a single drop-in file. Switch
between **26 color themes** and **22 prompt styles**, combine them into named
**looks**, and optionally let the whole shell **follow your terminal's theme**
automatically. Works on **macOS** and **Linux**.

![nuance demo](docs/welcome.gif)

## Installation

**No Nushell yet?** One command installs [Nushell](https://www.nushell.sh)
*and* sets up nuance — macOS, Linux and WSL:

```sh
curl -fsSL https://raw.githubusercontent.com/sorinirimies/nuance/main/bootstrap.sh | bash
```

<sub>…or with wget:</sub>

```sh
wget -qO- https://raw.githubusercontent.com/sorinirimies/nuance/main/bootstrap.sh | bash
```

The bootstrap installs Nushell via your package manager (Homebrew / apt /
pacman / dnf / zypper / cargo) or a prebuilt binary, then wires up the prompt.

**Already have Nushell?** Clone and run the pure-Nushell installer:

```sh
git clone https://github.com/sorinirimies/nuance
cd nuance
nu install.nu          # symlink (repo stays the source of truth) — or --copy
```

…or without cloning:

```sh
nu -c 'http get https://raw.githubusercontent.com/sorinirimies/nuance/main/install.nu | save -f /tmp/nuance-install.nu; nu /tmp/nuance-install.nu'
```

Then open a new shell (or `exec nu`). **Update** with `git pull`; **remove**
with `nu uninstall.nu`. A [Nerd Font](https://www.nerdfonts.com/) is
recommended for the glyph-based styles (or set `$env.PROMPT_NERD = false`).

### Updating

If you cloned/symlinked, just pull — or run the built-in command:

```nu
nuance-update      # git pull the checkout, then: exec nu
```

Manually: `cd` into the repo, `git pull`, then open a new shell. (Copy-based or
`bootstrap` installs: just re-run the bootstrap one-liner.)

## What is it?

`nuance` is a self-contained Nushell script that replaces the default prompt
with a richer, colorful one and adds a few commands to restyle your shell on
the fly. Concretely, it gives you:

- **Color themes** that recolor Nushell's syntax highlighting, table output,
  **and** the prompt in one coordinated palette (gruvbox, catppuccin, tokyo
  night, dracula, nord, a neon cyberpunk, even a Super Mario one, …).
- **Prompt styles** — different *layouts* for the prompt line (minimal,
  powerline, two-line boxed, retro game styles, …), independent of the colors.
- **Looks** — curated theme + style pairings you apply in one step.
- A **git segment** in the prompt showing branch, ahead/behind, staged,
  modified, untracked, stashed and conflict counts — like oh-my-zsh.
- **Ghostty auto-follow**: on startup it can read your
  [Ghostty](https://ghostty.org) terminal's theme and match it, so your shell
  and terminal always agree. Pin a theme to override it; `theme-sync` re-follows.

It installs into Nushell's autoload directory, so it loads automatically
without editing your `config.nu`, and nothing runs but a prompt — no daemons,
no external dependencies.

## Features

- **25 color themes**: `gruvbox`, `catppuccin-mocha`, `catppuccin-macchiato`,
  `catppuccin-frappe`, `catppuccin-latte`, `tokyo-night`, `nord`, `dracula`,
  `rose-pine`, `rose-pine-moon`, `rose-pine-dawn`, `everforest`, `kanagawa`,
  `onedark`, `monokai`, `ayu-dark`, `ayu-mirage`, `night-owl`, `github-dark`,
  `github-light`, `oxocarbon`, `zenburn`, `solarized`, `solarized-light`,
  `super-mario`, and a neon **`cyberpunk`**. Themes recolor syntax highlighting,
  tables **and** the prompt.
- **Looks** — curated theme + prompt-style combos applied in one step
  (e.g. `cyberpunk`, `synthwave`, `tokyo-powerline`, `mocha-pure`).
- **Ghostty auto-follow** (optional): by default the theme follows your Ghostty
  config (`theme = …`), matched automatically. Pick a theme manually with
  `theme <name>` to **pin** it (survives new shells); `theme-sync` re-enables
  auto-follow.
- **22 prompt styles**: `full`, `compact`, `minimal`, `lambda`, `pure`,
  `bracket`, `arrow`, `powerline`, `slant`, `capsule`, `rainbow`, `boxed`,
  `cyberpunk`, game-inspired `mario`/`arcade`/`8bit`, and oh-my-zsh classics
  `robbyrussell`/`ys`/`avit`/`bira`/`af-magic`/`cloud`.
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

## Full cyberpunk mode

```nu
theme cyberpunk          # neon colors (pinned across shells)
prompt-style cyberpunk   # two-line neon layout with ⚡ and ▶▶▶
```

## Usage

![interactive picker](docs/picker.gif)

```nu
look                  # pick a full LOOK: theme + prompt style, in one step
look cyberpunk        # apply a named look (pins theme + style, overrides Ghostty)
looks                 # list available looks

theme                 # pick a theme, THEN a prompt style (interactive)
theme nord            # set + pin a theme only
theme-sync            # re-enable Ghostty auto-follow
theme-list
theme-preview         # color swatch of every theme

prompt-style          # change ONLY the prompt style
prompt-style capsule
style-preview         # render every style once, on the current theme
nuance-update         # git pull the checkout + reload hint
```

### Themes

Every theme at a glance (`theme-preview`):

![theme gallery](docs/gallery-themes.gif)

And cycling through a few with recolored tables:

![themes gallery](docs/themes.gif)

…and more of the newer themes (nord, rosé pine, everforest, kanagawa, ayu,
onedark, solarized, super-mario):

![more themes](docs/themes-more.gif)

Light themes (`github-light`, `catppuccin-latte`, `rose-pine-dawn`,
`solarized-light`) shine on a light terminal background:

![light themes](docs/light.gif)

### Looks (theme + style presets)

![looks demo](docs/demo.gif)

| Look               | Theme                | Style     |
|--------------------|----------------------|-----------|
| `cyberpunk`        | cyberpunk            | cyberpunk |
| `synthwave`        | cyberpunk            | capsule   |
| `gruvbox`          | gruvbox              | full      |
| `gruvbox-minimal`  | gruvbox              | minimal   |
| `mocha-pure`       | catppuccin-mocha     | pure      |
| `macchiato-lambda` | catppuccin-macchiato | lambda    |
| `latte-compact`    | catppuccin-latte     | compact   |
| `tokyo-powerline`  | tokyo-night          | powerline |
| `tokyo-capsule`    | tokyo-night          | capsule   |
| `nord-lambda`      | nord                 | lambda    |

### Styles

Every prompt style at once (`style-preview`):

![style gallery](docs/gallery-styles.gif)

![prompt styles](docs/styles.gif)

### Ghostty auto-follow

Pin any theme to override Ghostty; `theme-sync` re-follows Ghostty's current
theme (falling back to `gruvbox`):

![theme-sync](docs/sync.gif)

Game-inspired styles — try `look super-mario`, `look arcade`, or `look 8bit`:

![game styles](docs/games.gif)

| Style       | Look                                                        |
|-------------|-------------------------------------------------------------|
| `full`      | `user@host in ~/path on  branch +git`  (default)          |
| `compact`   | `…/last2/dirs on  branch +git`                             |
| `minimal`   | `dirname on  branch`                                       |
| `lambda`    | `λ ~/path on  branch +git`                                 |
| `pure`      | two-line, [pure](https://github.com/sindresorhus/pure)-like |
| `robbyrussell` | oh-my-zsh's default — `➜  dir git:(branch) ✗`             |
| `ys`        | oh-my-zsh `ys` — `# user @ host in ~/dir on ⎇ branch●`      |
| `avit`      | oh-my-zsh `avit` — clean two-line + `git:(branch)`          |
| `bira`      | oh-my-zsh `bira` — `╭─user@host ~/dir` / `╰─➤`               |
| `af-magic`  | oh-my-zsh `af-magic` — full-width rule + info line          |
| `cloud`     | oh-my-zsh `cloud` — `☁  ~/dir git:(branch)`                  |
| `bracket`   | ASCII `[user@host] [path] [git]` (no Nerd Font needed)       |
| `arrow`     | `user » path » git` — no Nerd Font needed                    |
| `powerline` | Nerd-Font segments with `` separators                     |
| `slant`     | Nerd-Font slanted segment separators                        |
| `capsule`   | Nerd-Font rounded "pill" segments                           |
| `rainbow`   | Nerd-Font powerline, each segment its own color             |
| `boxed`     | two-line box-drawing with a `●` clean/dirty marker          |
| `mario`     | two-line 🍄 overworld — `▣`?-block, `◆` hero, `⚑` flag, `◉` coins, `▄` ground |
| `arcade`    | retro all-caps `▶ 1UP` score line                          |
| `8bit`      | pixel `░▒▓` gradient separators                              |
| `cyberpunk` | two-line neon box-drawing with `⚡` and `▶▶▶`                |

### Toggles

- `$env.PROMPT_NERD` — `true`/`false`, use Nerd Font glyphs (default `true`).
- `$env.PROMPT_USER` / `$env.PROMPT_HOST` — override the shown username/hostname
  (handy for screenshots/recordings, or a custom label).

## Cross-platform

One pure-Nushell file, no OS-specific dependencies — the same script runs on
**macOS** and **Linux** (and WSL). Paths are resolved via Nushell built-ins
(`$nu.user-autoload-dirs`, `$nu.default-config-dir`), the Ghostty config is
found at `~/.config/ghostty/config` **or** the macOS
`~/Library/Application Support/com.mitchellh.ghostty/config`, and light/dark
detection uses macOS `defaults` or GNOME `gsettings` (falling back to dark).

A test suite (`nu test.nu`) validates that every theme, style and look is
well-formed and the prompt renders; it runs in CI on both Ubuntu and macOS.

```sh
nu test.nu   # ✓ all checks passed — 26 themes, 21 styles, 30 looks
```

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

## Demos

The GIFs are recorded with [VHS](https://github.com/charmbracelet/vhs) from the
tapes in [`tapes/`](tapes). Regenerate them with:

```sh
vhs tapes/welcome.tape
vhs tapes/demo.tape
vhs tapes/styles.tape
vhs tapes/themes.tape
```

(Requires a Nerd Font; the tapes use `FiraCode Nerd Font Mono`.)
