import shutil

if $XONSH_INTERACTIVE and shutil.which("starship"):
    execx($(starship init xonsh), 'exec', __xonsh__.ctx, filename='starship')
