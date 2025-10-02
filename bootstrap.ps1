# ==========================================
# bootstrap.ps1
# Bootstraps package manager and installs the setup tool
# ==========================================

Write-Host "======================================="
Write-Host "🚀 Bootstrapping your setup tool..."
Write-Host "======================================="

# -------- Step 1: Ensure winget exists --------
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget not found. Downloading installer..."
    $wingetUrl = "https://aka.ms/getwinget"
    $outputFile = "$env:TEMP\winget.msixbundle"
    Invoke-WebRequest -Uri $wingetUrl -OutFile $outputFile

    Write-Host "Installing Winget..."
    Add-AppxPackage $outputFile
    Write-Host "Winget installed successfully!"
} else {
    Write-Host "Winget is already installed."
}

# -------- Step 2: Download main setup.ps1 --------
$installDir = "C:\Scripts"
if (-not (Test-Path $installDir)) {
    New-Item -ItemType Directory -Path $installDir
}

$setupUrl = "https://raw.githubusercontent.com/prithvirajnaik/env_builder/refs/heads/main/setup.ps1"
$setupPath = Join-Path $installDir "setup.ps1"

Write-Host "Downloading setup tool..."
Invoke-WebRequest -Uri $setupUrl -OutFile $setupPath

# -------- Step 3: Add to PATH --------
if (-not ($env:PATH -split ";" | Where-Object { $_ -eq $installDir })) {
    setx PATH "$env:PATH;$installDir"
    Write-Host "Added $installDir to PATH. You may need to restart your terminal."
}

Write-Host "======================================="
Write-Host "✅ Bootstrap complete! You can now run 'setup <tool>'."
Write-Host "======================================="
