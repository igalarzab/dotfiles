alias kc=kubectl

kcs() {
    kubectl --namespace=kube-system $@
}

kca() {
    kubectl $@ --all-namespaces
}

klogs () {
    stern --all-namespaces --since 10m --tail 10 $@
}
