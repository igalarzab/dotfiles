import shutil

if $XONSH_INTERACTIVE and shutil.which("atuin"):
    execx($(atuin init xonsh --disable-up-arrow), 'exec', __xonsh__.ctx, filename='atuin')
