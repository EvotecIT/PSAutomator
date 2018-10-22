Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods #-Force

Service -Name 'Active Directory Disable Users in Group' {
    Trigger -Name 'Dwa' -User GroupMembership -Value 'Disabled Users' |
        Ignore |
        Action -Name 'Disable Evotec Users' -ActiveDirectory AccountDisable
}