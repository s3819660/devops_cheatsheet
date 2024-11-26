#!/bin/bash
input_name=$1
bobby() {
    local name=$1
    if [[ ${name,,} = "bobby" ]]; then
        echo "Hello $name"
        exit 0
    elif ! [[ name ]]; then
        echo "Howdy, I am Bobby"
        exit 0
    else
        echo "You should enter a random word!"
    fi
}

bobby $input_name