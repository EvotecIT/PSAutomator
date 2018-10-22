function Get-WinADUsers {
    param(
        $Filter,
        $OrganizationalUnit,
        $Group
    )
    $Splatting = @{}
    if ($OrganizationalUnit) {
        $Splatting.SearchBase = $OrganizationalUnit
        $Splatting.Filter = '*'
    }
    if ($Filter) {
        $Splatting = $Filter
    }

    if ($Group) {
        $Users = @()
        $GroupMembers = Get-ADGroupMember -Identity $Group
        #Get-ADUser $Groupmembers
        foreach ($Member in $GroupMembers) {
            $Users += Get-ADUser -Identity $Member -Properties $Script:UserProperties #| Select-Object $Script:UserProperties
        }
    } else {
        $Users = Get-ADUser @Splatting -Properties $Script:UserProperties #| Select-Object $Script:UserProperties
    }
    return $Users
}
<#

$Splat = @{
    Filter = '*'
}

$Splat = @{
    Filter     = "UserPrincipalName -eq 'przemyslaw.klys@ad.evotec.xyz'"
    SearchBase = 'OU=Users,OU=Production,DC=ad,DC=evotec,DC=xyz'
}

Get-ADUser @Splat
#>
<#
$Script:UserProperties = 'Name', 'UserPrincipalName', 'SamAccountName', 'Enabled', 'PasswordLastSet', `
    'PasswordExpired', 'PasswordNeverExpires', 'PasswordNotRequired', 'EmailAddress', 'DisplayName', 'GivenName', `
    'Surname', 'Manager', "AccountExpirationDate", "AccountLockoutTime", "AllowReversiblePasswordEncryption", `
    "BadLogonCount", "CannotChangePassword", "CanonicalName", "Description", "DistinguishedName", "EmployeeID", `
    "EmployeeNumber", "LastBadPasswordAttempt", "LastLogonDate", "Created", "Modified", "PrimaryGroup", "MemberOf", `
    'msDS-UserPasswordExpiryTimeComputed','msExchHideFromAddressLists'



#Get-WinADUsers

Get-Aduser -Filter * -Properties * | Select-Object MemberOf

#>