Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods #-Force

Service -Name 'Active Directory Prepare Users' {
    Trigger -Name 'Offboard Users' -User OrganizationalUnit -Value 'OU=Users-Offboarded,OU=Production,DC=ad,DC=evotec,DC=xyz' |
        Ignore |
        Action -Name 'Disable Users' -ActiveDirectory AccountDisable -WhatIf |
        Action -Name 'Add to group' -ActiveDirectory AccountAddGroupsSpecific -Value 'Disabled Users' -WhatIf
}