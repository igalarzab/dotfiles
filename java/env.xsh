javaInstalls = p`~/.asdf/installs/java/.*/bin/java`

if len(javaInstalls):
    # TODO: Not very clean, picking just the first one
    $JAVA_HOME = javaInstalls[0]
