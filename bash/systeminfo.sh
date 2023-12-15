#!/bin/bash

source /home/samarthpatel/COMP2101/bash/reportfunctions.sh

help() {
    echo "Usage: systeminfo.sh [OPTION]"
    echo "-h        Display this help and exit"
    echo "-v        Run verbosely"
    echo "-system   Run system reports"
    echo "-disk     Run disk report"
    echo "-network  Run network report"
}

if [ "$(id -u)" -ne 0 ]; then
    errormessage "Root permissions are required."
    exit 1
fi

verbose=0
while getopts ":hvsystemdisknetwork" opt; do
    case $opt in
        h) help; exit ;;
        v) verbose=1 ;;
        system) 
            cpureport; computerreport; osreport; ramreport; videoreport
            ;;
        disk) diskreport ;;
        network) networkreport ;;
        \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    esac
done

shift $((OPTIND -1))

if [ $verbose -eq 1 ]; then
    exec 2>/dev/tty
fi

if [ $# -eq 0 ]; then
    cpureport; computerreport; osreport; ramreport; videoreport; diskreport; networkreport
fi
