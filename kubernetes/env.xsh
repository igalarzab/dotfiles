aliases['k'] = ['kubectl']
aliases['ks'] = ['kubectl', '-n', 'kube-system']

aliases['kbash'] = ['kubectl', 'run', '-i', '--tty', '--rm', '--image=ubuntu', 'shell', 'bash']
aliases['klogs'] = lambda args: ![kubectl logs --all-containers -n @(args[0]) -f -l app.kubernetes.io/name=@(args[1])]
aliases['krmp'] = lambda args: ![kubectl delete --all-namespaces pod -l app.kubernetes.io/name=@(args[0])]
