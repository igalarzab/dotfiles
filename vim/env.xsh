import shutil

if shutil.which('nvim'):
    aliases['vim'] = ['nvim']
    $EDITOR = 'nvim'
else:
    $EDITOR = 'vim'
