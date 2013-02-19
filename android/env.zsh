#
# Set the ANDROID_HOME environment variable
# Will look for the android-sdk installation in HomeBrew
#

if (( $+commands[brew] ))
then
    export ANDROID_HOME="`brew --prefix android-sdk`"
    export ANDROID_SDK_ROOT=$ANDROID_HOME
fi
