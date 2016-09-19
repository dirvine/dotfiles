#!/bin/bash
# Bash Menu Script Example

PS3='Please enter your choice: '
options=("battery" "dstat" "htop" "mtr" "nethogs" "iptraf" "ipcalc" "ledger" "wyrd" "notes" "tasks" "qalc" "ranger" "Quit")
select opt in "${options[@]}"
do
	echo "${options[@]}"
	echo -e "---------------------------"
    case $opt in
        "battery")
            acpi -bi
            ;;
        "dstat")
            dstat
            ;;
        "htop")
            htop
            ;;
        "mtr")
            mtr
            ;;
        "nethogs")
            sudo nethogs
            ;;
        "iptraf")
            sudo iptraf
            ;;
        "ipcalc")
            ipcalc
            ;;
        "ledger")
            ledger
            ;;
        "wyrd")
            wyrd
            ;;
        "notes")
            notes
            ;;
        "tasks")
            task
            ;;
        "qalc")
            qalc
            ;;
        "ranger")
            ranger
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
