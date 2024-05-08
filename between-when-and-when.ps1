# Import Active Directory module
Import-Module ActiveDirectory

# Prompt user to enter start and end dates
$startDate = Read-Host "Enter start date (MM/DD/YYYY)"
$endDate = Read-Host "Enter end date (MM/DD/YYYY)"

# Convert dates to DateTime objects
$startDate = [DateTime]::ParseExact($startDate, "MM/dd/yyyy", $null)
$endDate = [DateTime]::ParseExact($endDate, "MM/dd/yyyy", $null)

# Perform query to retrieve users within specified date range
$users = Get-ADUser -Filter {Created -ge $startDate -and Created -lt $endDate} -Properties Created

# Display the results
if ($users) {
    Write-Host "Users created between $startDate and $endDate:"
    $users | Select-Object Name, SamAccountName, Created
} else {
    Write-Host "No users found within the specified date range."
}
