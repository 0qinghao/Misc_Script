#!/bin/bash

while true; do
    echo -n "."

    read -t 0.01 -n 1 -s key_press
    if [[ $key_press = "q" ]] || [[ $key_press = "Q" ]]; then
        echo "exit loop"
        break
    fi
done
