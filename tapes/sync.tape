# theme-sync: pin a custom look, then snap back to Ghostty's theme.
Output docs/sync.gif

Set Shell "nu"
Set FontFamily "FiraCode Nerd Font Mono"
Set FontSize 20
Set Width 1200
Set Height 480
Set Padding 24
Set LineHeight 1.2
Set TypingSpeed 55ms

Hide
Type "$env.PROMPT_COMMAND = { || create_left_prompt }"
Enter
Type "$env.PROMPT_USER = 'sorin'"
Enter
Type "$env.PROMPT_HOST = 'nuance'"
Enter
Type "prompt-style compact"
Enter
Type "clear"
Enter
Sleep 300ms
Show

Sleep 800ms
Type "# pin a theme (overrides Ghostty)"
Enter
Sleep 700ms
Type "theme dracula"
Enter
Sleep 700ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 2s
Type "# re-follow whatever theme Ghostty uses"
Enter
Sleep 700ms
Type "theme-sync"
Enter
Sleep 700ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 2.4s
