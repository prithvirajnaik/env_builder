param (
    [string]$tool = "help"
)


function Update-Setup {
    $setupUrl = "https://raw.githubusercontent.com/prithvirajnaik/env_builder/main/setup.ps1"
    $setupPath = "C:\Scripts\setup.ps1"
    Invoke-WebRequest -Uri $setupUrl -OutFile $setupPath 
    Write-Host "Setup script updated"
}

function Help-Cmd {
    Write-Host "No args passed with setup <tool>"
}

# -------- Step 1: Tool install functions --------
function Install-Python {
    if (-not (Get-Command python -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Python..."
        winget install -e --id Python.Python.3.12 -h
    } else { Write-Host "Python already installed." }
        # -------- 2. Ensure pip is installed and upgraded --------
    Write-Host "Ensuring pip is installed and upgraded..."
    python -m ensurepip --upgrade
    python -m pip install --upgrade pip
    Write-Host "pip is ready."

     # -------- 3. Set environment variables (PATH) --------
    $pythonPath = (Get-Command python).Source
    $pythonDir = Split-Path $pythonPath -Parent
    $scriptsDir = Join-Path $pythonDir "Scripts"

    # Check if PATH already contains Python
    $currentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
    if (-not ($currentPath -split ";" | Select-String -Pattern [regex]::Escape($pythonDir))) {
        # Add Python directories to PATH permanently (system-wide)
        $newPath = $currentPath + ";" + $pythonDir + ";" + $scriptsDir
        [Environment]::SetEnvironmentVariable("Path", $newPath, [EnvironmentVariableTarget]::Machine)
        Write-Host "Python PATH added to system environment variables."
    } else {
        Write-Host "Python PATH already set."
    }

    # -------- 4. Verify installation --------
    python --version
    pip --version
    #TODO: adding variable version installation options
}

function Install-NodeJS {
    # -------- 1. Check if node is installed --------
    if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Node.js..."
        # Install Node.js LTS silently using winget
        winget install --id OpenJS.NodeJS.LTS -e --silent
        Write-Host "Node.js installed."
    } else {
        Write-Host "Node.js is already installed."
    }

    # -------- 2. Set environment variables (PATH) --------
    $nodePath = (Get-Command node).Source
    $nodeDir = Split-Path $nodePath -Parent
    $npmDir = Join-Path $nodeDir "node_modules\npm\bin"

    $currentPath = [Environment]::GetEnvironmentVariable("Path", [EnvironmentVariableTarget]::Machine)
    if (-not ($currentPath -split ";" | Select-String -Pattern [regex]::Escape($nodeDir))) {
        $newPath = $currentPath + ";" + $nodeDir + ";" + $npmDir
        [Environment]::SetEnvironmentVariable("Path", $newPath, [EnvironmentVariableTarget]::Machine)
        Write-Host "Node.js PATH added to system environment variables."
    } else {
        Write-Host "Node.js PATH already set."
    }

    # -------- 3. Verify installation --------
    node --version
    npm --version
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

#TODO: add configuration setup later
}

function Install-VSCode {
    if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
        Write-Host "Installing VS Code..."
        winget install -e --id Microsoft.VisualStudioCode -h
        Write-Host "VS Code installed."
    } else { Write-Host "VS Code already installed." }
#TODO: add extensions setup for convienece
}

# -------- Step 2: Parse argument --------
switch ($tool.ToLower()) {
    "python" { Install-Python }
    "cpp"    { Install-Cpp }
    "git"    { Install-Git }
    "vscode" { Install-VSCode }
    "help"   { Help-Cmd }
    "update" { Update-Setup }
    "node"   { Install-NodeJS}
    default { Write-Host "Unknown tool: $tool. Available: python, cpp, git, vscode, all" }
}

Write-Host "======================================="
Write-Host "Done!!"
Write-Host "======================================="
