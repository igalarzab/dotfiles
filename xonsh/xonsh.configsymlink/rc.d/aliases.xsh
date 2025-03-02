import shutil

aliases['..'] = ['cd' , '..']

aliases['l'] = ['ls']
aliases['ll'] = ['ls', '-l']
aliases['la'] = ['ls', '-a']
aliases['lla'] = ['ls', '-la']

aliases['grep'] = ['grep', '--color=auto']

if shutil.which('gsed', path=':'.join($PATH)):
    aliases['sed'] = ['gsed']

if shutil.which('gfind', path=':'.join($PATH)):
    aliases['find'] = ['gfind']

if shutil.which('bat', path=':'.join($PATH)):
    $BAT_THEME='OneHalfDark'
    aliases['cat'] = ['bat']
