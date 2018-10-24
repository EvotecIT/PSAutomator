Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods -Force

Service -Name 'Active Directory Disable Users in Group' {
    Trigger -Name 'User is a member of Disabled Users group' -User GroupMembership -Value 'Disabled Users' |
        Ignore |
        Action -Name 'Disable Evotec Users' -ActiveDirectory AccountDisable -WhatIf
}