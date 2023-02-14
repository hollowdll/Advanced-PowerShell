$ID = 1
$RequestParameters = @{
    URI    = "http://localhost:8080/api/resource/$ID"
    Method = "GET"
}

$Response = Invoke-WebRequest @RequestParameters
$PrettyJSON = $Response | ConvertFrom-Json | ConvertTo-Json -Depth 2
Write-Host $PrettyJSON