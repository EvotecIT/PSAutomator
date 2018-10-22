function Get-WinADUsers {
    param(
        $Filter,
        $OrganizationalUnit
    )
    $Splatting = @{}
    if ($OrganizationalUnit) {
        $Splatting.SearchBase = $OrganizationalUnit
    }
    if ($Filter) {
        $Splatting = $Filter
    }

    $Users = Get-ADUser @Splatting -Properties $Script:UserProperties
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
