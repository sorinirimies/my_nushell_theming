#!/usr/bin/env nu
# uninstall.nu — remove the prompt+theme from your autoload dir.
def main [] {
    let dest = ($nu.user-autoload-dirs | get 0)
    let d = ($dest | path join "nushell-prompt.nu")
    if (($d | path exists) or ($d | path type) == "symlink") {
        rm -f $d
        print $"removed ($d)"
    } else {
        print "nothing to remove."
    }
    let cli = ($env.HOME | path join ".local" "bin" "nuance")
    if (($cli | path exists) or ($cli | path type) == "symlink") { rm -f $cli; print $"removed ($cli)" }
    print "Done. Restart your shell. (State files current-theme.txt / prompt-style.txt are left in place.)"
}
