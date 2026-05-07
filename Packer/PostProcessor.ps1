$json = Get-Content manifest.json | ConvertFrom-Json
$lastRun = $json.last_run_uuid
$build = $json.builds | Where-Object { $_.packer_run_uuid -eq $lastRun }
$artifact = $build.artifact_id
$ami = $artifact.Split(':')[1]
$architecture = $build.custom_data.architecture
$PROJECT = "k8nsetup"

if (-not $ami) {
    Write-Error "AMI_ID not found"
    exit 1
}

if (-not $architecture) {
    Write-Error "Architecture not found in custom_data"
    exit 1
}

# Normalise to lowercase for consistent SSM path (e.g. "X86_64" -> "x86_64")
$architecture = $architecture.ToLower()

$ssmPath = "/$PROJECT/packer/ami/$architecture"
aws ssm put-parameter --name $ssmPath --value $ami --type String --overwrite --region ap-south-2
Write-Output "Stored AMI ID '$ami' for architecture '$architecture' at '$ssmPath'"