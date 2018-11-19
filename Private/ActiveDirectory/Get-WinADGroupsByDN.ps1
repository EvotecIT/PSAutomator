function Get-WinADGroupsByDN {

    <# Returns one of the values
    DistinguishedName : CN=Disabled Users,OU=SecurityGroups,OU=Groups,OU=Production,DC=ad,DC=evotec,DC=xyz
    GroupCategory     : Security
    GroupScope        : Universal
    Name              : Disabled Users
    ObjectClass       : group
    ObjectGUID        : b7b5961e-e190-4f01-973f-abdf824261a3
    SamAccountName    : Disabled Users
    SID               : S-1-5-21-853615985-2870445339-3163598659-1162
    #>

    param(
        [alias('DN')][string[]] $DistinguishedName,
        [string] $Field = 'Name', # return field
        [switch] $All
    )
    $Output = foreach ($DN in $DistinguishedName) {
        try {
            Get-AdGroup -Identity $DN
        } catch {
            # returns empty, basically ignores stuff
        }
    }
    if ($All) {
        return $Output
    } else {
        return $Output.$Field
    }
}




#Get-WinADUsersByDN -DistinguishedName 'CN=Przemyslaw Klys,OU=Users,OU=Production,DC=ad,DC=evotec,DC=xyz'