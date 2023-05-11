#!/bin/bash

mail_domain="openex.local"
players_file="sample_new_player.txt"

add_email(){
	email=$(get_email $"$@")
	password=$6
	bash ./setup.sh email add $email $password
}

get_email(){
	username=$1
	email=$2

	if [ $email == "-" ] && [ $username != "-" ]; then
		email="$username@$mail_domain"
	elif [ $email == "-" ] && [ $username == "-" ]; then
		firstname=$3
		lastname=$4
		email="$firstname.$lastname@$mail_domain"
	else
		email="$email@$mail_domain"
	fi

	echo $email
}

add_player(){
	declare -A fields
	fields["firstname"]=$3
	fields["lastname"]=$4
	fields["organization"]=$5
	fields["email"]=$(get_email $"$@")
	arg_str=""
	for field in ${!fields[@]}; do
		if [[ ${fields[$field]} == "-" ]]; then 
			continue
		fi
		
		arg_str+="$field=${fields[$field]} "
	done	
	bash ./add_player.sh $arg_str
}

while read -r line; do
	if [[ $line == \#* ]]; then
		continue
	fi

	add_email $line
	add_player $line
done < $players_file
