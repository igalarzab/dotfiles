if (( $+commands[go] ))
then
    export GOROOT=`go env GOROOT`
    export GOPATH=~/.golang/global
    export PATH=$PATH:$GOPATH/bin
fi
