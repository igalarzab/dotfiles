# autojump
set -U Z_CMD "j"                   # Jump with j instead of z

# fzf
bind \cp '_fzf_search_directory'   # Activate FZF with Ctrl+p (for files search)
bind \cg '_fzf_search_git_status'  # Activate FZF with Ctrl+g (for git files)

# pure
set -g pure_check_for_new_release false
set -g pure_color_git_branch (set_color green)
set -g pure_color_git_dirty (set_color yellow)
set -g pure_color_virtualenv (set_color blue)
set -g async_prompt_functions _pure_prompt_git   # Make some prompt functions async to make it faster


