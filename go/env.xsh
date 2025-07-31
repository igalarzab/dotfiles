import shutil

if shutil.which('go', path=':'.join($PATH)):
    path = p'~/.golang'

    $GOPATH = path
    $PATH.add(path / 'bin', front=True, replace=True)
