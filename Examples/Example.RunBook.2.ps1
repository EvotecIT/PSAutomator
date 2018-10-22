Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods #-Force

Service -Name 'Active Directory Prepare Users' {
    Trigger -Name 'Enable already disabled users' -User OrganizationalUnit -Value 'OU=Users-Offboarded,OU=Production,DC=ad,DC=evotec,DC=xyz' |
        Ignore |
        Action -Name 'Enable Evotec Users' -ActiveDirectory AccountEnable |
        Action -Name 'Add to group' -ActiveDirectory AccountAddGroupsSpecific -Value 'Disabled Users'
}