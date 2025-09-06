aliases['..'] = ['cd' , '..']
aliases['dot'] = ['cd' , $DOTFILES]

aliases['l'] = ['ls']
aliases['ll'] = ['ls', '-l']
aliases['la'] = ['ls', '-a']
aliases['lla'] = ['ls', '-la']

aliases['grep'] = ['grep', '--color=auto']

if !(which gsed all> /dev/null):
    aliases['sed'] = ['gsed']

if !(which gfind all> /dev/null):
    aliases['find'] = ['gfind']

if !(which bat all> /dev/null):
    $BAT_THEME='OneHalfDark'
    aliases['cat'] = ['bat']
