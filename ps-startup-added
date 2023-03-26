$computerName = "COMPUTER_NAME" # Replace with the name of the remote computer
##$username = "USERNAME" # Replace with the username of an account with administrative privileges on the remote computer
##$password = "PASSWORD" | ConvertTo-SecureString -AsPlainText -Force # Replace with the password for the above username
$cred = Get-Credential

Invoke-Command -ComputerName $computerName -Credential $cred -ScriptBlock {
    $startupFolder = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
    $registryKey = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run"

    $maliciousFiles = @()

    # Check for malicious files in the Startup folder
    $startupFiles = Get-ChildItem $startupFolder -File
    foreach ($file in $startupFiles) {
        if ((Get-ItemProperty $file.FullName).Publisher -eq "Unknown") {
            $maliciousFiles += $file.FullName
        }
    }

    # Check for malicious files in the Run registry key
    $runKey = Get-Item $registryKey
    $runValues = $runKey.GetValueNames()
    foreach ($value in $runValues) {
        $path = $runKey.GetValue($value)
        if ((Get-ItemProperty $path).Publisher -eq "Unknown") {
            $maliciousFiles += $path
        }
    }

    if ($maliciousFiles.Count -gt 0) {
        Write-Host "Malicious files found in startup processes:"
        foreach ($file in $maliciousFiles) {
            Write-Host $file
        }
    } else {
        Write-Host "No malicious files found in startup processes."
    }
}
