$url = "https://hblock.molinero.dev/hosts_adblock.txt"
$working = "list_$($myInvocation.ScriptName).txt"

(Invoke-WebRequest -Uri $url -split '
' | Where-Object {$_ -notmatch "!"}).replace('|','').replace('^','') | Set-Content -Path $working

