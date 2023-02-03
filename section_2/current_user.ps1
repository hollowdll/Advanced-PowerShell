# WindowsIdentity has information about the current user
# Display the currently signed-in user

Write-Output "Current user:"
([System.Security.Principal.WindowsIdentity]::GetCurrent()).Name