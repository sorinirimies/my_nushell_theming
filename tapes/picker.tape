# Interactive pickers: fuzzy-select a theme (+style) and a look.
Output docs/picker.gif

Set Shell "nu"
Set FontFamily "FiraCode Nerd Font Mono"
Set FontSize 20
Set Width 1200
Set Height 640
Set Padding 24
Set LineHeight 1.2
Set TypingSpeed 90ms

Hide
Type "$env.PROMPT_COMMAND = { || create_left_prompt }"
Enter
Type "$env.PROMPT_USER = 'sorin'"
Enter
Type "$env.PROMPT_HOST = 'nuance'"
Enter
Type "look gruvbox"
Enter
Type "clear"
Enter
Sleep 300ms
Show

Sleep 800ms
Type "prompt-style"
Enter
Sleep 900ms
Type "rainbow"
Sleep 1.2s
Enter
Sleep 1.6s

Type "theme"
Enter
Sleep 900ms
Type "monokai"
Sleep 1.2s
Enter
Sleep 900ms
Type "rainbow"
Sleep 1.2s
Enter
Sleep 1.8s
