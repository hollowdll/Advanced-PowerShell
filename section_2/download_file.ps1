# Use .NET framework classes

# If the website requires TLS 1.2 or some other version
# [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# Download a file from internet and open it in mspaint
$webClient = New-Object System.Net.WebClient
$url = 'https://github.com/hollowdll/ER-diagram-generator/blob/master/documentation/images/customization.JPG?raw=true'
$outputfile = "$((New-TemporaryFile).FullName).JPG"
$webClient.DownloadFile($url, $outputfile)

mspaint $outputfile