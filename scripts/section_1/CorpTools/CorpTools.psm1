function Get-FileVersion {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   HelpMessage="Enter a file name!")]
        [ValidatePattern("exe$")]
        [Alias("ItemName")]
        [string[]]$FileName
    )

    PROCESS {
        foreach($File in $FileName) {
            Write-Verbose "Checking $FileName"
            Get-ItemPropertyValue -Path $File -Name VersionInfo | Select-Object ProductVersion,
            FileVersion, CompanyName, FileName
        }
    }
}