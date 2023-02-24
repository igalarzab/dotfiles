if !(which zoxide):
    execx($(zoxide init --cmd j xonsh), 'exec', __xonsh__.ctx, filename='zoxide')

