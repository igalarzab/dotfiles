sourceFile = p'/opt/homebrew/opt/asdf/libexec/asdf.sh'

if sourceFile.exists():
    source-bash @(sourceFile)
    $PATH.add(p'~/.local/bin', front=True, replace=True)
