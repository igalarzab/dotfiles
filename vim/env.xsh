if $(which nvim 2>/dev/null):
    aliases['vim'] = ['nvim']
    $EDITOR = 'nvim'
else:
    $EDITOR = 'vim'
