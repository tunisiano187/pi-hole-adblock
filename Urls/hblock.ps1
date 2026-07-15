$url = "https://hblock.molinero.dev/hosts_adblock.txt"
$scriptname = "hblock"
$working = Join-Path ([System.IO.Path]::GetTempPath()) "list_$scriptname.txt"
$out = Join-Path $env:runningplace "list_$scriptname.txt"

Invoke-WebRequest -Uri $url -OutFile $working
$content = Get-Content -Path $working
($content | Where-Object {$_ -notmatch "!"}).replace('|','').replace('^','') | Sort-Object | get-unique | Set-Content -Path $out

