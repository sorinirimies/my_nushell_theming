#!/usr/bin/env nu
# install.nu — cross-platform deploy for nuance.
# Pure Nushell; works anywhere Nushell runs (macOS / Linux / Windows / WSL).
#
# From a clone:
#   nu install.nu            # symlink (repo stays the source of truth)
#   nu install.nu --copy     # copy instead of symlinking
#
# One-liner (no clone needed):
#   nu -c 'http get https://raw.githubusercontent.com/sorinirimies/nuance/main/install.nu | save -f /tmp/nuance-install.nu; nu /tmp/nuance-install.nu'

const REPO_URL = "https://github.com/sorinirimies/nuance.git"
const FILE = "nushell-prompt.nu"

# Find the source file next to this script, or clone the repo if run standalone.
def resolve-source []: nothing -> string {
    let here = ($env.FILE_PWD | path join $FILE)
    if ($here | path exists) { return $here }
    let cache = ($env.XDG_CACHE_HOME? | default ($env.HOME | path join ".cache") | path join "nuance")
    print $"(ansi cyan)fetching(ansi reset) ($REPO_URL) ..."
    rm -rf $cache
    ^git clone --depth 1 $REPO_URL $cache
    $cache | path join $FILE
}

def main [--copy] {
    let src = (resolve-source)
    let dest = ($nu.user-autoload-dirs | get 0)
    let target = ($dest | path join $FILE)

    mkdir $dest
    print $"(ansi green_bold)nuance(ansi reset) → ($dest)"

    if (($target | path exists) or (($target | path type) == "symlink")) { rm -f $target }
    if $copy {
        cp $src $target
        print $"  (ansi cyan)copied(ansi reset)  ($FILE)"
    } else {
        ^ln -s $src $target
        print $"  (ansi cyan)linked(ansi reset)  ($FILE) -> ($src)"
    }

    # Install the `nuance` CLI so `nuance update` works from any shell too.
    let cli_src = ($src | path dirname | path join "bin" "nuance")
    if ($cli_src | path exists) {
        let bindir = ($env.HOME | path join ".local" "bin")
        mkdir $bindir
        let cli_target = ($bindir | path join "nuance")
        if (($cli_target | path exists) or (($cli_target | path type) == "symlink")) { rm -f $cli_target }
        if $copy { cp $cli_src $cli_target } else { ^ln -s $cli_src $cli_target }
        ^chmod +x $cli_target
        print $"  (ansi cyan)cli(ansi reset)     nuance -> ($cli_target)"
        if (not ($env.PATH | any {|p| $p == $bindir })) {
            print $"  (ansi yellow)note(ansi reset)    add ($bindir) to your shell PATH to use `nuance` outside Nushell"
        }
    }

    print ""
    print $"(ansi green_bold)✓ installed.(ansi reset) Open a new shell, or run: (ansi attr_bold)exec nu(ansi reset)"
    print "Try:  theme cyberpunk   ·   prompt-style cyberpunk   ·   nuance update"
}
