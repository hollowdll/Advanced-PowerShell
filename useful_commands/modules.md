# Useful commands for modules

Locations where modules should be (First path = user, second path = system)
```powershell
$env:PsModulePath.split(";")
```

**Remove brackets "[ ]" when executing!**

Reload a module
```powershell
Import-Module [module name]
```

Reload a module without reopening terminal
```powershell
Import-Module -Name [module name] -Force
```

Remove a module from PowerShell session
```powershell
Remove-Module [module name]
```

Display help for a command
```powershell
Get-Help [cmdlet name] -Full
```