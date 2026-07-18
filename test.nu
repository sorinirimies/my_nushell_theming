#!/usr/bin/env nu
# test.nu — validates nuance: every theme, style and look is well-formed,
# the prompt renders, and helpers behave. Exits non-zero on any failure.
# Run:  nu test.nu
source nushell-prompt.nu

mut errors = []

# ── themes: color_config is substantial + palette has required keys ──
let required = [user host path git sep ok err time added modified deleted untracked ahead behind stash conflict duration ink]
for t in (theme-list) {
    let g = (theme-get $t)
    let cols = ($g.color_config | columns | length)
    if $cols < 40 { $errors = ($errors | append $"theme '($t)': color_config only ($cols) entries") }
    let pal = ($g.palette | columns)
    for k in $required {
        if ($k not-in $pal) { $errors = ($errors | append $"theme '($t)': palette missing '($k)'") }
    }
}

# ── styles: every style renders a non-empty prompt ──
$env.THEME_PALETTE = (theme-get "gruvbox").palette
for s in (prompt-styles) {
    $env.PROMPT_STYLE = $s
    let out = (try { create_left_prompt } catch {|e| "" })
    if ($out | is-empty) { $errors = ($errors | append $"style '($s)': empty/failed prompt") }
}

# ── looks: reference valid themes + styles, unique names ──
for l in (presets) {
    if ($l.theme not-in (theme-list)) { $errors = ($errors | append $"look '($l.name)': unknown theme '($l.theme)'") }
    if ($l.style not-in (prompt-styles)) { $errors = ($errors | append $"look '($l.name)': unknown style '($l.style)'") }
}
let look_names = (presets | get name)
if (($look_names | length) != ($look_names | uniq | length)) {
    $errors = ($errors | append "duplicate look names")
}

# ── uniqueness of theme + style names ──
if ((theme-list | length) != (theme-list | uniq | length)) { $errors = ($errors | append "duplicate theme names") }
if ((prompt-styles | length) != (prompt-styles | uniq | length)) { $errors = ($errors | append "duplicate style names") }

# ── helpers ──
if ((prompt-user) | is-empty) { $errors = ($errors | append "prompt-user returned empty") }
if ((prompt-host) | is-empty) { $errors = ($errors | append "prompt-host returned empty") }
$env.PROMPT_USER = "sorin"; $env.PROMPT_HOST = "nuance"
if ((prompt-user) != "sorin") { $errors = ($errors | append "PROMPT_USER override ignored") }
if ((prompt-host) != "nuance") { $errors = ($errors | append "PROMPT_HOST override ignored") }
hide-env PROMPT_USER PROMPT_HOST

# ── git formatting helpers ('present' record) ──
let gdirty = { present: true, head: "main", ahead: 1, behind: 2, staged: 1, modified: 3, untracked: 2, conflict: 0, stash: 1, clean: false }
let gclean = { present: true, head: "main", ahead: 0, behind: 0, staged: 0, modified: 0, untracked: 0, conflict: 0, stash: 0, clean: true }
let plain = (git-plain $gdirty)
for frag in ["main" "⇡1" "⇣2" "+1" "!3" "?2" "*1"] {
    if not ($plain | str contains $frag) { $errors = ($errors | append $"git-plain missing '($frag)' in '($plain)'") }
}
let omz = (git-omz $gdirty | ansi strip)
if not ($omz | str contains "git:(main)") { $errors = ($errors | append $"git-omz format wrong: '($omz)'") }
if not ($omz | str contains "✗") { $errors = ($errors | append "git-omz missing dirty mark") }
if ((git-omz $gclean | ansi strip) | str contains "✗") { $errors = ($errors | append "git-omz shows dirty mark when clean") }

# ── public commands are defined ──
let cmds = (scope commands | get name)
for c in ["theme" "theme-sync" "prompt-style" "look" "looks" "theme-preview" "style-preview" "nuance" "nuance update"] {
    if ($c not-in $cmds) { $errors = ($errors | append $"command not defined: ($c)") }
}

# ── ghostty keyword mapping ──
let gmap = { "Gruvbox Dark Hard": "gruvbox", "Catppuccin Mocha": "catppuccin-mocha", "Dracula": "dracula", "Tokyo Night": "tokyo-night", "Nord": "nord", "Solarized Light": "solarized-light", "Ayu Mirage": "ayu-mirage", "Super Mario": "super-mario" }
for row in ($gmap | transpose k v) {
    let got = (ghostty-map-name $row.k)
    if ($got != $row.v) { $errors = ($errors | append $"ghostty map '($row.k)' -> '($got)' (want '($row.v)')") }
}

# ── report ──
if ($errors | is-empty) {
    print $"(ansi green_bold)✓ all checks passed(ansi reset) — (theme-list | length) themes, (prompt-styles | length) styles, (presets | length) looks"
} else {
    $errors | each {|e| print $"(ansi red)✗(ansi reset) ($e)" }
    print $"(ansi red_bold)(($errors | length)) check\(s) failed(ansi reset)"
    exit 1
}
