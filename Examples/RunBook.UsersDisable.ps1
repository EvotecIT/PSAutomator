Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods #-Force

Service -Name 'Active Directory Disable Users in Group' {
    Trigger -Name 'User is a member of Disabled Users group' -User GroupMembership -Value 'Disabled Users' |
        Condition -Name 'Ignore Email Address like *@evotec.pl' -Condition Field -Value @{ Field = 'EmailAddress'; Operator = 'notlike'; Value = '*@evotec.pl' } |
        Condition -Name 'Ignore Email Address if Empty or Null' -Condition EmptyOrNull -Value EmailAddress |
        Action -Name 'Disable Evotec Users' -ActiveDirectory AccountDisable -WhatIf
}