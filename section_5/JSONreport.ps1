# Read JSON file and write to console/file in JSON format

[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true,
               HelpMessage = "JSON filename")]
    [ValidatePattern("JSON$")]
    [string]$FileName
)

$inputdata = Get-Content $FileName | ConvertFrom-Json
$outputdata = @()

foreach ($computer in $inputdata) {
    $computer = $computer | Select-Object Name
    $computer | Add-Member -Name OSInfo -Value (Get-OSInfo -ComputerName $computer.Name) -MemberType NoteProperty
    $computer | Add-Member -Name MemInfo -Value (Get-MemInfo -ComputerName $computer.Name) -MemberType NoteProperty
    $computer | Add-Member -Name DiskInfo -Value (Get-DiskInfo -ComputerName $computer.Name) -MemberType NoteProperty
    $outputdata += $computer
}

$outputJSON = $outputdata | ConvertTo-Json
Write-Host $outputJSON

# Write to file
$outputJSON | Out-File -FilePath "inventory-output.json"