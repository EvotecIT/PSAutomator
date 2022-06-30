function Get-WinADGroupsTranslate {
    param (
        [System.Object[]] $Groups
    )
    $ReturnGroups = @(
        foreach ($Group in $Groups) {
            #$User = $Users | Where { $_.DistinguishedName -eq $Group.ManagedBy }
            [PSCustomObject] @{
                'Group Name'            = $Group.Name
                'Group Display Name'    = $Group.DisplayName
                'Group Category'        = $Group.GroupCategory
                'Group Scope'           = $Group.GroupScope
                'Group SID'             = $Group.SID.Value
                'High Privileged Group' = if ($Group.AdminCount -eq 1) { $True } else { $False }
                'Member Count'          = $Group.Members.Count
                'MemberOf Count'        = $Group.MemberOf.Count
                'Manager'               = $Group.ManagedBy
                #'Manager'               = $User.Name
                #'Manager Email'         = $User.EmailAddress
                #'Group Members'         = (Get-ADObjectFromDistingusishedName -ADCatalog $Data.DomainUsersFullList, $Data.DomainComputersFullList, $Data.DomainGroupsFullList -DistinguishedName $Group.Members -Type 'SamAccountName')
                'Group Members'         = $Group.Members
            }
        }
    )
    return $ReturnGroups
}
