#!/bin/bash

cpureport() {
    echo "CPU Report"
    # Commands to extract CPU info
    echo "Manufacturer: $(...)"
    echo "Model: $(...)"
    echo "Architecture: $(...)"
    echo "Core Count: $(...)"
    echo "Max Speed: $(...)"
    echo "Cache Sizes: L1: $(...), L2: $(...), L3: $(...)"
}

computerreport() {
    echo "Computer Report"
    # Commands to extract computer info
    echo "Manufacturer: $(...)"
    echo "Model: $(...)"
    echo "Serial Number: $(...)"
}

osreport() {
    echo "OS Report"
    # Commands to extract OS info
    echo "Distro: $(...)"
    echo "Version: $(...)"
}

ramreport() {
    echo "RAM Report"
    # Commands to extract RAM info
    echo "Component Manufacturer: $(...)"
    echo "Model/Product Name: $(...)"
    echo "Size: $(...)"
    echo "Speed: $(...)"
    echo "Physical Location: $(...)"
    echo "Total Installed RAM: $(...)"
}

videoreport() {
    echo "Video Report"
    # Commands to extract video card info
    echo "Manufacturer: $(...)"
    echo "Model: $(...)"
}

diskreport() {
    echo "Disk Report"
    # Commands to extract disk drive info
    echo "Drive Manufacturer: $(...)"
    echo "Model: $(...)"
    echo "Size: $(...)"
    echo "Partition: $(...)"
    echo "Mount Point: $(...)"
    echo "Filesystem Size: $(...)"
    echo "Free Space: $(...)"
}

networkreport() {
    echo "Network Report"
    # Commands to extract network info
    echo "Interface Manufacturer: $(...)"
    echo "Model/Description: $(...)"
    echo "Link State: $(...)"
    echo "Speed: $(...)"
    echo "IP Address: $(...)"
    echo "Bridge Master: $(...)"
    echo "DNS Server(s): $(...)"
}

errormessage() {
    echo "[$(date)] $1" | tee -a /var/log/systeminfo.log >&2
}
