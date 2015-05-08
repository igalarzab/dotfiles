#
# Set the ANDROID_HOME environment variable
# Will look for the android-sdk installation in HomeBrew
#

if (( $+commands[java_home] ))
then
JAVA_HOME=`/usr/libexec/java_home -v 1.7`
fi

if (( $+commands[brew] && $+commands[android] ))
then
    export ANDROID_HOME="`brew --prefix android-sdk`"
    export ANDROID_SDK_ROOT=$ANDROID_HOME
fi
