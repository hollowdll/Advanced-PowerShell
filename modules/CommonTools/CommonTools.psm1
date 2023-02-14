Function Get-OSInfo {
    [CmdletBinding()]
    Param(
        [string[]]$computername=@("localhost")
    )

    PROCESS {
        $CVPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"
        foreach ($computer in $computername) {
            if ($computer -eq $ENV:ComputerName) { $computer = 'localhost'}
            $arguments = if ($computer -eq "localhost") { @{} } else { @{ 'ComputerName' = $computer } }
            try {
                $OS = Get-CimInstance -ClassName Win32_OperatingSystem @arguments -ErrorAction Stop
            } catch {
                Write-Warning "$computer failed - logged to errors.txt"
                $Date = Get-Date
                "[$Date] $computer failed" | Out-File -FilePath .\errors.txt -Append
                continue
            }
            $ReleaseID = (Get-ItemProperty -Path $CVPath -Name ReleaseId).ReleaseId
            $output = [pscustomobject][ordered]@{
                'OSName'         = $OS.Caption
                'OSArchitecture' = $OS.OSArchitecture
                'OSLanguage'     = $OS.MUILanguages[0]
                'OSVersion'      = $ReleaseID
                'OSBuild'        = $OS.Version
            }
            Write-Output $output
        } # Computers
    } # Process
} # Function

Function Get-MemInfo {
    [CmdletBinding()]
    Param(
        [string[]]$computername=@("localhost")
    )

    PROCESS {
        $KiB_PER_GiB = [Math]::Pow(1024,2)
        foreach ($computer in $computername) {
            if ($computer -eq $ENV:ComputerName) { $computer = 'localhost'}
            $arguments = if ($computer -eq "localhost") { @{} } else { @{ 'ComputerName' = $computer } }
            $Memory = Get-CimInstance -ClassName Win32_OperatingSystem @arguments
            $output = [pscustomobject][ordered]@{
                'FreeMemory (GiB)'  = [Math]::Round($Memory.FreePhysicalMemory / $KiB_PER_GiB, 2)
                'TotalMemory (GiB)' = [Math]::Round($Memory.TotalVisibleMemorySize / $KiB_PER_GiB, 2)
                'Occupied'          = [Math]::Round($Memory.FreePhysicalMemory * 100 / $Memory.TotalVisibleMemorySize, 2)
            }
            Write-Output $output
        } # Computer
    } # Process
} # Function

function Get-DiskInfo {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $false)]
        [string[]]$ComputerName = @("localhost")
    )

    PROCESS {
        $BYTES_PER_GiB = [Math]::Pow(1024, 3)
        foreach ($computer in $ComputerName) {
            if ($computer -eq $ENV:ComputerName) { $computer = 'localhost' }
            $arguments = if ($computer -eq "localhost") { @{} } else { @{ 'ComputerName' = $computer } }
            $disks = Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3" @arguments

            foreach ($disk in $disks) {
                $output = [pscustomobject][ordered]@{
                    'ComputerName'    = $computer
                    'DriveLetter'     = $disk.DeviceId
                    'FreeSpace (GiB)' = [Math]::Round($disk.FreeSpace / $BYTES_PER_GiB, 2)
                    'Size (GiB)'      = [Math]::Round($disk.Size / $BYTES_PER_GiB, 2)
                }
                Write-Output $output
            }
        }
    }
}

function Get-NetAdapterInfo {
    [CmdletBinding()]
    Param(
        [string[]]$ComputerName = @("localhost")
    )

    PROCESS {
        foreach ($computer in $ComputerName) {
            if ($computer -eq $ENV:ComputerName) { $computer = 'localhost' }
            $arguments = if ($computer -eq "localhost") { @{} } else { @{ 'ComputerName' = $computer } }
            Write-Verbose "Connecting to $computer"
            $session = New-CimSession @arguments
            $adapters = Get-NetAdapter -CimSession $session

            foreach ($adapter in $adapters) {
                $addresses = Get-NetIPAddress -InterfaceIndex ($adapter.InterfaceIndex) -CimSession $session

                foreach ($address in $addresses) {
                    $output = [PSCustomObject][ordered]@{
                        'ComputerName'   = $computer
                        'AdapterName'    = $adapter.Name
                        'InterfaceIndex' = $adapter.InterfaceIndex
                        'IPAddress'      = $address.IPAddress
                        'AddressFamily'  = $address.AddressFamily
                    }
                    Write-Output $output
                }
            }
            Write-Verbose "Closing session to $computer"
            Remove-CimSession -CimSession $session
        }
    }
}