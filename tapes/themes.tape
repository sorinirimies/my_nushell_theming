# Themes: cycle through a selection of the 25 color themes.
Output docs/themes.gif

Set Shell "nu"
Set FontFamily "FiraCode Nerd Font Mono"
Set FontSize 20
Set Width 1200
Set Height 640
Set Padding 24
Set LineHeight 1.2
Set TypingSpeed 40ms

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

Sleep 700ms
Type "theme gruvbox"
Enter
Sleep 450ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 1.6s
Type "theme catppuccin-mocha"
Enter
Sleep 450ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 1.6s
Type "theme tokyo-night"
Enter
Sleep 450ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 1.6s
Type "theme dracula"
Enter
Sleep 450ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 1.6s
Type "theme monokai"
Enter
Sleep 450ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 1.6s
Type "theme night-owl"
Enter
Sleep 450ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 1.6s
Type "theme oxocarbon"
Enter
Sleep 450ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 1.6s
Type "theme github-light"
Enter
Sleep 450ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 1.6s
Type "theme cyberpunk"
Enter
Sleep 450ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 2s
