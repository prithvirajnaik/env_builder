# Dev Environment Setup Script

A simpler way to set up development environments for beginners.

This repository contains a PowerShell script (`setup.ps1`) designed to automate the installation and configuration of essential development tools on a fresh Windows machine. The goal is to provide a quick and hassle-free setup experience for beginners and developers [attached_file:1].

---

## 🚀 Purpose

The script installs and configures the most commonly used tools for programming, including:

- Git & Git Bash
- Visual Studio Code
- Python (with pip and PATH setup)
- Node.js (with npm and PATH setup)
- C++ Compiler (MSYS2 / MinGW)

---

## 🛠 Features

- Automatic tool installation using winget
- Environment variable (`PATH`) configuration
- Version checks and validations
- Beginner-friendly setup without manual configuration

---

## 📄 How to Use

### 1️⃣ Bootstrap Script (Recommended)

A `bootstrap.ps1` script is provided for fully automated setup. It:

- Creates the `C:\Scripts` folder if missing
- Downloads or updates `setup.ps1`
- Optionally runs `setup.ps1`

Run the bootstrap script directly from PowerShell:
```powershell
irm https://raw.githubusercontent.com/prithvirajnaik/env_builder/main/bootstrap.ps1 | iex
```

---

### 2️⃣ Run PowerShell as Administrator

Script installation and PATH changes require administrator privileges.

---

### 3️⃣ Allow Script Execution (first time only)
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
```

## ❗ Requirements

* Windows 10 / 11
* Internet connection
* PowerShell (Admin mode recommended)



