# Disable Bing Smart Search
Write-Host "Disabling Bing Smart Search..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "BingSearchEnabled" -Value 0 -Force

# Disable CoPilot AI features
Write-Host "Disabling CoPilot AI features..."
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Input\TIPC\Features" -Name "CoPilot" -Value 0 -Force

Write-Host "Bing Smart Search and CoPilot AI features disabled successfully."
