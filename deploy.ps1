# Build the Hugo site and publish it to the gh-pages branch.
# Usage: ./deploy.ps1 [-Push]
param([switch]$Push)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

if (-not (Test-Path public/.git)) {
    if (Test-Path public) { Remove-Item -Recurse -Force public }
    git worktree add -B gh-pages public gh-pages
}

Get-ChildItem -Path public -Force | Where-Object { $_.Name -ne '.git' } | Remove-Item -Recurse -Force
hugo --minify
New-Item -ItemType File -Force -Path public/.nojekyll | Out-Null

git -C public add -A
git -C public commit -m "Build Hugo static blog"
if ($Push) { git -C public push origin gh-pages }
