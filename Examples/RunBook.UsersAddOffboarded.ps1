Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods -Force

Service -Name 'Active Directory Add Users To Group' {
    Trigger -Name 'Find Offboarded Users' -User OrganizationalUnit -Value 'OU=Users-Offboarded,OU=Production,DC=ad,DC=evotec,DC=xyz' |
        Condition |
        Action -Name 'Add Users To Disabled Group' -ActiveDirectory AccountAddGroupsSpecific -Value 'Disabled Users' -WhatIf
}