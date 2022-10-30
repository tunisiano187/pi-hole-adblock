$url = "https://hblock.molinero.dev/hosts_adblock.txt"
$working = "list_$($myInvocation.ScriptName).txt"

$content = (Invoke-WebRequest -Uri $url)
($content.Tostring().split('
') | Where-Object {$_ -notmatch "!"}).replace('|','').replace('^','') | Set-Content -Path $working

