# Hero demo: cycle through several "looks" (theme + prompt style).
Output docs/demo.gif

Set Shell "nu"
Set FontFamily "FiraCode Nerd Font Mono"
Set FontSize 20
Set Width 1200
Set Height 560
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
Type "clear"
Enter
Sleep 500ms
Show

Sleep 1s
Type "look cyberpunk"
Enter
Sleep 1.8s
Type "ls | first 3"
Enter
Sleep 2.2s
Type "look monokai-rainbow"
Enter
Sleep 2.2s
Type "look ayu-arrow"
Enter
Sleep 2.2s
Type "look tokyo-powerline"
Enter
Sleep 2.2s
Type "look oxocarbon-rainbow"
Enter
Sleep 2.2s
Type "look gruvbox"
Enter
Sleep 2.4s
