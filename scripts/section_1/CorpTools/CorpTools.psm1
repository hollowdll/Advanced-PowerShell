function Get-FileVersion {
    [CmdletBinding()]
    Param(
        [string]$FileName
    )

    Write-Verbose "Checking $FileName"
    Get-ItemPropertyValue -Path $FileName -Name VersionInfo | Select-Object ProductVersion,
    FileVersion, CompanyName, FileName
}