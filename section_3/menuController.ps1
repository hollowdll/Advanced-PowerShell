# Display a CLI menu in PowerShell terminal

$continue = $true

while ($continue) {
    Write-Host "Menu for CommonTools module" -ForegroundColor Yellow
    Write-Host "1. Display OS information"
    Write-Host "2. Display disk information"
    Write-Host "3. Display memory information"
    # Write-Host "4. Power off the computer (disabled)"
    Write-Host "\q Exit the menu"
    $choice = Read-Host "Enter your choice"
    Write-Host ""

    Switch ($choice) {
        1 { Get-OSInfo }
        2 { Get-DiskInfo }
        3 { Get-MemInfo }
        # 4 { Stop-Computer }
        '\q' {
            $continue = $false
            Write-Host ""
        }
        default { Write-Host "Unknown choice`n" -ForegroundColor Red }
    }
}