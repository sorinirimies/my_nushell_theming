# Gallery: color swatch of every theme (all 26 at once).
Output docs/gallery-themes.gif

Set Shell "nu"
Set FontFamily "FiraCode Nerd Font Mono"
Set FontSize 18
Set Width 760
Set Height 900
Set Padding 22
Set LineHeight 1.15

Hide
Type "$env.PROMPT_COMMAND = { || create_left_prompt }"
Enter
Type "$env.PROMPT_USER = 'sorin'"
Enter
Type "$env.PROMPT_HOST = 'nuance'"
Enter
Type "clear"
Enter
Sleep 300ms
Show

Sleep 500ms
Type "theme-preview"
Enter
Sleep 3.5s
