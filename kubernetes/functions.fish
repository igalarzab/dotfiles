# Set the iterm2 badge
if type -q kubectl
    function iterm2_print_user_vars
        iterm2_set_user_var kubeContext (kubectl config current-context)
    end
end
