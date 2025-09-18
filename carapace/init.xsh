if !(which carapace all> /dev/null):
    $CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
    exec($(carapace _carapace xonsh))
