Write-Information "Setting up the workflow"
Get-ChildItem -Path .\Setup -Filter "*.ps1" | ForEach-Object { . $_.FullName }

Write-Information "Downloading Lists"
Get-ChildItem -Path .\Lists -Filter "*.ps1" | ForEach-Object { . $_.FullName }
