function Get-WinAzureADUsers {
    [CmdletBinding()]
    param(
        [ValidateSet("All", "DisabledOnly", "EnabledOnly")][string] $Filter = 'All',
        [int] $MaxResults = 5000000,
        [string] $UserPrincipalName,
        [switch] $ReturnDeletedUsers,
        [switch] $ReturnUnlicensedUsers,
        [string] $Country,
        [string] $City,
        [string] $Department,
        [string] $State,
        [switch] $Synchronized,
        [string] $DomainName,
        [string] $Title,
        [switch] $All,
        [switch] $LicenseReconciliationNeededOnly,
        [string] $SearchString,
        [switch] $HasErrorsOnly,
        [Guid] $TenantId,
        [string] $UsageLocation

    )

    $UserSplat = @{}
    if ($UserPrincipalName) { $UserSplat.UserPrincipalName = $UserPrincipalName }

    if ($DomainName) { $UserSplat.DomainName = $DomainName }

    if ($MaxResults) { $UserSplat.MaxResults = $MaxResults }

    <#
    EnabledFilter                   = $Filter
    ReturnDeletedUsers              = $ReturnDeletedUsers
    UnlicensedUsersOnly             = $ReturnUnlicensedUsers

    Country                         = $Country
    City                            = $City
    State                           = $State
    UsageLocation                   = $UsageLocation

    Title                           = $Title
    Department                      = $Department



    LicenseReconciliationNeededOnly = $LicenseReconciliationNeededOnly
    SearchString                    = $SearchString
    HasErrorsOnly                   = $HasErrorsOnly
    TenantID                        = $TenantId
    #>

    if ($All) {
        #$UserSplat.All = $All
        #$UserSplat.DomainName = 'evotec.xyz'

    }

    $Users = Get-MsolUser -All:$All -Synchronized:$Synchronized -ReturnDeletedUsers:$ReturnDeletedUsers -UnlicensedUsersOnly:$ReturnUnlicensedUsers
    $Users

}

#Get-WinAzureADUsers -MaxResults 3 -Country 'Poland' -ReturnDeletedUsers -ReturnUnlicensedUsers