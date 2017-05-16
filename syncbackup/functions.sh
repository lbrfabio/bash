#!/bin/bash

#$1 message;  $2 script;  $3 skip answer;
function startScript () {
	answer="$3"
	if [[ ! "$3" = "y" ]]; then
		echo -ne "\n$1 ? [y/n]: "
		read answer
	fi

	if [[ $answer == "y" ]]; then
		"$2"
	fi 
}

#$1 source;  $2 dest;  $3 name;  $4 skip answer;
function backupFolder () {
	answer="$4"
	if [[ ! "$4" = "y" ]]; then
		echo -ne "\n$1 ? [y/n]: "
		read answer
	fi

	if [[ $answer == "y" ]]; then
		tar -pcvzf "$2/$3".tar.gz $1
	fi 
}

function printTitle () {
echo "
#######################################
				$1
#######################################"
}
