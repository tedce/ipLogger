#!/bin/bash

function request_handled() {
    ip=$1
    # if address has yet to be logged
    if [ ! $(awk -v ipaddress=$ip '$1 == ipaddress { print $1 }' requestingIps.log) ]
    then
        echo "$ip 1 " >> requestingIps.log
        echo "wrote ip request to file..."
    else
        #log additional visits
        currentCount=$(awk -v ipaddress=$ip '$1 == ipaddress { print $2 }' requestingIps.log)
        incrementedCount=$(($currentCount + 1))
        sed -i "s/$ip\ $currentCount/$ip\ $incrementedCount/g" requestingIps.log
        echo "incremented ip count..."
    fi
}

function top100() {
    echo $(awk '{ print $1 "(" $2 ")" }' requestingIps.txt | sort -r | head -n 100)
}

function clear() {
    > requestingIps.log
    echo "ip list has been cleared..."
}

func=$1

if [ $func == "request_handled" ]
then
    $func $2
else
    $func
fi
