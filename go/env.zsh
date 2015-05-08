if (( $+commands[go] ))
then
    export GOROOT=`go env GOROOT`
    export GOPATH=~/.golang/global
    export PATH=$PATH:/usr/local/opt/go/libexec/bin:$GOPATH/bin
fi
