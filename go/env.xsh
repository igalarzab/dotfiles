if !(which go all> /dev/null):
    path = p'~/.golang'

    $GOPATH = path
    $PATH.add(path / 'bin', front=True, replace=True)
