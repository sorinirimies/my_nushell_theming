# Light themes spotlight (rendered on a light terminal background).
Output docs/light.gif

Set Shell "nu"
Set FontFamily "FiraCode Nerd Font Mono"
Set FontSize 20
Set Width 1200
Set Height 620
Set Padding 24
Set LineHeight 1.2
Set TypingSpeed 45ms
Set Theme { "background": "#f6f6f8", "foreground": "#3a3a48" }

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
Type "theme github-light"
Enter
Sleep 450ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 1.8s
Type "theme catppuccin-latte"
Enter
Sleep 450ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 1.8s
Type "theme rose-pine-dawn"
Enter
Sleep 450ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 1.8s
Type "theme solarized-light"
Enter
Sleep 450ms
Type "ls | first 3 | select name size modified"
Enter
Sleep 2s
