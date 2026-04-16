$json = Get-Content manifest.json | ConvertFrom-Json
$lastRun = $json.last_run_uuid
$artifact = ($json.builds | Where-Object {
    $_.packer_run_uuid -eq $lastRun
}).artifact_id
$ami = $artifact.Split(':')[1]
$PROJECT="k8nsetup"

if (-not $ami) {
    Write-Error "AMI_ID not found"
    exit 1
}

aws ssm put-parameter --name /$PROJECT/packer/ami --value $ami --type String --overwrite --region ap-south-2
Write-Output "Stored AMI ID: $ami"