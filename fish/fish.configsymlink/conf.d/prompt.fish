# Faster prompt
set -g async_prompt_functions _pure_prompt_git

# Overwrite some pure colors
set -g pure_color_git_branch (set_color green)
set -g pure_color_git_dirty (set_color yellow)
set -g pure_color_virtualenv (set_color blue)

