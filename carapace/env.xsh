if !(which carapace all> /dev/null):
    $CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
    $COMPLETIONS_CONFIRM=True

    exec($(carapace _carapace xonsh))
