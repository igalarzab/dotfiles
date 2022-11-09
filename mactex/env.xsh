texlive=p'/usr/local/texlive/2022/bin/universal-darwin/'

if texlive.exists():
    $PATH.add(texlive)
