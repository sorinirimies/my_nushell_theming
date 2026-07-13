# Game-inspired styles on the Super Mario theme.
Output docs/games.gif

Set Shell "nu"
Set FontFamily "FiraCode Nerd Font Mono"
Set FontSize 20
Set Width 1200
Set Height 520
Set Padding 24
Set LineHeight 1.2
Set TypingSpeed 45ms

Hide
Type "$env.PROMPT_COMMAND = { || create_left_prompt }"
Enter
Type "theme super-mario"
Enter
Type "clear"
Enter
Sleep 300ms
Show

Sleep 700ms
Type "prompt-style mario"
Enter
Sleep 1.6s
Type "ls | first 3 | select name size modified"
Enter
Sleep 2s
Type "prompt-style arcade"
Enter
Sleep 1.8s
Type "prompt-style 8bit"
Enter
Sleep 1.8s
Type "look super-mario"
Enter
Sleep 2s
