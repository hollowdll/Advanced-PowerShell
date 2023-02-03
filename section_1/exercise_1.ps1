function Get-FileVersion {
    [CmdletBinding()]
    Param(
        [string]$FileName
    )

    Get-ItemPropertyValue -Path $FileName -Name VersionInfo | Select-Object ProductVersion,
    FileVersion, CompanyName, FileName
}