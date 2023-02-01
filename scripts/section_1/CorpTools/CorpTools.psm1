function Get-FileVersion {
    <#
    .SYNOPSIS
    Retreives File and Product version, Creation date and Last Access Date from
    one or more .exe files.
    .DESCRIPTION
    This command retrieves specific information from each file defined in the
    input. The command will only work with .exe files.
    .PARAMETER FileName
    One or more filenames, as strings. Use full path is necessary. This
    parameter accepts pipeline input. Filenames must end in ".exe".
    .EXAMPLE
    Get-ChildItem *.exe | Get-FileVersion
    This example assumes that there are .exe files in the current directory,
    and will retrieve information from each file listed.
    .EXAMPLE
    Get-FileVersion -FileName C:\Windows\explorer.exe
    This example retrieves information from one file.
    #>

    [CmdletBinding(SupportsShouldProcess=$true, ConfirmImpact='Medium')]
    Param(
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   HelpMessage="Enter a file name!")]
        [ValidatePattern("exe$")]
        [Alias("ItemName")]
        [string[]]$FileName
    )

    BEGIN {
        # Create log files, needed variables, etc.
    }

    PROCESS {
        # Print information about files
        foreach($File in $FileName) {
            if ($PSCmdlet.ShouldProcess($File)) {
                Write-Verbose "Checking $FileName"
    
                $version = Get-ItemPropertyValue -Path $File -Name VersionInfo |
                Select-Object ProductVersion, FileVersion, CompanyName, FileName
    
                $CreationDate = Get-ItemProperty -Path $File |
                Select-Object -ExpandProperty CreationTime
    
                $LastAccessDate = Get-ItemProperty -Path C:\Windows |
                Select-Object -ExpandProperty LastAccessTime
    
                $properties = @{
                    'FileName'      = $File;
                    'ProductVersion' = $version.ProductVersion;
                    'FileVersion' = $version.FileVersion;
                    'CreationDate' = $CreationDate;
                    'LastAccessDate' = $LastAccessDate;
                }
    
                $output = New-Object -TypeName PSObject -Property $properties
                Write-Output $output
            }
        }
    }

    END {
        # Cleanup
    }
}