#!/usr/bin/env nu
# install.nu — cross-platform deploy for nuance.
# Pure Nushell; works anywhere Nushell runs (macOS / Linux / Windows / WSL).
#
# From a clone:
#   nu install.nu            # symlink (repo stays the source of truth)
#   nu install.nu --copy     # copy instead of symlinking
#
# One-liner (no clone needed):
#   nu -c "let d = (mktemp -d); http get https://raw.githubusercontent.com/sorinirimies/nuance/main/install.nu | save ($d | path join install.nu); nu ($d | path join install.nu)"

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

    print ""
    print $"(ansi green_bold)✓ installed.(ansi reset) Open a new shell, or run: (ansi attr_bold)exec nu(ansi reset)"
    print "Try:  theme cyberpunk   ·   prompt-style cyberpunk"
    print "Also: theme · theme-sync · prompt-style"
}
