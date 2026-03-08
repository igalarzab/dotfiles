def _openclaw(args, stdin=None):
  pod = $(kubectl get pod -n openclaw -l app.kubernetes.io/name=openclaw -o jsonpath='{.items[0].metadata.name}').strip().strip("'")
  kubectl exec -it -n openclaw @(pod) -- node dist/index.js @(args)


aliases['openclaw'] = _openclaw
