# Welcome / hero: the git-aware cyberpunk prompt in action.
Output docs/welcome.gif

Set Shell "nu"
Set FontFamily "FiraCode Nerd Font Mono"
Set FontSize 20
Set Width 1200
Set Height 420
Set Padding 26
Set LineHeight 1.2
Set TypingSpeed 55ms

Hide
Type "$env.PROMPT_COMMAND = { || create_left_prompt }"
Enter
Type "$env.PROMPT_USER = 'sorin'"
Enter
Type "$env.PROMPT_HOST = 'nuance'"
Enter
Type "look cyberpunk"
Enter
Type "clear"
Enter
Sleep 400ms
Show

Sleep 1s
Type "git status --short"
Enter
Sleep 2s
Type "ls | first 4 | select name size modified"
Enter
Sleep 2.5s
Type "sys host | select hostname uptime"
Enter
Sleep 2.5s
