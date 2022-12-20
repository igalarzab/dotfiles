sourceFile = p'/usr/local/opt/asdf/libexec/asdf.sh'

if sourceFile.exists():
    source-bash sourceFile
    $PATH.add(p'~/.local/bin', front=False, replace=True)
