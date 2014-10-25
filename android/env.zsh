#
# Set the ANDROID_HOME environment variable
# Will look for the android-sdk installation in HomeBrew
#

JAVA_HOME=`/usr/libexec/java_home -v 1.7`

if (( $+commands[brew] ))
then
    export ANDROID_HOME="`brew --prefix android-sdk`"
    export ANDROID_SDK_ROOT=$ANDROID_HOME
fi
