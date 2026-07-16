$env:runningplace=$PSScriptRoot

Write-Information "Setting up the workflow"
Get-ChildItem -Path ./Setup -Filter "*.ps1" | ForEach-Object { . $_.FullName }

Write-Information "Downloading Lists"
Get-ChildItem -Path ./Urls -Filter "*.ps1" | ForEach-Object { . $_.FullName }

Write-Information "Commit changes"
$toadd = (get-childitem -path "." -Filter "list*.txt").FullName
foreach ($file in $toadd) {
    Move-Item $file ./Lists/ -Force
}
$toadd = (get-childitem -path "." -Filter "list*.txt").FullName
foreach ($file in $toadd) {
    git add $file
}
git commit -m "[skip ci] update lists"

$exclusions = [System.Collections.Generic.HashSet[string]]::new([string[]](
    Get-Content ./Lists/exclusions.txt -ErrorAction SilentlyContinue |
        ForEach-Object { $_.Trim().ToLowerInvariant() } |
        Where-Object { $_ -ne "" -and -not $_.StartsWith("#") }
))

get-childitem -path "." -include list*.txt -Recurse | ForEach-Object {Get-Content $_; ""} | Where-Object { $_.Trim() -ne "" } | ForEach-Object { $_.ToLowerInvariant() } | Where-Object { -not $exclusions.Contains($_) } | Sort-Object -Unique | out-file ./Lists/all.txt
git add ./Lists/all.txt
git commit -m "[skip ci] update all.txt"

Write-Information "Push if required"
try {
    git push
} catch {
    write-output "nothing to push"
}
