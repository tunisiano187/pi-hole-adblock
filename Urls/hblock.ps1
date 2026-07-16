$url = "https://hblock.molinero.dev/hosts_adblock.txt"
$scriptname = "hblock"
$working = Join-Path ([System.IO.Path]::GetTempPath()) "list_$scriptname.txt"
$out = Join-Path $env:runningplace "list_$scriptname.txt"

try {
    Invoke-WebRequest -Uri $url -OutFile $working -ErrorAction Stop
} catch {
    Write-Warning "Failed to download $scriptname list from $url : $_"
    return
}

$content = Get-Content -Path $working
if (-not $content -or $content.Count -eq 0) {
    Write-Warning "Downloaded $scriptname list is empty, skipping update"
    return
}

($content | Where-Object {$_ -notmatch "!"}).replace('|','').replace('^','') | Sort-Object | get-unique | Set-Content -Path $out

