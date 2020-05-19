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

dialog --title "Welcome!" --msgbox "Welcome to my bootstraping script. It will install my config to your system." 10 30

OUTPUT="/tmp/input.txt"
>$OUTPUT

dialog --inputbox "Input name for new user:" 2> $OUTPUT 5 40
username=$(<$OUTPUT)
echo $username

if id -u $username &> /dev/null; then
        dialog --title "Warning!" --yesno "User $username exists! Are you sure to install?" 10 40
        echo $?
fi


