#####
#
# Fisher Config
#
#####

set -g fisher_path ~/.config/fish/fisher/

set fish_function_path $fish_function_path[1] $fisher_path/functions $fish_function_path[2..-1]
set fish_complete_path $fish_complete_path[1] $fisher_path/completions $fish_complete_path[2..-1]

# Install fisher CLI and fisher packages
if not functions -q fisher
    curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
    fish -c fisher
end

for file in $fisher_path/conf.d/*.fish
    builtin source $file 2> /dev/null
end

