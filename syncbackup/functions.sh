#!/bin/bash

#$1 message;  $2 script;
function startScript () {
    echo ""
    echo -n "Backup $1 ? (y/n) "
    echo ""
    read answer
    if [[ $answer == "y" ]]; then
        "$2"
    fi 
}

#$1 source;  $2 dest;  $3 name
function backupFolder () {
    echo ""
    echo -n "Backup $1 ? (y/n)"
    echo ""
    read answer
    if [[ $answer == "y" ]]; then
        tar -pcvzf "$2/$3".tar.gz $1
    fi 
}

function printTitle () {
echo ""
echo "#######################################
                $1
#######################################"
}
