aliases['..'] = ['cd' , '..']

aliases['l'] = ['ls']
aliases['ll'] = ['ls', '-l']
aliases['la'] = ['ls', '-a']
aliases['lla'] = ['ls', '-la']

aliases['grep'] = ['grep', '--color=auto']

#
# GNU Utils
#

if $(which gsed 2>/dev/null):
    aliases['sed'] = ['gsed']

if $(which gfind 2>/dev/null):
    aliases['find'] = ['gfind']

if $(which bat 2>/dev/null):
    $BAT_THEME='OneHalfDark'
    aliases['cat'] = ['bat']
