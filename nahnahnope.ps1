# Set the username you want to log off
$UserName = "CHANGE-ME-TO-THE-USERname-You-Need"

# Disable user account to invalidate existing tickets
Disable-ADAccount -Identity $UserName

#Force password change on next logon
Set-ADUser -Identity $UserName -ChangePasswordAtLogon $true

# Get a list of all machines in the domain
$Machines = Get-ADComputer -Filter *

# Loop through each machine, because i don't know a better way to do this, and log off user
foreach ($Machine in $Machines) {
    $ComputerName = $Machine.Name
    Write-Host "Logging off $UserName from $ComputerName..."
    try {
        # Attempt to log off the user using the 'logoff' command remotely
        Invoke-Command -ComputerName $ComputerName -ScriptBlock { logoff.exe $($using:UserName) /server:$env:COMPUTERNAME } -Credential (Get-Credential)
        Write-Host "Successfully logged off $UserName from $ComputerName"
    } catch {
        Write-Host "Failed to log off $UserName from $ComputerName using 'logoff.exe': $_" -ForegroundColor Red
        Write-Host "Let's try another way to log off $UserName from $ComputerName..."
        try {
            # Attempt to log off the user 
            Invoke-Command -ComputerName $ComputerName -ScriptBlock {
                $session = query session | Where-Object { $_ -match $using:UserName }
                if ($session) {
                    $sessionId = $session -replace '\s+', ' ' -split ' ' | Select-Object -Index 2
                    logoff $sessionId
                } else {
                    Write-Host "No session found for user $($using:UserName)" -ForegroundColor Yellow
                }
            } -Credential (Get-Credential)
            Write-Host "Successfully logged off $UserName from $ComputerName using alternative method"
        } catch {
            Write-Host "Failed to log off $UserName from $ComputerName using 2nd method also: $_" -ForegroundColor Red
        }
    }
}

# Wait 
Start-Sleep -Seconds 5

# Re-enable user 
Enable-ADAccount -Identity $UserName
