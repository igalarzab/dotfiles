aliases['k'] = ['kubectl']
aliases['kctx'] = ['kubectx']
aliases['kbash'] = ['kubectl', 'run', '-i', '--tty', '--rm', '--image=ubuntu', 'shell', 'bash']
aliases['klogs'] = ['kubectl', 'logs', '-f', '--all-containers']

aliases['ks'] = ['kubectl', '-n', 'kube-system']
