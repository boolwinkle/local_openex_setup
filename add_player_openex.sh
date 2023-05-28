#!/bin/bash

API_KEY="2a1bcc5b-14f1-415e-85ba-05ad532a7c37"

parse_arg(){
    arg=$1
    split=($(echo $arg | tr "=" " "))
    echo -e "\"user_${split[0]}\":\"${split[1]}\",\n"
}

add_player(){
    parsed_args=()
    for arg in "$@"; do
    	parsed_args+=($(parse_arg $arg))
    done
	data=$(echo "{ ${parsed_args[@]} \"user_admin\": false }")
	echo $data
	curl -X POST http://localhost:8080/api/users \
		--header "Content-Type: application/json" \
		--header "Authorization: Bearer $API_KEY" \
		--data "$data"
}

add_player $*
