if !(which zoxide all> /dev/null):
    execx($(zoxide init --cmd j xonsh), 'exec', __xonsh__.ctx, filename='zoxide')