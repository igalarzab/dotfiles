alias kc=kubectl

kcs() {
    kubectl --namespace=kube-system $@
}

kca() {
    kubectl $@ --all-namespaces
}

if [ $commands[stern] ]; then
  source <(stern --completion=zsh)

  klogs () {
    stern --all-namespaces --since 10m --tail 10 $@
  }
fi
