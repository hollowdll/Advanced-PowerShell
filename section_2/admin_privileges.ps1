# Use WindowsIdentity to check administrator privileges

$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent()
$currentUserName = $currentUser.Name
$principal = [System.Security.Principal.WindowsPrincipal]$currentUser
$role = [System.Security.Principal.WindowsBuiltInRole]::Administrator

# If user has administrator role
$isAdmin = $principal.IsInRole($role)

Write-Output "Current user: $currentUserName"
Write-Output "Has administrator privileges: $isAdmin"