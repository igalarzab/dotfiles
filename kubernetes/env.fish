alias k=kubectl
alias kctx=kubectx

function klogs
    stern --all-namespaces --since 10m --tail 100 $argv
end
