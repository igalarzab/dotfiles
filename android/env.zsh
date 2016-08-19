#
# Set the ANDROID_HOME environment variable
# Will look for the android-sdk installation in HomeBrew
#

if (( $+commands[android] ))
then
    export ANDROID_HOME="/usr/local/opt/android-sdk"
    export ANDROID_SDK_ROOT=$ANDROID_HOME
fi
