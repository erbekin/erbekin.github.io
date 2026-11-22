# Build the Hugo site (plus apps/*) and publish it to the gh-pages branch.
# Usage: ./deploy.ps1 [-Push]
param([switch]$Push)

$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot

# --- Demo apps: apps/<name> -> static/demos/<name> -> /demos/<name>/ ---
if (Test-Path static/demos) { Remove-Item -Recurse -Force static/demos }
if (Test-Path apps) {
    foreach ($app in Get-ChildItem apps -Directory) {
        $name = $app.Name
        $out = "static/demos/$name"
        if (Test-Path "$($app.FullName)/package.json") {
            Write-Host "Building app: $name"
            Push-Location $app.FullName
            try {
                if (Get-Command bun -ErrorAction SilentlyContinue) {
                    bun install
                    bun run build --base=/demos/$name/
                } else {
                    npm install
                    npm run build -- --base=/demos/$name/
                }
                if ($LASTEXITCODE -ne 0) { throw "Build failed for app $name" }
            } finally { Pop-Location }
            New-Item -ItemType Directory -Force -Path $out | Out-Null
            Copy-Item "$($app.FullName)/dist/*" $out -Recurse -Force
        } else {
            Write-Host "Copying static app: $name"
            New-Item -ItemType Directory -Force -Path $out | Out-Null
            Copy-Item "$($app.FullName)/*" $out -Recurse -Force
        }
    }
}

# --- gh-pages worktree ---
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
