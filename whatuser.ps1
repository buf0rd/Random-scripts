$remoteComputer = "harty"
$credential = Get-Credential

# Establish a remote PowerShell session
$session = New-PSSession -ComputerName $remoteComputer -Credential $credential

# Run the quser command on the remote machine
Invoke-Command -Session $session -ScriptBlock {
    quser
}

# Close the remote PowerShell session
Remove-PSSession $session
