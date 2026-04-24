def _openclaw(args, stdin=None):
  pod = $(kubectl --context=saturn get pod -n openclaw -l app.kubernetes.io/name=openclaw -o jsonpath='{.items[0].metadata.name}').strip().strip("'")
  kubectl --context saturn exec -it -n openclaw @(pod) -c openclaw -- node dist/index.js @(args)

aliases['openclaw'] = _openclaw
