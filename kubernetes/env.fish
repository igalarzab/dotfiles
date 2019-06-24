alias kc=kubectl
alias kctx=kubectx

function kcs
    kubectl --namespace=kube-system $argv
end

function kca
    kubectl $argv --all-namespaces
end

function klogs
    stern --all-namespaces --since 10m --tail 100 $argv
end

function kcpods
    kubectl -n $argv[1] get pods
end

function kcpodsw
    watch -n3 kubectl -n $argv[1] get pods
end
