param (
    [string]$tool = "all"
)


function Update-Setup {
    $setupUrl = "https://raw.githubusercontent.com/<username>/<repo>/main/setup.ps1"
    $setupPath = "$PSScriptRoot\setup.ps1"
    Invoke-WebRequest -Uri $setupUrl -OutFile $setupPath -UseBasicParsing
    Write-Host "Setup script updated!"
}

# -------- Step 1: Tool install functions --------
function Install-Python {
    if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Python..."
        winget install -e --id Python.Python.3.12 -h
    } else { Write-Host "Python already installed." }
}

function Install-Cpp {
    Write-Host "Installing MinGW..."
    winget install -e --id MSYS2.MSYS2 -h
}

function Install-Git {
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Git..."
        winget install -e --id Git.Git -h
    } else { Write-Host "Git already installed." }
}

function Install-VSCode {
    if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
        Write-Host "Installing VS Code..."
        winget install -e --id Microsoft.VisualStudioCode -h
    } else { Write-Host "VS Code already installed." }
}

# -------- Step 2: Parse argument --------
switch ($tool.ToLower()) {
    "python" { Install-Python }
    "cpp"    { Install-Cpp }
    "git"    { Install-Git }
    "vscode" { Install-VSCode }
    "all"    { Install-Python; Install-Cpp; Install-Git; Install-VSCode }
    "update" { Update-setup }
    default { Write-Host "Unknown tool: $tool. Available: python, cpp, git, vscode, all" }
}

Write-Host "======================================="
Write-Host "✅ Done!"
Write-Host "======================================="
