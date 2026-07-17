# nushell-prompt.nu — nuance: themeable, git-aware Nushell prompt
# https://github.com/sorinirimies/nuance
# Single self-contained file. Drop into your Nushell autoload dir.

# ── color themes ─────────────────────────────────────────────
# (part of nushell-prompt)
#
# Exposes:
#   theme-list         -> list of available theme names
#   theme-get <name>   -> { color_config: {...}, palette: {...} }
#
# `color_config` plugs into `$env.config.color_config`.
# `palette` supplies accent colors for the custom prompt (see config.nu).

# ── Catppuccin flavor palettes ────────────────────────────────
const CAT_MOCHA = {
    rosewater: "#f5e0dc", flamingo: "#f2cdcd", pink: "#f5c2e7", mauve: "#cba6f7"
    red: "#f38ba8", maroon: "#eba0ac", peach: "#fab387", yellow: "#f9e2af"
    green: "#a6e3a1", teal: "#94e2d5", sky: "#89dceb", sapphire: "#74c7ec"
    blue: "#89b4fa", lavender: "#b4befe", text: "#cdd6f4", subtext1: "#bac2de"
    subtext0: "#a6adc8", overlay2: "#9399b2", overlay1: "#7f849c", overlay0: "#6c7086"
    surface2: "#585b70", surface1: "#45475a", surface0: "#313244"
    base: "#1e1e2e", mantle: "#181825", crust: "#11111b"
}
const CAT_MACCHIATO = {
    rosewater: "#f4dbd6", flamingo: "#f0c6c6", pink: "#f5bde6", mauve: "#c6a0f6"
    red: "#ed8796", maroon: "#ee99a0", peach: "#f5a97f", yellow: "#eed49f"
    green: "#a6da95", teal: "#8bd5ca", sky: "#91d7e3", sapphire: "#7dc4e4"
    blue: "#8aadf4", lavender: "#b7bdf8", text: "#cad3f5", subtext1: "#b8c0e0"
    subtext0: "#a5adcb", overlay2: "#939ab7", overlay1: "#8087a2", overlay0: "#6e738d"
    surface2: "#5b6078", surface1: "#494d64", surface0: "#363a4f"
    base: "#24273a", mantle: "#1e2030", crust: "#181926"
}
const CAT_FRAPPE = {
    rosewater: "#f2d5cf", flamingo: "#eebebe", pink: "#f4b8e4", mauve: "#ca9ee6"
    red: "#e78284", maroon: "#ea999c", peach: "#ef9f76", yellow: "#e5c890"
    green: "#a6d189", teal: "#81c8be", sky: "#99d1db", sapphire: "#85c1dc"
    blue: "#8caaee", lavender: "#babbf1", text: "#c6d0f5", subtext1: "#b5bfe2"
    subtext0: "#a5adce", overlay2: "#949cbb", overlay1: "#838ba7", overlay0: "#737994"
    surface2: "#626880", surface1: "#51576d", surface0: "#414559"
    base: "#303446", mantle: "#292c3c", crust: "#232634"
}
const CAT_LATTE = {
    rosewater: "#dc8a78", flamingo: "#dd7878", pink: "#ea76cb", mauve: "#8839ef"
    red: "#d20f39", maroon: "#e64553", peach: "#fe640b", yellow: "#df8e1d"
    green: "#40a02b", teal: "#179299", sky: "#04a5e5", sapphire: "#209fb5"
    blue: "#1e66f5", lavender: "#7287fd", text: "#4c4f69", subtext1: "#5c5f77"
    subtext0: "#6c6f85", overlay2: "#7c7f93", overlay1: "#8c8fa1", overlay0: "#9ca0b0"
    surface2: "#acb0be", surface1: "#bcc0cc", surface0: "#ccd0da"
    base: "#eff1f5", mantle: "#e6e9ef", crust: "#dce0e8"
}

# Build the Catppuccin color_config for a given flavor palette.
# Faithful port of catppuccin/nushell.
def cat-color-config [p: record] {
    let s = {
        recognized_command: $p.blue
        unrecognized_command: $p.text
        constant: $p.peach
        punctuation: $p.overlay2
        operator: $p.sky
        string: $p.green
        virtual_text: $p.surface2
        variable: { fg: $p.flamingo attr: i }
        filepath: $p.yellow
    }
    {
        separator: { fg: $p.surface2 attr: b }
        leading_trailing_space_bg: { fg: $p.lavender attr: u }
        header: { fg: $p.text attr: b }
        row_index: $s.virtual_text
        record: $p.text
        list: $p.text
        hints: $s.virtual_text
        search_result: { fg: $p.base bg: $p.yellow }
        shape_closure: $p.teal
        closure: $p.teal
        shape_flag: { fg: $p.maroon attr: i }
        shape_matching_brackets: { attr: u }
        shape_garbage: $p.red
        shape_keyword: $p.mauve
        shape_match_pattern: $p.green
        shape_signature: $p.teal
        shape_table: $s.punctuation
        cell-path: $s.punctuation
        shape_list: $s.punctuation
        shape_record: $s.punctuation
        shape_vardecl: $s.variable
        shape_variable: $s.variable
        empty: { attr: n }
        filesize: {||
            if $in < 1kb { $p.teal } else if $in < 10kb { $p.green
            } else if $in < 100kb { $p.yellow } else if $in < 10mb { $p.peach
            } else if $in < 100mb { $p.maroon } else if $in < 1gb { $p.red } else { $p.mauve }
        }
        duration: {||
            if $in < 1day { $p.teal } else if $in < 1wk { $p.green
            } else if $in < 4wk { $p.yellow } else if $in < 12wk { $p.peach
            } else if $in < 24wk { $p.maroon } else if $in < 52wk { $p.red } else { $p.mauve }
        }
        datetime: {|| (date now) - $in |
            if $in < 1day { $p.teal } else if $in < 1wk { $p.green
            } else if $in < 4wk { $p.yellow } else if $in < 12wk { $p.peach
            } else if $in < 24wk { $p.maroon } else if $in < 52wk { $p.red } else { $p.mauve }
        }
        shape_external: $s.unrecognized_command
        shape_internalcall: $s.recognized_command
        shape_external_resolved: $s.recognized_command
        shape_block: $s.recognized_command
        block: $s.recognized_command
        shape_custom: $p.pink
        custom: $p.pink
        shape_range: $s.operator
        range: $s.operator
        shape_pipe: $s.operator
        shape_operator: $s.operator
        shape_redirection: $s.operator
        glob: $s.filepath
        shape_directory: $s.filepath
        shape_filepath: $s.filepath
        shape_glob_interpolation: $s.filepath
        shape_globpattern: $s.filepath
        shape_int: $s.constant
        int: $s.constant
        bool: $s.constant
        float: $s.constant
        nothing: $s.constant
        binary: $s.constant
        shape_nothing: $s.constant
        shape_bool: $s.constant
        shape_float: $s.constant
        shape_binary: $s.constant
        shape_datetime: $s.constant
        shape_literal: $s.constant
        string: $s.string
        shape_string: $s.string
        shape_string_interpolation: $p.flamingo
        shape_raw_string: $s.string
        shape_externalarg: $s.string
    }
}

# Accent colors for the prompt, derived from a Catppuccin flavor.
def cat-prompt-palette [p: record] {
    {
        user: $p.yellow, host: $p.peach, path: $p.blue, git: $p.mauve
        sep: $p.overlay1, ok: $p.green, err: $p.red, time: $p.overlay0
        added: $p.green, modified: $p.yellow, deleted: $p.red, untracked: $p.overlay1
        ahead: $p.sky, behind: $p.peach, stash: $p.lavender, conflict: $p.maroon
        duration: $p.peach, ink: $p.crust
    }
}

# ── Gruvbox Dark Hard ─────────────────────────────────────────
const GRUV = {
    fg: "#ebdbb2", gray: "#928374", red: "#fb4934", green: "#b8bb26"
    yellow: "#fabd2f", blue: "#83a598", purple: "#d3869b", aqua: "#8ec07c"
    orange: "#fe8019", bg: "#1d2021"
}

def gruvbox-color-config [] {
    let g = $GRUV
    {
        separator: { fg: $g.gray }
        leading_trailing_space_bg: { attr: n }
        header: { fg: $g.green attr: b }
        empty: $g.blue
        bool: $g.aqua
        int: $g.purple
        filesize: $g.aqua
        duration: $g.purple
        date: $g.yellow
        range: $g.fg
        float: $g.purple
        string: $g.fg
        nothing: $g.gray
        binary: $g.orange
        cell-path: $g.fg
        row_index: { fg: $g.yellow attr: b }
        record: $g.fg
        list: $g.fg
        block: $g.fg
        hints: $g.gray
        search_result: { fg: $g.bg bg: $g.yellow }
        shape_and: { fg: $g.purple attr: b }
        shape_binary: { fg: $g.purple attr: b }
        shape_block: { fg: $g.blue attr: b }
        shape_bool: $g.aqua
        shape_closure: { fg: $g.aqua attr: b }
        shape_custom: $g.green
        shape_datetime: { fg: $g.aqua attr: b }
        shape_directory: $g.aqua
        shape_external: $g.aqua
        shape_externalarg: { fg: $g.green attr: b }
        shape_external_resolved: { fg: $g.yellow attr: b }
        shape_filepath: $g.aqua
        shape_flag: { fg: $g.blue attr: b }
        shape_float: { fg: $g.purple attr: b }
        shape_glob_interpolation: { fg: $g.aqua attr: b }
        shape_globpattern: { fg: $g.aqua attr: b }
        shape_int: { fg: $g.purple attr: b }
        shape_internalcall: { fg: $g.aqua attr: b }
        shape_keyword: { fg: $g.red attr: b }
        shape_list: { fg: $g.aqua attr: b }
        shape_literal: $g.blue
        shape_match_pattern: $g.green
        shape_matching_brackets: { attr: u }
        shape_nothing: $g.aqua
        shape_operator: $g.orange
        shape_or: { fg: $g.purple attr: b }
        shape_pipe: { fg: $g.purple attr: b }
        shape_range: { fg: $g.orange attr: b }
        shape_record: { fg: $g.aqua attr: b }
        shape_redirection: { fg: $g.purple attr: b }
        shape_signature: { fg: $g.green attr: b }
        shape_string: $g.green
        shape_string_interpolation: { fg: $g.aqua attr: b }
        shape_table: { fg: $g.blue attr: b }
        shape_variable: $g.purple
        shape_vardecl: $g.purple
        shape_garbage: { fg: $g.bg bg: $g.red attr: b }
    }
}

# ── Cyberpunk (neon) ──────────────────────────────────────────
const NEON = {
    fg: "#eaf2ff", gray: "#6c5b8c", pink: "#ff2a6d", cyan: "#05d9e8"
    magenta: "#ff5cf4", green: "#00ff9f", yellow: "#f9f871", violet: "#a97bff"
    orange: "#ff8b39", bg: "#0b0221"
}

def neon-color-config [] {
    let n = $NEON
    {
        separator: { fg: $n.magenta }
        leading_trailing_space_bg: { attr: n }
        header: { fg: $n.cyan attr: b }
        empty: $n.violet
        bool: $n.green
        int: $n.magenta
        filesize: $n.cyan
        duration: $n.magenta
        date: $n.yellow
        range: $n.fg
        float: $n.magenta
        string: $n.green
        nothing: $n.gray
        binary: $n.orange
        cell-path: $n.cyan
        row_index: { fg: $n.cyan attr: b }
        record: $n.fg
        list: $n.fg
        block: $n.fg
        hints: $n.gray
        search_result: { fg: $n.bg bg: $n.pink }
        shape_and: { fg: $n.magenta attr: b }
        shape_binary: { fg: $n.magenta attr: b }
        shape_block: { fg: $n.cyan attr: b }
        shape_bool: $n.green
        shape_closure: { fg: $n.cyan attr: b }
        shape_custom: $n.green
        shape_datetime: { fg: $n.cyan attr: b }
        shape_directory: $n.cyan
        shape_external: $n.cyan
        shape_externalarg: { fg: $n.green attr: b }
        shape_external_resolved: { fg: $n.yellow attr: b }
        shape_filepath: $n.cyan
        shape_flag: { fg: $n.yellow attr: b }
        shape_float: { fg: $n.magenta attr: b }
        shape_glob_interpolation: { fg: $n.cyan attr: b }
        shape_globpattern: { fg: $n.cyan attr: b }
        shape_int: { fg: $n.magenta attr: b }
        shape_internalcall: { fg: $n.cyan attr: b }
        shape_keyword: { fg: $n.pink attr: b }
        shape_list: { fg: $n.cyan attr: b }
        shape_literal: $n.violet
        shape_match_pattern: $n.green
        shape_matching_brackets: { attr: u }
        shape_nothing: $n.gray
        shape_operator: $n.pink
        shape_or: { fg: $n.magenta attr: b }
        shape_pipe: { fg: $n.pink attr: b }
        shape_range: { fg: $n.orange attr: b }
        shape_record: { fg: $n.cyan attr: b }
        shape_redirection: { fg: $n.pink attr: b }
        shape_signature: { fg: $n.green attr: b }
        shape_string: $n.green
        shape_string_interpolation: { fg: $n.cyan attr: b }
        shape_table: { fg: $n.cyan attr: b }
        shape_variable: $n.violet
        shape_vardecl: $n.violet
        shape_garbage: { fg: $n.bg bg: $n.pink attr: b }
    }
}

# ── Extra themes via a shared builder ────────────────────────
const TOKYO = {
    fg: "#c0caf5", gray: "#565f89", red: "#f7768e", orange: "#ff9e64"
    yellow: "#e0af68", green: "#9ece6a", cyan: "#7dcfff", blue: "#7aa2f7"
    magenta: "#bb9af7", purple: "#9d7cd8", bg: "#1a1b26"
}
const NORD = {
    fg: "#d8dee9", gray: "#4c566a", red: "#bf616a", orange: "#d08770"
    yellow: "#ebcb8b", green: "#a3be8c", cyan: "#88c0d0", blue: "#81a1c1"
    magenta: "#b48ead", purple: "#5e81ac", bg: "#2e3440"
}
const DRACULA = {
    fg: "#f8f8f2", gray: "#6272a4", red: "#ff5555", orange: "#ffb86c"
    yellow: "#f1fa8c", green: "#50fa7b", cyan: "#8be9fd", blue: "#bd93f9"
    magenta: "#ff79c6", purple: "#bd93f9", bg: "#282a36"
}
const ROSE_PINE = {
    fg: "#e0def4", gray: "#6e6a86", red: "#eb6f92", orange: "#ebbcba"
    yellow: "#f6c177", green: "#9ccfd8", cyan: "#9ccfd8", blue: "#31748f"
    magenta: "#c4a7e7", purple: "#c4a7e7", bg: "#191724"
}
const EVERFOREST = {
    fg: "#d3c6aa", gray: "#859289", red: "#e67e80", orange: "#e69875"
    yellow: "#dbbc7f", green: "#a7c080", cyan: "#83c092", blue: "#7fbbb3"
    magenta: "#d699b6", purple: "#d699b6", bg: "#2d353b"
}
const KANAGAWA = {
    fg: "#dcd7ba", gray: "#727169", red: "#ff5d62", orange: "#ffa066"
    yellow: "#e6c384", green: "#98bb6c", cyan: "#7fb4ca", blue: "#7e9cd8"
    magenta: "#957fb8", purple: "#957fb8", bg: "#1f1f28"
}
const ONEDARK = {
    fg: "#abb2bf", gray: "#5c6370", red: "#e06c75", orange: "#d19a66"
    yellow: "#e5c07b", green: "#98c379", cyan: "#56b6c2", blue: "#61afef"
    magenta: "#c678dd", purple: "#c678dd", bg: "#282c34"
}
const SOLARIZED = {
    fg: "#839496", gray: "#586e75", red: "#dc322f", orange: "#cb4b16"
    yellow: "#b58900", green: "#859900", cyan: "#2aa198", blue: "#268bd2"
    magenta: "#d33682", purple: "#6c71c4", bg: "#002b36"
}
const SOLARIZED_LIGHT = {
    fg: "#657b83", gray: "#93a1a1", red: "#dc322f", orange: "#cb4b16"
    yellow: "#b58900", green: "#859900", cyan: "#2aa198", blue: "#268bd2"
    magenta: "#d33682", purple: "#6c71c4", bg: "#fdf6e3"
}
const ROSE_PINE_MOON = {
    fg: "#e0def4", gray: "#6e6a86", red: "#eb6f92", orange: "#ea9a97"
    yellow: "#f6c177", green: "#9ccfd8", cyan: "#9ccfd8", blue: "#3e8fb0"
    magenta: "#c4a7e7", purple: "#c4a7e7", bg: "#232136"
}
const ROSE_PINE_DAWN = {
    fg: "#575279", gray: "#9893a5", red: "#b4637a", orange: "#d7827e"
    yellow: "#ea9d34", green: "#56949f", cyan: "#56949f", blue: "#286983"
    magenta: "#907aa9", purple: "#907aa9", bg: "#faf4ed"
}
const MONOKAI = {
    fg: "#f8f8f2", gray: "#75715e", red: "#f92672", orange: "#fd971f"
    yellow: "#e6db74", green: "#a6e22e", cyan: "#66d9ef", blue: "#66d9ef"
    magenta: "#ae81ff", purple: "#ae81ff", bg: "#272822"
}
const AYU_MIRAGE = {
    fg: "#cbccc6", gray: "#707a8c", red: "#ff3333", orange: "#ffa759"
    yellow: "#ffd580", green: "#bae67e", cyan: "#95e6cb", blue: "#73d0ff"
    magenta: "#d4bfff", purple: "#d4bfff", bg: "#1f2430"
}
const AYU_DARK = {
    fg: "#bfbdb6", gray: "#565b66", red: "#f26d78", orange: "#ff8f40"
    yellow: "#e6b450", green: "#aad94c", cyan: "#95e6cb", blue: "#59c2ff"
    magenta: "#d2a6ff", purple: "#d2a6ff", bg: "#0b0e14"
}
const NIGHT_OWL = {
    fg: "#d6deeb", gray: "#637777", red: "#ef5350", orange: "#f78c6c"
    yellow: "#ffeb95", green: "#addb67", cyan: "#7fdbca", blue: "#82aaff"
    magenta: "#c792ea", purple: "#c792ea", bg: "#011627"
}
const GITHUB_DARK = {
    fg: "#c9d1d9", gray: "#8b949e", red: "#ff7b72", orange: "#ffa657"
    yellow: "#e3b341", green: "#7ee787", cyan: "#a5d6ff", blue: "#79c0ff"
    magenta: "#d2a8ff", purple: "#d2a8ff", bg: "#0d1117"
}
const GITHUB_LIGHT = {
    fg: "#24292f", gray: "#6e7781", red: "#cf222e", orange: "#bc4c00"
    yellow: "#9a6700", green: "#1a7f37", cyan: "#1b7c83", blue: "#0969da"
    magenta: "#8250df", purple: "#8250df", bg: "#ffffff"
}
const OXOCARBON = {
    fg: "#f2f4f8", gray: "#525252", red: "#ee5396", orange: "#ff6f00"
    yellow: "#fae48c", green: "#42be65", cyan: "#3ddbd9", blue: "#33b1ff"
    magenta: "#be95ff", purple: "#be95ff", bg: "#161616"
}
const ZENBURN = {
    fg: "#dcdccc", gray: "#709080", red: "#cc9393", orange: "#dfaf8f"
    yellow: "#f0dfaf", green: "#7f9f7f", cyan: "#93e0e3", blue: "#8cd0d3"
    magenta: "#dc8cc3", purple: "#dc8cc3", bg: "#3f3f3f"
}
# Super Mario — vivid red / coin-gold / luigi-green / sky-blue on night bg.
const SUPER_MARIO = {
    fg: "#f8f8f2", gray: "#8a7f9a", red: "#e52521", orange: "#e39c4b"
    yellow: "#fbd000", green: "#43b047", cyan: "#49b6d8", blue: "#049cd8"
    magenta: "#d472d4", purple: "#7c5cbf", bg: "#12102a"
}

# Generic color_config from a simple palette (fg/gray/red/orange/yellow/
# green/cyan/blue/magenta/bg). Reused by tokyo-night and nord.
def basic-color-config [c: record] {
    {
        separator: { fg: $c.gray }
        leading_trailing_space_bg: { attr: n }
        header: { fg: $c.blue attr: b }
        empty: $c.blue
        bool: $c.cyan
        int: $c.magenta
        filesize: $c.cyan
        duration: $c.magenta
        date: $c.yellow
        range: $c.fg
        float: $c.magenta
        string: $c.green
        nothing: $c.gray
        binary: $c.orange
        cell-path: $c.fg
        row_index: { fg: $c.yellow attr: b }
        record: $c.fg
        list: $c.fg
        block: $c.fg
        hints: $c.gray
        search_result: { fg: $c.bg bg: $c.yellow }
        shape_and: { fg: $c.magenta attr: b }
        shape_binary: { fg: $c.magenta attr: b }
        shape_block: { fg: $c.blue attr: b }
        shape_bool: $c.cyan
        shape_closure: { fg: $c.cyan attr: b }
        shape_custom: $c.green
        shape_datetime: { fg: $c.cyan attr: b }
        shape_directory: $c.blue
        shape_external: $c.cyan
        shape_externalarg: { fg: $c.green attr: b }
        shape_external_resolved: { fg: $c.yellow attr: b }
        shape_filepath: $c.blue
        shape_flag: { fg: $c.magenta attr: b }
        shape_float: { fg: $c.magenta attr: b }
        shape_glob_interpolation: { fg: $c.cyan attr: b }
        shape_globpattern: { fg: $c.cyan attr: b }
        shape_int: { fg: $c.magenta attr: b }
        shape_internalcall: { fg: $c.cyan attr: b }
        shape_keyword: { fg: $c.red attr: b }
        shape_list: { fg: $c.cyan attr: b }
        shape_literal: $c.blue
        shape_match_pattern: $c.green
        shape_matching_brackets: { attr: u }
        shape_nothing: $c.cyan
        shape_operator: $c.orange
        shape_or: { fg: $c.magenta attr: b }
        shape_pipe: { fg: $c.magenta attr: b }
        shape_range: { fg: $c.orange attr: b }
        shape_record: { fg: $c.cyan attr: b }
        shape_redirection: { fg: $c.magenta attr: b }
        shape_signature: { fg: $c.green attr: b }
        shape_string: $c.green
        shape_string_interpolation: { fg: $c.cyan attr: b }
        shape_table: { fg: $c.blue attr: b }
        shape_variable: $c.magenta
        shape_vardecl: $c.magenta
        shape_garbage: { fg: $c.bg bg: $c.red attr: b }
    }
}

def basic-prompt-palette [c: record] {
    {
        user: $c.yellow, host: $c.orange, path: $c.blue, git: $c.magenta
        sep: $c.gray, ok: $c.green, err: $c.red, time: $c.gray
        added: $c.green, modified: $c.yellow, deleted: $c.red, untracked: $c.gray
        ahead: $c.cyan, behind: $c.orange, stash: $c.magenta, conflict: $c.red
        duration: $c.orange, ink: $c.bg
    }
}

# ── Public API ────────────────────────────────────────────────
def theme-list [] {
    ["gruvbox" "catppuccin-mocha" "catppuccin-macchiato" "catppuccin-frappe" "catppuccin-latte" "tokyo-night" "nord" "dracula" "rose-pine" "rose-pine-moon" "rose-pine-dawn" "everforest" "kanagawa" "onedark" "monokai" "ayu-dark" "ayu-mirage" "night-owl" "github-dark" "github-light" "oxocarbon" "zenburn" "solarized" "solarized-light" "super-mario" "cyberpunk"]
}

def theme-get [name: string] {
    match $name {
        "catppuccin-mocha"     => { color_config: (cat-color-config $CAT_MOCHA)     palette: (cat-prompt-palette $CAT_MOCHA) }
        "catppuccin-macchiato" => { color_config: (cat-color-config $CAT_MACCHIATO) palette: (cat-prompt-palette $CAT_MACCHIATO) }
        "catppuccin-frappe"    => { color_config: (cat-color-config $CAT_FRAPPE)    palette: (cat-prompt-palette $CAT_FRAPPE) }
        "catppuccin-latte"     => { color_config: (cat-color-config $CAT_LATTE)     palette: (cat-prompt-palette $CAT_LATTE) }
        "cyberpunk" => {
            color_config: (neon-color-config)
            palette: {
                user: $NEON.yellow, host: $NEON.pink, path: $NEON.cyan, git: $NEON.magenta
                sep: $NEON.gray, ok: $NEON.green, err: $NEON.pink, time: $NEON.violet
                added: $NEON.green, modified: $NEON.yellow, deleted: $NEON.pink, untracked: $NEON.gray
                ahead: $NEON.cyan, behind: $NEON.orange, stash: $NEON.magenta, conflict: $NEON.pink
                duration: $NEON.orange, ink: $NEON.bg
            }
        }
        "tokyo-night" => { color_config: (basic-color-config $TOKYO) palette: (basic-prompt-palette $TOKYO) }
        "nord"        => { color_config: (basic-color-config $NORD)  palette: (basic-prompt-palette $NORD) }
        "dracula"     => { color_config: (basic-color-config $DRACULA)     palette: (basic-prompt-palette $DRACULA) }
        "rose-pine"   => { color_config: (basic-color-config $ROSE_PINE)   palette: (basic-prompt-palette $ROSE_PINE) }
        "rose-pine-moon" => { color_config: (basic-color-config $ROSE_PINE_MOON) palette: (basic-prompt-palette $ROSE_PINE_MOON) }
        "rose-pine-dawn" => { color_config: (basic-color-config $ROSE_PINE_DAWN) palette: (basic-prompt-palette $ROSE_PINE_DAWN) }
        "everforest"  => { color_config: (basic-color-config $EVERFOREST)  palette: (basic-prompt-palette $EVERFOREST) }
        "kanagawa"    => { color_config: (basic-color-config $KANAGAWA)    palette: (basic-prompt-palette $KANAGAWA) }
        "onedark"     => { color_config: (basic-color-config $ONEDARK)     palette: (basic-prompt-palette $ONEDARK) }
        "monokai"     => { color_config: (basic-color-config $MONOKAI)     palette: (basic-prompt-palette $MONOKAI) }
        "ayu-dark"    => { color_config: (basic-color-config $AYU_DARK)    palette: (basic-prompt-palette $AYU_DARK) }
        "ayu-mirage"  => { color_config: (basic-color-config $AYU_MIRAGE)  palette: (basic-prompt-palette $AYU_MIRAGE) }
        "night-owl"   => { color_config: (basic-color-config $NIGHT_OWL)   palette: (basic-prompt-palette $NIGHT_OWL) }
        "github-dark"  => { color_config: (basic-color-config $GITHUB_DARK)  palette: (basic-prompt-palette $GITHUB_DARK) }
        "github-light" => { color_config: (basic-color-config $GITHUB_LIGHT) palette: (basic-prompt-palette $GITHUB_LIGHT) }
        "oxocarbon"   => { color_config: (basic-color-config $OXOCARBON)   palette: (basic-prompt-palette $OXOCARBON) }
        "zenburn"     => { color_config: (basic-color-config $ZENBURN)     palette: (basic-prompt-palette $ZENBURN) }
        "super-mario" => { color_config: (basic-color-config $SUPER_MARIO) palette: (basic-prompt-palette $SUPER_MARIO) }
        "solarized"       => { color_config: (basic-color-config $SOLARIZED)       palette: (basic-prompt-palette $SOLARIZED) }
        "solarized-light" => { color_config: (basic-color-config $SOLARIZED_LIGHT) palette: (basic-prompt-palette $SOLARIZED_LIGHT) }
        _ => {
            color_config: (gruvbox-color-config)
            palette: {
                user: $GRUV.yellow, host: $GRUV.orange, path: $GRUV.aqua, git: $GRUV.purple
                sep: $GRUV.gray, ok: $GRUV.green, err: $GRUV.red, time: $GRUV.gray
                added: $GRUV.green, modified: $GRUV.yellow, deleted: $GRUV.red, untracked: $GRUV.gray
                ahead: $GRUV.aqua, behind: $GRUV.orange, stash: $GRUV.purple, conflict: $GRUV.red
                duration: $GRUV.orange, ink: $GRUV.bg
            }
        }
    }
}

# ─────────────────────────────────────────────────────────────
# Theme system  (definitions live in theme.nu)
#   • Ghostty is the source of truth: on startup nushell adopts
#     whatever theme Ghostty is using (gruvbox → gruvbox, etc.)
#   • re-sync in a running shell:  theme-sync
#   • override manually:           theme  (or: theme catppuccin-mocha)
#   • list themes:                 theme-list
# ─────────────────────────────────────────────────────────────

$env.config.table.mode = "rounded"
$env.config.table.index_mode = "auto"
$env.config.footer_mode = 25
$env.config.render_right_prompt_on_last_line = true
$env.config.show_banner = false

# File that stores the currently-selected theme name.
def theme-state-path [] { $nu.default-config-dir | path join "current-theme.txt" }

# Apply a theme to the *current* session (colors + prompt palette).
def --env theme-apply [name: string] {
    let t = (theme-get $name)
    $env.config.color_config = $t.color_config
    $env.THEME_PALETTE = $t.palette
    $env.THEME_NAME = $name
}

# Switch theme. With no argument, opens an interactive fuzzy picker.
# The choice is applied live and persisted for future sessions.
def --env theme [name?: string] {
    let choice = if ($name | is-empty) {
        theme-list | input list --fuzzy $"theme  \(current: ($env.THEME_NAME? | default 'gruvbox')\)"
    } else { $name }
    if ($choice | is-empty) { return }
    if ($choice not-in (theme-list)) {
        print $"(ansi red)unknown theme:(ansi reset) ($choice)"
        print $"available: (theme-list | str join ', ')"
        return
    }
    theme-apply $choice
    $choice | save -f (theme-state-path)
    print $"(ansi green_bold)✓(ansi reset) theme set to (ansi attr_bold)($choice)(ansi reset) (ansi grey)\(pinned\)(ansi reset)"
    # When picked interactively, also choose a matching prompt style.
    if ($name | is-empty) {
        let s = (prompt-styles | input list --fuzzy $"prompt style for ($choice)  \(esc to keep ($env.PROMPT_STYLE? | default 'full')\)")
        if ($s | is-not-empty) {
            $env.PROMPT_STYLE = $s
            $s | save -f (prompt-style-path)
            print $"(ansi green_bold)✓(ansi reset) prompt style set to (ansi attr_bold)($s)(ansi reset)"
        }
    }
}

# Curated theme + prompt-style combinations.
def presets [] {
    [
        { name: "cyberpunk",        theme: "cyberpunk",             style: "cyberpunk" }
        { name: "synthwave",        theme: "cyberpunk",             style: "capsule" }
        { name: "gruvbox",          theme: "gruvbox",               style: "full" }
        { name: "gruvbox-minimal",  theme: "gruvbox",               style: "minimal" }
        { name: "mocha-pure",       theme: "catppuccin-mocha",      style: "pure" }
        { name: "macchiato-lambda", theme: "catppuccin-macchiato",  style: "lambda" }
        { name: "latte-compact",    theme: "catppuccin-latte",      style: "compact" }
        { name: "tokyo-powerline",  theme: "tokyo-night",           style: "powerline" }
        { name: "tokyo-capsule",    theme: "tokyo-night",           style: "capsule" }
        { name: "nord-lambda",      theme: "nord",                  style: "lambda" }
        { name: "dracula-slant",    theme: "dracula",               style: "slant" }
        { name: "rose-pine-pure",   theme: "rose-pine",             style: "pure" }
        { name: "everforest-boxed", theme: "everforest",            style: "boxed" }
        { name: "kanagawa-capsule", theme: "kanagawa",              style: "capsule" }
        { name: "onedark-bracket",  theme: "onedark",               style: "bracket" }
        { name: "solarized-full",   theme: "solarized",             style: "full" }
        { name: "monokai-rainbow",  theme: "monokai",               style: "rainbow" }
        { name: "ayu-arrow",        theme: "ayu-dark",              style: "arrow" }
        { name: "night-owl-pure",   theme: "night-owl",             style: "pure" }
        { name: "github-arrow",     theme: "github-dark",           style: "arrow" }
        { name: "oxocarbon-rainbow",theme: "oxocarbon",             style: "rainbow" }
        { name: "rose-moon-boxed",  theme: "rose-pine-moon",        style: "boxed" }
        { name: "super-mario",      theme: "super-mario",           style: "mario" }
        { name: "arcade",           theme: "super-mario",           style: "arcade" }
        { name: "8bit",             theme: "gruvbox",               style: "8bit" }
    ]
}

# Apply + pin a theme and a prompt style together (overrides Ghostty).
def --env apply-look [theme_name: string, style_name: string] {
    theme-apply $theme_name
    $env.PROMPT_STYLE = $style_name
    $theme_name | save -f (theme-state-path)
    $style_name | save -f (prompt-style-path)
}

# Pick a full look (theme + prompt style). No arg = interactive picker.
def --env look [name?: string] {
    let ps = (presets)
    let choice = if ($name | is-empty) {
        $ps | each {|r| $"($r.name)  —  ($r.theme) + ($r.style)" } | input list --fuzzy "look  (theme + prompt style)"
        | split row "  —  " | get 0? | default ""
    } else { $name }
    if ($choice | is-empty) { return }
    let row = ($ps | where name == $choice | get 0?)
    if ($row | is-empty) {
        print $"(ansi red)unknown look:(ansi reset) ($choice)"
        print $"available: ($ps | get name | str join ', ')"
        return
    }
    apply-look $row.theme $row.style
    print $"(ansi green_bold)✓(ansi reset) look (ansi attr_bold)($choice)(ansi reset) — theme (ansi attr_bold)($row.theme)(ansi reset), style (ansi attr_bold)($row.style)(ansi reset)"
}

# List available looks.
def looks [] { presets | select name theme style }

# Swatch of every theme's palette (one row each) — see all colors at a glance.
def theme-preview [] {
    let names = (theme-list)
    let w = ($names | each { str length } | math max)
    let keys = [err host modified ok ahead path git user]
    for t in $names {
        let p = (theme-get $t).palette
        let sw = ($keys | each {|k| $"(ansi {fg: ($p | get $k)})███(ansi reset)" } | str join "")
        print $"($t | fill --alignment left --width $w)  ($sw)"
    }
}

# Render every prompt style once (using the current theme), stacked + labelled.
def style-preview [] {
    let saved = ($env.PROMPT_STYLE? | default "full")
    let sep = (($env.THEME_PALETTE? | default {}).sep? | default "#808080")
    for s in (prompt-styles) {
        $env.PROMPT_STYLE = $s
        print $"(ansi {fg: $sep})($s)(ansi reset)"
        print (create_left_prompt)
        print ""
    }
    $env.PROMPT_STYLE = $saved
}

# Read Ghostty's active theme and map it to a nushell theme name.
# Returns null when it can't be determined.
# Detect OS dark mode (macOS `defaults`, GNOME `gsettings`); default dark.
def os-dark-mode [] {
    let mac = (do -i { ^defaults read -g AppleInterfaceStyle } | complete)
    if $mac.exit_code == 0 { return ($mac.stdout | str contains --ignore-case "dark") }
    let gnome = (do -i { ^gsettings get org.gnome.desktop.interface color-scheme } | complete)
    if $gnome.exit_code == 0 { return ($gnome.stdout | str contains --ignore-case "dark") }
    true
}

def ghostty-theme-name [] {
    let cfgs = [
        ($env.HOME | path join ".config" "ghostty" "config")
        ($env.HOME | path join "Library" "Application Support" "com.mitchellh.ghostty" "config")
    ]
    let file = ($cfgs | where {|p| $p | path exists } | get 0? )
    if ($file | is-empty) { return null }

    let line = (
        open $file | lines
        | where {|l| ($l | str trim | str starts-with --ignore-case "theme") and ($l | str contains "=") }
        | get 0?
    )
    if ($line | is-empty) { return null }
    mut val = ($line | str replace -r '^\s*[Tt]heme\s*=\s*' '' | str trim)

    # Ghostty supports  theme = light:NAME,dark:NAME  — pick per OS appearance.
    if ($val | str contains ":") {
        let dark = (os-dark-mode)
        let want = (if $dark { "dark" } else { "light" })
        let seg = ($val | split row "," | where {|s| $s | str trim | str starts-with --ignore-case $want } | get 0?)
        if ($seg | is-not-empty) { $val = ($seg | split row ":" | last | str trim) }
    }

    let low = $val
    if ($low | str contains --ignore-case "gruvbox") { "gruvbox"
    } else if ($low | str contains --ignore-case "mocha") { "catppuccin-mocha"
    } else if ($low | str contains --ignore-case "macchiato") { "catppuccin-macchiato"
    } else if ($low | str contains --ignore-case "frappe") { "catppuccin-frappe"
    } else if ($low | str contains --ignore-case "latte") { "catppuccin-latte"
    } else if ($low | str contains --ignore-case "tokyo") { "tokyo-night"
    } else if ($low | str contains --ignore-case "nord") { "nord"
    } else if ($low | str contains --ignore-case "dracula") { "dracula"
    } else if (($low | str contains --ignore-case "rose") or ($low | str contains --ignore-case "ros\u{e9}")) {
        if ($low | str contains --ignore-case "dawn") { "rose-pine-dawn"
        } else if ($low | str contains --ignore-case "moon") { "rose-pine-moon"
        } else { "rose-pine" }
    } else if ($low | str contains --ignore-case "everforest") { "everforest"
    } else if ($low | str contains --ignore-case "kanagawa") { "kanagawa"
    } else if (($low | str contains --ignore-case "one") and ($low | str contains --ignore-case "dark")) { "onedark"
    } else if ($low | str contains --ignore-case "monokai") { "monokai"
    } else if ($low | str contains --ignore-case "mirage") { "ayu-mirage"
    } else if ($low | str contains --ignore-case "ayu") { "ayu-dark"
    } else if (($low | str contains --ignore-case "night") and ($low | str contains --ignore-case "owl")) { "night-owl"
    } else if (($low | str contains --ignore-case "github") and ($low | str contains --ignore-case "light")) { "github-light"
    } else if ($low | str contains --ignore-case "github") { "github-dark"
    } else if ($low | str contains --ignore-case "oxocarbon") { "oxocarbon"
    } else if ($low | str contains --ignore-case "zenburn") { "zenburn"
    } else if ($low | str contains --ignore-case "mario") { "super-mario"
    } else if (($low | str contains --ignore-case "solarized") and ($low | str contains --ignore-case "light")) { "solarized-light"
    } else if ($low | str contains --ignore-case "solarized") { "solarized"
    } else { null }
}

# Re-adopt Ghostty's current theme in this session.
def --env theme-sync [] {
    let g = (ghostty-theme-name)
    if ($g | is-empty) {
        print $"(ansi yellow)could not detect a matching Ghostty theme(ansi reset)"
        return
    }
    theme-apply $g
    "auto" | save -f (theme-state-path)
    print $"(ansi green_bold)✓(ansi reset) synced to Ghostty theme (ansi attr_bold)($g)(ansi reset) (ansi grey)\(auto-follow on\)(ansi reset)"
}

# Startup theme selection:
#   • a pinned theme (a saved theme name) wins — keeps e.g. cyberpunk
#   • "auto" / no pin / invalid → follow Ghostty, else fall back to gruvbox
let saved_theme = (try { open (theme-state-path) | str trim } catch { "auto" })
let start_theme = (
    if ($saved_theme in (theme-list)) { $saved_theme }
    else {
        let g = (ghostty-theme-name)
        if ($g | is-not-empty) { $g } else { "gruvbox" }
    }
)
theme-apply $start_theme

# ─────────────────────────────────────────────────────────────
# Prompt — git-aware, oh-my-zsh style, themed via $env.THEME_PALETTE
#   • rich repo info: branch, ahead/behind, staged/modified/etc.
#   • command duration + exit status
#   • switch layout with:  prompt-style   (full | compact | minimal)
# ─────────────────────────────────────────────────────────────

def prompt-style-path [] { $nu.default-config-dir | path join "prompt-style.txt" }
def prompt-styles [] { ["full" "compact" "minimal" "lambda" "pure" "bracket" "arrow" "powerline" "slant" "capsule" "rainbow" "boxed" "mario" "arcade" "8bit" "cyberpunk"] }

# Use Nerd Font glyphs (branch icon). Set to false for plain ASCII.
$env.PROMPT_NERD = true

# Load saved layout (default: full).
let saved_style = (try { open (prompt-style-path) | str trim } catch { "full" })
$env.PROMPT_STYLE = (if ($saved_style in (prompt-styles)) { $saved_style } else { "full" })

# Switch prompt layout. No arg = interactive picker. Persisted.
def --env prompt-style [name?: string] {
    let choice = if ($name | is-empty) {
        prompt-styles | input list --fuzzy $"prompt style  \(current: ($env.PROMPT_STYLE)\)"
    } else { $name }
    if ($choice | is-empty) { return }
    if ($choice not-in (prompt-styles)) {
        print $"(ansi red)unknown style:(ansi reset) ($choice)"
        print $"available: (prompt-styles | str join ', ')"
        return
    }
    $env.PROMPT_STYLE = $choice
    $choice | save -f (prompt-style-path)
    print $"(ansi green_bold)✓(ansi reset) prompt style set to (ansi attr_bold)($choice)(ansi reset)"
}

# Gather git repo state as data (reused by every prompt style).
def git-info [] {
    let inside = (do -i { git rev-parse --is-inside-work-tree } | complete)
    if $inside.exit_code != 0 { return { present: false } }
    let branch = (do -i { git branch --show-current } | complete | get stdout | str trim)
    let head = if ($branch | is-not-empty) { $branch } else {
        let sha = (do -i { git rev-parse --short HEAD } | complete | get stdout | str trim)
        if ($sha | is-empty) { "(no commits)" } else { $"@($sha)" }
    }
    let lines = (do -i { git status --porcelain=v1 --branch } | complete | get stdout | lines)
    let bl = ($lines | where {|l| $l | str starts-with "##" } | get 0? | default "")
    let ahead  = ($bl | parse -r 'ahead (?<n>\d+)'  | get n.0? | default "0" | into int)
    let behind = ($bl | parse -r 'behind (?<n>\d+)' | get n.0? | default "0" | into int)
    mut staged = 0; mut modified = 0; mut untracked = 0; mut conflict = 0
    for line in ($lines | where {|l| not ($l | str starts-with "##") }) {
        let cs = ($line | split chars)
        let x = ($cs | get 0? | default " ")
        let y = ($cs | get 1? | default " ")
        if ($x == "?" and $y == "?") { $untracked = $untracked + 1
        } else if ($x == "U" or $y == "U" or ($x == "A" and $y == "A") or ($x == "D" and $y == "D")) { $conflict = $conflict + 1
        } else {
            if $x != " " { $staged = $staged + 1 }
            if $y != " " { $modified = $modified + 1 }
        }
    }
    let stash = (do -i { git stash list } | complete | get stdout | lines | where {|l| $l | is-not-empty } | length)
    let clean = (($ahead + $behind + $staged + $modified + $untracked + $conflict + $stash) == 0)
    { present: true, head: $head, ahead: $ahead, behind: $behind, staged: $staged, modified: $modified, untracked: $untracked, conflict: $conflict, stash: $stash, clean: $clean }
}

# Plain-text branch + status summary (no color), e.g. "main ⇡2 +1 !3".
def git-plain [g: record] {
    mut t = $g.head
    if $g.ahead    > 0 { $t = $t + $" ⇡($g.ahead)" }
    if $g.behind   > 0 { $t = $t + $" ⇣($g.behind)" }
    if $g.conflict > 0 { $t = $t + $" =($g.conflict)" }
    if $g.staged   > 0 { $t = $t + $" +($g.staged)" }
    if $g.modified > 0 { $t = $t + $" !($g.modified)" }
    if $g.untracked > 0 { $t = $t + $" ?($g.untracked)" }
    if $g.stash    > 0 { $t = $t + $" *($g.stash)" }
    $t
}

# Rich git segment: branch/commit + divergence + working-tree status.
def git-segment [--counts] {
    let p = $env.THEME_PALETTE
    let inside = (do -i { git rev-parse --is-inside-work-tree } | complete)
    if $inside.exit_code != 0 { return "" }

    let branch = (do -i { git branch --show-current } | complete | get stdout | str trim)
    let head = if ($branch | is-not-empty) { $branch } else {
        let sha = (do -i { git rev-parse --short HEAD } | complete | get stdout | str trim)
        if ($sha | is-empty) { "(no commits)" } else { $"@($sha)" }
    }
    let icon = if ($env.PROMPT_NERD? | default true) { " " } else { "" }
    let base = $"(ansi {fg: $p.sep})on (ansi {fg: $p.git attr: b})($icon)($head)(ansi reset)"
    if not $counts { return $" ($base)" }

    let lines = (do -i { git status --porcelain=v1 --branch } | complete | get stdout | lines)
    let bl = ($lines | where {|l| $l | str starts-with "##" } | get 0? | default "")
    let ahead  = ($bl | parse -r 'ahead (?<n>\d+)'  | get n.0? | default "0" | into int)
    let behind = ($bl | parse -r 'behind (?<n>\d+)' | get n.0? | default "0" | into int)

    mut staged = 0; mut modified = 0; mut untracked = 0; mut conflict = 0
    for line in ($lines | where {|l| not ($l | str starts-with "##") }) {
        let cs = ($line | split chars)
        let x = ($cs | get 0? | default " ")
        let y = ($cs | get 1? | default " ")
        if ($x == "?" and $y == "?") { $untracked = $untracked + 1
        } else if ($x == "U" or $y == "U" or ($x == "A" and $y == "A") or ($x == "D" and $y == "D")) { $conflict = $conflict + 1
        } else {
            if $x != " " { $staged = $staged + 1 }
            if $y != " " { $modified = $modified + 1 }
        }
    }
    let stash = (do -i { git stash list } | complete | get stdout | lines | where {|l| $l | is-not-empty } | length)

    mut parts = []
    if $ahead    > 0 { $parts = ($parts | append $"(ansi {fg: $p.ahead})⇡($ahead)(ansi reset)") }
    if $behind   > 0 { $parts = ($parts | append $"(ansi {fg: $p.behind})⇣($behind)(ansi reset)") }
    if $conflict > 0 { $parts = ($parts | append $"(ansi {fg: $p.conflict})=($conflict)(ansi reset)") }
    if $staged   > 0 { $parts = ($parts | append $"(ansi {fg: $p.added})+($staged)(ansi reset)") }
    if $modified > 0 { $parts = ($parts | append $"(ansi {fg: $p.modified})!($modified)(ansi reset)") }
    if $untracked > 0 { $parts = ($parts | append $"(ansi {fg: $p.untracked})?($untracked)(ansi reset)") }
    if $stash    > 0 { $parts = ($parts | append $"(ansi {fg: $p.stash})*($stash)(ansi reset)") }
    let clean = ($parts | is-empty)
    let status_seg = if $clean {
        $" (ansi {fg: $p.added})✔(ansi reset)"
    } else {
        $" ($parts | str join ' ')"
    }
    $" ($base)($status_seg)"
}

# Username / hostname that don't break the prompt in minimal environments
# (e.g. ttyd/VHS where `whoami` may fail).
def prompt-user [] {
    if (($env.PROMPT_USER? | default "") | is-not-empty) { return $env.PROMPT_USER }
    let u = ($env.USER? | default ($env.USERNAME? | default ""))
    if ($u | is-not-empty) { $u } else {
        let w = (do -i { whoami } | complete | get stdout | str trim)
        if ($w | is-not-empty) { $w } else { "user" }
    }
}
def prompt-host [] {
    if (($env.PROMPT_HOST? | default "") | is-not-empty) { return $env.PROMPT_HOST }
    try { sys host | get hostname } catch { ($env.HOSTNAME? | default "host") }
}

def create_left_prompt [] {
    let p = $env.THEME_PALETTE
    let style = ($env.PROMPT_STYLE? | default "full")
    let full_dir = ($env.PWD | str replace $nu.home-dir "~")

    match $style {
        "minimal" => {
            let dir = ($full_dir | path basename)
            $"(ansi {fg: $p.path attr: b})($dir)(ansi reset)(git-segment)"
        }
        "compact" => {
            let parts = ($full_dir | path split)
            let dir = if (($parts | length) > 2) { $"…/($parts | last 2 | path join)" } else { $full_dir }
            $"(ansi {fg: $p.path attr: b})($dir)(ansi reset)(git-segment --counts)"
        }
        "lambda" => {
            $"(ansi {fg: $p.git attr: b})λ (ansi {fg: $p.path attr: b})($full_dir)(ansi reset)(git-segment --counts)"
        }
        "pure" => {
            let g = (git-info)
            let git_txt = if $g.present {
                let dirty = if $g.clean { "" } else { $"(ansi {fg: $p.modified})*(ansi reset)" }
                $" (ansi {fg: $p.sep})($g.head)($dirty)(ansi reset)"
            } else { "" }
            $"(ansi {fg: $p.path attr: b})($full_dir)(ansi reset)($git_txt)\n"
        }
        "bracket" => {
            let g = (git-info)
            let git_txt = if $g.present { $" (ansi {fg: $p.git attr: b})[(git-plain $g)](ansi reset)" } else { "" }
            let uh = $"(ansi {fg: $p.user attr: b})[(prompt-user)@(prompt-host)](ansi reset)"
            let dir = $"(ansi {fg: $p.path attr: b})[($full_dir)](ansi reset)"
            $"($uh) ($dir)($git_txt)"
        }
        "slant" => {
            let sep = (char --unicode e0b8)
            let ink = $p.ink
            let a = $p.path
            let seg_a = $"(ansi {bg: $a fg: $ink attr: b}) ($full_dir) "
            let g = (git-info)
            if $g.present {
                let b = $p.git
                let seg_b = $"(ansi {fg: $a bg: $b})($sep)(ansi {bg: $b fg: $ink attr: b}) (git-plain $g) "
                $"($seg_a)($seg_b)(ansi reset)(ansi {fg: $b})($sep)(ansi reset) "
            } else {
                $"($seg_a)(ansi reset)(ansi {fg: $a})($sep)(ansi reset) "
            }
        }
        "boxed" => {
            let g = (git-info)
            let git_txt = if $g.present {
                let mark = if $g.clean { $"(ansi {fg: $p.ok})●(ansi reset)" } else { $"(ansi {fg: $p.modified})●(ansi reset)" }
                $" (ansi {fg: $p.sep})│ (ansi {fg: $p.git attr: b})(git-plain $g)(ansi reset) ($mark)"
            } else { "" }
            let uh = $"(ansi {fg: $p.user attr: b})(prompt-user)(ansi {fg: $p.sep})@(ansi {fg: $p.host})(prompt-host)(ansi reset)"
            let l1 = $"(ansi {fg: $p.sep})╭─ ($uh) (ansi {fg: $p.sep})in (ansi {fg: $p.path attr: b})($full_dir)(ansi reset)($git_txt)"
            let l2 = $"(ansi {fg: $p.sep})╰─(ansi reset)"
            $"($l1)\n($l2)"
        }
        "arrow" => {
            let g = (git-info)
            let sep = $"(ansi {fg: $p.sep}) » "
            let gitp = if $g.present { $"($sep)(ansi {fg: $p.git attr: b})(git-plain $g)(ansi reset)" } else { "" }
            $"(ansi {fg: $p.user attr: b})(prompt-user)(ansi reset)($sep)(ansi {fg: $p.path attr: b})($full_dir)(ansi reset)($gitp)"
        }
        "rainbow" => {
            let a = (char --unicode e0b0)
            let ink = $p.ink
            let g = (git-info)
            let s1 = $"(ansi {bg: $p.user fg: $ink attr: b}) (prompt-user) "
            let t12 = $"(ansi {fg: $p.user bg: $p.path})($a)"
            let s2 = $"(ansi {bg: $p.path fg: $ink attr: b}) ($full_dir) "
            if $g.present {
                let t23 = $"(ansi {fg: $p.path bg: $p.git})($a)"
                let s3 = $"(ansi {bg: $p.git fg: $ink attr: b}) (git-plain $g) "
                $"($s1)($t12)($s2)($t23)($s3)(ansi reset)(ansi {fg: $p.git})($a)(ansi reset) "
            } else {
                $"($s1)($t12)($s2)(ansi reset)(ansi {fg: $p.path})($a)(ansi reset) "
            }
        }
        "mario" => {
            # ◆ hero · ⚑ flag(branch) · ◉ coins(changes) / ★ when clean
            let g = (git-info)
            let hero = $"(ansi {fg: $p.err attr: b})◆(ansi reset)"
            let dir = $"(ansi {fg: $p.path attr: b})($full_dir)(ansi reset)"
            let git_txt = if $g.present {
                let flag = $" (ansi {fg: $p.ok attr: b})⚑ ($g.head)(ansi reset)"
                let n = ($g.staged + $g.modified + $g.untracked)
                let coins = if $n > 0 { $" (ansi {fg: $p.modified attr: b})◉×($n)(ansi reset)" } else { $" (ansi {fg: $p.modified})★(ansi reset)" }
                $"($flag)($coins)"
            } else { "" }
            $"($hero) ($dir)($git_txt)"
        }
        "arcade" => {
            # retro all-caps score/1UP vibe
            let g = (git-info)
            let git_txt = if $g.present { $" (ansi {fg: $p.sep})‹(ansi {fg: $p.git attr: b})(git-plain $g)(ansi {fg: $p.sep})›(ansi reset)" } else { "" }
            $"(ansi {fg: $p.modified attr: b})▶ 1UP(ansi reset) (ansi {fg: $p.path attr: b})($full_dir)(ansi reset)($git_txt)"
        }
        "8bit" => {
            # pixel gradient separators ░▒▓
            let g = (git-info)
            let grad = $"(ansi {fg: $p.sep})░▒▓(ansi reset)"
            let gitp = if $g.present { $"($grad)(ansi {fg: $p.git attr: b})(git-plain $g)(ansi reset)" } else { "" }
            $"(ansi {fg: $p.user attr: b})(prompt-user)($grad)(ansi {fg: $p.path attr: b})($full_dir)(ansi reset)($gitp)"
        }
        "capsule" => {
            let lc = (char --unicode e0b6)
            let rc = (char --unicode e0b4)
            let ink = $p.ink
            let g = (git-info)
            let path_cap = $"(ansi {fg: $p.path})($lc)(ansi {bg: $p.path fg: $ink attr: b}) ($full_dir) (ansi reset)(ansi {fg: $p.path})($rc)(ansi reset)"
            let git_cap = if $g.present {
                $"  (ansi {fg: $p.git})($lc)(ansi {bg: $p.git fg: $ink attr: b}) (git-plain $g) (ansi reset)(ansi {fg: $p.git})($rc)(ansi reset)"
            } else { "" }
            $"($path_cap)($git_cap)"
        }
        "powerline" => {
            let sep = (char --unicode e0b0)
            let ink = $p.ink
            let a = $p.path
            let seg_a = $"(ansi {bg: $a fg: $ink attr: b}) ($full_dir) "
            let g = (git-info)
            if $g.present {
                let b = $p.git
                let seg_b = $"(ansi {fg: $a bg: $b})($sep)(ansi {bg: $b fg: $ink attr: b}) (git-plain $g) "
                $"($seg_a)($seg_b)(ansi reset)(ansi {fg: $b})($sep)(ansi reset) "
            } else {
                $"($seg_a)(ansi reset)(ansi {fg: $a})($sep)(ansi reset) "
            }
        }
        "cyberpunk" => {
            let g = (git-info)
            let git_txt = if $g.present {
                $" (ansi {fg: $p.sep})─(ansi {fg: $p.git attr: b})▓ (git-plain $g)(ansi reset)"
            } else { "" }
            let bolt = $"(ansi {fg: $p.modified attr: b})⚡(ansi reset)"
            let uh = $"(ansi {fg: $p.user attr: b})❮(prompt-user)@(prompt-host)❯"
            let dir = $"(ansi {fg: $p.path attr: b})❮($full_dir)❯"
            let l1 = $"(ansi {fg: $p.sep})╭─($bolt)(ansi {fg: $p.sep})─($uh)(ansi {fg: $p.sep})─($dir)(ansi reset)($git_txt)"
            let l2 = $"(ansi {fg: $p.sep})╰─(ansi reset)"
            $"($l1)\n($l2)"
        }
        _ => {
            let user_host = $"(ansi {fg: $p.user})(prompt-user)(ansi {fg: $p.sep})@(ansi {fg: $p.host})(prompt-host)(ansi reset)"
            $"($user_host) (ansi {fg: $p.sep})in (ansi {fg: $p.path attr: b})($full_dir)(ansi reset)(git-segment --counts)"
        }
    }
}

def create_right_prompt [] {
    let p = $env.THEME_PALETTE
    let dur_ms = ($env.CMD_DURATION_MS? | default "0" | into int)
    let dur_seg = if $dur_ms > 2000 {
        let d = ($dur_ms * 1ms)
        $"(ansi {fg: $p.duration})took ($d)(ansi reset)  "
    } else { "" }
    let time = $"(ansi {fg: $p.time})(date now | format date '%H:%M:%S')(ansi reset)"
    if ($env.PROMPT_STYLE? | default "full") == "minimal" { $time } else { $"($dur_seg)($time)" }
}

# Indicator: style-aware glyph, turns red after a failed command.
def prompt-indicator [] {
    let p = $env.THEME_PALETTE
    let ok = (($env.LAST_EXIT_CODE? | default 0) == 0)
    let style = ($env.PROMPT_STYLE? | default "full")
    let glyph = match $style {
        "cyberpunk" => "▶▶▶"
        "lambda" => "λ"
        "mario" => "▶"
        "arcade" => "▮▮"
        "8bit" => "█"
        _ => "❯"
    }
    let color = if $ok {
        if $style in ["cyberpunk" "pure"] { $p.git } else if $style in ["mario" "arcade" "8bit"] { $p.modified } else { $p.ok }
    } else { $p.err }
    $"(ansi {fg: $color attr: b})($glyph) (ansi reset)"
}

$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { || create_right_prompt }
$env.PROMPT_INDICATOR = { || prompt-indicator }
$env.PROMPT_INDICATOR_VI_INSERT = { || prompt-indicator }
$env.PROMPT_INDICATOR_VI_NORMAL = { || $"(ansi {fg: $env.THEME_PALETTE.err attr: b})❮ (ansi reset)" }
$env.PROMPT_MULTILINE_INDICATOR = { || $"(ansi {fg: $env.THEME_PALETTE.sep})::: (ansi reset)" }
