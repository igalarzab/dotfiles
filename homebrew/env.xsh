$HOMEBREW_PREFIX = p"/opt/homebrew"

$HOMEBREW_CELLAR = $HOMEBREW_PREFIX / 'Cellar'
$HOMEBREW_REPOSITORY = $HOMEBREW_PREFIX
$HOMEBREW_NO_AUTO_UPDATE = 1

$PATH.add($HOMEBREW_PREFIX / 'sbin', front=True, replace=True)
$PATH.add($HOMEBREW_PREFIX / 'bin', front=True, replace=True)