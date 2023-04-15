#!/bin/bash

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
	curl -X POST http://localhost:8080/api/users --verbose \
		--header "Content-Type: application/json" \
		--header "Authorization: Bearer b846fb94-5656-43b6-a8ac-5c6101a6b041" \
		--data "$data"
}

add_player $*
