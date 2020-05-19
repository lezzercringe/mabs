#!/bin/bash
if pacman -Qqi dialog >> /dev/null; then
        echo "Dialog is installed..."
else
        echo "The package dialog is not installed"
        pacman -Sq --noconfirm dialog >> /dev/null
        if [ $? == 0 ]; then
                echo "Installed successfuly, starting the script!"
        else
                exit 1
        fi

fi


