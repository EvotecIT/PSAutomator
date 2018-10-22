function Get-WinADUsersTranslate {
    param(
        [System.Object[]] $Users
    )
    $UserList = @()
    foreach ($U in $Users) {
        $UserList += [PSCustomObject] @{
            'Name'                              = $U.Name
            'UserPrincipalName'                 = $U.UserPrincipalName
            'SamAccountName'                    = $U.SamAccountName
            'Display Name'                      = $U.DisplayName
            'Given Name'                        = $U.GivenName
            'Surname'                           = $U.Surname
            'EmailAddress'                      = $U.EmailAddress
            'PasswordExpired'                   = $U.PasswordExpired
            'PasswordLastSet'                   = $U.PasswordLastSet
            'PasswordLastChanged'               = if ($U.PasswordLastSet -ne $Null) { "$(-$($U.PasswordLastSet - [DateTime]::Today).Days)" } else { ''}
            'PasswordNotRequired'               = $U.PasswordNotRequired
            'PasswordNeverExpires'              = $U.PasswordNeverExpires
            'Enabled'                           = $U.Enabled
            'Manager'                           = $U.Manager #  (Get-ADObjectFromDistingusishedName -ADCatalog $ADCatalogUsers -DistinguishedName $U.Manager).Name
            # 'Manager Email'                     = (Get-ADObjectFromDistingusishedName -ADCatalog $ADCatalogUsers -DistinguishedName $U.Manager).EmailAddress
            'DateExpiry'                        = Convert-ToDateTime -Timestring $($U."msDS-UserPasswordExpiryTimeComputed") -Verbose
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

            "Created"                           = $U.Created
            "Modified"                          = $U.Modified
            "Protected"                         = $U.ProtectedFromAccidentalDeletion

            "PrimaryGroup"                      = $U.PrimaryGroup # (Get-ADObjectFromDistingusishedName -ADCatalog $ADCatalog -DistinguishedName $U.PrimaryGroup -Type 'SamAccountName')
            "MemberOf"                          = $U.MemberOf # (Get-ADObjectFromDistingusishedName -ADCatalog $ADCatalog -DistinguishedName $U.MemberOf -Type 'SamAccountName' -Splitter ', ')
            "Domain"                            = $Domain
        }

    }
    return $UserList
}

<#

$Users = Get-ADUser -Filter * -Properties 'Name', 'UserPrincipalName', 'SamAccountName', 'Enabled', 'PasswordLastSet', `
    'PasswordExpired', 'PasswordNeverExpires', 'PasswordNotRequired', 'EmailAddress', 'DisplayName', 'GivenName', `
    'Surname', 'Manager', "AccountExpirationDate", "AccountLockoutTime", "AllowReversiblePasswordEncryption", `
    "BadLogonCount", "CannotChangePassword", "CanonicalName", "Description", "DistinguishedName", "EmployeeID", `
    "EmployeeNumber", "LastBadPasswordAttempt", "LastLogonDate", "Created", "Modified", "PrimaryGroup", "MemberOf", `
    'msDS-UserPasswordExpiryTimeComputed'

Get-WinADUsers -Users $Users | Format-Table -AutoSize

#>