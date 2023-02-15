# Some useful commands

List all environment variables
```powershell
Get-ChildItem env:
```
```powershell
ls env:
```
```powershell
dir env:
```
```powershell
gci env:
```

Using command prompt
```bash
set
```
Filter by name
```bash
set "name"
```

## File system

#

Current location
```powershell
Get-Location
```
```powershell
pwd
```

Change directory
```powershell
Set-Location
```
```powershell
cd
```

List contents of current location
```powershell
Get-ChildItem
```
```powershell
ls
```
```powershell
dir
```
```powershell
gci
```

Create new directory
```powershell
mkdir
```
```powershell
New-Item -Name "DirectoryName" -ItemType "directory"
```

New file
```powershell
New-Item -Name "text.txt"
```

Remove item
```powershell
Remove-Item "name"
```
```powershell
rm "name"
```