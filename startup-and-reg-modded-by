# Get the current time and the time one hour ago
$currentDate = Get-Date
$oneHourAgo = $currentDate.AddHours(-1)

# Get all registry keys modified within the last hour
$registryKeys = Get-WinEvent -FilterHashtable @{Logname='System';ID=4657;StartTime=$oneHourAgo} | ForEach-Object { 
    $_.Properties[0].Value 
}

# Get the associated users for each modified registry key
$users = @{}
foreach ($key in $registryKeys) {
    $owner = (Get-Acl $key).Owner
    $users[$key] = $owner
}

# Print the modified registry keys and associated users
Write-Host "Registry keys modified within the last hour:"
foreach ($key in $registryKeys) {
    $user = $users[$key]
    Write-Host "$key modified by $user"
}

# Get the PIDs for processes started by a parent process attempting to make external network connections
$networkProcesses = Get-NetTCPConnection -State Established | Where-Object {
    $parentProcess = Get-WmiObject Win32_Process -Filter "ProcessID = $($_.OwningProcess)" | Select-Object -ExpandProperty ParentProcessId
    $parentProcessConnections = Get-NetTCPConnection -State Established | Where-Object { $_.OwningProcess -eq $parentProcess }
    ($parentProcessConnections.RemoteAddress | Select-Object -Unique) -notcontains '127.0.0.1'
} | Select-Object -ExpandProperty OwningProcess

# Print the PIDs for the network processes
Write-Host "PIDs for processes started by a parent process attempting to make external network connections:"
foreach ($pid in $networkProcesses) {
    Write-Host $pid
}
