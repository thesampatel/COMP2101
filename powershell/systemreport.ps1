function Get-SystemHardware {
    Get-CimInstance Win32_ComputerSystem | Format-List
}

function Get-OperatingSystem {
    Get-CimInstance Win32_OperatingSystem | Format-List
}

function Get-ProcessorInfo {
    Get-CimInstance Win32_Processor | Format-List
}

function Get-RAMSummary {
    Get-CimInstance Win32_PhysicalMemory | Format-Table Manufacturer, Description, Capacity, BankLabel, DeviceLocator
    $totalRAM = Get-CimInstance Win32_PhysicalMemory | Measure-Object Capacity -Sum
    "Total RAM Installed: $($totalRAM.Sum / 1GB) GB"
}

function systemreport {
    Get-SystemHardware
    Get-OperatingSystem
    Get-ProcessorInfo
    Get-RAMSummary
    Get-DiskInfo
    Get-NetworkInfo
    Get-VideoCardInfo
}

function Get-DiskInfo {
    $diskdrives = Get-CIMInstance CIM_DiskDrive
    foreach ($disk in $diskdrives) {
        $partitions = $disk | Get-CimAssociatedInstance -ResultClassName CIM_DiskPartition
        foreach ($partition in $partitions) {
            $logicaldisks = $partition | Get-CimAssociatedInstance -ResultClassName CIM_LogicalDisk
            foreach ($logicaldisk in $logicaldisks) {
                New-Object -TypeName PSObject -Property @{
                    Manufacturer=$disk.Manufacturer
                    Location=$partition.DeviceID
                    Drive=$logicaldisk.DeviceID
                    "Size(GB)"= [math]::Round($logicaldisk.Size / 1GB, 2)
                    "Free Space(GB)"= [math]::Round($logicaldisk.FreeSpace / 1GB, 2)
                    "Percent Free"= [math]::Round(($logicaldisk.FreeSpace / $logicaldisk.Size) * 100, 2)
                } | Format-Table
            }
        }
    }
}

function Get-NetworkInfo {
    # Add your lab 3 network adapter configuration report logic here
}

function Get-VideoCardInfo {
    Get-CimInstance Win32_VideoController | Format-Table Manufacturer, Description, VideoModeDescription
}

# System Report
"SYSTEM HARDWARE"
Get-SystemHardware

"OPERATING SYSTEM"
Get-OperatingSystem

"PROCESSOR INFORMATION"
Get-ProcessorInfo

"RAM SUMMARY"
Get-RAMSummary

"DISK INFORMATION"
Get-DiskInfo

"NETWORK INFORMATION"
Get-NetworkInfo

"VIDEO CARD INFORMATION"
Get-VideoCardInfo
