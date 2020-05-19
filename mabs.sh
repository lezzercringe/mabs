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
        if [[ $? == 1 ]]; then
                exit 0 
        fi
fi

dialog --title "We have 2 options..." --yesno "You've done your part, are you sure to make the installation?" 10 30
if [[ $? == 1 ]]; then
        echo "See you next time. Good luck."
fi

echo "Installing needed packages... Just wait a couple of minutes. " 
sleep 5;
pacman -S bspwm sxhkd xorg xorg-xinit firefox > /dev/pts/2
if [[ $? == 1 ]]; then
        echo "Something went wrong with installation. Check mabs.log file and try to fix the problem manually. Then restart the script."
        exit 1
fi
dialog --title "Packages installed." --msgbox "Everything went right. Moving to the next step." 10 30
