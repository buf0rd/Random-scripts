# Load the Exchange Management Shell
if ((Get-PSSnapin -Name Microsoft.Exchange.Management.PowerShell.SnapIn -ErrorAction SilentlyContinue) -eq $null) {
    Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn
}

# Get the members of the "Organization Management" role group
$organizationManagementRoleGroup = Get-RoleGroupMember "Organization Management"

# Filter and display the members who are users (not built-in groups)
$usersWithViewAllEmailAccess = $organizationManagementRoleGroup | Where-Object { $_.RecipientTypeDetails -eq "UserMailbox" }

# Display the list of users with view all email access
$usersWithViewAllEmailAccess | Select-Object DisplayName, SamAccountName, UserPrincipalName, RecipientTypeDetails
