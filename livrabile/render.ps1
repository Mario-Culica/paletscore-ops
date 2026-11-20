# Generează PDF-urile (și PNG-ul afișului) din livrabile/src cu Microsoft Edge, fără alte programe.
# Rulare: powershell -ExecutionPolicy Bypass -File livrabile\render.ps1
$ErrorActionPreference = 'Stop'
$edge = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
$src = Join-Path $PSScriptRoot 'src'
$prof = Join-Path $env:TEMP 'paletscore-edge-render'
function Edge([string[]]$a) { & $edge --headless=new --disable-gpu --no-first-run "--user-data-dir=$prof" --virtual-time-budget=10000 @a | Out-Null }
foreach ($n in '01_aplicatie_web', '02_strategie', '05_jurnal_ai', '04_afis') {
  $url = 'file:///' + ((Join-Path $src "$n.html") -replace '\\', '/')
  Edge @('--no-pdf-header-footer', "--print-to-pdf=$(Join-Path $PSScriptRoot "$n.pdf")", $url)
}
$url = 'file:///' + ((Join-Path $src '04_afis.html') -replace '\\', '/')
Edge @('--hide-scrollbars', '--window-size=1080,1350', "--screenshot=$(Join-Path $PSScriptRoot '04_afis.png')", $url)
Get-ChildItem $PSScriptRoot -File | Where-Object { $_.Extension -in '.pdf', '.png' } | Select-Object Name, Length
