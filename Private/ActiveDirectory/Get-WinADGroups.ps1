function Get-WinADGroups {
    [CmdletBinding()]
    param(
        $Filter,
        $OrganizationalUnit
    )
    $Splatting = @{}
    if ($Filter -eq $null -and $OrganizationalUnit -eq $null) {
        $Splatting = $Filter
    } else {
        if ($OrganizationalUnit) {
            $Splatting.SearchBase = $OrganizationalUnit
        }
        if ($Filter) {
            $Splatting.Filter = $Filter
        }
    }
    $Groups = Get-ADGroup @Splatting -Properties $Script:GroupProperties
    return $Groups
}

#Get-ADGroup -Filter * -Properties * # $Script:GroupProperties


#Get-WinADGroupsByDN -DistinguishedName 'CN=Disabled Users,OU=SecurityGroups,OU=Groups,OU=Production,DC=ad,DC=evotec,DC=xyz' -Field 'Name'
