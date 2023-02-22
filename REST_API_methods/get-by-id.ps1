$ID = 1
$RequestParameters = @{
    URI    = "http://localhost:8080/api/resource/$ID"
    Method = "GET"
}

$Response = Invoke-WebRequest @RequestParameters
$StatusCode = $Response.StatusCode
$StatusDescription = $Response.StatusDescription
$PrettyJSON = $Response | ConvertFrom-Json | ConvertTo-Json -Depth 2

Write-Host "Status Code: $StatusCode $StatusDescription"
Write-Host $PrettyJSON