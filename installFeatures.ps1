# Define the path to the CSV file containing the list of features
$featuresFilePath = "C:\path\to\features.csv"

# Import the list of features from the CSV file
$features = Import-Csv -Path $featuresFilePath

# Install each feature from the list
foreach ($feature in $features) {
    try {
        Install-WindowsFeature -Name $feature.Name -ErrorAction Stop
        Write-Host "Successfully installed feature: $($feature.Name)"
    } catch {
        Write-Host "Failed to install feature: $($feature.Name). Error: $_"
    }
}

# Enter the new server name
$newServerName = Read-Host "Enter the new server name"

# Rename the computer
Rename-Computer -NewName $newServerName -Force

# Restart the computer
Restart-Computer -Force
