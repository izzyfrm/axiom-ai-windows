$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

Write-Host ""
Write-Host "Axiom AI - Windows Builder" -ForegroundColor Cyan
Write-Host "==========================" -ForegroundColor Cyan
Write-Host ""

if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
    Write-Host "Node.js/npm is missing." -ForegroundColor Red
    Write-Host "Install Node.js LTS, then run this script again."
    exit 1
}

if (-not (Get-Command cargo -ErrorAction SilentlyContinue)) {
    Write-Host "Rust/Cargo is missing." -ForegroundColor Red
    Write-Host "Install Rust from rustup, then run this script again."
    exit 1
}

Write-Host "[1/3] Installing Tauri CLI..." -ForegroundColor Yellow
npm install

Write-Host "[2/3] Building Axiom AI..." -ForegroundColor Yellow
npm run build

$bundleDir = Join-Path $PSScriptRoot "src-tauri\target\release\bundle\nsis"
$installer = Get-ChildItem -Path $bundleDir -Filter "*.exe" -ErrorAction SilentlyContinue |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 1

if (-not $installer) {
    Write-Host "Build finished, but the NSIS installer could not be found." -ForegroundColor Red
    exit 1
}

$dist = Join-Path $PSScriptRoot "dist"
New-Item -ItemType Directory -Force -Path $dist | Out-Null
$finalInstaller = Join-Path $dist "AxiomAI-Setup.exe"
Copy-Item $installer.FullName $finalInstaller -Force

$portableSource = Join-Path $PSScriptRoot "src-tauri\target\release\axiom-ai.exe"
if (Test-Path $portableSource) {
    Copy-Item $portableSource (Join-Path $dist "AxiomAI-Portable.exe") -Force
}

Write-Host "[3/3] Done." -ForegroundColor Green
Write-Host ""
Write-Host "Installer:" -ForegroundColor Green
Write-Host $finalInstaller
Write-Host ""
Write-Host "Axiom loads https://axiomai.technology, so the desktop app stays synced with the live website."
