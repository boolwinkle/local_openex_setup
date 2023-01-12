#!/bin/bash

mail_domain="openex.local"
players_file="./players.txt"

while read line
do
    arr=($line)
    mail="${arr[0]}@$mail_domain"
    password=${arr[1]}

    bash ./setup.sh email add $mail $password

done < $players_file

