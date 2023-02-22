$ID = 1
$RequestParameters = @{
    URI     = "http://localhost:3000/api/resource/$ID"
    Method  = "PUT"
    Headers = @{
        "Content-Type" = "application/json"
    }
    Body    = @{
        "name"    = "Test";
        "example" = "example";
    } | ConvertTo-Json
}

$Response = Invoke-WebRequest @RequestParameters
$StatusCode = $Response.StatusCode
$StatusDescription = $Response.StatusDescription
$PrettyJSON = $Response | ConvertFrom-Json | ConvertTo-Json -Depth 2

Write-Host "Status Code: $StatusCode $StatusDescription"
Write-Host $PrettyJSON