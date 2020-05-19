#!/bin/bash

needPkgs="sudo bspwm sxhkd xorg xorg-xinit firefox"

if pacman -Qqi dialog >> /dev/null; then
        sleep 1;
else
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
else
        useradd -m -g users -G wheel -s /bin/bash $username
fi

dialog --title "We have 2 options..." --yesno "You've done your part, are you sure to make the installation?" 10 30
if [[ $? == 1 ]]; then
        echo "See you next time. Good luck."
fi

dialog --title "Installation" --infobox "Installing needed packages via pacman. Just wait." 10 40
pacman -S --noconfirm $needPkgs &> mabs.log 
if [[ $? == 1 ]]; then
        dialog --title "Error" --msgbox "Something went wrong with installation. Check mabs.log file and try to fix the problem manually. Then restart the script." 10 40
        exit 1
fi
dialog --title "Installing yay" --infobox "Installing yay AUR package manager." 10 30
git clone https://aur.archlinux.org/yay.git
cd yay
sudo -u $username makepkg -si &> /dev/null


