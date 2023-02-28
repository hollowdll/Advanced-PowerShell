# Read XML file and write to it.

[xml]$xml = Get-Content inventory.xml

foreach ($computer in $xml.computers.computer) {
    Write-Host $computer.name
    
    $osinfo = Get-OSInfo -ComputerName $computer.name

    try {
        $computer.OSName = $osinfo.OSName
        $computer.OSArchitecture = $osinfo.OSArchitecture
        $computer.OSLanguage = $osinfo.OSLanguage
        $computer.OSVersion = $osinfo.OSVersion
        $computer.OSBuild = $osinfo.OSBuild
    } catch {
        Write-Warning "($computer) Error parsing data into XMLNode - logged to errors.txt"
        $Date = Get-Date
        "[$Date] ($computer) failed trying to parse data into XMLNode in XMLreport.ps1" | Out-File -FilePath .\errors.txt -Append
        continue
    }

    $disks = Get-DiskInfo -ComputerName $computer.name

    if ($computer.HasChildNodes) {
        $disks_node = $computer.SelectSingleNode('disks')
        $computer.RemoveChild($disks_node) | Out-Null
    }

    $disks_node = $xml.CreateElement('element', 'disks', '')

    foreach ($disk in $disks) {
        $disk_node = $xml.CreateElement('element', 'disk', '')
        $disk_node.InnerText = $disk.DriveLetter
        $disks_node.AppendChild($disk_node) | Out-Null
    }

    $computer.AppendChild($disks_node) | Out-Null
}

$xml.save($(Get-Location).Path + '\inventory.xml')