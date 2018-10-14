Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods #-Force

Service -Name 'Active Directory Offboarding' {
    Trigger -Name 'OU Offboarded Users' -Trigger OrganizationalUnit -Value 'OU=Users-Offboarded,OU=Production,DC=ad,DC=evotec,DC=xyz' |
        Condition -Name 'No conditions' |
        Ignore -Name 'Ignore Windows Email Address if Empty or null' -IgnoreAction MatchingEmptyOrNull -IgnoreParameter WindowsEmailAddress -IgnoreValue $true |
        ActionActiveDirectory -Name 'Disable AD Account' -Action AccountDisable |
        ActionActiveDirectory -Name 'Hide account in GAL' -Action AccountHideInGAL |
        ActionActiveDirectory -Name 'Rename Account' -Action AccountRename -ActionValue @{ Action = 'AddText'; Where = 'After'; Text = ' (offboarded)'; }

    Trigger -Name 'Reenabling my users' -Trigger OrganizationalUnit -Value 'OU=Users-Offboarded,OU=Production,DC=ad,DC=evotec,DC=xyz' |
        Condition -Name 'No conditions' |
        Ignore -Name 'Ignore Windows Email Address if Empty or null' -IgnoreAction MatchingEmptyOrNull -IgnoreParameter WindowsEmailAddress -IgnoreValue $true |
        ActionActiveDirectory -Name 'Enable AD Account' -Action AccountEnable
}

Service -Name 'Active Directory Testing' {
    Trigger -Name 'Dwa' -Trigger GroupMembership -Value 'Disabled Users' |
        Ignore |
        ActionActiveDirectory -Name 'Disable Evotec Users' -Action AccountDisable
}