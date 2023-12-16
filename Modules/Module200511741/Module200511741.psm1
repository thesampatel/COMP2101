function Get-ComputerSystem {
    Get-WmiObject Win32_ComputerSystem | Select-Object Manufacturer, Model, NumberOfProcessors, TotalPhysicalMemory
}

function Get-OperatingSystem {
    Get-WmiObject Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber
}

function Get-ProcessorInfo {
    Get-WmiObject Win32_Processor | Select-Object Name, MaxClockSpeed, NumberOfCores, L2CacheSize, L3CacheSize
}

function Get-RAMInfo {
    $RAM = Get-WmiObject Win32_PhysicalMemory | Select-Object Manufacturer, Description, Capacity, BankLabel, DeviceLocator
    $TotalRAM = ($RAM | Measure-Object -Property Capacity -Sum).Sum
    [PSCustomObject]@{
        RAM_Details = $RAM
        Total_RAM_Installed = "$([Math]::Round($TotalRAM / 1GB, 2)) GB"
    }
}

function Get-DiskInfo {
    $diskdrives = Get-CimInstance CIM_DiskDrive
    foreach ($disk in $diskdrives) {
        $partitions = $disk | Get-CimAssociatedInstance -ResultClassName CIM_DiskPartition
        foreach ($partition in $partitions) {
            $logicaldisks = $partition | Get-CimAssociatedInstance -ResultClassName CIM_LogicalDisk
            foreach ($logicaldisk in $logicaldisks) {
                [PSCustomObject]@{
                    Manufacturer = $disk.Manufacturer
                    Location = $partition.DeviceID
                    Drive = $logicaldisk.DeviceID
                    "Size(GB)" = [Math]::Round($logicaldisk.Size / 1GB, 2)
                    "FreeSpace(GB)" = [Math]::Round($logicaldisk.FreeSpace / 1GB, 2)
                    "PercentFree" = [Math]::Round(($logicaldisk.FreeSpace / $logicaldisk.Size) * 100, 2)
                }
            }
        }
    }
}

function Get-NetworkAdapterConfig {
    Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true } | 
    Select-Object Description, MACAddress, IPAddress, IPSubnet, DefaultIPGateway
}

function Get-VideoControllerInfo {
    Get-WmiObject Win32_VideoController | Select-Object Manufacturer, Description, VideoModeDescription
}

# Generate Report
"Computer System Information"
Get-ComputerSystem

"Operating System Information"
Get-OperatingSystem

"Processor Information"
Get-ProcessorInfo

"RAM Information"
Get-RAMInfo | Format-Table -AutoSize

"Disk Information"
Get-DiskInfo | Format-Table -AutoSize

"Network Adapter Configuration"
Get-NetworkAdapterConfig | Format-Table -AutoSize

"Video Controller Information"
Get-VideoControllerInfo
