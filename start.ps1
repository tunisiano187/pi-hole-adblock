$env:runningplace=$PSScriptRoot

Write-Information "Setting up the workflow"
Get-ChildItem -Path .\Setup -Filter "*.ps1" | ForEach-Object { . $_.FullName }

Write-Information "Downloading Lists"
Get-ChildItem -Path .\Urls -Filter "*.ps1" | ForEach-Object { . $_.FullName }

Write-Information "Commit changes"
$toadd = (get-childitem -path "." -Filter "list*.txt").FullName
foreach ($file in $toadd) {
    Move-Item $file .\Lists\ -Force
    Remove-Item $file -Force
}
$toadd = (get-childitem -path "." -Filter "list*.txt").FullName
foreach ($file in $toadd) {
    git add $file
}
git commit -m "[skip ci] add lists"

get-childitem -path "." -include list*.txt -Recurse | ForEach-Object {Get-Content $_; ""} | Sort-Object | get-unique | out-file .\Lists\all.txt
git commit -m "[skip ci] add all.txt"

Write-Information "Push if required"
try {
    git push
} catch {
    write-output "nothing to push"
}