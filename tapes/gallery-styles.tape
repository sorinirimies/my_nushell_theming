# Gallery: every prompt style rendered once (on tokyo-night).
Output docs/gallery-styles.gif

Set Shell "nu"
Set FontFamily "FiraCode Nerd Font Mono"
Set FontSize 16
Set Width 1100
Set Height 1220
Set Padding 22
Set LineHeight 1.2

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

Sleep 500ms
Type "style-preview"
Enter
Sleep 3.5s
