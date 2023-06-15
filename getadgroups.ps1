# Import the Active Directory module
Import-Module ActiveDirectory

# Get all Active Directory groups
$groups = Get-ADGroup -Filter * -Properties *

# Create an empty array to store group information
$groupInfo = @()

# Iterate through each group
foreach ($group in $groups) {
    # Retrieve group members
    $members = Get-ADGroupMember -Identity $group.DistinguishedName

    # Convert the group members to a comma-separated string
    $memberNames = $members | Select-Object -ExpandProperty Name -Join ', '

    # Create a custom object with group information
    $groupObj = [PSCustomObject] @{
        GroupName = $group.Name
        GroupDN = $group.DistinguishedName
        Members = $memberNames
        GroupScope = $group.GroupScope
        GroupType = $group.GroupCategory
        Privileges = $group.MemberOf | ForEach-Object { (Get-ADGroup $_).Name } -Join ', '
    }

    # Add the group object to the array
    $groupInfo += $groupObj
}

# Export the group information to a CSV file
$groupInfo | Export-Csv -Path "ADGroupInformation.csv" -NoTypeInformation

Write-Host "Group information exported to ADGroupInformation.csv"
