import shutil

if shutil.which('nvim', path=':'.join($PATH)):
    aliases['vim'] = ['nvim']
    $EDITOR = 'nvim'
else:
    $EDITOR = 'vim'
