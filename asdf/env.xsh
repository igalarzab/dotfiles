sourceFiles = [
    p'/usr/local/opt/asdf/libexec/asdf.sh',
    p'/opt/homebrew/opt/asdf/libexec/asdf.sh',
]

for f in sourceFiles:
    if f.exists():
        source-bash @(f)
        $PATH.add(p'~/.local/bin', front=False, replace=True)
