aliases['..'] = ['cd' , '..']

aliases['l'] = ['ls']
aliases['ll'] = ['ls', '-l']
aliases['la'] = ['ls', '-a']
aliases['lla'] = ['ls', '-la']

aliases['grep'] = ['grep', '--color=auto']

#
# GNU Utils
#

if !(which gsed):
    aliases['sed'] = ['gsed']

if !(which gfind):
    aliases['find'] = ['gfind']

if !(which bat):
    $BAT_THEME='OneHalfDark'
    aliases['cat'] = ['bat']
