# Get reboot events
$rebootEvents = Get-WinEvent -LogName System | Where-Object { $_.Id -eq 1074 } | Select-Object TimeCreated, Message

# Get shutdown events
$shutdownEvents = Get-WinEvent -LogName System | Where-Object { $_.Id -eq 1074 -and $_.Message -like "*shutdown*" } | Select-Object TimeCreated, Message

# Combine and sort events
$allEvents = $rebootEvents + $shutdownEvents | Sort-Object TimeCreated

# Display the combined events
foreach ($event in $allEvents) {
    Write-Host "Time: $($event.TimeCreated) - $($event.Message)"
}
