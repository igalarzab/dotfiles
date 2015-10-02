#
# Set the ANDROID_HOME environment variable
# Will look for the android-sdk installation in HomeBrew
#

if [[ -f /usr/libexec/java_home ]];
then
JAVA_HOME=`/usr/libexec/java_home`
fi

if (( $+commands[android] ))
then
    export ANDROID_HOME="/usr/local/opt/android-sdk"
    export ANDROID_SDK_ROOT=$ANDROID_HOME
fi
