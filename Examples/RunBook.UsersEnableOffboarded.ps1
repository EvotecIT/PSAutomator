Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods -Force

Service -Name 'Active Directory Enable Users in OU' {
    Trigger -Name 'Find Offboarded Users' -User OrganizationalUnit -Value 'OU=Users-Offboarded,OU=Production,DC=ad,DC=evotec,DC=xyz' |
        Ignore |
        Action -Name 'Enable Offboarded Users' -ActiveDirectory AccountEnable -WhatIf |
        Action -Name 'Add to group GDS-TestGroup5' -ActiveDirectory AccountAddGroupsSpecific -Value 'GDS-TestGroup5' -WhatIf |
        Action -Name 'Add to group GDS-TestGroup4' -ActiveDirectory AccountAddGroupsSpecific -Value 'GDS-TestGroup4' -Whatif |
        Action -Name 'Remove Offboarded Tag' -ActiveDirectory AccountRename -Value @{ Action = 'RemoveText'; Fields = 'DisplayName', 'Name' ; Text = ' (offboarded)'; } -WhatIf
}