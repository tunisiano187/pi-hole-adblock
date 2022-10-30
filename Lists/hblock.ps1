$url = "https://hblock.molinero.dev/hosts_adblock.txt"
$working = "$env:runningplace\list_$($myInvocation.ScriptName).txt"

$content = (Invoke-WebRequest -Uri $url).content
($content.Tostring().split('
') | Where-Object {$_ -notmatch "!"}).replace('|','').replace('^','') | Set-Content -Path $working

