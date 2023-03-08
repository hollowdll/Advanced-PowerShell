[CmdletBinding()]
Param (
    [Parameter(Mandatory=$true)]
    [string[]]$RuleName
)

foreach ($name in $RuleName) {
    Write-Debug "Searching for firewall rule '$name'"
    Get-NetFirewallRule -DisplayName $name | Where-Object Enabled -eq True | Select-Object -Property DisplayName.Profile.Direction.Action.Description
}