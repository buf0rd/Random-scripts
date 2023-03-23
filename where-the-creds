$computers = Get-ADComputer -Filter {OperatingSystem -Like "*Windows*"} | Select -ExpandProperty Name

foreach ($computer in $computers) {
    $cred = cmdkey /list:$computer | where {$_ -like "*Domain:[DOMAIN*]" -and $_ -like "*User:*Administrator*"}
    if ($cred) {
        Write-Host "Domain Administrator credentials found on $computer:`n$cred" -ForegroundColor Red
    }
}
