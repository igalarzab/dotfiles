dockerForMac = p'/Applications/Docker.app/Contents/Resources/bin'

if dockerForMac.exists():
    $PATH.add(dockerForMac, front=True, replace=True)
