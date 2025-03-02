import shutil

if shutil.which('carapace', path=':'.join($PATH)):
    $CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
    $COMPLETIONS_CONFIRM=True

    exec($(carapace _carapace xonsh))
