import shutil

aliases['..'] = ['cd' , '..']

aliases['l'] = ['ls']
aliases['ll'] = ['ls', '-l']
aliases['la'] = ['ls', '-a']
aliases['lla'] = ['ls', '-la']

aliases['grep'] = ['grep', '--color=auto']

if shutil.which('gsed'):
    aliases['sed'] = ['gsed']

if shutil.which('gfind'):
    aliases['find'] = ['gfind']

if shutil.which('bat'):
    $BAT_THEME='OneHalfDark'
    aliases['cat'] = ['bat']