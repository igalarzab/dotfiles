# Colored output to the adb logcat
function adbl() {
    adb logcat $@ | $DOTFILES/android/coloredlogcat.py
}
