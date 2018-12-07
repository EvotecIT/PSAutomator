function Get-WinADUsers {
    [CmdletBinding()]
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
        if ($Filter -is [hashtable]) {
            # $Splatting.Filter = $Filter.Filter
            # $Splatting.SearchBase = $Filter.SearchBase
            $Splatting = $Filter
        } elseif ($Filter -is [string]) {
            $Splatting.Filter = $Filter
        } else {

        }
    }

    #Write-Color $Group -Color Red
    if ($Group) {
        $Users = @()
        $GroupMembers = Get-ADGroupMember -Identity $Group
        #Get-ADUser $Groupmembers
        $Users = foreach ($Member in $GroupMembers) {
            #Write-COlor $Member -Color Red
            Get-ADUser -Identity $Member -Properties $Script:UserProperties #| Select-Object $Script:UserProperties
        }
    } else {
        $Users = Get-ADUser @Splatting -Properties $Script:UserProperties #| Select-Object $Script:UserProperties
    }


    $UserList = foreach ($U in $Users) {
        $Manager = Get-WinADUsersByDN -DistinguishedName $U.Manager
        $PrimaryGroup = Get-WinADGroupsByDN -DistinguishedName $U.PrimaryGroup -All #-Field 'Name'
        $Groups = Get-WinADGroupsByDN -DistinguishedName $U.MemberOf -All #-Field 'Name'
        $OrganizationalUnit = Get-WinADOrganizationalUnitFromDN -DistinguishedName $U.DistinguishedName
        $OrganizationalUnitData = Get-WinADOrganizationalUnitData -OrganizationalUnit $OrganizationalUnit

        [PsCustomObject][ordered] @{
            'Name'                              = $U.Name
            'UserPrincipalName'                 = $U.UserPrincipalName
            'SamAccountName'                    = $U.SamAccountName
            'Display Name'                      = $U.DisplayName
            'Given Name'                        = $U.GivenName
            'Surname'                           = $U.Surname
            'EmailAddress'                      = $U.EmailAddress
            'PasswordExpired'                   = $U.PasswordExpired
            'PasswordLastSet'                   = $U.PasswordLastSet
            'Password Last Changed'             = if ($U.PasswordLastSet -ne $Null) { "$(-$($U.PasswordLastSet - [DateTime]::Today).Days) days" } else { 'N/A'}
            'PasswordNotRequired'               = $U.PasswordNotRequired
            'PasswordNeverExpires'              = $U.PasswordNeverExpires
            'Enabled'                           = $U.Enabled
            'Manager'                           = $Manager.Name
            'Manager Email'                     = $Manager.EmailAddress
            'DateExpiry'                        = Convert-ToDateTime -Timestring $($U."msDS-UserPasswordExpiryTimeComputed") #-Verbose
            "DaysToExpire"                      = (Convert-TimeToDays -StartTime GET-DATE -EndTime (Convert-ToDateTime -Timestring $($U."msDS-UserPasswordExpiryTimeComputed")))
            "AccountExpirationDate"             = $U.AccountExpirationDate
            "AccountLockoutTime"                = $U.AccountLockoutTime
            "AllowReversiblePasswordEncryption" = $U.AllowReversiblePasswordEncryption
            "BadLogonCount"                     = $U.BadLogonCount
            "CannotChangePassword"              = $U.CannotChangePassword
            "CanonicalName"                     = $U.CanonicalName

            "Description"                       = $U.Description
            "DistinguishedName"                 = $U.DistinguishedName
            "EmployeeID"                        = $U.EmployeeID
            "EmployeeNumber"                    = $U.EmployeeNumber
            "LastBadPasswordAttempt"            = $U.LastBadPasswordAttempt
            "LastLogonDate"                     = $U.LastLogonDate
            'Last Logon Days'                   = if ($U.LastLogonDate -ne $Null) { "$(-$($U.LastLogonDate - [DateTime]::Today).Days) days" } else { 'N/A'}

            "Created"                           = $U.Created
            "Modified"                          = $U.Modified
            "Protected"                         = $U.ProtectedFromAccidentalDeletion

            "PrimaryGroup"                      = $PrimaryGroup # Whole Object
            "MemberOf"                          = $Groups #Whole Objects
            #"Domain"                            = $Domain
            'Identity'                          = $U.Identity
            'OU'                                = $OrganizationalUnit
            'OrganizationalUnit'                = $OrganizationalUnitData
        }

    }
    return $UserList
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


$User = Get-WinADUsers -Filter "UserPrincipalName -eq 'przemyslaw.klys@ad.evotec.xyz'"
#$User.MemberOf.Name
#$User."MemberOf.Name"

$string = 'memberOf.Name'
$value = $user
foreach($part in $string.Split('.')){
    $Part
    $value = $value."$part"
}
#>

#Get-Aduser -Filter * -Properties * | Select-Object MemberOf

#>
<#
$Script:UserProperties = 'Name', 'UserPrincipalName', 'SamAccountName', 'Enabled', 'PasswordLastSet', `
    'PasswordExpired', 'PasswordNeverExpires', 'PasswordNotRequired', 'EmailAddress', 'DisplayName', 'GivenName', `
    'Surname', 'Manager', "AccountExpirationDate", "AccountLockoutTime", "AllowReversiblePasswordEncryption", `
    "BadLogonCount", "CannotChangePassword", "CanonicalName", "Description", "DistinguishedName", "EmployeeID", `
    "EmployeeNumber", "LastBadPasswordAttempt", "LastLogonDate", "Created", "Modified", "PrimaryGroup", "MemberOf", `
    'msDS-UserPasswordExpiryTimeComputed','msExchHideFromAddressLists'

Get-WinADUsers -Filter '*'

#>