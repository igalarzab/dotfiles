alias kc=kubectl

if [ $commands[stern] ]; then
  source <(stern --completion=zsh)

  klogs () {
    stern --all-namespaces --since 10m --tail 10 $@
  }
fi


kcs() {
    kubectl --namespace=kube-system $@
}
