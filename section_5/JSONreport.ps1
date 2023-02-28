# Read JSON file and write to console/file in JSON format

[CmdletBinding()]
Param (
    [Parameter(Mandatory = $true,
               HelpMessage = "JSON filename")]
    [ValidatePattern("JSON$")]
    [string]$FileName
)

$inputdata = Get-Content $FileName | ConvertFrom-Json
$outputdata = @{}

foreach ($computer in $inputdata) {
    $computer = $computer | Select-Object Name
    # add data to output 
}

$outputdata | ConvertTo-Json

# Write to file