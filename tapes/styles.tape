# Prompt styles: same theme, cycle through all the layout styles.
Output docs/styles.gif

Set Shell "nu"
Set FontFamily "FiraCode Nerd Font Mono"
Set FontSize 20
Set Width 1200
Set Height 560
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
Type "theme tokyo-night"
Enter
Type "clear"
Enter
Sleep 300ms
Show

Sleep 700ms
Type "prompt-style full"
Enter
Sleep 1.3s
Type "prompt-style arrow"
Enter
Sleep 1.3s
Type "prompt-style bracket"
Enter
Sleep 1.3s
Type "prompt-style lambda"
Enter
Sleep 1.3s
Type "prompt-style powerline"
Enter
Sleep 1.3s
Type "prompt-style slant"
Enter
Sleep 1.3s
Type "prompt-style capsule"
Enter
Sleep 1.3s
Type "prompt-style rainbow"
Enter
Sleep 1.3s
Type "prompt-style boxed"
Enter
Sleep 1.5s
Type "prompt-style cyberpunk"
Enter
Sleep 1.8s
