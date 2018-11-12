Clear-Host
Import-Module PSAutomator -Force #-Verbose
Import-Module PSSharedGoods #-Force

Service -Name 'Active Directory Disable Users in Group' {
    Trigger -Name 'User is a member of Disabled Users group' -User GroupMembership -Value 'Disabled Users' |
        Ignore -Name 'Ignore Email Address like *@evotec.pl' -Ignore MatchingFields -Value @{ Field = 'EmailAddress'; Operator = 'notlike'; Value = '*@evotec.pl' } |
        Ignore -Name 'Ignore Email Address if Empty or Null' -Ignore MatchingEmptyOrNull -Value EmailAddress |
        Action -Name 'Disable Evotec Users' -ActiveDirectory AccountDisable -WhatIf
}