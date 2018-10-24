Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods #-Force

Service -Name 'Active Directory Prepare Users' {
    Trigger -Name 'Enable already Offboarded Users' -User OrganizationalUnit -Value 'OU=Users-Offboarded,OU=Production,DC=ad,DC=evotec,DC=xyz' |
        Ignore |
        Action -Name 'Enable Users' -ActiveDirectory AccountEnable -WhatIf |
        Action -Name 'Remove Users From Group' -ActiveDirectory AccountRemoveGroupsSpecific -Value 'Disabled Users' -WhatIf
}