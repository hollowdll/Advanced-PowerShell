# Create HTML file containing report info about the current device.
# The file gets created to this script's folder.

# Pass argument to -ReportFileName with the file format!
# For example: test.html or test.txt

# Note! Import CommonTools.psm1 before using this!

[CmdletBinding()]
Param(
    [Parameter(Mandatory = $true)]
    [string]$ReportFileName
)

$frag1 = Get-OSInfo |
    ConvertTo-Html -Fragment -As List -PreContent "<h2>Basic Info</h2>" |
    Out-String

$frag2 = Get-DiskInfo |
    ConvertTo-Html -Fragment -As Table -PreContent "<h2>Disks</h2>" |
    Out-String

$frag3 = Get-MemInfo |
    ConvertTo-Html -Fragment -As Table -PreContent "<h2>Memory</h2>" |
    Out-String

$frag4 = Get-NetAdapterInfo |
    ConvertTo-Html -Fragment -As Table -PreContent "<h2>Network Adapters</h2>" |
    Out-String


$style = @"
<style>
    body {
        font-family: Segoe, Tahoma, Arial, Helvetica, sans-serif;
        font-size: 10pt;
        color: #333;
        background-color: #eee;
        margin: 10px;
    }

    th {
        font-weight: bold;
        color: white;
        background-color: #333;
    }
</style>
"@

ConvertTo-Html `
    -Title "System Report" `
    -Head "<title>System Report</title>", $style `
    -Body "<h1>System Report</h1>", $frag1, $frag2, $frag3, $frag4 | Out-File $ReportFileName

Start-Process $ReportFileName
