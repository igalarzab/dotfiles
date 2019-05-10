#krew
export PATH="$PATH:${KREW_ROOT:-$HOME/.krew}/bin"

alias kc=kubectl
alias kctx=kubectx

kcs() {
    kubectl --namespace=kube-system $@
}

kca() {
    kubectl $@ --all-namespaces
}

klogs () {
    stern --all-namespaces --since 10m --tail 100 $@
}

kcpods () {
    kubectl -n $1 get pods
}

kcpodsw () {
    watch -n3 "kubectl -n $1 get pods"
}
