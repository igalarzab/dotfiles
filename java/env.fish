/usr/libexec/java_home -V > /dev/null 2>&1

if test $status -eq 0
    set -x JAVA_HOME (/usr/libexec/java_home)
end
