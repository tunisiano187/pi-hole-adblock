Write-Information "Setting up the workflow"
Get-ChildItem -Path .\Setup -Filter "*.ps1" | ForEach-Object { . $_.FullName }

Write-Information "Downloading Lists"
Get-ChildItem -Path .\Lists -Filter "*.ps1" | ForEach-Object { . $_.FullName }

Write-Information "Commit changes"
$toadd = (get-childitem -path "." -Filter "list*.txt").FullName
foreach ($file in $toadd) {
    git add $file
}
git commit -m "add lists"

Write-Information "Push if required"
try {
    git pull
    git push origin master
} catch {
    write-output "nothing to push"
}