function Get-FileVersion {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true, HelpMessage="Enter a file name!")]
        [ValidatePattern("exe$")]
        [Alias("ItemName")]
        [string]$FileName
    )

    Write-Verbose "Checking $FileName"
    Get-ItemPropertyValue -Path $FileName -Name VersionInfo | Select-Object ProductVersion,
    FileVersion, CompanyName, FileName
}