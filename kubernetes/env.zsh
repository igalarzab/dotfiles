alias kc=kubectl

kcs() {
    kubectl --namespace=kube-system $@
}

kclogs() {
    if [ -z $1 ]; then
        echo "Usage: kclogs pod-exp [pod-number]"
        return
    fi

    line=1

    if [ ! -z $2 ]; then
        line=$2
    fi

    kubectl logs --tail 100 --follow `kubectl get pods | grep $1 | awk NR==${line}'{print $1}'`
}

kcbash() {
    if [ -z $1 ]; then
        echo "Usage: kcbash pod-exp"
        return
    fi

    line=1

    if [ ! -z $2 ]; then
        line=$2
    fi

    kubectl exec -ti `kubectl get pods | grep $1 | awk NR==${line}'{print $1}'` /bin/bash
}

