#!/bin/bash

# Colors
Alert="\e[0;31m[×]"
Red="\e[0;31m"
Green="\e[0;32m"
Blue="\e[0;34m"
Success="\e[0;32m[+]"
dim="\e[0;2m"
enc="\e[0;m"

errorlog="$HOME/.errorlog.cat"


echo ""
echo -e "$Success Welcome To Recycle 1.0 $enc"

listing_files(){
    echo ""
    echo -e "$Success Select Your Bash File !"
    echo ""
    cd $directory
    
    #loops
    arrFiles=()
    for bashes in *.sh ; do
        #statements
        arrFiles=(${arrFiles[@]} "$bashes")
    done
    
    let i=0
    for items in ${arrFiles[@]} ; do
        #statements
        echo -e "$Blue $((i++)).$items $enc"
    done
    echo ""
    
    read -p ">> " proc
    
    if [[ $proc -le ${#arrFiles[@]} ]]; then
        #statements
        rm $HOME/${arrFiles[$proc]} &> /dev/null
        cp ${arrFiles[$proc]} $HOME
        chmod +x $HOME/${arrFiles[$proc]}
        echo ""
        echo -e "$Success Started Successfully $enc"
        cd
        echo ""
        bash $HOME/${arrFiles[$proc]}
    else
        echo ""
        echo -e "$Alert Invalid Input"
        echo ""
    fi
}

if [[ -f "$HOME/.bashconfig.cat" ]]; then
    #statements
    directory=`cat .bashconfig.cat`
    if [[ -d "$directory" ]]; then
        #statements
        cd $directory &> /dev/null && cd && listing_files
    fi
else
    echo ""
    echo -e "$Alert Enter the parant directory of your bash script files $enc"
    echo ""
    read -e -p ">> " folder
    echo ""
    {
        cd $HOME/$folder &> /dev/null && cd && echo "$HOME/$folder" >> .bashconfig.cat && echo -e "$Success File Successfully Saved !" && listing_files
    }||{
        echo -e "$Alert Error"
        echo ""
    }
fi
