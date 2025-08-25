if !(which nvim all> /dev/null):
    aliases['vim'] = ['nvim']
    $EDITOR = 'nvim'
else:
    $EDITOR = 'vim'
