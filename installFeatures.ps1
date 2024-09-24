# Install AWS Tools for PowerShell module if not already installed
if (-not (Get-Module -ListAvailable -Name AWSPowerShell)) {
    Install-Module -Name AWSPowerShell -Force
}

# Define S3 Bucket and File Paths
$s3Bucket = "my-s3-bucket"
$featuresS3Path = "config-files/features.csv"
$serverS3Path = "config-files/server_name.csv"
$localFeaturesPath = "C:\temp\features.csv"
$localServerPath = "C:\temp\server_name.csv"

# Create a local temp directory to store the downloaded files
if (-not (Test-Path "C:\temp")) {
    New-Item -Path "C:\temp" -ItemType Directory
}

# Download the CSV files from S3
Read-S3Object -BucketName $s3Bucket -Key $featuresS3Path -File $localFeaturesPath
Read-S3Object -BucketName $s3Bucket -Key $usersS3Path -File $localServerPath

# Import the list of features from the CSV file
$features = Import-Csv -Path $localFeaturesPath

# Install each feature from the list
foreach ($feature in $features) {
    try {
        Install-WindowsFeature -Name $feature.Name -ErrorAction Stop
        Write-Host "Successfully installed feature: $($feature.Name)"
    } catch {
        Write-Host "Failed to install feature: $($feature.Name). Error: $_"
    }
}

# Import the server name from the downloaded CSV file
$serverInfo = Import-Csv -Path $localServerPath
$serverName = ($serverInfo | Select-Object -First 1).ServerName

# Check if the server name is not empty
if ($serverName -and $serverName -ne (hostname)) {
    try {
        Rename-Computer -NewName $serverName -Force -ErrorAction Stop
        Write-Host "Successfully renamed the computer to: $serverName"
    } catch {
        Write-Host "Failed to rename the computer. Error: $_"
    }
} else {
    Write-Host "No valid server name found or the computer is already named $serverName"
}

# Restart the computer
try {
    Restart-Computer -Force -ErrorAction Stop
} catch {
    Write-Host "Failed to restart the computer. Error: $_"
}
