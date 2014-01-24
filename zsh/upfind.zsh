#
# Find a file going upwards
#
# Author: @sakuro
#

function upfind() {
    local previous=
    local current=$PWD

    if [[ $# -ne 1 ]];then
    echo "$0 FILE_NAME"
    return 1
    fi

    while [[ -d $current && $current != $previous ]]; do
    local target_path=$current/$1
    if [[ -f $target_path ]]; then
        echo $target_path
        return 0
    else
        previous=$current
        current=$current:h
    fi
    done
    return 1
}
