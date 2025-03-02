import shutil

if shutil.which('zoxide', path=':'.join($PATH)):
    execx($(zoxide init --cmd j xonsh), 'exec', __xonsh__.ctx, filename='zoxide')

