$CloudBuilderFQDN = "cb.vcf.lab"
$CloudBuilderUsername = "admin"
$CloudBuilderPassword = "VMware1!VMware1!"
$VCFManagementDomainJSONFile = "vcf52-management-domain-example.json"

try {
    $uri = "https://${CloudBuilderFQDN}/v1/sddcs"
    $method = "POST"
    $body = Get-Content -Raw $VCFManagementDomainJSONFile

    $pair = "${CloudBuilderUsername}:${CloudBuilderPassword}"
	$bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
	$base64 = [System.Convert]::ToBase64String($bytes)

    $headers = @{
        "Content-Type"="application/json"
        "Accept"="application/json"
        "Authorization"="basic $base64"
    }

    $requests = Invoke-WebRequest -Uri $uri -Method $method -SkipCertificateCheck -TimeoutSec 5 -Headers $headers -Body $body
}
catch {
    Write-Error "Failed to submit Deployment request ..."
    $requests
    exit
}

Write-Host "Open browser to the VCF Cloud Builder UI (https://${CloudBuilderFQDN}) to monitor deployment progress ..."