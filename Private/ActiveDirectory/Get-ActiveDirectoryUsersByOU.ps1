function Get-ActiveDirectoryUsersByOU {
    [CmdletBinding()]
    param (
        $OrganizationalUnit
    )
    $OU = Get-ADOrganizationalUnit $OrganizationalUnit
    if ($OU.ObjectClass -eq 'OrganizationalUnit') {
        #if ($BlockActiveDirectory.AccountHideInGAL) {
        $Properties = 'DisplayName', 'msExchHideFromAddressLists', 'MemberOf', 'Name'
        #} else {
        #    $Properties = 'DisplayName', 'memberof', 'Name'
        #}
        try {
            $Users = Get-ADUser -SearchBase $OU -Filter * -Properties $Properties
        } catch {
            Write-Color @Script:WriteParameters -Text '[i]', ' One or more properties are invalid - Terminating', ' Terminating' -Color Yellow, White, Red
            return
        }
    }
    return $Users
}