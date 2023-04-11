# Capture all logged-in users
$users = Get-WmiObject -Class Win32_ComputerSystem | Select-Object UserName

# Capture all recent DNS requests
$dns = Get-DnsClientCache | Select-Object -Property Entry, TimeStamp

# Capture all startup applications
$startup = Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, Location, User

# No screen for you
rundll32.exe user32.dll,LockWorkStation

# Reset that pass.... because you failed last time
Set-ADUser -Identity $env:USERNAME -ChangePasswordAtLogon $true

# Write results to a log file
$log = "C:\incident-response-remediation.txt"
"$users`n$dns`n$startup" | Out-File -FilePath $log
