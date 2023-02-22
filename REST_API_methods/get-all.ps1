$RequestParameters = @{
    URI    = "http://localhost:3000/api/resource"
    Method = "GET"
}

$Response = Invoke-WebRequest @RequestParameters
$StatusCode = $Response.StatusCode
$StatusDescription = $Response.StatusDescription
$PrettyJSON = $Response | ConvertFrom-Json | ConvertTo-Json -Depth 2

Write-Host "Status Code: $StatusCode $StatusDescription"
Write-Host $PrettyJSON