$scriptname = "kitsapcreator"
$urls = @{
    "ads"       = "https://blocklists.kitsapcreator.com/ads.txt"
    "scam-spam" = "https://blocklists.kitsapcreator.com/scam-spam.txt"
}

foreach ($name in $urls.Keys) {
    $url = $urls[$name]
    $working = "$env:temp\list_${scriptname}_$name.txt"
    $out = "$env:runningplace\list_${scriptname}_$name.txt"

    try {
        Invoke-WebRequest -Uri $url -OutFile $working -ErrorAction Stop
    } catch {
        Write-Warning "Failed to download $name list from $url : $_"
        continue
    }

    $content = Get-Content -Path $working
    if (-not $content -or $content.Count -eq 0) {
        Write-Warning "Downloaded $name list is empty, skipping update"
        continue
    }

    ($content | Where-Object { $_.Trim() -ne "" -and $_ -notmatch "^\s*[!#]" }).replace('|', '').replace('^', '') |
        Sort-Object -Unique |
        Set-Content -Path $out
}
